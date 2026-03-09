from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime


class WalletCreate(BaseModel):
    user_id: str = Field(...)
    balance: float = Field(default=0.0)

class WalletOut(BaseModel):
    id: str
    user_id: str
    balance: float
    created_at: Optional[datetime]

    class Config:
        orm_mode = True