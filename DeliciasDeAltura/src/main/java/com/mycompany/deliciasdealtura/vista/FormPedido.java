package com.mycompany.deliciasdealtura.vista;

import com.mycompany.deliciasdealtura.conexion.Conexion;
import com.mycompany.deliciasdealtura.modelo.ClienteItem;
import com.mycompany.deliciasdealtura.modelo.PlatoItem;
import com.mycompany.deliciasdealtura.util.Estilos;

import javax.swing.*;
import java.awt.*;
import java.sql.*;

public class FormPedido extends javax.swing.JFrame {
    
    private JComboBox<ClienteItem> comboCliente;
    private JComboBox<PlatoItem> comboPlato;
    private JTextField txtCantidad;
    
    public FormPedido() {
        setTitle("Registrar Pedido");
        setSize(420, 320);
        setLocationRelativeTo(null);
        setLayout(null);

        JLabel lblTitulo = new JLabel("Nuevo Pedido", SwingConstants.CENTER);
        lblTitulo.setFont(new Font("Arial", Font.BOLD, 18));
        lblTitulo.setBounds(110, 20, 200, 30);
        add(lblTitulo);

        // CLIENTE
        JLabel lblCliente = new JLabel("Cliente:");
        lblCliente.setBounds(50, 70, 100, 25);
        add(lblCliente);

        comboCliente = new JComboBox<>();
        comboCliente.setBounds(150, 70, 200, 25);
        add(comboCliente);

        // PLATO
        JLabel lblPlato = new JLabel("Plato:");
        lblPlato.setBounds(50, 110, 100, 25);
        add(lblPlato);

        comboPlato = new JComboBox<>();
        comboPlato.setBounds(150, 110, 200, 25);
        add(comboPlato);

        // CANTIDAD
        JLabel lblCantidad = new JLabel("Cantidad:");
        lblCantidad.setBounds(50, 150, 100, 25);
        add(lblCantidad);

        txtCantidad = new JTextField();
        txtCantidad.setBounds(150, 150, 200, 25);
        add(txtCantidad);

        // BOTÓN
        JButton btnConfirmar = new JButton("Confirmar Pedido");
        btnConfirmar.setBounds(120, 210, 180, 40);
        Estilos.botonPrincipal(btnConfirmar);
        add(btnConfirmar);

        btnConfirmar.addActionListener(e -> registrarPedido());

        // cargar datos
        cargarClientes();
        cargarPlatos();
    }

    // =======================
    // CARGAR CLIENTES
    // =======================
    private void cargarClientes() {
        String sql = "SELECT id_cliente, nombre FROM clientes";

        try (Connection con = Conexion.getConexion();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            comboCliente.removeAllItems();

            while (rs.next()) {
                comboCliente.addItem(
                    new ClienteItem(
                        rs.getInt("id_cliente"),
                        rs.getString("nombre")
                    )
                );
            }

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error al cargar clientes");
            e.printStackTrace();
        }
    }

    // =======================
    // CARGAR PLATOS
    // =======================
    private void cargarPlatos() {
        String sql = "SELECT id_plato, nombre FROM platos";

        try (Connection con = Conexion.getConexion();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            comboPlato.removeAllItems();

            while (rs.next()) {
                comboPlato.addItem(
                    new PlatoItem(
                        rs.getInt("id_plato"),
                        rs.getString("nombre")
                    )
                );
            }

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error al cargar platos");
            e.printStackTrace();
        }
    }

    // =======================
    // REGISTRAR PEDIDO
    // =======================
    private void registrarPedido() {

        try {
            ClienteItem cliente = (ClienteItem) comboCliente.getSelectedItem();
            PlatoItem plato = (PlatoItem) comboPlato.getSelectedItem();

            if (cliente == null || plato == null) {
                JOptionPane.showMessageDialog(this, "Seleccione cliente y plato");
                return;
            }

            int cantidad = Integer.parseInt(txtCantidad.getText());

            Connection con = Conexion.getConexion();
            CallableStatement cs = con.prepareCall("{CALL registrar_pedido(?, ?, ?)}");

            cs.setInt(1, cliente.getId());
            cs.setInt(2, plato.getId());
            cs.setInt(3, cantidad);

            cs.execute();

            JOptionPane.showMessageDialog(this, "✅ Pedido registrado correctamente");

            txtCantidad.setText("");

        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, "❌ Error: " + ex.getMessage());
            ex.printStackTrace();
        }
    }
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 400, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 300, Short.MAX_VALUE)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    /**
     * @param args the command line arguments
     */
    // Variables declaration - do not modify//GEN-BEGIN:variables
    // End of variables declaration//GEN-END:variables
}