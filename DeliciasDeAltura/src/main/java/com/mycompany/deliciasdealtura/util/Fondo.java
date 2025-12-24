package com.mycompany.deliciasdealtura.util;

import javax.swing.*;
import java.awt.*;

public class Fondo extends JPanel {

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);

        Graphics2D g2 = (Graphics2D) g;
        GradientPaint gp = new GradientPaint(
            0, 0, new Color(210, 225, 245),   // azul claro más presente
            0, getHeight(), new Color(170, 200, 235) // azul frío más intenso
        );



        g2.setPaint(gp);
        g2.fillRect(0, 0, getWidth(), getHeight());
    }
}