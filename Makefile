.PHONY: test

ci.test:
	mix format --check-formatted
	mix compile --warnings-as-errors
	mix credo --strict
	mix doctor
	mix test --trace --slowest 10
	mix dialyzer

install:
	mix deps.get
	mix compile

setup:
	@./scripts/setup.sh

test:
	mix test

test.iex:
	iex -S mix test
