# Docker - Node and MySQL Demo
### Note : Storing password in plaintext is not secure and best practice. We are doing here only for demo purpose.
As a part of this demo we are going to do connectivity between Node docker container and mysql docker continer. We are going to permoform below operations.
1. Connect to Database
2. Create Table
3. Insert Data into table
4. Get data from table.

## Steps
1. Create Docker network for Node and MySql container.
   `docker network create webapp`

Here `webapp` is network name, you can change this netwrok as per your requirement.

2. Run mysql container using below command.

```docker run --name mysqldatabase --network webapp  -e MYSQL_ROOT_PASSWORD=pa55w0rd -d mysql```

Here, we will be over-ridding mysql root passowrd. Also we need to make sure that mysql container runs under network that we created above. Name of container is here `mysqldatabase`, you can also change this.
3. Now, we need to create database inside mysql container. You can do this by getting into container.
`docker exec -it <container-id/container-id> sh`
e.g.
`docker exec -it mysqldatabase sh`

Once you are in container, run below mysql commands

To login:
`mysql -uroot -p`

Enter root password.

Create database
`CREATE DATABASE webapp_db`

4. Now refer, index.js file from repo and modify database connection:

``` JS
const mysqlConfig = {
  host: "mysqldatabase",
  user: "root",
  password: "pa55w0rd",
  database: "webapp_db"
}
```
Here Host is name of container that you gave while running mysql container.
5. Once Database connection modified, you can build docker image.
`docker build -t mysql-nodapp:1.0 .`

You can change tag as per your requirement.

6. Once build is successful, you should have docker image ready. `docker image ls`
7. Run container from the image you build. 
`docker run -p 3300:3000 --network webapp mysql-nodapp:1.3`

Here again, you need to put this container under same network you have created.

## Test
1. In browser, past below URLs to check
   1. localhost:3300 : It should give hello world output
   2. localhost:3300/connect : It will check if Database connection is successful or not
   3. localhost:3300/create-table: Create table in database
   4. localhost:3300/insert: Insert data in table.
   5. localhost:3300/fetch: Get data from table.