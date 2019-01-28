/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ute.models.coordenates;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;
import org.apache.commons.io.FileUtils;
import org.json.*;
import sun.misc.BASE64Encoder;

/**
 *
 * @author Jessica Roman
 */
public class CreateJson {

    public JSONObject typeImage(String data) throws JSONException {

        JSONObject objectImage = new JSONObject();

        objectImage.put("type", "image");
        objectImage.put("version", "2.2.4");
        objectImage.put("originX", "left");
        objectImage.put("originY", "top");
        objectImage.put("left", 0);
        objectImage.put("top", 0);
        objectImage.put("width", 1920);
        objectImage.put("height", 1080);
        objectImage.put("fill", "rgb(0,0,0)");
        objectImage.put("strokeWidth", 0);
        objectImage.put("strokeLineCap", "butt");
        objectImage.put("strokeLineJoin", "miter");
        objectImage.put("strokeMiterLimit", 10);
        objectImage.put("scaleX", 1);
        objectImage.put("scaleY", 1);
        objectImage.put("angle", 0);
        objectImage.put("opacity", 1);
        objectImage.put("backgroundColor", "");
        objectImage.put("selectable", false);
        objectImage.put("fillRule", "nonzero");
        objectImage.put("paintFirst", "fill");
        objectImage.put("globalCompositeOperation", "source-over");
        objectImage.put("skewX", 0);
        objectImage.put("skewY", 0);
        objectImage.put("crossOrigin", "");
        objectImage.put("cropX", 0);
        objectImage.put("cropY", 0);
        objectImage.put("src", data);

        return objectImage;
    }

    public JSONObject typeRect(Double left, Double top, Double width, Double height, Double scaleX, Double scaleY, Double angle) throws JSONException {

        JSONObject objectRect = new JSONObject();

        objectRect.put("type", "rect");
        objectRect.put("version", "2.2.4");
        objectRect.put("originX", "left");
        objectRect.put("originY", "top");
        objectRect.put("left", left);
        objectRect.put("top", top);
        objectRect.put("width", width);
        objectRect.put("height", height);
        objectRect.put("fill", "");
        objectRect.put("stroke", "red");
        objectRect.put("strokeWidth", 1);
        objectRect.put("strokeLineCap", "butt");
        objectRect.put("strokeLineJoin", "miter");
        objectRect.put("strokeMiterLimit", 10);
        objectRect.put("scaleX", scaleX);
        objectRect.put("scaleY", scaleY);
        objectRect.put("angle", angle);
        objectRect.put("flipX", false);
        objectRect.put("flipY", false);
        objectRect.put("opacity", 1);
        objectRect.put("visible", true);
        objectRect.put("backgroundColor", "");
        objectRect.put("fillRule", "nonzero");
        objectRect.put("paintFirst", "fill");
        objectRect.put("globalCompositeOperation", "source-over");
        objectRect.put("skewX", 0);
        objectRect.put("skewY", 0);
        objectRect.put("rx", 0);
        objectRect.put("ry", 0);

        return objectRect;
    }

    public String create(String path) throws IOException, JSONException {
        BufferedImage image = ImageIO.read(new File(path + ".jpg"));
        JSONObject objectImage = typeImage(encodeToString(image, "jpeg"));
        JSONObject objectRect = new JSONObject();
        JSONObject json = new JSONObject();
        JSONArray objects = new JSONArray();

        objects.put(0, objectImage);
        json.put("version", "2.2.4");
        File file = new File(path + ".json");
        String content = FileUtils.readFileToString(file, "utf-8");
        JSONArray array = new JSONArray(content);
        for (int i = 0; i < array.length(); i++) {
            JSONObject coord = new JSONObject();
            coord = (JSONObject) array.getJSONObject(i).get("coordGroup");
            objectRect = typeRect(coord.getDouble("left"), coord.getDouble("top"), coord.getDouble("width"), coord.getDouble("height"), coord.getDouble("scaleX"), coord.getDouble("scaleY"), coord.getDouble("angle"));
            objects.put(i + 1, objectRect);
        }

        json.put("objects", objects);

        return json.toString();

    }

    public static String encodeToString(BufferedImage image, String type) {
        String imageString = null;
        ByteArrayOutputStream bos = new ByteArrayOutputStream();

        try {
            ImageIO.write(image, type, bos);
            byte[] imageBytes = bos.toByteArray();

            BASE64Encoder encoder = new BASE64Encoder();
            imageString = "data:image/jpeg;base64," + encoder.encode(imageBytes);

            bos.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return imageString;
    }

}
