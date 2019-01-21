package com.ute.models.coordenates;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import org.json.JSONException;

public class Conexion {

    String[] conexion = {"Remote", "127.0.0.1", "3306", "parkingdb", "root", "NONE", "Local", "166.62.78.1", "3306", "server-administrator", "jessicaroman", "12345"};

    public String[] select(String sql, int n) throws SQLException, IOException, JSONException {

        testMySQLDriver();
        String result = "";
        try {
            String passLocal = (conexion[11].equals("NONE")) ? "" : conexion[11];

            Connection conn = DriverManager.getConnection("jdbc:mysql://"
                    + conexion[7] + ":"
                    + conexion[8] + "/"
                    + conexion[9],
                    conexion[10],
                    passLocal);

            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery(sql);

            while (rs.next()) {
                for (int i = 1; i <= n; i++) {
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

    private static void testMySQLDriver() {
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
        } catch (Exception ex) {
            System.out.println("Error, no se ha podido cargar MySQL JDBC Driver");
        }
    }

}
