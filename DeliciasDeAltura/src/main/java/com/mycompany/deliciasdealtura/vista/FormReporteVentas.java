package com.mycompany.deliciasdealtura.vista;

import com.mycompany.deliciasdealtura.conexion.Conexion;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.sql.*;

public class FormReporteVentas extends javax.swing.JFrame {
    private JTable tabla;
    private DefaultTableModel modelo;
    private JLabel lblTotal;
    
    public FormReporteVentas() {
        setTitle("Reporte de Ventas");
        setSize(550, 400);
        setLocationRelativeTo(null);
        setLayout(null);

        JLabel lblTitulo = new JLabel("Reporte de Ventas", SwingConstants.CENTER);
        lblTitulo.setFont(new Font("Arial", Font.BOLD, 18));
        lblTitulo.setBounds(150, 10, 250, 30);
        add(lblTitulo);

        modelo = new DefaultTableModel(
                new String[]{"Factura", "Cliente", "Total", "Fecha"}, 0
        );
        tabla = new JTable(modelo);
        JScrollPane scroll = new JScrollPane(tabla);
        scroll.setBounds(30, 60, 480, 230);
        add(scroll);

        lblTotal = new JLabel("Total Ventas: ₡0.00", SwingConstants.RIGHT);
        lblTotal.setFont(new Font("Arial", Font.BOLD, 14));
        lblTotal.setBounds(280, 300, 230, 30);
        add(lblTotal);

        cargarVentas();
        calcularTotal();
    }
    
    private void cargarVentas() {
        try {
            modelo.setRowCount(0);
            Connection con = Conexion.getConexion();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM vista_ventas");

            while (rs.next()) {
                modelo.addRow(new Object[]{
                        rs.getInt("id_factura"),
                        rs.getString("cliente"),
                        rs.getDouble("total"),
                        rs.getTimestamp("fecha")
                });
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this, ex.getMessage());
        }
    }

    private void calcularTotal() {
        try {
            Connection con = Conexion.getConexion();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT SUM(total) AS total FROM vista_ventas");

            if (rs.next()) {
                double total = rs.getDouble("total");
                lblTotal.setText("Total Ventas: ₡" + total);
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this, ex.getMessage());
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

    // Variables declaration - do not modify//GEN-BEGIN:variables
    // End of variables declaration//GEN-END:variables
}
