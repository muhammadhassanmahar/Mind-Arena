from motor.motor_asyncio import AsyncIOMotorClient
from bson.objectid import ObjectId

MONGO_DETAILS = "mongodb://localhost:27017"  # Change this to your MongoDB URI

client = AsyncIOMotorClient(MONGO_DETAILS)
database = client["puzzle_contest_db"]  # Database name

# Collections
users_collection = database.get_collection("users")
contests_collection = database.get_collection("contests")
results_collection = database.get_collection("results")
wallets_collection = database.get_collection("wallets")


# Helper function to convert MongoDB document to dict
def user_helper(user) -> dict:
    return {
        "id": str(user["_id"]),
        "uid": user.get("uid"),
        "email": user.get("email"),
        "name": user.get("name"),
        "created_at": user.get("created_at")
    }

def contest_helper(contest) -> dict:
    return {
        "id": str(contest["_id"]),
        "title": contest.get("title"),
        "puzzle_image": contest.get("puzzle_image"),
        "user_id": contest.get("user_id"),
        "created_at": contest.get("created_at")
    }

def result_helper(result) -> dict:
    return {
        "id": str(result["_id"]),
        "contest_id": result.get("contest_id"),
        "score": result.get("score"),
        "created_at": result.get("created_at")
    }

def wallet_helper(wallet) -> dict:
    return {
        "id": str(wallet["_id"]),
        "user_id": wallet.get("user_id"),
        "balance": wallet.get("balance"),
        "created_at": wallet.get("created_at")
    }