package com.miky;
import static com.miky.model.Split.split;
import static com.miky.model.Split.split2;

import java.sql.Connection;
import java.sql.SQLException;
import com.miky.config.DatabaseConnection;

public class Main {
    public static void main(String[] args) {

        System.out.println("primer split");
        split(600, 20, 30);
        split2(1200, 22, 30, 24, 20, 4);

        System.out.println("Iniciando prueba de conexión a Aiven (PostgreSQL)...");
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("==========================================");
                System.out.println("¡CONEXIÓN EXITOSA!");
                System.out.println("Conectado a: " + conn.getMetaData().getDatabaseProductName());
                System.out.println("Versión: " + conn.getMetaData().getDatabaseProductVersion());
                System.out.println("==========================================");
            }
        } catch (SQLException e) {
            System.err.println("❌ ERROR DE CONEXIÓN:");
            System.err.println("Mensaje: " + e.getMessage());
            System.err.println("Estado SQL: " + e.getSQLState());
            
        }
    }
}