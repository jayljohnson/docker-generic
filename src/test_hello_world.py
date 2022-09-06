import pytest

from .hello_world import hello_world


@pytest.mark.parametrize("input, expected", 
[
    (None, "Hello, world"),
    ("world", "Hello, world"),
    ("Alice", "Hello, Alice"),
])
def test_hello_world(input, expected):
    result = hello_world(input)
    assert result == expected


def test_hello_world_noargs():
    result = hello_world()
    assert result == "Hello, world"
