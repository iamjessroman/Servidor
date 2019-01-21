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
public class Coordenates {
    private String idSpaceParking;
    private int statusParking;
    private int isEnable;

    public int getIsEnable() {
        return isEnable;
    }

    public void setIsEnable(int isEnable) {
        this.isEnable = isEnable;
    }
    private aCoords Coords;
    private float angle;
    private itext coordText;
    private igroup coordGroup;
    private int width;
    private int height;

    public int getWidth() {
        return width;
    }

    public void setWidth(int width) {
        this.width = width;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public igroup getCoordGroup() {
        return coordGroup;
    }

    public void setCoordGroup(igroup coordGroup) {
        this.coordGroup = coordGroup;
    }

    public itext getCoordText() {
        return coordText;
    }

    public void setCoordText(itext coordText) {
        this.coordText = coordText;
    }

    public irect getCoordRect() {
        return coordRect;
    }

    public void setCoordRect(irect coordRect) {
        this.coordRect = coordRect;
    }
    private irect coordRect;
    

    public String getIdSpaceParking() {
        return idSpaceParking;
    }

    public void setIdSpaceParking(String idSpaceParking) {
        this.idSpaceParking = idSpaceParking;
    }

    public int getStatusParking() {
        return statusParking;
    }

    public void setStatusParking(int statusParking) {
        this.statusParking = statusParking;
    }

    public aCoords getCoords() {
        return Coords;
    }

    public void setCoords(aCoords Coords) {
        this.Coords = Coords;
    }

    public float getAngle() {
        return angle;
    }

    public void setAngle(float angle) {
        this.angle = angle;
    }

    public Rect getRotate() {
        return rotate;
    }

    public void setRotate(Rect rotate) {
        this.rotate = rotate;
    }
    private Rect rotate; 
}
