var num = [];
var i = "";
var json = "";
var img = "";
var id_parking = "";
var name = "";
var path = "";
var w = "";
var h = "";
var api = "";

function save() {

    jsonObj = [];
    for (var i = 0; i < num; i++) {
        var h = document.getElementById(i);
        item = {}
        item ["id_parking"] = id_parking;
        item ["name_parking"] = name;
        item ["path"] = path;
        item ["id"] = i + 1;
        item ["src"] = h.toDataURL('image/jpeg', 1.0);
        jsonObj.push(item);
    }

    document.getElementById("code").innerHTML = JSON.stringify(jsonObj);
}


function refresh() {
    for (var i = 0; i < num; i++) {

        var h = document.getElementById("h" + i);
        h.remove();
        var div = document.getElementById("div" + i);
        div.remove();
    }
    num = 0;
    upload(api);

}


function next() {
    //Test
//    console.log(json);
//    console.log(img);

    if (document.getElementById('screen').style.display == 'block') {
        document.getElementById('screen').style.display = 'none';
        document.getElementById('postScreen').style.display = 'block';
        var elems = document.getElementsByClassName('guidat');
        for (var i = 0; i < elems.length; i += 1) {
            elems[i].style.display = 'block';
        }
    } else {
        document.getElementById('postScreen').style.display = 'none';
        var elems = document.getElementsByClassName('guidat');
        for (var i = 0; i < elems.length; i += 1) {
            elems[i].style.display = 'none';
        }
    }
    draw();
}

function upload(url) {
//    console.log(num);

    api = url;
    for (var i = 0; i < num; i++) {
        var h = document.getElementById("h" + i);
        h.remove();
        var div = document.getElementById("div" + i);
        div.remove();
    }

    var canvas = document.getElementById('screen');
    canvas.style.display = 'block';
    document.getElementById('postScreen').style.display = 'none';
    var elems = document.getElementsByClassName('guidat');
    for (var i = 0; i < elems.length; i += 1) {
        elems[i].style.display = 'none';
    }
    var parking = new fabric.Canvas('parking');
    num = 0;
    $.getJSON(url, function (data) {
        json = data;
        parking.loadFromJSON(data, parking.renderAll.bind(parking), function (o, object) {
            if (o.type === 'image') {
                img = o.src;
                id_parking = o.id_parking;
                name = o.name;
                path = o.path;
                document.getElementById('tittle').innerHTML = name + " (" + path + ") ";
                fabric.util.loadImage(o.src, function (img) {
                    image = new fabric.Image(img);
                    image.selectable = true;
                    parking.setWidth(image.width);
                    parking.setHeight(image.height);
                    parking.centerObject(image);
                    parking.renderAll();
                });
            }

            if (o.type === 'group') {
                var nDiv = document.createElement('div');
                nDiv.id = 'div' + (num);
                nDiv.style.display = 'none';
                nDiv.className = 'divcanvas';
                nDiv.onclick = '';
                document.getElementById('Layer').appendChild(nDiv);

                var h = document.createElement("h3");
                h.setAttribute('id', "h" + (num));
                h.style.fontFamily = 'Arial';
                h.style.color = '#265b91';
                nDiv.appendChild(h);

                document.getElementById("h" + (num)).innerHTML = "Parqueo '" + (object._objects[1].text) + "'";
                var canv = document.createElement("canvas");
                canv.setAttribute('width', 300);
                canv.setAttribute('height', 300);
                canv.setAttribute('id', num);
                canv.style.border = "thick solid #0000FF";
                nDiv.appendChild(canv);
                num += 1;
            }
        });
    });
}
function draw() {
    var a = new fabric.Canvas('parking');
    num = 0;

    a.loadFromJSON(json, a.renderAll.bind(a), function (o, object) {
//        fabric.log(o);
        if (o.type == 'group') {
            var angle = o.angle;

            if (angle > 40 && angle < 140) {
                console.log("1");
                cut(o.left, o.top, (o.height * o.scaleY), (o.width * o.scaleX), 0, (num), img);
                rotate(true, num, 90, (o.height * o.scaleY), (o.width * o.scaleX));
                $("#" + (num)).attr("onclick", "copy(" + (num) + "," + (o.width * o.scaleX) + "," + (o.height * o.scaleY) + ")");
                num += 1;
            } else if (angle > -140 && angle < -40) {
                console.log("2");
                cut(o.top, o.left, (o.height * o.scaleY), (o.width * o.scaleX), 0, (num), img);
                rotate(true, num, 90, (o.height * o.scaleY), (o.width * o.scaleX));
                $("#" + (num)).attr("onclick", "copy(" + (num) + "," + (o.width * o.scaleX) + "," + (o.height * o.scaleY) + ")");
                num += 1;
            } else if (angle > 260 && angle < 320) {
                 console.log("2");
                cut(o.top, o.left, (o.height * o.scaleY), (o.width * o.scaleX), 0, (num), img);
                rotate(true, num, 90, (o.height * o.scaleY), (o.width * o.scaleX));
                $("#" + (num)).attr("onclick", "copy(" + (num) + "," + (o.width * o.scaleX) + "," + (o.height * o.scaleY) + ")");
                num += 1;
            } else if (angle >= 0 && angle <= 40) {
                console.log("3");
                cut(o.left, o.top, (o.width * o.scaleX), (o.height * o.scaleY), 0, (num), img);
                $("#" + (num)).attr("onclick", "copy(" + (num) + "," + (o.width * o.scaleX) + "," + (o.height * o.scaleY) + ")");
                num += 1;
            } else if (angle >= 140 && angle <= 260) {
                console.log("4");
                cut(o.left - 71.3, o.top - 153, (o.width * o.scaleX), (o.height * o.scaleY), 0, (num), img);
                $("#" + (num)).attr("onclick", "copy(" + (num) + "," + (o.width * o.scaleX) + "," + (o.height * o.scaleY) + ")");
                num += 1;
            }
        }
    });
    var elems = document.getElementsByClassName('divcanvas');
    for (var i = 0; i < elems.length; i += 1) {
        elems[i].style.display = 'block';
    }
}

