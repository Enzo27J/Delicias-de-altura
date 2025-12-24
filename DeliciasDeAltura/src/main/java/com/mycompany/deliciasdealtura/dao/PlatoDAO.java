package com.mycompany.deliciasdealtura.dao;

import com.mycompany.deliciasdealtura.conexion.Conexion;
import com.mycompany.deliciasdealtura.modelo.Plato;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PlatoDAO {

    public void insertar(Plato p) throws SQLException {
        String sql = "INSERT INTO platos(nombre, precio) VALUES (?, ?)";
        Connection con = Conexion.getConexion();
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, p.getNombre());
        ps.setDouble(2, p.getPrecio());

        ps.executeUpdate();
    }

    public List<Plato> listar() throws SQLException {
        List<Plato> lista = new ArrayList<>();
        String sql = "SELECT * FROM platos";

        Connection con = Conexion.getConexion();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(sql);

        while (rs.next()) {
            Plato p = new Plato();
            p.setIdPlato(rs.getInt("id_plato"));
            p.setNombre(rs.getString("nombre"));
            p.setPrecio(rs.getDouble("precio"));
            lista.add(p);
        }
        return lista;
    }

    public void actualizar(Plato p) throws SQLException {
        String sql = "UPDATE platos SET nombre=?, precio=? WHERE id_plato=?";
        Connection con = Conexion.getConexion();
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, p.getNombre());
        ps.setDouble(2, p.getPrecio());
        ps.setInt(3, p.getIdPlato());

        ps.executeUpdate();
    }

    public void eliminar(int idPlato) throws SQLException {
        String sql = "DELETE FROM platos WHERE id_plato=?";
        Connection con = Conexion.getConexion();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, idPlato);

        ps.executeUpdate();
    }
}