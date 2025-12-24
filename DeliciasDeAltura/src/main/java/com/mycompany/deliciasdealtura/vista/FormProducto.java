package com.mycompany.deliciasdealtura.vista;

import com.mycompany.deliciasdealtura.dao.ProductoDAO;
import com.mycompany.deliciasdealtura.modelo.Producto;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.sql.SQLException;
import java.util.List;

public class FormProducto extends javax.swing.JFrame {
    private JTextField txtId, txtNombre, txtStock, txtPrecio, txtProveedor;
    private JTable tabla;
    private DefaultTableModel modelo;
    private ProductoDAO dao = new ProductoDAO();
    
    public FormProducto() {
        setTitle("CRUD Productos");
        setSize(600, 420);
        setLocationRelativeTo(null);
        setLayout(null);

        JLabel lblTitulo = new JLabel("Gestión de Productos", SwingConstants.CENTER);
        lblTitulo.setFont(new Font("Arial", Font.BOLD, 18));
        lblTitulo.setBounds(150, 10, 300, 30);
        add(lblTitulo);

        JLabel lblId = new JLabel("ID:");
        lblId.setBounds(30, 60, 100, 25);
        add(lblId);

        txtId = new JTextField();
        txtId.setBounds(120, 60, 80, 25);
        txtId.setEnabled(false);
        add(txtId);

        JLabel lblNombre = new JLabel("Nombre:");
        lblNombre.setBounds(30, 90, 100, 25);
        add(lblNombre);

        txtNombre = new JTextField();
        txtNombre.setBounds(120, 90, 150, 25);
        add(txtNombre);

        JLabel lblStock = new JLabel("Stock:");
        lblStock.setBounds(30, 120, 100, 25);
        add(lblStock);

        txtStock = new JTextField();
        txtStock.setBounds(120, 120, 150, 25);
        add(txtStock);

        JLabel lblPrecio = new JLabel("Precio:");
        lblPrecio.setBounds(30, 150, 100, 25);
        add(lblPrecio);

        txtPrecio = new JTextField();
        txtPrecio.setBounds(120, 150, 150, 25);
        add(txtPrecio);

        JLabel lblProveedor = new JLabel("ID Proveedor:");
        lblProveedor.setBounds(30, 180, 100, 25);
        add(lblProveedor);

        txtProveedor = new JTextField();
        txtProveedor.setBounds(120, 180, 150, 25);
        add(txtProveedor);

        JButton btnGuardar = new JButton("Guardar");
        btnGuardar.setBounds(300, 90, 150, 30);
        add(btnGuardar);

        JButton btnActualizar = new JButton("Actualizar");
        btnActualizar.setBounds(300, 130, 150, 30);
        add(btnActualizar);

        JButton btnEliminar = new JButton("Eliminar");
        btnEliminar.setBounds(300, 170, 150, 30);
        add(btnEliminar);

        modelo = new DefaultTableModel(
                new String[]{"ID", "Nombre", "Stock", "Precio", "Proveedor"}, 0
        );
        tabla = new JTable(modelo);
        JScrollPane scroll = new JScrollPane(tabla);
        scroll.setBounds(30, 230, 520, 130);
        add(scroll);

        cargarProductos();

        btnGuardar.addActionListener(e -> guardar());
        btnActualizar.addActionListener(e -> actualizar());
        btnEliminar.addActionListener(e -> eliminar());

        tabla.getSelectionModel().addListSelectionListener(e -> {
            if (!e.getValueIsAdjusting()) {
                int f = tabla.getSelectedRow();
                if (f != -1) {
                    txtId.setText(tabla.getValueAt(f, 0).toString());
                    txtNombre.setText(tabla.getValueAt(f, 1).toString());
                    txtStock.setText(tabla.getValueAt(f, 2).toString());
                    txtPrecio.setText(tabla.getValueAt(f, 3).toString());
                    txtProveedor.setText(tabla.getValueAt(f, 4).toString());
                }
            }
        });
    }
    
    private void cargarProductos() {
        try {
            modelo.setRowCount(0);
            List<Producto> lista = dao.listar();
            for (Producto p : lista) {
                modelo.addRow(new Object[]{
                        p.getIdProducto(),
                        p.getNombre(),
                        p.getStock(),
                        p.getPrecio(),
                        p.getIdProveedor()
                });
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this, ex.getMessage());
        }
    }

    private void guardar() {
        try {
            Producto p = new Producto();
            p.setNombre(txtNombre.getText());
            p.setStock(Integer.parseInt(txtStock.getText()));
            p.setPrecio(Double.parseDouble(txtPrecio.getText()));
            p.setIdProveedor(Integer.parseInt(txtProveedor.getText()));

            dao.insertar(p);
            cargarProductos();
            limpiar();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, ex.getMessage());
        }
    }

    private void actualizar() {
        try {
            Producto p = new Producto();
            p.setIdProducto(Integer.parseInt(txtId.getText()));
            p.setNombre(txtNombre.getText());
            p.setStock(Integer.parseInt(txtStock.getText()));
            p.setPrecio(Double.parseDouble(txtPrecio.getText()));
            p.setIdProveedor(Integer.parseInt(txtProveedor.getText()));

            dao.actualizar(p);
            cargarProductos();
            limpiar();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, ex.getMessage());
        }
    }

    private void eliminar() {
        try {
            dao.eliminar(Integer.parseInt(txtId.getText()));
            cargarProductos();
            limpiar();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, ex.getMessage());
        }
    }

    private void limpiar() {
        txtId.setText("");
        txtNombre.setText("");
        txtStock.setText("");
        txtPrecio.setText("");
        txtProveedor.setText("");
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
