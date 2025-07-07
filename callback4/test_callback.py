import demo



def test_callback4():
    d = demo.Callback(lambda x: 2 * x)
    assert d.call(100) == 200

def test_callback4_reregister():
    d = demo.Callback(lambda x: 2 * x)
    d.register_pycallback(lambda x: 4 * x)
    assert d.call(100) == 400
