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
            console.log(o);
        });
    });
}