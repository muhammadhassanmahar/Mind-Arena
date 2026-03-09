from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime


class WalletCreate(BaseModel):
    user_id: str = Field(...)
    balance: float = Field(default=0.0)


class WalletUpdate(BaseModel):
    balance: Optional[float] = None  # User can update balance partially


class WalletOut(BaseModel):
    id: str
    user_id: str
    balance: float
    created_at: Optional[datetime]

    model_config = {
        "from_attributes": True  # Pydantic v2 replacement for orm_mode
    }