from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime


class LeaderboardEntry(BaseModel):
    user_id: str = Field(...)
    contest_id: str = Field(...)
    score: int = Field(...)


class LeaderboardOut(BaseModel):
    id: Optional[str] = Field(None, alias="_id")  # MongoDB _id mapping
    user_id: str = Field(...)
    contest_id: str = Field(...)
    score: int = Field(...)
    created_at: Optional[datetime] = None

    class Config:
        orm_mode = True
        allow_population_by_field_name = True  # allow _id to map to id