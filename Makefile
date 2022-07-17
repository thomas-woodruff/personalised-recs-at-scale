NAME=recs

.PHONY: bash
bash: clean build
	docker-compose run --service-ports --name $(NAME) $(NAME) bash

.PHONY: build
build:
	docker-compose build $(NAME)

.PHONY: clean
clean: clean-container clean-image

.PHONY: clean-container
clean-container:
	docker rm -f $(NAME) || true

.PHONY: clean-image
clean-image:
	docker image rm $(NAME)_$(NAME) || true