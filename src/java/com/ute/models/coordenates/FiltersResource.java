/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ute.models.coordenates;

import java.io.IOException;
import java.sql.SQLException;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PUT;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import org.json.JSONException;

/**
 * REST Web Service
 *
 * @author jessi
 */
@Path("filters")
public class FiltersResource {
    Conexion cx = new Conexion ();
    @Context
    private UriInfo context;

    /**
     * Creates a new instance of FiltersResource
     */
    public FiltersResource() {
    }
    
//    @GET
//    @Path("/getFilters")
//    @Produces(MediaType.APPLICATION_JSON)
//    public String getFilters() throws SQLException, IOException, JSONException {
//        String sql = "SELECT * FROM `config`";
//        return cx.select(sql);
//    }
    
    /**
     * Retrieves representation of an instance of com.ute.models.coordenates.FiltersResource
     * @return an instance of java.lang.String
     */
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getJson() {
       
        //TODO return proper representation object
        throw new UnsupportedOperationException();
    }

    /**
     * PUT method for updating or creating an instance of FiltersResource
     * @param content representation for the resource
     */
    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    public void putJson(String content) {
    }
}
