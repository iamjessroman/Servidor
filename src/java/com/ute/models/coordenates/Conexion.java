package com.ute.models.coordenates;

import java.awt.HeadlessException;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.swing.JOptionPane;
import org.json.JSONException;

public class Conexion {

    String[] con = {"Remote", "127.0.0.1", "3306", "parkingdb", "root", "NONE", "Local", "127.0.0.1", "3306", "server-administrator", "root", "NONE"};
    String[] conexion = {"1", "2", "3", "4", "5"};

    public void getCrediantials(int n) {
        if (n != 2) {
            conexion[0] = con[1];
            conexion[1] = con[2];
            conexion[2] = con[3];
            conexion[3] = con[4];
            conexion[4] = con[5];
        } else {
            conexion[0] = con[7];
            conexion[1] = con[8];
            conexion[2] = con[9];
            conexion[3] = con[10];
            conexion[4] = con[11];
        }

    }

    public String[] select(String sql, int columns, int n) throws SQLException, IOException, JSONException {

        testMySQLDriver();
        getCrediantials(n);
        String result = "";
        String passLocal = (conexion[4].equals("NONE")) ? "" : conexion[4];
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://"
                    + conexion[0] + ":"
                    + conexion[1] + "/"
                    + conexion[2],
                    conexion[3],
                    passLocal);

            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery(sql);

            while (rs.next()) {
                for (int i = 1; i <= columns; i++) {
                    result += rs.getString(i) + " columns ";
                }
                result += " rows ";
            }
            rs.close();
            statement.close();
            conn.close();

        } catch (SQLException ex) {
            System.out.println(ex);
        }
        String[] select = result.split(" rows ");
        return select;
    }
    
        public void insert(String sql, String[] columns, String msg, int n) {
        testMySQLDriver();
        getCrediantials(n);
        String passLocal = (conexion[4].equals("NONE")) ? "" : conexion[4];
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://"
                    + conexion[0] + ":"
                    + conexion[1] + "/"
                    + conexion[2],
                    conexion[3],
                    passLocal);
            PreparedStatement ps = conn.prepareStatement(sql);

            for (int i = 1; i <= columns.length; i++) {
                ps.setString(i, columns[i - 1]);
            }
            ps.executeUpdate();
            if (!" ".equals(msg)) {
               
            }

        } catch (HeadlessException | SQLException e) {
            
        }
    }

    private static void testMySQLDriver() {
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
        } catch (Exception ex) {
            System.out.println("Error, no se ha podido cargar MySQL JDBC Driver");
        }
    }

}
