function docker-clean
	docker rm (docker ps -qa --no-trunc --filter "status=exited")
	docker rmi (docker images -f dangling=true -q)
end
