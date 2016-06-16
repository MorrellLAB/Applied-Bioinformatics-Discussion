# write addition function:
def add(x,y):
    """Add two things together"""
    return x + y

# Run assert over add function
# Assuming 1 + 1 =2, this should return no error
assert(add(1,1)==2)

# Write an test function to test the add() function
#	over a variety of numeric types
# There should not be any errors
def test_add():
    """positive integer types"""
    assert(add(2,3) == 5)
    """negative integer types"""
    assert(add(-2,3) == 1)
    """floating-point type"""
    assert(abs(add(2.4, 0.1) - 2.5) < 0.00001)

# Assuming 1 + 1 != 3, this should return an assert error
assert(add(1,1)==3)
