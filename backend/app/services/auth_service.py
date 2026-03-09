from typing import Optional
from bson import ObjectId
from fastapi import HTTPException
from passlib.context import CryptContext

from ..database.database import db
from ..schemas.user_schema import UserCreate, UserOut

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

USERS_COLLECTION = db.get_collection("users")


def hash_password(password: str) -> str:
    return pwd_context.hash(password)


def verify_password(plain_password: str, hashed_password: str) -> bool:
    return pwd_context.verify(plain_password, hashed_password)


async def create_user(user_data: UserCreate) -> UserOut:
    # Check if email exists
    existing_user = await USERS_COLLECTION.find_one({"email": user_data.email})
    if existing_user:
        raise HTTPException(status_code=400, detail="Email already registered")

    hashed_pw = hash_password(user_data.password)
    user_dict = {
        "name": user_data.name,
        "email": user_data.email,
        "password": hashed_pw,
        "created_at": None
    }
    result = await USERS_COLLECTION.insert_one(user_dict)
    user_dict["uid"] = str(result.inserted_id)
    return UserOut(**user_dict)


async def authenticate_user(email: str, password: str) -> Optional[UserOut]:
    user = await USERS_COLLECTION.find_one({"email": email})
    if not user:
        return None
    if not verify_password(password, user["password"]):
        return None

    user["uid"] = str(user["_id"])
    return UserOut(**user)