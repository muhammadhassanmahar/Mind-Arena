from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime


class ContestCreate(BaseModel):
    title: str = Field(...)
    puzzle_image: str = Field(...)
    user_id: str = Field(...)

class ContestOut(BaseModel):
    id: str
    title: str
    puzzle_image: str
    user_id: str
    created_at: Optional[datetime]

    class Config:
        orm_mode = True