# pruebaSysman

![image](https://github.com/user-attachments/assets/d11ef389-8bbf-4c25-b419-d2e1c82ef2d3)

Se ejecutaron las pruebas correctamente usando apache-tomcat.
![image](https://github.com/user-attachments/assets/fe722de1-c0eb-4162-a4c8-bfe6abb6eef9)
Las pruebas tuvieron un 100% de efectividad.

Los script's de PK y de tablas están en el archivo SQL.
Apis;

http://localhost:8080/taskmanager/api/tasks - POST - Creación
http://localhost:8080/taskmanager/api/tasks/{ID} - PUT - Actualización
http://localhost:8080/taskmanager/api/tasks - GET - Extraer todas
http://localhost:8080/taskmanager/api/tasks/{ID} - GET - Extraer por ID
http://localhost:8080/taskmanager/api/tasks/{ID} - DELETE - Elimina por ID

Conexión a BD - URL: jdbc:oracle:thin:@192.168.1.147:1521:XE
usuario: system
contraseña: Leito9803
