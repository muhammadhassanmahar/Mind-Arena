from fastapi import APIRouter, Depends
from typing import List

# Use absolute imports based on your package root
from app.services.contest_service import ContestService
from app.services.leaderboard_service import LeaderboardService
from app.schemas.leaderboard_schema import LeaderboardOut
from app.services.auth_service import AuthService

router = APIRouter(prefix="/leaderboard", tags=["Leaderboard"])


@router.get("/contest/{contest_id}", response_model=List[LeaderboardOut])
async def get_contest_leaderboard(
    contest_id: str, 
    current_user=Depends(AuthService.get_current_user)
):
    """
    Get leaderboard for a specific contest
    """
    leaderboard = await LeaderboardService.get_contest_leaderboard(contest_id)
    return leaderboard


@router.get("/top-users", response_model=List[LeaderboardOut])
async def get_top_users(limit: int = 10):
    """
    Get top users across all contests
    """
    leaderboard = await LeaderboardService.get_top_users(limit)
    return leaderboard