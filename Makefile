postgres:
	docker run --name postgres12 --network bank-network -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -p 5431:5432 -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres12 dropdb simple_bank

migrateup:
	migrate -path db/migration --database "postgresql://root:secret@localhost:5431/simple_bank?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration --database "postgresql://root:secret@localhost:5431/simple_bank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration --database "postgresql://root:secret@localhost:5431/simple_bank?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration --database "postgresql://root:secret@localhost:5431/simple_bank?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/Joris1Jansen/simplebank/db/sqlc Store

testapi:
	go test -v -cover ./api

tf-init:
	docker-compose -f ./.deploy/$(env)/docker-compose.yaml run --rm terraform init

tf-init-nb:
	cd ./.deploy/$(env)/tf  && terraform init -backend=false

tf-fmt:
	docker-compose -f ./.deploy/$(env)/docker-compose.yaml run --rm terraform fmt

tf-fmt-check:
	cd ./.deploy/$(env)/tf  && terraform fmt -check

tf-val:
	docker-compose -f ./.deploy/$(env)/docker-compose.yaml run --rm terraform validate

tf-val-check:
	cd ./.deploy/$(env)/tf && terraform validate

tf-plan:
	docker-compose -f ./.deploy/$(env)/docker-compose.yaml run --rm terraform plan

tf-apply:
	docker-compose -f ./.deploy/$(env)/docker-compose.yaml run --rm terraform apply

tf-destroy:
	docker-compose -f ./.deploy/$(env)/docker-compose.yaml run --rm terraform destroy

.PHONY: postgres createdb dropdb migrateup migrateup1 migratedown migratedown1 sqlc test server mock
