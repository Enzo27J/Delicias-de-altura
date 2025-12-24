package com.mycompany.deliciasdealtura.dao;

import com.mycompany.deliciasdealtura.conexion.Conexion;
import com.mycompany.deliciasdealtura.modelo.Cliente;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {

    // INSERTAR
    public void insertar(Cliente cliente) throws SQLException {
        String sql = "INSERT INTO clientes(nombre, telefono) VALUES (?, ?)";

        Connection con = Conexion.getConexion();
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, cliente.getNombre());
        ps.setString(2, cliente.getTelefono());

        ps.executeUpdate();
    }

    // LISTAR
    public List<Cliente> listar() throws SQLException {
        List<Cliente> lista = new ArrayList<>();
        String sql = "SELECT * FROM clientes";

        Connection con = Conexion.getConexion();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(sql);

        while (rs.next()) {
            Cliente c = new Cliente();
            c.setIdCliente(rs.getInt("id_cliente"));
            c.setNombre(rs.getString("nombre"));
            c.setTelefono(rs.getString("telefono"));
            lista.add(c);
        }

        return lista;
    }

    // ACTUALIZAR
    public void actualizar(Cliente cliente) throws SQLException {
        String sql = "UPDATE clientes SET nombre=?, telefono=? WHERE id_cliente=?";

        Connection con = Conexion.getConexion();
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, cliente.getNombre());
        ps.setString(2, cliente.getTelefono());
        ps.setInt(3, cliente.getIdCliente());

        ps.executeUpdate();
    }

    // ELIMINAR
    public void eliminar(int idCliente) throws SQLException {
        String sql = "DELETE FROM clientes WHERE id_cliente=?";

        Connection con = Conexion.getConexion();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, idCliente);

        ps.executeUpdate();
    }
}