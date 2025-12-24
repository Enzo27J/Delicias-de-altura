package com.mycompany.deliciasdealtura.vista;

import com.mycompany.deliciasdealtura.dao.PlatoDAO;
import com.mycompany.deliciasdealtura.modelo.Plato;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.sql.SQLException;
import java.util.List;

public class FormPlato extends javax.swing.JFrame {
    private JTextField txtId, txtNombre, txtPrecio;
    private JTable tabla;
    private DefaultTableModel modelo;
    private PlatoDAO dao = new PlatoDAO();
    
    public FormPlato() {
      setTitle("CRUD Platos");
        setSize(500, 380);
        setLocationRelativeTo(null);
        setLayout(null);

        JLabel lblTitulo = new JLabel("Gestión de Platos", SwingConstants.CENTER);
        lblTitulo.setFont(new Font("Arial", Font.BOLD, 18));
        lblTitulo.setBounds(120, 10, 250, 30);
        add(lblTitulo);

        JLabel lblId = new JLabel("ID:");
        lblId.setBounds(30, 60, 80, 25);
        add(lblId);

        txtId = new JTextField();
        txtId.setBounds(100, 60, 80, 25);
        txtId.setEnabled(false);
        add(txtId);

        JLabel lblNombre = new JLabel("Nombre:");
        lblNombre.setBounds(30, 95, 80, 25);
        add(lblNombre);

        txtNombre = new JTextField();
        txtNombre.setBounds(100, 95, 150, 25);
        add(txtNombre);

        JLabel lblPrecio = new JLabel("Precio:");
        lblPrecio.setBounds(30, 130, 80, 25);
        add(lblPrecio);

        txtPrecio = new JTextField();
        txtPrecio.setBounds(100, 130, 150, 25);
        add(txtPrecio);

        JButton btnGuardar = new JButton("Guardar");
        btnGuardar.setBounds(300, 80, 150, 30);
        add(btnGuardar);

        JButton btnActualizar = new JButton("Actualizar");
        btnActualizar.setBounds(300, 120, 150, 30);
        add(btnActualizar);

        JButton btnEliminar = new JButton("Eliminar");
        btnEliminar.setBounds(300, 160, 150, 30);
        add(btnEliminar);

        modelo = new DefaultTableModel(
                new String[]{"ID", "Nombre", "Precio"}, 0
        );
        tabla = new JTable(modelo);
        JScrollPane scroll = new JScrollPane(tabla);
        scroll.setBounds(30, 210, 420, 120);
        add(scroll);

        cargarPlatos();

        btnGuardar.addActionListener(e -> guardar());
        btnActualizar.addActionListener(e -> actualizar());
        btnEliminar.addActionListener(e -> eliminar());

        tabla.getSelectionModel().addListSelectionListener(e -> {
            if (!e.getValueIsAdjusting()) {
                int fila = tabla.getSelectedRow();
                if (fila != -1) {
                    txtId.setText(tabla.getValueAt(fila, 0).toString());
                    txtNombre.setText(tabla.getValueAt(fila, 1).toString());
                    txtPrecio.setText(tabla.getValueAt(fila, 2).toString());
                }
            }
        });  
    }
    
    private void cargarPlatos() {
        try {
            modelo.setRowCount(0);
            List<Plato> lista = dao.listar();
            for (Plato p : lista) {
                modelo.addRow(new Object[]{
                        p.getIdPlato(),
                        p.getNombre(),
                        p.getPrecio()
                });
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this, ex.getMessage());
        }
    }

    private void guardar() {
        try {
            Plato p = new Plato();
            p.setNombre(txtNombre.getText());
            p.setPrecio(Double.parseDouble(txtPrecio.getText()));

            dao.insertar(p);
            cargarPlatos();
            limpiar();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, ex.getMessage());
        }
    }

    private void actualizar() {
        try {
            Plato p = new Plato();
            p.setIdPlato(Integer.parseInt(txtId.getText()));
            p.setNombre(txtNombre.getText());
            p.setPrecio(Double.parseDouble(txtPrecio.getText()));

            dao.actualizar(p);
            cargarPlatos();
            limpiar();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, ex.getMessage());
        }
    }

    private void eliminar() {
        try {
            dao.eliminar(Integer.parseInt(txtId.getText()));
            cargarPlatos();
            limpiar();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, ex.getMessage());
        }
    }

    private void limpiar() {
        txtId.setText("");
        txtNombre.setText("");
        txtPrecio.setText("");
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
