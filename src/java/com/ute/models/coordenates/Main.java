/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ute.models.coordenates;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import org.json.JSONException;

/**
 *
 * @author Jessica Roman
 */
public class Main {

    Conexion cx = new Conexion();
    

    public String getDir(int id) throws IOException, SQLException, JSONException {
        String sql = "SELECT pathImg_Parklot FROM `parklot` WHERE id_Parklot ='" + id + "'";
        String[] temp = cx.select(sql, 1, 1);
        String[] sub = temp[0].split(".jpg columns");
        String dir = sub[0].substring(0, sub[0].length() - 19);
        String parklot = getParklot(dir);
        return parklot;
    }
    
     public String getPath(int id) throws IOException, SQLException, JSONException {
        String sql = "SELECT pathImg_Parklot FROM `parklot` WHERE id_Parklot ='" + id + "'";
        String[] temp = cx.select(sql, 1, 1);
        String[] sub = temp[0].split(".jpg columns");
        String dir = sub[0].substring(0, sub[0].length() - 19);
        return dir;
    }
    
       public String getName(int id) throws IOException, SQLException, JSONException {
        String sql = "SELECT name_Parklot FROM `parklot` WHERE id_Parklot ='" + id + "'";
        String[] temp = cx.select(sql, 1, 1);
        String[] sub = temp[0].split(" columns ");
        String name = sub[0];
        return name;
    }

    public String getParklot(String ruta) throws IOException {
        File folder = new File(ruta);
        File[] listOfFiles = folder.listFiles();
        ArrayList<String> data = new ArrayList<>();
        for (File file : listOfFiles) {
            if (file.isFile()) {
                data.add(file.getCanonicalPath());
            }
        }
        Collections.sort(data);
        String[] name = data.get(data.size() - 1).split(".j");
        for (int i = 0; i < name.length; i++) {
        }
        return name[0];
    }

}
