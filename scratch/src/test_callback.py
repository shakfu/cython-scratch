import scratch

# d = scratch.CallbackDemo()

# d.setup_python_callback(lambda x: print(x))

# d.call(100)


d = scratch.CallbackDemo1()

d.call(100, lambda x: print(x))
