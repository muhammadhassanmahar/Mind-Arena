from fastapi import APIRouter, HTTPException, Depends
from typing import List
from datetime import datetime

from ..services.contest_service import ContestService
from ..schemas.contest_schema import ContestCreate, ContestOut
from ..services.auth_service import AuthService

router = APIRouter(prefix="/contest", tags=["Contest"])


@router.post("/", response_model=ContestOut)
async def create_contest(
    contest_data: ContestCreate,
    current_user=Depends(AuthService.get_current_user)
):
    """
    Create a new contest (admin only)
    """
    if not getattr(current_user, "is_admin", False):
        raise HTTPException(status_code=403, detail="Not authorized")

    contest = await ContestService.create_contest(contest_data)
    return contest


@router.get("/", response_model=List[ContestOut])
async def get_all_contests():
    """
    Get all contests
    """
    contests = await ContestService.get_all_contests()
    return contests


@router.get("/today", response_model=ContestOut)
async def get_today_contest():
    """
    Get today's active contest
    """
    today = datetime.utcnow()

    contest = await ContestService.get_today_contest(today)

    if not contest:
        raise HTTPException(status_code=404, detail="No contest available today")

    return contest


@router.get("/{contest_id}", response_model=ContestOut)
async def get_contest(contest_id: str):
    """
    Get contest details by ID
    """
    contest = await ContestService.get_contest_by_id(contest_id)

    if not contest:
        raise HTTPException(status_code=404, detail="Contest not found")

    return contest