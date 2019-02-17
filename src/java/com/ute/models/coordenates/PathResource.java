/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ute.models.coordenates;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PUT;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.MediaType;
import org.apache.commons.io.FileUtils;
import org.json.JSONException;

/**
 * REST Web Service
 *
 * @author Jessica Roman
 */
@Path("path")
public class PathResource {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of PathResource
     */
    Main m = new Main();

    public PathResource() {
    }

    /**
     * Retrieves representation of an instance of
     * com.ute.models.coordenates.PathResource
     *
     * @return an instance of java.lang.String
     */
    @GET
    @Path("/{id}/{path}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getParklot(@PathParam("id") int id, @PathParam("path") String path) throws SQLException, IOException, JSONException {
        String dir = m.getPath(id);
        File file = new File(dir + path + ".json");
        String content = FileUtils.readFileToString(file, "utf-8");
        return content;
    }
}
