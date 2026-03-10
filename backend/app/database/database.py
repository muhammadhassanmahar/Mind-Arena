from motor.motor_asyncio import AsyncIOMotorClient
import os

# MongoDB connection URL
MONGO_DETAILS = os.getenv("MONGO_DETAILS", "mongodb://localhost:27017")

# Database name
DATABASE_NAME = "puzzle_contest_db"

# MongoDB client
client = AsyncIOMotorClient(MONGO_DETAILS)

# Database
db = client[DATABASE_NAME]


# Collections
users_collection = db.get_collection("users")
contests_collection = db.get_collection("contests")
results_collection = db.get_collection("results")
wallets_collection = db.get_collection("wallets")


# Dependency for FastAPI (used in services like leaderboard)
def get_db():
    return db


# ---------------- Helper functions ---------------- #

def user_helper(user: dict) -> dict:
    return {
        "id": str(user.get("_id")),
        "uid": user.get("uid", ""),
        "email": user.get("email", ""),
        "name": user.get("name", ""),
        "created_at": user.get("created_at")
    }


def contest_helper(contest: dict) -> dict:
    return {
        "id": str(contest.get("_id")),
        "title": contest.get("title", ""),
        "puzzle_image": contest.get("puzzle_image", ""),
        "user_id": contest.get("user_id", ""),
        "created_at": contest.get("created_at")
    }


def result_helper(result: dict) -> dict:
    return {
        "id": str(result.get("_id")),
        "contest_id": result.get("contest_id", ""),
        "score": result.get("score", 0),
        "created_at": result.get("created_at")
    }


def wallet_helper(wallet: dict) -> dict:
    return {
        "id": str(wallet.get("_id")),
        "user_id": wallet.get("user_id", ""),
        "balance": wallet.get("balance", 0.0),
        "created_at": wallet.get("created_at")
    }