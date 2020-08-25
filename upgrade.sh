docker stop stock-db
docker rm stock-db
git pull origin setup
docker pull mysql/mysql-server
docker run --name=stock-db -d mysql/mysql-server
echo "Sleeping for 10 seconds to let the instance start"

sleep  10
password_str=`docker logs stock-db 2>&1 | grep GENERATE`
# Set space as the delimiter
IFS=' '
read -a password_arr <<< "$password_str"
password=${password_arr[4]}

read -sp 'Root Password: ' new_password
echo ""

docker exec -it stock-db mysql --user="root" --password="$password" --execute="ALTER USER 'root'@'localhost' IDENTIFIED BY '$new_password';" --connect-expired-password

echo "Use this command to login to MySQL:"
echo "docker exec -it stock-db mysql -uroot -p"