function cut(X, Y, Width, Height, Angle, num, src) {
    var canvas = document.getElementById(num);
    var ctx = canvas.getContext("2d");
    // blue rect's info
    var blueX = X;
    var blueY = Y;
    var blueWidth = Width;
    var blueHeight = Height;
    var blueAngle = Angle * Math.PI / 180;
    // load the image
    var img = new Image();
    img.onload = start;
    img.src = src;

    function start() {
        // create 2 temporary canvases
        var canvas1 = document.createElement("canvas");
        var ctx1 = canvas1.getContext("2d");
        var canvas2 = document.createElement("canvas");
        var ctx2 = canvas2.getContext("2d");
        // get the boundingbox of the rotated blue box
        var rectBB = getRotatedRectBB(blueX, blueY, blueWidth, blueHeight, blueAngle);
        // clip the boundingbox of the rotated blue rect to a temporary canvas
        canvas1.width = canvas2.width = rectBB.width;
        canvas1.height = canvas2.height = rectBB.height;
        ctx1.drawImage(img, rectBB.cx - rectBB.width / 2, rectBB.cy - rectBB.height / 2, rectBB.width, rectBB.height, 0, 0, rectBB.width, rectBB.height);
        // unrotate the blue rect on the temporary canvas
        ctx2.translate(canvas1.width / 2, canvas1.height / 2);
        ctx2.rotate(-blueAngle);
        ctx2.drawImage(canvas1, -canvas1.width / 2, -canvas1.height / 2);
        // draw the blue rect to the display canvas
        var offX = rectBB.width / 2 - blueWidth / 2;
        var offY = rectBB.height / 2 - blueHeight / 2;
        ctx.drawImage(canvas2, -offX, -offY);
    } // end start
    // Utility: get bounding box of rotated rectangle
    function getRotatedRectBB(x, y, width, height, rAngle) {
        var absCos = Math.abs(Math.cos(rAngle));
        var absSin = Math.abs(Math.sin(rAngle));
        var cx = x + width / 2 * Math.cos(rAngle) - height / 2 * Math.sin(rAngle);
        var cy = y + width / 2 * Math.sin(rAngle) + height / 2 * Math.cos(rAngle);
        var w = width * absCos + height * absSin;
        var h = width * absSin + height * absCos;
        return ({
            cx: cx,
            cy: cy,
            width: w,
            height: h
        });
    }
}

function rotate(rotating, num, deg, width, height) {
    var canvas = document.getElementById(num);
    var ctx = canvas.getContext("2d");
    if (rotating) {
        ctx.translate((width-5) / 2,(height-99) / 2);
        ctx.rotate(deg * Math.PI / 180);
    }
    console.log("g");
}

function copy(num, width, height) {
    h = height;
    w = width;
    var c1 = document.getElementById(num);
    var c2 = document.getElementById("b");
    var ctx1 = c1.getContext("2d");
    var ctx2 = c2.getContext("2d");
    ctx2.clearRect(0, 0, c2.width, c2.height);
    var imgData = ctx1.getImageData(0, 0, width, height);
    ctx2.putImageData(imgData, 0, 0);
    var url = c2.toDataURL();
    var current_filter = $("#filter_list").val();
    if (!current_filter) {
        $('#filter_list option:eq(0)').attr('selected', 'selected');
        current_filter = $("#filter_list").val();
    }
    loadImage(url, function () {
        initFilter(current_filter);
    });
    i = num;
}

function savecanvas() {
    console.log(num);
    //   var canvas = document.getElementById("b");   var link = document.createElement('a');   link.download = "test.png";   link.href = canvas.toDataURL("image/png").replace("image/png", "image/octet-stream");;   link.click();
    var c1 = document.getElementById("output");
    var c2 = document.getElementById(i);
    if (c2 != null) {
        var ctx1 = c1.getContext("2d");
        var ctx2 = c2.getContext("2d");
        ctx2.clearRect(0, 0, c2.width, c2.height);
        var imgData = ctx1.getImageData(0, 0, w, h);
        ctx2.putImageData(imgData, 0, 0);
        i = num;

        var c1 = document.getElementById("output");
        var c2 = document.getElementById("b");
        var ctx1 = c1.getContext("2d");
        var ctx2 = c2.getContext("2d");
        ctx1.clearRect(0, 0, c2.width, c2.height);
        ctx2.clearRect(0, 0, c2.width, c2.height);
    }
    save();
}
