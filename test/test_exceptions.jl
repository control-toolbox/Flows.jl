e = AmbiguousDescription((:e,))
@test_throws ErrorException error(e)
@test typeof(sprint(showerror, e)) == String