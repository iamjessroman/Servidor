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

    public JSONObject typeGroup(
            Double left,
            Double top,
            Double width,
            Double height,
            Double scaleX,
            Double scaleY,
            Double angle,
            Double top_rect,
            Double left_rect,
            Double width_rect,
            Double height_rect,
            Double scaleX_text,
            Double scaleY_text,
            Double top_text,
            Double left_text,
            String id) throws JSONException {

        JSONObject objectGroup = new JSONObject();
        JSONObject objectRect = new JSONObject();
        JSONObject objectText = new JSONObject();
        JSONArray objects = new JSONArray();

        objectGroup.put("type", "group");
        objectGroup.put("originX", "left");
        objectGroup.put("originY", "top");
        objectGroup.put("left", left);
        objectGroup.put("top", top);
        objectGroup.put("width", width);
        objectGroup.put("height", height);
        objectGroup.put("fill", "rgb(0,0,0)");
        objectGroup.put("strokeWidth", 1);
        objectGroup.put("strokeLineCap", "butt");
        objectGroup.put("strokeLineJoin", "miter");
        objectGroup.put("strokeMiterLimit", 10);
        objectGroup.put("scaleX", scaleX);
        objectGroup.put("scaleY", scaleY);
        objectGroup.put("angle", angle);
        objectGroup.put("flipX", false);
        objectGroup.put("flipY", false);
        objectGroup.put("opacity", 1);
        objectGroup.put("visible", true);

        objectRect = typeRect(
                top_rect,
                left_rect,
                width_rect,
                height_rect,
                scaleX,
                scaleY,
                angle);
        objects.put(0, objectRect);
        objectText = typeText(
                top_text,
                left_text,
                width,
                height,
                scaleX_text,
                scaleY_text,
                angle,
                id);
        objects.put(1, objectText);

        objectGroup.put("objects", objects);

        return objectGroup;
    }

    public JSONObject typeRect(Double top, Double left, Double width, Double height, Double scaleX, Double scaleY, Double angle) throws JSONException {

        JSONObject objectRect = new JSONObject();

        objectRect.put("type", "rect");
        objectRect.put("originX", "left");
        objectRect.put("originY", "top");
        objectRect.put("left", left);
        objectRect.put("top", top);
        objectRect.put("width", width);
        objectRect.put("height", height);
        objectRect.put("fill", "transparent");
        objectRect.put("stroke", "green");
        objectRect.put("strokeWidth", 5);
        objectRect.put("strokeLineCap", "butt");
        objectRect.put("strokeLineJoin", "miter");
        objectRect.put("strokeMiterLimit", 10);
        objectRect.put("scaleX", 1);
        objectRect.put("scaleY", 1);
        objectRect.put("angle", angle);
        objectRect.put("flipX", false);
        objectRect.put("flipY", false);
        objectRect.put("opacity", 1);
        objectRect.put("visible", true);
        objectRect.put("fillRule", "nonzero");
        objectRect.put("paintFirst", "fill");
        objectRect.put("globalCompositeOperation", "source-over");
        objectRect.put("skewX", 0);
        objectRect.put("skewY", 0);
        objectRect.put("rx", 0);
        objectRect.put("ry", 0);

        return objectRect;
    }

    public JSONObject typeText(
            Double top, 
            Double left, 
            Double width, 
            Double height, 
            Double scaleX, 
            Double scaleY, 
            Double angle,
            String id
           ) throws JSONException {

        JSONObject objectText = new JSONObject();

        objectText.put("type", "text");
        objectText.put("originX", "left");
        objectText.put("originY", "top");
        objectText.put("left", left);
        objectText.put("top", top);
        objectText.put("width", width);
        objectText.put("height", height);
        objectText.put("fill", "yellow");
        objectText.put("strokeWidth", 1);
        objectText.put("strokeLineCap", "butt");
        objectText.put("strokeLineJoin", "miter");
        objectText.put("strokeMiterLimit", 10);
        objectText.put("scaleX", 0.5);
        objectText.put("scaleY", 0.5);
        objectText.put("angle", angle);
        objectText.put("flipX", false);
        objectText.put("flipY", false);
        objectText.put("opacity", 1);
        objectText.put("visible", true);
        objectText.put("text", id);
        objectText.put("fontSize", 100);
        objectText.put("fontFamily", "helvetica");
        objectText.put("lineHeight", 1.3);
        objectText.put("textAlign", "left");
        objectText.put("useNative", true);

        return objectText;
    }

    public String create(String path) throws IOException, JSONException {
        BufferedImage image = ImageIO.read(new File(path + ".jpg"));
        JSONObject objectImage = typeImage(encodeToString(image, "jpeg"));
        JSONObject objectGroup = new JSONObject();
        JSONObject json = new JSONObject();
        JSONArray objects = new JSONArray();

        objects.put(0, objectImage);
        File file = new File(path + ".json");
        String content = FileUtils.readFileToString(file, "utf-8");
        JSONArray array = new JSONArray(content);
        for (int i = 0; i < array.length(); i++) {
            JSONObject group = new JSONObject();
            JSONObject rect = new JSONObject();
            JSONObject text = new JSONObject();
            String id = new String();

            group = (JSONObject) array.getJSONObject(i).get("coordGroup");
            rect = (JSONObject) array.getJSONObject(i).get("coordRect");
            text = (JSONObject) array.getJSONObject(i).get("coordText");
            id = (String) array.getJSONObject(i).get("idSpaceParking");
            objectGroup = typeGroup(
                    group.getDouble("left"),
                    group.getDouble("top"),
                    group.getDouble("width"),
                    group.getDouble("height"),
                    group.getDouble("scaleX"),
                    group.getDouble("scaleY"),
                    group.getDouble("angle"),
                    rect.getDouble("top"),
                    rect.getDouble("left"),
                    rect.getDouble("width"),
                    rect.getDouble("height"),
                    text.getDouble("scaleX"),
                    text.getDouble("scaleY"),
                    text.getDouble("top"),
                    text.getDouble("left"),
                    id);
            objects.put(i + 1, objectGroup);
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
