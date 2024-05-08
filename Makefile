context_file = ctx.yaml
user = 1000
group = 1000

start: ## start all
	docker compose up -d
	docker compose logs -f
stop: ## stop all
	docker compose down --remove-orphans
logs: ## view logs
	docker compose logs -f
install: ## install dependencies
	docker compose run frontend --rm bash -c "npm install"

	# docker compose run admin_panel bash -c "npm install"
	# docker compose run backend bash -c "npm install"
	# docker compose run frontend bash -c "npm install"
	# &bbdd_start

owner_fixer: ## arregla permisos de root
	docker compose -f $(context_file) run --rm tools bash -c "chown -R 1000:1000 /app"

ng: ## inicializa cliente angular
	docker compose -f $(context_file) run -it --rm -u $(user):$(group) angular
ng-legacy:  ## inicializa cliente angular heredado
	docker compose -f $(context_file) run -it --rm -u $(user):$(group) angular-legacy bash
nestjs:  ## inicializa cliente nestjs
	docker compose -f $(context_file) run -it --rm -u $(user):$(group) nestjs bash
dotnet:  ## inicializa cliente dotnet
	docker compose -f $(context_file) run -it --rm -u $(user):$(group) dotnet
bbdd_start: ## despliega datos en la base de datos
	docker compose run bbdd bash -c "dump -f /fixture/archivo.sql "
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
