
import com.ute.models.coordenates.Coordenates;
import javax.json.*;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author jessi
 */
public class Valores {
    private String imagen;
    private Coordenates [] coordenadas;

    public Coordenates[] getCoordenadas() {
        return coordenadas;
    }

    public void setCoordenadas(Coordenates[] coordenadas) {
        this.coordenadas = coordenadas;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    
}
