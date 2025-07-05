import demo



def test_callback3():
	d = demo.CallbackDemo3()

	d.register(lambda x: 2 * x)
	assert d.call(100) == 200
