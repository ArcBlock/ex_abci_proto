TOP_DIR=.
PROTOS=$(TOP_DIR)/lib/protos
README=$(TOP_DIR)/README.md

VERSION=$(strip $(shell cat version))
ELIXIR_VERSION=$(strip $(shell cat .elixir_version))

build:
	@echo "Building the software..."
	@make format

format:
	@mix compile; mix format;

init: submodule install dep
	@echo "Initializing the repo..."
	@brew install protobuf
	@mix escript.install hex protobuf

travis-init: submodule
	@echo "Initialize software required for travis (normally ubuntu software)"

install:
	@echo "Install software required for this repo..."
	@mix local.hex --force
	@mix local.rebar --force

dep:
	@echo "Install dependencies required for this repo..."
	@mix deps.get

pre-build: install dep
	@echo "Running scripts before the build..."

post-build:
	@echo "Running scripts after the build is done..."

all: pre-build build post-build

test:
	@echo "Running test suites..."
	@MIX_ENV=test mix test

dialyzer:
	@echo "Running dialyzer..."
	@mix dialyzer

doc:
	@echo "Building the documentation..."

precommit: pre-build build post-build test

travis: precommit

travis-deploy:
	@echo "Deploy the software by travis"
	@make release

clean:
	@echo "Cleaning the build..."

watch:
	@make build
	@echo "Watching templates and slides changes..."
	@fswatch -o lib/ config/ | xargs -n1 -I{} make build

run:
	@echo "Running the software..."
	@iex -S mix

# warning: if you rebuild-proto, please remove the grpc definition in the compiled file. Those parts are not used. If we keep them, we need to include the grpc library, which is unnecessary.
rebuild-proto:
	@rm -rf $(PROTOS)/*.pb.ex
	@protoc -I $(PROTOS) --elixir_out=plugins=grpc:$(PROTOS) $(PROTOS)/*.proto
	@echo "New protobuf files created for tendermint ABCI."


rebuild-deps:
	@rm -rf mix.lock;
	@make dep


include .makefiles/*.mk

.PHONY: build init travis-init install dep pre-build post-build all test dialyzer doc precommit travis clean watch run bump-version create-pr submodule build-release
