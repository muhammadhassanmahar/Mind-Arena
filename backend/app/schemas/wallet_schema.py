from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime


class WalletCreate(BaseModel):
    user_id: str = Field(..., description="ID of the user who owns the wallet")
    balance: float = Field(default=0.0, description="Initial wallet balance")


class WalletUpdate(BaseModel):
    balance: Optional[float] = Field(None, description="Updated wallet balance")


class WalletOut(BaseModel):
    id: str
    user_id: str
    balance: float
    created_at: Optional[datetime] = None

    model_config = {
        "from_attributes": True
    }