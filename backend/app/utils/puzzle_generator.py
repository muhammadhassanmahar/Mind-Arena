import random
from typing import List

class PuzzleGenerator:
    @staticmethod
    def generate_puzzle(image_url: str, size: int = 3) -> List[dict]:
        """
        Generates a simple puzzle structure for frontend use.
        Returns a list of tile dicts with position and image URL info.
        """
        tiles = [{"index": i, "image": image_url} for i in range(size * size)]
        random.shuffle(tiles)
        return tiles