import demo



def test_callback1():
	d = demo.CallbackDemo1()

	assert d.call(100, lambda x: 2 * x) == 200
