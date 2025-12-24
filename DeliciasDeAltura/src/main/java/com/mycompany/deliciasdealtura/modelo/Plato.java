package com.mycompany.deliciasdealtura.modelo;

public class Plato {

    private int idPlato;
    private String nombre;
    private double precio;

    public Plato() {
    }

    public Plato(int idPlato, String nombre, double precio) {
        this.idPlato = idPlato;
        this.nombre = nombre;
        this.precio = precio;
    }

    public int getIdPlato() {
        return idPlato;
    }

    public void setIdPlato(int idPlato) {
        this.idPlato = idPlato;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }
}