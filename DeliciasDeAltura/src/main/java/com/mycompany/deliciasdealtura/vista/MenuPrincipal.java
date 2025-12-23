// Descripción: Form del menú principal

package com.mycompany.deliciasdealtura.vista;

import javax.swing.*;
import java.awt.*;
import com.mycompany.deliciasdealtura.util.Estilos;

public class MenuPrincipal extends javax.swing.JFrame {
    
    private JButton btnPedido;
    
    public MenuPrincipal() {
        setTitle("Delicias de Altura");
        setSize(420, 300);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(null); // simple y directo

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

        // Botón Registrar Pedido
        btnPedido = new JButton("Registrar Pedido");
        btnPedido.setBounds(110, 130, 200, 45);
        Estilos.botonPrincipal(btnPedido);
        add(btnPedido);

        btnPedido.addActionListener(e -> {
            new FormPedido().setVisible(true);
        });
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
