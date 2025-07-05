import demo



def test_callback3():
	d = demo.CallbackDemo3()

	assert d.call(100, lambda x: 2 * x) == 200
