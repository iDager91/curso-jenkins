import pytest_lazyfixture
def suma(a,b):
    """Funcion que suma dos numeros"""
    return a + b

def test_suma():
    assert suma(1, 2) == 3
    assert suma(-1, 1) == 0
    assert suma(0, 0) == 0 

def test_suma_fail():
        assert suma(1, 2)== 4

