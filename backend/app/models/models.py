from typing import Optional
from datetime import datetime
from beanie import Document, Indexed
from pydantic import Field, ConfigDict


# ===== User Model =====
class UserModel(Document):
    email: Indexed(str) = Field(unique=True)
    name: str
    password_hash: str
    created_at: datetime = Field(default_factory=datetime.utcnow)
    is_active: bool = True

    model_config = ConfigDict(
        json_schema_extra={
            "example": {
                "email": "user@example.com",
                "name": "John Doe",
                "password_hash": "hashed_password",
                "is_active": True
            }
        }
    )

    class Settings:
        name = "users"


# ===== Contest Model =====
class ContestModel(Document):
    title: str
    description: Optional[str] = None
    puzzle_image: Optional[str] = None
    start_time: datetime
    end_time: datetime
    created_at: datetime = Field(default_factory=datetime.utcnow)

    model_config = ConfigDict(
        json_schema_extra={
            "example": {
                "title": "Daily Puzzle",
                "description": "Solve the 3x3 puzzle",
                "puzzle_image": "https://example.com/puzzle.jpg",
                "start_time": "2026-03-10T00:00:00Z",
                "end_time": "2026-03-10T23:59:59Z"
            }
        }
    )

    class Settings:
        name = "contests"


# ===== Wallet Model =====
class WalletModel(Document):
    user_id: str
    balance: float = 0.0
    currency: str = "USD"
    created_at: datetime = Field(default_factory=datetime.utcnow)

    model_config = ConfigDict(
        json_schema_extra={
            "example": {
                "user_id": "user_id_here",
                "balance": 100.0,
                "currency": "USD"
            }
        }
    )

    class Settings:
        name = "wallets"


# ===== Leaderboard Model =====
class LeaderboardModel(Document):
    user_id: str
    contest_id: str
    score: int
    created_at: datetime = Field(default_factory=datetime.utcnow)

    model_config = ConfigDict(
        json_schema_extra={
            "example": {
                "user_id": "user_id_here",
                "contest_id": "contest_id_here",
                "score": 150
            }
        }
    )

    class Settings:
        name = "leaderboards"