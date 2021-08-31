SCHEME = chibi-scheme

check:
	$(SCHEME) tests.scm
	$(SCHEME) test-application-hook.scm

.PHONY: check
