docker stop stock-db
docker rm stock-db
git pull origin master
docker pull mysql/mysql-server
docker run --name=stock-db -d mysql/mysql-server
echo "Sleeping for 10 seconds to let the instance start"
sleep  10
docker logs stock-db 2>&1 | grep GENERATE
echo ""
echo "Use this command to login to MySQL:"
echo "docker exec -it stock-db mysql -uroot -p"
