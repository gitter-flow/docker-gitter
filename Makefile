include variables.env
export

.SECONDARY: main-build

.DEFAULT_GOAL := help
SHELL := /bin/bash
ENV_FILE=variables.env

APP_REPO=git@github.com:gitter-flow/app.git
APP_FOLDER=app
CODE_API_REPO=git@github.com:gitter-flow/code-api.git
CODE_API_FOLDER=code-api
SOCIAL_API_REPO=git@github.com:gitter-flow/social-api.git
SOCIAL_API_FOLDER=social-api
KEYCLOAK_EVENT_LISTENER_REPO=https://github.com/gitter-flow/keycloak-event-listener
KEYCLOAK_EVENT_LISTENER_FOLDER=keycloak-event-listener


help: banner ## Show help for all targets
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-30s\033[0m %s\n", $$1, $$2}'
.PHONY: help

all: ## Clone repo and run containers
	$(MAKE) clone
	$(MAKE) up
.PHONY: all

clear: ## Clear all generated folders
	@rm -rf $(INFRASTRUCTURE_API_FOLDER)
.PHONY: clear

_clone: ## Clone a repository
	@git clone $(REPO) $(DIR)
.PHONY: _clone

clone: ## Clone Gitter repositories
	$(MAKE) _clone REPO=$(APP_REPO) DIR=$(APP_FOLDER)
	$(MAKE) _clone REPO=$(CODE_API_REPO) DIR=$(CODE_API_FOLDER)
	$(MAKE) _clone REPO=$(SOCIAL_API_REPO) DIR=$(SOCIAL_API_FOLDER)
	$(MAKE) _clone REPO=$(KEYCLOAK_EVENT_LISTENER_REPO) DIR=$(KEYCLOAK_EVENT_LISTENER_FOLDER)
.PHONY: clone

clear-repo: ## Remove cloned repositories
	@rm -rf $(APP_FOLDER) $(CODE_API_FOLDER) $(SOCIAL_API_FOLDER)
.PHONY: clear-repo

rm: ## Remove Gitter containers
	@docker-compose rm
.PHONY: rm

up:  ## Run Gitter containers
	$(MAKE) env
	@docker compose up -V -d --build
.PHONY: up

ps: banner ## List Gitter containers
	@docker compose ps
.PHONY: ps

logs: ## Show Gitter containers logs [svc=<container> for 1 container]
	@docker compose logs -f $(SVC)
.PHONY: logs

nuke-containers:
	@docker rm -f $(docker ps -aq)
.PHONY: nuke-containers

env: ## Set environment variables
	@set -a && source $(ENV_FILE)
.PHONY: .env

banner:
	@cat .assets/banner.txt
.PHONY: banner

