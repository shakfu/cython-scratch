import demo



def test_flat():
    a = demo.AppParams1()
    assert a.cpu_n_threads == 4

def test_nested():
    a = demo.AppParams()
    assert a.cpuparams.n_threads == 4
