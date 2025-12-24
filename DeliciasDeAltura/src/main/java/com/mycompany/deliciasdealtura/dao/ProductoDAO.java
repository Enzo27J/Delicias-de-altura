package com.mycompany.deliciasdealtura.dao;

import com.mycompany.deliciasdealtura.conexion.Conexion;
import com.mycompany.deliciasdealtura.modelo.Producto;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

    public void insertar(Producto p) throws SQLException {
        String sql = "INSERT INTO productos(nombre, stock, precio_unitario, id_proveedor) VALUES (?, ?, ?, ?)";
        Connection con = Conexion.getConexion();
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, p.getNombre());
        ps.setInt(2, p.getStock());
        ps.setDouble(3, p.getPrecio());
        ps.setInt(4, p.getIdProveedor());

        ps.executeUpdate();
    }

    public List<Producto> listar() throws SQLException {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT * FROM productos";

        Connection con = Conexion.getConexion();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(sql);

        while (rs.next()) {
            Producto p = new Producto();
            p.setIdProducto(rs.getInt("id_producto"));
            p.setNombre(rs.getString("nombre"));
            p.setStock(rs.getInt("stock"));
            p.setPrecio(rs.getDouble("precio_unitario"));
            p.setIdProveedor(rs.getInt("id_proveedor"));
            lista.add(p);
        }
        return lista;
    }

    public void actualizar(Producto p) throws SQLException {
        String sql = "UPDATE productos SET nombre=?, stock=?, precio_unitario=?, id_proveedor=? WHERE id_producto=?";
        Connection con = Conexion.getConexion();
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, p.getNombre());
        ps.setInt(2, p.getStock());
        ps.setDouble(3, p.getPrecio());
        ps.setInt(4, p.getIdProveedor());
        ps.setInt(5, p.getIdProducto());

        ps.executeUpdate();
    }

    public void eliminar(int id) throws SQLException {
        String sql = "DELETE FROM productos WHERE id_producto=?";
        Connection con = Conexion.getConexion();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        ps.executeUpdate();
    }
}