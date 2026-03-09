from typing import Optional
from datetime import datetime, timedelta
from bson import ObjectId
from fastapi import HTTPException, Depends
from fastapi.security import OAuth2PasswordBearer
from passlib.context import CryptContext
import jwt
import os

from app.database.database import users_collection  # Use your updated database.py
from app.schemas.user_schema import UserCreate, UserOut

# Password hashing
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# JWT settings
SECRET_KEY = os.getenv("SECRET_KEY", "supersecretkey")
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60 * 24  # 1 day

# OAuth2 scheme
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")


def hash_password(password: str) -> str:
    return pwd_context.hash(password)


def verify_password(plain_password: str, hashed_password: str) -> bool:
    return pwd_context.verify(plain_password, hashed_password)


async def create_user(user_data: UserCreate) -> UserOut:
    existing_user = await users_collection.find_one({"email": user_data.email})
    if existing_user:
        raise HTTPException(status_code=400, detail="Email already registered")

    hashed_pw = hash_password(user_data.password)
    user_dict = {
        "name": user_data.name,
        "email": user_data.email,
        "password": hashed_pw,
        "created_at": datetime.utcnow()
    }
    result = await users_collection.insert_one(user_dict)
    user_dict["uid"] = str(result.inserted_id)
    return UserOut(**user_dict)


async def authenticate_user(email: str, password: str) -> Optional[UserOut]:
    user = await users_collection.find_one({"email": email})
    if not user or not verify_password(password, user["password"]):
        return None

    user["uid"] = str(user["_id"])
    return UserOut(**user)


def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt


class AuthService:
    @staticmethod
    async def get_current_user(token: str = Depends(oauth2_scheme)) -> UserOut:
        try:
            payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
            user_id: str = payload.get("sub")
            if user_id is None:
                raise HTTPException(status_code=401, detail="Invalid authentication credentials")
        except jwt.PyJWTError:
            raise HTTPException(status_code=401, detail="Invalid authentication credentials")

        user = await users_collection.find_one({"_id": ObjectId(user_id)})
        if user is None:
            raise HTTPException(status_code=404, detail="User not found")
        user["uid"] = str(user["_id"])
        return UserOut(**user)