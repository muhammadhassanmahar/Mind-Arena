from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime


class LeaderboardEntry(BaseModel):
    user_id: str = Field(...)
    contest_id: str = Field(...)
    score: int = Field(...)

class LeaderboardOut(BaseModel):
    id: str
    user_id: str
    contest_id: str
    score: int
    created_at: Optional[datetime]

    class Config:
        orm_mode = True