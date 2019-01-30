var num = 0;
var json = "";
var img = "";
var name = "";
var path = "";

window.onload = function () {
    document.getElementById('box').style.display = 'none';
}


function next() {
    //Test
//    console.log(json);
//    console.log(img);

    if (document.getElementById('screen').style.display == 'block') {
        document.getElementById('screen').style.display = 'none'
        document.getElementById('postScreen').style.display = 'block'
    } else {
        document.getElementById('postScreen').style.display = 'none'
    }
    draw();
}

function upload(url) {
    var canvas = document.getElementById('screen');
    canvas.style.display = 'block';
    document.getElementById('postScreen').style.display = 'none';
    document.getElementById('guidat').style.display = 'none';
    var parking = new fabric.Canvas('parking');
    $.getJSON(url, function (data) {
        json = data;
        parking.loadFromJSON(data, parking.renderAll.bind(parking), function (o, object) {
            if (o.type === 'image') {
                img = o.src;
                name = o.name;
                path = o.path;
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
                nDiv.id = 'div' + num;
                nDiv.style.display = 'none';
                nDiv.className = 'divcanvas';
                nDiv.onclick = '';
                document.getElementById('Layer').appendChild(nDiv);
                var canv = document.createElement("canvas");
                canv.setAttribute('width', 300);
                canv.setAttribute('height', 300);
                canv.setAttribute('id', num);
                nDiv.appendChild(canv);
                num += 1;
            }
        });
    });
    console.log(name);
    document.getElementById('tittle').innerHTML = name + "(" + path + ")";
}
function draw() {
    var a = new fabric.Canvas('parking');
    num = 0;

    a.loadFromJSON(json, a.renderAll.bind(a), function (o, object) {
//        fabric.log(o);
        if (o.type == 'group') {
//            alert(o.left, o.top, (o.width*o.scaleX), (o.height*o.scaleY), o.angle)
            cut(o.left, o.top, (o.width * o.scaleX), (o.height * o.scaleY), o.angle, num, img);
            $("#" + num).attr("onclick", "copy(" + num + "," + o.width + "," + o.height + ")");
            num += 1;
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

