"""Python CLI Logic"""

import logging
import os


def main() -> None:
    """Entrypoint"""
    logging.basicConfig(
        level=os.getenv("LOG_LEVEL", "INFO"),
        format="%(levelname)s: %(message)s",
    )
    logging.info("Hello world!")
