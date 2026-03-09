from datetime import datetime, timedelta

class TimerHelper:
    @staticmethod
    def get_time_after_seconds(seconds: int) -> datetime:
        """
        Returns the datetime after given seconds from now
        """
        return datetime.utcnow() + timedelta(seconds=seconds)

    @staticmethod
    def get_time_remaining(end_time: datetime) -> int:
        """
        Returns remaining time in seconds until end_time
        """
        now = datetime.utcnow()
        remaining = (end_time - now).total_seconds()
        return max(int(remaining), 0)