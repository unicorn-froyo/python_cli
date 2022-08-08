"""Main Tests"""

from unittest import TestCase, main
from unittest.mock import patch
from python_cli.main import main as entrypoint


class TestMain(TestCase):
    """Main tests"""

    @patch("python_cli.main.logging.info")
    def test_main(self, mock_info):
        """Test entrypoint"""
        entrypoint()
        mock_info.assert_called_once_with("Hello world!")


if __name__ == "__main__":
    main()
