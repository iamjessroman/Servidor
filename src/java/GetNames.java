
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author jessi
 */
public class GetNames {

    public String listFolder() throws IOException {
        File folder = new File("C:\\payara41\\glassfish\\domains\\serverUte\\config\\Parklot\\Parking");
        File[] listOfFiles = folder.listFiles();
        ArrayList<String> data = new ArrayList<String>();
        for (File file : listOfFiles) {
            if (file.isFile()) {
                data.add(file.getCanonicalPath());
            File archivo = new File("C:\\Servidor\\data\\data.txt");
            BufferedWriter bw;
            FileWriter fw;

            if (archivo.exists()) {
                fw = new FileWriter(archivo.getAbsoluteFile(), true);
                bw = new BufferedWriter(fw);
                bw.write(file.getName()+"\n");

            } else {
                archivo.createNewFile();
                fw = new FileWriter(archivo.getAbsoluteFile(), true);
                bw = new BufferedWriter(fw);
                bw.write(file.getName()+"\n");
            }
            bw.close();
            }

        }
         Collections.sort(data);
         String[] name= data.get(data.size()-1).split(".j");
         for (int i = 0; i < name.length; i++) {
        }
         return name[0];
    }
}
