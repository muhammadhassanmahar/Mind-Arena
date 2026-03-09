from pydantic import BaseModel, EmailStr, Field
from typing import Optional
from datetime import datetime


class UserCreate(BaseModel):
    name: str = Field(...)
    email: EmailStr = Field(...)
    password: str = Field(...)

class UserOut(BaseModel):
    uid: str
    name: str
    email: EmailStr
    created_at: Optional[datetime]

    class Config:
        orm_mode = True