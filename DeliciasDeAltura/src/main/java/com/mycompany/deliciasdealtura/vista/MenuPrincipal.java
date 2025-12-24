// Descripción: Form del menú principal

package com.mycompany.deliciasdealtura.vista;

import javax.swing.*;
import java.awt.*;
import com.mycompany.deliciasdealtura.util.Estilos;
import com.mycompany.deliciasdealtura.util.Fondo;

public class MenuPrincipal extends javax.swing.JFrame {
    
    private JButton btnPedido;
    private JButton btnClientes;
    private JButton btnProductos;
    private JButton btnPlatos;
    private JButton btnVentas;
    
    public MenuPrincipal() {
        setTitle("Delicias de Altura");
        setSize(450, 420);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setContentPane(new Fondo());
        setLayout(null);

        inicializarComponentes();
    }
    
    
    
    private void inicializarComponentes() {

        // Título
        JLabel lblTitulo = new JLabel("Delicias de Altura", SwingConstants.CENTER);
        lblTitulo.setFont(new Font("Segoe UI", Font.BOLD, 22));
        lblTitulo.setBounds(60, 30, 300, 30);
        add(lblTitulo);

        // Subtítulo
        JLabel lblSubtitulo = new JLabel("Sistema de Gestión del Restaurante", SwingConstants.CENTER);
        lblSubtitulo.setFont(new Font("Segoe UI", Font.PLAIN, 12));
        lblSubtitulo.setBounds(60, 65, 300, 20);
        add(lblSubtitulo);

        int x = 120;
        int y = 100;
        int ancho = 200;
        int alto = 40;
        int espacio = 45;

        btnPedido = new JButton("Registrar Pedido");
        btnPedido.setBounds(x, y, ancho, alto);
        Estilos.botonPrincipal(btnPedido);
        add(btnPedido);

        btnClientes = new JButton("Gestionar Clientes");
        btnClientes.setBounds(x, y + espacio, ancho, alto);
        Estilos.botonPrincipal(btnClientes);
        add(btnClientes);

        btnProductos = new JButton("Gestionar Productos");
        btnProductos.setBounds(x, y + espacio * 2, ancho, alto);
        Estilos.botonPrincipal(btnProductos);
        add(btnProductos);

        btnPlatos = new JButton("Gestionar Platos");
        btnPlatos.setBounds(x, y + espacio * 3, ancho, alto);
        Estilos.botonPrincipal(btnPlatos);
        add(btnPlatos);

        btnVentas = new JButton("Ver Ventas");
        btnVentas.setBounds(x, y + espacio * 4, ancho, alto);
        Estilos.botonPrincipal(btnVentas);
        add(btnVentas);

        // EVENTOS
        btnPedido.addActionListener(e -> new FormPedido().setVisible(true));
        btnClientes.addActionListener(e -> new FormCliente().setVisible(true));
        btnProductos.addActionListener(e -> new FormProducto().setVisible(true));
        btnPlatos.addActionListener(e -> new FormPlato().setVisible(true));
        btnVentas.addActionListener(e -> new FormReporteVentas().setVisible(true));
    }
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setBackground(new java.awt.Color(204, 204, 204));
        setPreferredSize(new java.awt.Dimension(450, 420));
        setResizable(false);
        setSize(new java.awt.Dimension(450, 420));

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
