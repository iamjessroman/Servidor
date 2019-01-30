/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



function upload(url) {
    // Initialize a simple canvas
    var parking = new fabric.Canvas('parking', {
        hoverCursor: 'pointer',
        selection: false,
        selectionBorderColor: 'green',
        backgroundColor: null
    });

    $.getJSON(url, function (data) {
        parking.loadFromJSON(data, parking.renderAll.bind(parking), function (o, object) {
            if (o.type == 'image') {
                fabric.util.loadImage(o.src, function (img) {
                    image = new fabric.Image(img);
                    image.selectable = true;
                    parking.setWidth(image.width);
                    parking.setHeight(image.height);
                    parking.centerObject(image);
                    parking.renderAll();
                });
            }
        });
    });
}