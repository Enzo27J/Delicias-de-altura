//Descripción: Clase para los platos

package com.mycompany.deliciasdealtura.modelo;

public class PlatoItem {

    private int id;
    private String nombre;

    public PlatoItem(int id, String nombre) {
        this.id = id;
        this.nombre = nombre;
    }

    public int getId() {
        return id;
    }

    @Override
    public String toString() {
        return nombre; // lo que se muestra en el ComboBox
    }
}