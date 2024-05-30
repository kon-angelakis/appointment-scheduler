# appointment-scheduler
 A webapp made using java servlets where a student can manage and make appointments with the professor he wants

To run you need Tomcat 11 and java sdk 22  
Once installed open intellij configure Tomcat home and then in the deployment tab remove the artifact and add a new exploded one, (also remove the Application context at the bottom)  
Once the above steps are done you should be able to run it  

To setup the database  
In the src/main/java/Classes find the jdbc_connector class and change the DB_URL DB_Username DB_Password and port to connect to your database the table creation sql is provided in the sql.sql file and some data will also be included in the db_data.txt  
