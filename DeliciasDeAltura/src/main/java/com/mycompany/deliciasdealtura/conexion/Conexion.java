package com.mycompany.deliciasdealtura.conexion;



import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {

    public static Connection getConexion() {
        try {
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/delicias_altura",
                "root",
                "root123"
            );
            System.out.println("✅ Conexión exitosa");
            return con;

        } catch (Exception e) {
            System.out.println("❌ Error de conexión:");
            e.printStackTrace(); // MUY IMPORTANTE
            return null;
        }
    }
}

