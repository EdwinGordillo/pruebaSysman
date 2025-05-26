package com.tareas.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:oracle:thin:@192.168.1.147:1521:XE";
    private static final String USER = "system";
    private static final String PASSWORD = "Leito9803";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("oracle.jdbc.OracleDriver");  // Carga explícita del driver Oracle
        } catch (ClassNotFoundException e) {
            throw new SQLException("No se pudo cargar el driver Oracle JDBC", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}