package com.miky.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    // Los datos los obtienes de tu consola de Aiven (Service URI)
    // El puerto por defecto de Postgres es 5432
    //private static final String URL = "jdbc:postgresql://tu-host-aiven.aivencloud.com:puerto/defaultdb?sslmode=require";
    private static final String URL = System.getenv("DB_URL");
    private static final String USER = System.getenv("DB_USER");
    private static final String PASSWORD = System.getenv("DB_PASSWORD");

    public static Connection getConnection() throws SQLException {
        try {
            // Es buena práctica cargar explícitamente el driver en Java puro
            Class.forName("org.postgresql.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("No se encontró el driver de PostgreSQL", e);
        }
    }
}