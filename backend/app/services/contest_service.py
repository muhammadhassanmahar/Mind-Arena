from typing import List, Optional
from bson import ObjectId
from fastapi import HTTPException

from ..database.database import db
from ..schemas.contest_schema import ContestCreate, ContestOut

CONTEST_COLLECTION = db.get_collection("contests")


async def create_contest(contest_data: ContestCreate) -> ContestOut:
    contest_dict = contest_data.dict()
    result = await CONTEST_COLLECTION.insert_one(contest_dict)
    contest_dict["id"] = str(result.inserted_id)
    return ContestOut(**contest_dict)


async def get_contest(contest_id: str) -> ContestOut:
    contest = await CONTEST_COLLECTION.find_one({"_id": ObjectId(contest_id)})
    if not contest:
        raise HTTPException(status_code=404, detail="Contest not found")
    contest["id"] = str(contest["_id"])
    return ContestOut(**contest)


async def list_contests() -> List[ContestOut]:
    contests_cursor = CONTEST_COLLECTION.find()
    contests = []
    async for contest in contests_cursor:
        contest["id"] = str(contest["_id"])
        contests.append(ContestOut(**contest))
    return contests


async def update_contest(contest_id: str, contest_data: ContestCreate) -> ContestOut:
    result = await CONTEST_COLLECTION.update_one(
        {"_id": ObjectId(contest_id)},
        {"$set": contest_data.dict()}
    )
    if result.matched_count == 0:
        raise HTTPException(status_code=404, detail="Contest not found")
    return await get_contest(contest_id)


async def delete_contest(contest_id: str) -> dict:
    result = await CONTEST_COLLECTION.delete_one({"_id": ObjectId(contest_id)})
    if result.deleted_count == 0:
        raise HTTPException(status_code=404, detail="Contest not found")
    return {"status": "Contest deleted successfully"}