from pydantic import BaseModel, EmailStr, Field
from typing import Optional
from datetime import datetime


# ----------------------------
# User Model
# ----------------------------
class UserModel(BaseModel):
    uid: str = Field(...)
    name: str = Field(...)
    email: EmailStr = Field(...)
    created_at: Optional[datetime] = Field(default_factory=datetime.utcnow)

    class Config:
        orm_mode = True


# ----------------------------
# Contest Model
# ----------------------------
class ContestModel(BaseModel):
    title: str = Field(...)
    puzzle_image: str = Field(...)
    user_id: str = Field(...)
    created_at: Optional[datetime] = Field(default_factory=datetime.utcnow)

    class Config:
        orm_mode = True


# ----------------------------
# Result Model
# ----------------------------
class ResultModel(BaseModel):
    contest_id: str = Field(...)
    score: int = Field(...)
    created_at: Optional[datetime] = Field(default_factory=datetime.utcnow)

    class Config:
        orm_mode = True


# ----------------------------
# Wallet Model
# ----------------------------
class WalletModel(BaseModel):
    user_id: str = Field(...)
    balance: float = Field(default=0.0)
    created_at: Optional[datetime] = Field(default_factory=datetime.utcnow)

    class Config:
        orm_mode = True