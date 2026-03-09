from typing import List
from app.database.database import get_db
from app.schemas.leaderboard_schema import LeaderboardOut
from app.models.models import ContestModel, UserModel
from bson import ObjectId


class LeaderboardService:

    @staticmethod
    async def get_contest_leaderboard(contest_id: str) -> List[LeaderboardOut]:
        """
        Returns leaderboard for a specific contest, sorted by score descending.
        """
        db = get_db()
        contest = await db.contests.find_one({"_id": ObjectId(contest_id)})
        if not contest:
            return []

        leaderboard_data = await db.leaderboard.find(
            {"contest_id": contest_id}
        ).sort("score", -1).to_list(length=100)

        return [
            LeaderboardOut(
                user_id=entry["user_id"],
                username=entry.get("username", "Unknown"),
                score=entry.get("score", 0)
            )
            for entry in leaderboard_data
        ]

    @staticmethod
    async def get_top_users(limit: int = 10) -> List[LeaderboardOut]:
        """
        Returns top users across all contests by total score.
        """
        db = get_db()

        pipeline = [
            {
                "$group": {
                    "_id": "$user_id",
                    "total_score": {"$sum": "$score"},
                    "username": {"$first": "$username"}
                }
            },
            {"$sort": {"total_score": -1}},
            {"$limit": limit}
        ]

        top_users = await db.leaderboard.aggregate(pipeline).to_list(length=limit)

        return [
            LeaderboardOut(
                user_id=user["_id"],
                username=user.get("username", "Unknown"),
                score=user.get("total_score", 0)
            )
            for user in top_users
        ]