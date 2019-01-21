/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ute.models.coordenates;

/**
 *
 * @author oswal
 */
public class aCoords {
    private Point br;

    public Point getBr() {
        return br;
    }

    public void setBr(Point br) {
        this.br = br;
    }

    public Point getBl() {
        return bl;
    }

    public void setBl(Point bl) {
        this.bl = bl;
    }

    public Point getTr() {
        return tr;
    }

    public void setTr(Point tr) {
        this.tr = tr;
    }

    public Point getTl() {
        return tl;
    }

    public void setTl(Point tl) {
        this.tl = tl;
    }
    private Point bl;
    private Point tr;
    private Point tl;
    
}
