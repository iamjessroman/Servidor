/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ute.models.coordenates;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author jessi
 */
public class ClassMain {

    public String[] ReadArray(String ruta) throws FileNotFoundException {
        String[] arrays = null;
        File archivo = new File(ruta);
        FileReader fr = new FileReader(ruta);
        BufferedReader br = new BufferedReader(fr);

        try {
            if (archivo.exists()) {
                String linea;
                while ((linea = br.readLine()) != null) {
                    arrays = linea.split(",");
                }

            } else {
                arrays = null;
            }
            fr.close();
        } catch (IOException ex) {
            
        }
        return arrays;
    }

    public void Write(String Text, String ruta, boolean b) {
        try {
            File archivo = new File(ruta);
            BufferedWriter bw;
            FileWriter fw;
            
            //Test
//            System.out.println(Text);

            if (archivo.exists()) {
                fw = new FileWriter(archivo.getAbsoluteFile(), b);
                bw = new BufferedWriter(fw);
                bw.write(Text + "\n");

            } else {
                archivo.createNewFile();
                fw = new FileWriter(archivo.getAbsoluteFile(), b);
                bw = new BufferedWriter(fw);
                bw.write(Text + "\n");
            }
            bw.close();
        } catch (IOException ex) {
        }

    }

    public String Read(String ruta) throws FileNotFoundException {
        String config = null;

        File archivo = new File(ruta);
        FileReader fr = new FileReader(ruta);
        BufferedReader br = new BufferedReader(fr);

        try {
            if (archivo.exists()) {
                String linea;
                while ((linea = br.readLine()) != null) {
                    config = linea;
                }

            } else {
                config = null;
            }
            fr.close();
        } catch (IOException ex) {
        }
        return config;
    }

    public void WriteMix(String Text, String ruta) {

        try {
            File archivo = new File(ruta);
            BufferedWriter bw;
            FileWriter fw;

            if (archivo.exists()) {
                fw = new FileWriter(archivo.getAbsoluteFile(), true);
                bw = new BufferedWriter(fw);
                bw.write(Text + "\n");

            } else {
                archivo.createNewFile();
                fw = new FileWriter(archivo.getAbsoluteFile(), true);
                bw = new BufferedWriter(fw);
                bw.write(Text);
            }
            bw.close();

        } catch (IOException ex) {
        }

    }

    public String[] ReadMix(String ruta) throws FileNotFoundException {
        String config[] = new String[100];
        File archivo = new File(ruta);
        FileReader fr = new FileReader(ruta);
        BufferedReader br = new BufferedReader(fr);

        try {
            if (archivo.exists()) {
                String linea;
                int n = 0;
                while ((linea = br.readLine()) != null) {
                    config[n] = linea;
                    n++;
                }

            } else {
                config = null;
            }
            fr.close();

        } catch (IOException ex) {
        }
        return config;
    }

    public void WriteEstados(String Text, String ruta) {

        try {

            File archivo = new File(ruta);
            BufferedWriter bw;
            FileWriter fw;

            if (archivo.exists()) {
                archivo.delete();
                archivo.createNewFile();
                fw = new FileWriter(archivo.getAbsoluteFile(), true);
                bw = new BufferedWriter(fw);
                bw.write(Text + "\n");

            } else {
                archivo.createNewFile();
                fw = new FileWriter(archivo.getAbsoluteFile(), true);
                bw = new BufferedWriter(fw);
                bw.write(Text);
            }
            bw.close();

        } catch (IOException ex) {
        }

    }
}
