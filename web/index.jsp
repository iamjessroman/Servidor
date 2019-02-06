<%-- 
    Document   : parklots
    Created on : 3/02/2018, 04:20:08 PM
    Author     : Jessica Roman
--%>

<!DOCTYPE html>
<!-- saved from url=(0036)http://www.arahaya.com/imagefilters/ -->
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/estilo.css" crossorigin="anonymous">
    </head>

    <script src="./js/fabric.min.js"></script>

    <script language="JavaScript" type="text/javascript" src="./js/script.js"></script>
    <script language="JavaScript" type="text/javascript" src="./js/jquery-3.3.1.min.js"></script>
    <body>
        <div id="tittle" class="tittle" style="
             text-align: center; 
             font-family: 'Arial';
             font-size: 22;
             font-weight: bold;
             padding: 15px;
             color: #265b91;
             "></div>

        <div id="postScreen" style="display:none;">
            <font color="Black" face="Arial">
            </font>
            <div id="Layer" align="center" style="border:3px solid #4aad52; text-align: center; width: 400px; height: 400px; overflow: scroll;"></div>
            <div style="text-align: center">
                <button id="canvasImageSave" onclick="savecanvas()">Guardar</button>
                <form method="post" action="process.jsp">
                    <textarea style="display:none;" name="code" id="code" ></textarea>
                    <input type="submit" value="Convertir Parqueos">
                </form>
            </div>

            <div id="container">
                <div id="wrapper">
                    <div id="side">
                        <font color="Black" face="Arial">
                        <h3>Filtros</h3>
                        </font>
                        <select id="filter_list" size="31">
                            <%@ page import="java.io.*"                  
                                     import="com.ute.models.coordenates.Conexion"%>

                            <%
                                Conexion cx = new Conexion();
                            %>
                            <%
                                String sql = "SELECT name FROM `filters`";
                                int n = 1;
                                String text[] = cx.select(sql, n, 2);
                                for (int i = 0; i < text.length; i++) {
                                    String temp[] = text[i].split(" columns ");
                            %> 
                            <option value = "<%= temp[0]%>"><%= temp[0]%></option>
                            <% }%>
                        </select>
                    </div>
                    <!--/side-->
                    <div id="main">
                        <div id="result">
                            <font color="Black" face="Arial">
                            <h3>Output</h3>
                            </font>
                            <div>
                                <canvas id="output" width="400" height="300" style="border:3px solid #265b91;"></canvas>
                                <canvas id="b" width="400" height="300" style="border:3px solid #265b91;"></canvas>
                            </div>

                        </div>

                        <!--/result-->
                    </div>
                    <!--/main-->
                </div>
                <!--/wrapper-->
            </div>
            <!--/container-->
            <script src="./js/jquery-1.6.min.js.descarga"></script>
            <script src="./js/DAT.GUI.js.descarga"></script>
            <script>
                    function trace() {
                    try {
                    console.log.apply(console, arguments);
                    } catch (e) {
                    try {
                    console.log(Array.prototype.slice.apply(arguments));
                    } catch (e) {
                    }
                    }
                    }
                    function loadImage(src, callback) {
                    $('<img />').attr('src', src).load(function () {
                    TestCanvas.init(this);
                    callback && callback();
                    });
                    }
                    function initFilter(filter_name) {
                    //TestCanvas.reset();
                    gui.clear();
                    var filterConfig = filters[filter_name];
                    filterConfig.init(filterConfig);
                    filterConfig.gui(filterConfig);
                    filterConfig.apply(filterConfig);
                    if (filterConfig.use_gui !== false) {
                    gui.add({
                    reset: function () {
                    gui.reset();
                    //TestCanvas.reset();
                    filterConfig.init(filterConfig);
                    filterConfig.apply(filterConfig);
                    }
                    }, 'reset');
                    }
                    }
                    // Globals
                    var gui;
                    var TestCanvas = {
                    init: function (img) {
                    this.canvas = $('#output')[0];
                    this.canvas.width = img.width;
                    this.canvas.height = img.height;
                    this.context = this.canvas.getContext('2d');
                    this.context.drawImage(img, 0, 0);
                    this.defaultImage = this.context.getImageData(
                            0, 0, img.width, img.height);
                    },
                            apply: function (filter_name, args) {
                            if (!this.context) {
                            return;
                            }
                            args.unshift(this.defaultImage);
                            var start_time = new Date().getTime();
                            var result = ImageFilters[filter_name].apply(ImageFilters, args);
                            var elapsed_time = new Date().getTime() - start_time;
                            trace(filter_name + " " + elapsed_time + " ms");
                            $("#timer").html(elapsed_time + " ms");
                            this.context.clearRect(0, 0, this.canvas.width, this.canvas.height);
                            try {
                            this.context.putImageData(result, 0, 0);
                            } catch (e) {
                            trace(e);
                            }
                            },
                            reset: function () {
                            if (!this.context) {
                            return;
                            }
                            this.context.putImageData(this.defaultImage, 0, 0);
                            }
                    };
                    var filters = {
                <%
                    sql = "SELECT * FROM `filters`";
                    n = 7;
                    text = cx.select(sql, n, 2);
                    for (int i = 0; i < text.length; i++) {
                        String temp[] = text[i].split(" columns ");
                %>
                <%= temp[1]%> :{
                    use_gui: <%= temp[2]%>,
                            init: <%= temp[3]%>,
                            gui: <%= temp[4]%>,
                            apply: <%= temp[5]%>
                    } <%=i != text.length - 1 ? "," : " "%>
                <% }%>
                    }
                    $(function () {
                    // init gui library
                    gui = new DAT.GUI();
                    // init url form
                    $('#form_submit').click(function () {
                    var url = $('#form_url').val();
                    if (url) {
                    url = encodeURIComponent(url);
                    $('#form_submit').val('Loading...');
                    loadImage('./p.php?u=' + url, function () {
                    initFilter(current_filter);
                    $('#form_submit').val('Submit');
                    });
                    }
                    });
                    // init select list
                    $("#filter_list").attr('size', $("#filter_list").children().size());
                    var current_filter = $("#filter_list").val();
                    if (!current_filter) {
                    $('#filter_list option:eq(0)').attr('selected', 'selected');
                    current_filter = $("#filter_list").val();
                    }
                    setInterval(function () {
                    var selected_filter = $("#filter_list").val();
                    if (selected_filter && selected_filter !== current_filter) {
                    current_filter = selected_filter;
                    initFilter(current_filter);
                    }
                    }, 20);
                    });
                    var ImageFilters = {};
                    ImageFilters.utils = {
                    initSampleCanvas: function () {
                    var _canvas = document.createElement('canvas'),
                            _context = _canvas.getContext('2d');
                    _canvas.width = 0;
                    _canvas.height = 0;
                    this.getSampleCanvas = function () {
                    return _canvas;
                    };
                    this.getSampleContext = function () {
                    return _context;
                    };
                    this.createImageData = (_context.createImageData) ? function (w, h) {
                    return _context.createImageData(w, h);
                    } : function (w, h) {
                    return new ImageData(w, h);
                    };
                    },
                            getSampleCanvas: function () {
                            this.initSampleCanvas();
                            return this.getSampleCanvas();
                            },
                            getSampleContext: function () {
                            this.initSampleCanvas();
                            return this.getSampleContext();
                            },
                            createImageData: function (w, h) {
                            this.initSampleCanvas();
                            return this.createImageData(w, h);
                            },
                            clamp: function (value) {
                            return value > 255 ? 255 : value < 0 ? 0 : value;
                            },
                            buildMap: function (f) {
                            for (var m = [], k = 0, v; k < 256; k += 1) {
                            m[k] = (v = f(k)) > 255 ? 255 : v < 0 ? 0 : v | 0;
                            }
                            return m;
                            },
                            applyMap: function (src, dst, map) {
                            for (var i = 0, l = src.length; i < l; i += 4) {
                            dst[i] = map[src[i]];
                            dst[i + 1] = map[src[i + 1]];
                            dst[i + 2] = map[src[i + 2]];
                            dst[i + 3] = src[i + 3];
                            }
                            },
                            mapRGB: function (src, dst, func) {
                            this.applyMap(src, dst, this.buildMap(func));
                            },
                            getPixelIndex: function (x, y, width, height, edge) {
                            if (x < 0 || x >= width || y < 0 || y >= height) {
                            switch (edge) {
                            case 1: // clamp
                                    x = x < 0 ? 0 : x >= width ? width - 1 : x;
                            y = y < 0 ? 0 : y >= height ? height - 1 : y;
                            break;
                            case 2: // wrap
                                    x = (x %= width) < 0 ? x + width : x;
                            y = (y %= height) < 0 ? y + height : y;
                            break;
                            default: // transparent
                                    return null;
                            }
                            }
                            return (y * width + x) << 2;
                            },
                            getPixel: function (src, x, y, width, height, edge) {
                            if (x < 0 || x >= width || y < 0 || y >= height) {
                            switch (edge) {
                            case 1: // clamp
                                    x = x < 0 ? 0 : x >= width ? width - 1 : x;
                            y = y < 0 ? 0 : y >= height ? height - 1 : y;
                            break;
                            case 2: // wrap
                                    x = (x %= width) < 0 ? x + width : x;
                            y = (y %= height) < 0 ? y + height : y;
                            break;
                            default: // transparent
                                    return 0;
                            }
                            }
                            var i = (y * width + x) << 2;
                            // ARGB
                            return src[i + 3] << 24 | src[i] << 16 | src[i + 1] << 8 | src[i + 2];
                            },
                            getPixelByIndex: function (src, i) {
                            return src[i + 3] << 24 | src[i] << 16 | src[i + 1] << 8 | src[i + 2];
                            },
                            /**
                             * one of the most important functions in this library.
                             * I want to make this as fast as possible.
                             */
                            copyBilinear: function (src, x, y, width, height, dst, dstIndex, edge) {
                            var fx = x < 0 ? x - 1 | 0 : x | 0, // Math.floor(x)
                                    fy = y < 0 ? y - 1 | 0 : y | 0, // Math.floor(y)
                                    wx = x - fx,
                                    wy = y - fy,
                                    i,
                                    nw = 0,
                                    ne = 0,
                                    sw = 0,
                                    se = 0,
                                    cx, cy,
                                    r, g, b, a;
                            if (fx >= 0 && fx < (width - 1) && fy >= 0 && fy < (height - 1)) {
                            // in bounds, no edge actions required
                            i = (fy * width + fx) << 2;
                            if (wx || wy) {
                            nw = src[i + 3] << 24 | src[i] << 16 | src[i + 1] << 8 | src[i + 2];
                            i += 4;
                            ne = src[i + 3] << 24 | src[i] << 16 | src[i + 1] << 8 | src[i + 2];
                            i = (i - 8) + (width << 2);
                            sw = src[i + 3] << 24 | src[i] << 16 | src[i + 1] << 8 | src[i + 2];
                            i += 4;
                            se = src[i + 3] << 24 | src[i] << 16 | src[i + 1] << 8 | src[i + 2];
                            } else {
                            // no interpolation required
                            dst[dstIndex] = src[i];
                            dst[dstIndex + 1] = src[i + 1];
                            dst[dstIndex + 2] = src[i + 2];
                            dst[dstIndex + 3] = src[i + 3];
                            return;
                            }
                            } else {
                            // edge actions required
                            nw = this.getPixel(src, fx, fy, width, height, edge);
                            if (wx || wy) {
                            ne = this.getPixel(src, fx + 1, fy, width, height, edge);
                            sw = this.getPixel(src, fx, fy + 1, width, height, edge);
                            se = this.getPixel(src, fx + 1, fy + 1, width, height, edge);
                            } else {
                            // no interpolation required
                            dst[dstIndex] = nw >> 16 & 0xFF;
                            dst[dstIndex + 1] = nw >> 8 & 0xFF;
                            dst[dstIndex + 2] = nw & 0xFF;
                            dst[dstIndex + 3] = nw >> 24 & 0xFF;
                            return;
                            }
                            }
                            cx = 1 - wx;
                            cy = 1 - wy;
                            r = ((nw >> 16 & 0xFF) * cx + (ne >> 16 & 0xFF) * wx) * cy + ((sw >> 16 & 0xFF) * cx + (se >> 16 & 0xFF) * wx) * wy;
                            g = ((nw >> 8 & 0xFF) * cx + (ne >> 8 & 0xFF) * wx) * cy + ((sw >> 8 & 0xFF) * cx + (se >> 8 & 0xFF) * wx) * wy;
                            b = ((nw & 0xFF) * cx + (ne & 0xFF) * wx) * cy + ((sw & 0xFF) * cx + (se & 0xFF) * wx) * wy;
                            a = ((nw >> 24 & 0xFF) * cx + (ne >> 24 & 0xFF) * wx) * cy + ((sw >> 24 & 0xFF) * cx + (se >> 24 & 0xFF) * wx) * wy;
                            dst[dstIndex] = r > 255 ? 255 : r < 0 ? 0 : r | 0;
                            dst[dstIndex + 1] = g > 255 ? 255 : g < 0 ? 0 : g | 0;
                            dst[dstIndex + 2] = b > 255 ? 255 : b < 0 ? 0 : b | 0;
                            dst[dstIndex + 3] = a > 255 ? 255 : a < 0 ? 0 : a | 0;
                            },
                            /**
                             * @param r 0 <= n <= 255
                             * @param g 0 <= n <= 255
                             * @param b 0 <= n <= 255
                             * @return Array(h, s, l)
                             */
                            rgbToHsl: function (r, g, b) {
                            r /= 255;
                            g /= 255;
                            b /= 255;
                            //        var max = Math.max(r, g, b),
                            //            min = Math.min(r, g, b),
                            var max = (r > g) ? (r > b) ? r : b : (g > b) ? g : b,
                                    min = (r < g) ? (r < b) ? r : b : (g < b) ? g : b,
                                    chroma = max - min,
                                    h = 0,
                                    s = 0,
                                    // Lightness
                                    l = (min + max) / 2;
                            if (chroma !== 0) {
                            // Hue
                            if (r === max) {
                            h = (g - b) / chroma + ((g < b) ? 6 : 0);
                            } else if (g === max) {
                            h = (b - r) / chroma + 2;
                            } else {
                            h = (r - g) / chroma + 4;
                            }
                            h /= 6;
                            // Saturation
                            s = (l > 0.5) ? chroma / (2 - max - min) : chroma / (max + min);
                            }
                            return [h, s, l];
                            },
                            /**
                             * @param h 0.0 <= n <= 1.0
                             * @param s 0.0 <= n <= 1.0
                             * @param l 0.0 <= n <= 1.0
                             * @return Array(r, g, b)
                             */
                            hslToRgb: function (h, s, l) {
                            var m1, m2, hue,
                                    r, g, b,
                                    rgb = [];
                            if (s === 0) {
                            r = g = b = l * 255 + 0.5 | 0;
                            rgb = [r, g, b];
                            } else {
                            if (l <= 0.5) {
                            m2 = l * (s + 1);
                            } else {
                            m2 = l + s - l * s;
                            }
                            m1 = l * 2 - m2;
                            hue = h + 1 / 3;
                            var tmp;
                            for (var i = 0; i < 3; i += 1) {
                            if (hue < 0) {
                            hue += 1;
                            } else if (hue > 1) {
                            hue -= 1;
                            }
                            if (6 * hue < 1) {
                            tmp = m1 + (m2 - m1) * hue * 6;
                            } else if (2 * hue < 1) {
                            tmp = m2;
                            } else if (3 * hue < 2) {
                            tmp = m1 + (m2 - m1) * (2 / 3 - hue) * 6;
                            } else {
                            tmp = m1;
                            }
                            rgb[i] = tmp * 255 + 0.5 | 0;
                            hue -= 1 / 3;
                            }
                            }
                            return rgb;
                            }
                    };
                    // TODO
                <%
                    sql = "SELECT `imagefilters_function` FROM `filters`";
                    n = 1;
                    text = cx.select(sql, n, 2);
                    for (int i = 0; i < text.length; i++) {
                        String temp[] = text[i].split(" columns ");
                %>
                <%= temp[0]%>
                <% }%>
                    ImageFilters.Translate = function (srcImageData, x, y, interpolation) {
                    };
                    ImageFilters.Scale = function (srcImageData, scaleX, scaleY, interpolation) {
                    };
                    ImageFilters.Rotate = function (srcImageData, originX, originY, angle, resize, interpolation) {
                    };
                    ImageFilters.Affine = function (srcImageData, matrix, resize, interpolation) {
                    };
                    ImageFilters.UnsharpMask = function (srcImageData, level) {
                    };
                    ImageFilters.ConvolutionFilter = function (srcImageData, matrixX, matrixY, matrix, divisor, bias, preserveAlpha, clamp, color, alpha) {
                    var srcPixels = srcImageData.data,
                            srcWidth = srcImageData.width,
                            srcHeight = srcImageData.height,
                            srcLength = srcPixels.length,
                            dstImageData = this.utils.createImageData(srcWidth, srcHeight),
                            dstPixels = dstImageData.data;
                    divisor = divisor || 1;
                    bias = bias || 0;
                    // default true
                    (preserveAlpha !== false) && (preserveAlpha = true);
                    (clamp !== false) && (clamp = true);
                    color = color || 0;
                    alpha = alpha || 0;
                    var index = 0,
                            rows = matrixX >> 1,
                            cols = matrixY >> 1,
                            clampR = color >> 16 & 0xFF,
                            clampG = color >> 8 & 0xFF,
                            clampB = color & 0xFF,
                            clampA = alpha * 0xFF;
                    for (var y = 0; y < srcHeight; y += 1) {
                    for (var x = 0; x < srcWidth; x += 1, index += 4) {
                    var r = 0,
                            g = 0,
                            b = 0,
                            a = 0,
                            replace = false,
                            mIndex = 0,
                            v;
                    for (var row = - rows; row <= rows; row += 1) {
                    var rowIndex = y + row,
                            offset;
                    if (0 <= rowIndex && rowIndex < srcHeight) {
                    offset = rowIndex * srcWidth;
                    } else if (clamp) {
                    offset = y * srcWidth;
                    } else {
                    replace = true;
                    }
                    for (var col = - cols; col <= cols; col += 1) {
                    var m = matrix[mIndex++];
                    if (m !== 0) {
                    var colIndex = x + col;
                    if (!(0 <= colIndex && colIndex < srcWidth)) {
                    if (clamp) {
                    colIndex = x;
                    } else {
                    replace = true;
                    }
                    }
                    if (replace) {
                    r += m * clampR;
                    g += m * clampG;
                    b += m * clampB;
                    a += m * clampA;
                    } else {
                    var p = (offset + colIndex) << 2;
                    r += m * srcPixels[p];
                    g += m * srcPixels[p + 1];
                    b += m * srcPixels[p + 2];
                    a += m * srcPixels[p + 3];
                    }
                    }
                    }
                    }
                    dstPixels[index] = (v = r / divisor + bias) > 255 ? 255 : v < 0 ? 0 : v | 0;
                    dstPixels[index + 1] = (v = g / divisor + bias) > 255 ? 255 : v < 0 ? 0 : v | 0;
                    dstPixels[index + 2] = (v = b / divisor + bias) > 255 ? 255 : v < 0 ? 0 : v | 0;
                    dstPixels[index + 3] = preserveAlpha ? srcPixels[index + 3] : (v = a / divisor + bias) > 255 ? 255 : v < 0 ? 0 : v | 0;
                    }
                    }
                    return dstImageData;
                    };
                    ImageFilters.BlendAdd = function (srcImageData, blendImageData, dx, dy) {
                    var srcPixels = srcImageData.data,
                            srcWidth = srcImageData.width,
                            srcHeight = srcImageData.height,
                            srcLength = srcPixels.length,
                            dstImageData = this.utils.createImageData(srcWidth, srcHeight),
                            dstPixels = dstImageData.data,
                            blendPixels = blendImageData.data;
                    var v;
                    for (var i = 0; i < srcLength; i += 4) {
                    dstPixels[i] = ((v = srcPixels[i] + blendPixels[i]) > 255) ? 255 : v;
                    dstPixels[i + 1] = ((v = srcPixels[i + 1] + blendPixels[i + 1]) > 255) ? 255 : v;
                    dstPixels[i + 2] = ((v = srcPixels[i + 2] + blendPixels[i + 2]) > 255) ? 255 : v;
                    dstPixels[i + 3] = 255;
                    }
                    return dstImageData;
                    };
                    ImageFilters.BlendSubtract = function (srcImageData, blendImageData, dx, dy) {
                    var srcPixels = srcImageData.data,
                            srcWidth = srcImageData.width,
                            srcHeight = srcImageData.height,
                            srcLength = srcPixels.length,
                            dstImageData = this.utils.createImageData(srcWidth, srcHeight),
                            dstPixels = dstImageData.data,
                            blendPixels = blendImageData.data;
                    var v;
                    for (var i = 0; i < srcLength; i += 4) {
                    dstPixels[i] = ((v = srcPixels[i] - blendPixels[i]) < 0) ? 0 : v;
                    dstPixels[i + 1] = ((v = srcPixels[i + 1] - blendPixels[i + 1]) < 0) ? 0 : v;
                    dstPixels[i + 2] = ((v = srcPixels[i + 2] - blendPixels[i + 2]) < 0) ? 0 : v;
                    dstPixels[i + 3] = 255;
                    }
                    return dstImageData;
                    };
                    /**
                     * Stack Blur Algorithm by Mario Klingemann <mario@quasimondo.com>
                     * @see http://incubator.quasimondo.com/processing/fast_blur_deluxe.php
                     */
                    /*
                     Copyright (c) 2010 Mario Klingemann
                     
                     Permission is hereby granted, free of charge, to any person
                     obtaining a copy of this software and associated documentation
                     files (the "Software"), to deal in the Software without
                     restriction, including without limitation the rights to use,
                     copy, modify, merge, publish, distribute, sublicense, and/or sell
                     copies of the Software, and to permit persons to whom the
                     Software is furnished to do so, subject to the following
                     conditions:
                     
                     The above copyright notice and this permission notice shall be
                     included in all copies or substantial portions of the Software.
                     
                     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
                     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
                     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
                     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
                     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
                     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
                     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
                     OTHER DEALINGS IN THE SOFTWARE.
                     */
                    /**
                     * TV based algorithm
                     */
                    ImageFilters.Brightness = function (srcImageData, brightness) {
                    var srcPixels = srcImageData.data,
                            srcWidth = srcImageData.width,
                            srcHeight = srcImageData.height,
                            srcLength = srcPixels.length,
                            dstImageData = this.utils.createImageData(srcWidth, srcHeight),
                            dstPixels = dstImageData.data;
                    this.utils.mapRGB(srcPixels, dstPixels, function (value) {
                    value += brightness;
                    return (value > 255) ? 255 : value;
                    });
                    return dstImageData;
                    };
                    /**
                     * GIMP algorithm modified. pretty close to fireworks
                     * @param brightness -100 <= n <= 100
                     * @param contrast -100 <= n <= 100
                     */
                    /**
                     * more like the new photoshop algorithm
                     * @param brightness -100 <= n <= 100
                     * @param contrast -100 <= n <= 100
                     */
                    ImageFilters.Clone = function (srcImageData) {
                    return this.Copy(srcImageData, this.utils.createImageData(srcImageData.width, srcImageData.height));
                    };
                    ImageFilters.CloneCanvas = function (srcImageData) {
                    var srcWidth = srcImageData.width,
                            srcHeight = srcImageData.height,
                            canvas = this.utils.getSampleCanvas(),
                            context = this.utils.getSampleContext(),
                            dstImageData;
                    canvas.width = srcWidth;
                    canvas.height = srcHeight;
                    context.putImageData(srcImageData, 0, 0);
                    dstImageData = context.getImageData(0, 0, srcWidth, srcHeight);
                    canvas.width = 0;
                    canvas.height = 0;
                    return dstImageData;
                    };
                    ImageFilters.ColorMatrixFilter = function (srcImageData, matrix) {
                    var srcPixels = srcImageData.data,
                            srcWidth = srcImageData.width,
                            srcHeight = srcImageData.height,
                            srcLength = srcPixels.length,
                            dstImageData = this.utils.createImageData(srcWidth, srcHeight),
                            dstPixels = dstImageData.data;
                    var m0 = matrix[0],
                            m1 = matrix[1],
                            m2 = matrix[2],
                            m3 = matrix[3],
                            m4 = matrix[4],
                            m5 = matrix[5],
                            m6 = matrix[6],
                            m7 = matrix[7],
                            m8 = matrix[8],
                            m9 = matrix[9],
                            m10 = matrix[10],
                            m11 = matrix[11],
                            m12 = matrix[12],
                            m13 = matrix[13],
                            m14 = matrix[14],
                            m15 = matrix[15],
                            m16 = matrix[16],
                            m17 = matrix[17],
                            m18 = matrix[18],
                            m19 = matrix[19];
                    var value, i, r, g, b, a;
                    for (i = 0; i < srcLength; i += 4) {
                    r = srcPixels[i];
                    g = srcPixels[i + 1];
                    b = srcPixels[i + 2];
                    a = srcPixels[i + 3];
                    dstPixels[i] = (value = r * m0 + g * m1 + b * m2 + a * m3 + m4) > 255 ? 255 : value < 0 ? 0 : value | 0;
                    dstPixels[i + 1] = (value = r * m5 + g * m6 + b * m7 + a * m8 + m9) > 255 ? 255 : value < 0 ? 0 : value | 0;
                    dstPixels[i + 2] = (value = r * m10 + g * m11 + b * m12 + a * m13 + m14) > 255 ? 255 : value < 0 ? 0 : value | 0;
                    dstPixels[i + 3] = (value = r * m15 + g * m16 + b * m17 + a * m18 + m19) > 255 ? 255 : value < 0 ? 0 : value | 0;
                    }
                    return dstImageData;
                    };
                    ImageFilters.Copy = function (srcImageData, dstImageData) {
                    var srcPixels = srcImageData.data,
                            srcLength = srcPixels.length,
                            dstPixels = dstImageData.data;
                    while (srcLength--) {
                    dstPixels[srcLength] = srcPixels[srcLength];
                    }
                    return dstImageData;
                    };
                    ImageFilters.Crop = function (srcImageData, x, y, width, height) {
                    var srcPixels = srcImageData.data,
                            srcWidth = srcImageData.width,
                            srcHeight = srcImageData.height,
                            srcLength = srcPixels.length,
                            dstImageData = this.utils.createImageData(width, height),
                            dstPixels = dstImageData.data;
                    var srcLeft = Math.max(x, 0),
                            srcTop = Math.max(y, 0),
                            srcRight = Math.min(x + width, srcWidth),
                            srcBottom = Math.min(y + height, srcHeight),
                            dstLeft = srcLeft - x,
                            dstTop = srcTop - y,
                            srcRow, srcCol, srcIndex, dstIndex;
                    for (srcRow = srcTop, dstRow = dstTop; srcRow < srcBottom; srcRow += 1, dstRow += 1) {
                    for (srcCol = srcLeft, dstCol = dstLeft; srcCol < srcRight; srcCol += 1, dstCol += 1) {
                    srcIndex = (srcRow * srcWidth + srcCol) << 2;
                    dstIndex = (dstRow * width + dstCol) << 2;
                    dstPixels[dstIndex] = srcPixels[srcIndex];
                    dstPixels[dstIndex + 1] = srcPixels[srcIndex + 1];
                    dstPixels[dstIndex + 2] = srcPixels[srcIndex + 2];
                    dstPixels[dstIndex + 3] = srcPixels[srcIndex + 3];
                    }
                    }
                    return dstImageData;
                    };
                    ImageFilters.CropBuiltin = function (srcImageData, x, y, width, height) {
                    var srcWidth = srcImageData.width,
                            srcHeight = srcImageData.height,
                            canvas = this.utils.getSampleCanvas(),
                            context = this.utils.getSampleContext();
                    canvas.width = srcWidth;
                    canvas.height = srcHeight;
                    context.putImageData(srcImageData, 0, 0);
                    var result = context.getImageData(x, y, width, height);
                    canvas.width = 0;
                    canvas.height = 0;
                    return result;
                    };
                    /**
                     * sets to the average of the highest and lowest contrast
                     */
                    /**
                     * TODO: use bilinear
                     */
                    ImageFilters.DisplacementMapFilter = function (srcImageData, mapImageData, mapX, mapY, componentX, componentY, scaleX, scaleY, mode) {
                    var srcPixels = srcImageData.data,
                            srcWidth = srcImageData.width,
                            srcHeight = srcImageData.height,
                            srcLength = srcPixels.length,
                            //        dstImageData = this.utils.createImageData(srcWidth, srcHeight),
                            dstImageData = ImageFilters.Clone(srcImageData),
                            dstPixels = dstImageData.data;
                    mapX || (mapX = 0);
                    mapY || (mapY = 0);
                    componentX || (componentX = 0); // red?
                    componentY || (componentY = 0);
                    scaleX || (scaleX = 0);
                    scaleY || (scaleY = 0);
                    mode || (mode = 2); // wrap
                    var mapWidth = mapImageData.width,
                            mapHeight = mapImageData.height,
                            mapPixels = mapImageData.data,
                            mapRight = mapWidth + mapX,
                            mapBottom = mapHeight + mapY,
                            dstIndex, srcIndex, mapIndex,
                            cx, cy, tx, ty, x, y;
                    for (x = 0; x < srcWidth; x += 1) {
                    for (y = 0; y < srcHeight; y += 1) {
                    dstIndex = (y * srcWidth + x) << 2;
                    if (x < mapX || y < mapY || x >= mapRight || y >= mapBottom) {
                    // out of the map bounds
                    // copy src to dst
                    srcIndex = dstIndex;
                    } else {
                    // apply map
                    mapIndex = ((y - mapY) * mapWidth + (x - mapX)) << 2;
                    // tx = x + ((componentX(x, y) - 128) * scaleX) / 256
                    cx = mapPixels[mapIndex + componentX];
                    tx = x + (((cx - 128) * scaleX) >> 8);
                    // tx = y + ((componentY(x, y) - 128) * scaleY) / 256
                    cy = mapPixels[mapIndex + componentY];
                    ty = y + (((cy - 128) * scaleY) >> 8);
                    srcIndex = ImageFilters.utils.getPixelIndex(tx + 0.5 | 0, ty + 0.5 | 0, srcWidth, srcHeight, mode);
                    if (srcIndex === null) {
                    // if mode == ignore and (tx,ty) is out of src bounds
                    // then copy (x,y) to dst
                    srcIndex = dstIndex;
                    }
                    }
                    dstPixels[dstIndex] = srcPixels[srcIndex];
                    dstPixels[dstIndex + 1] = srcPixels[srcIndex + 1];
                    dstPixels[dstIndex + 2] = srcPixels[srcIndex + 2];
                    dstPixels[dstIndex + 3] = srcPixels[srcIndex + 3];
                    }
                    }
                    return dstImageData;
                    };
                    ImageFilters.OpacityFilter = function (srcImageData, opacity) {
                    var srcPixels = srcImageData.data,
                            srcWidth = srcImageData.width,
                            srcHeight = srcImageData.height,
                            srcLength = srcPixels.length,
                            dstImageData = this.utils.createImageData(srcWidth, srcHeight),
                            dstPixels = dstImageData.data;
                    for (var i = 0; i < srcLength; i += 4) {
                    dstPixels[i] = srcPixels[i];
                    dstPixels[i + 1] = srcPixels[i + 1];
                    dstPixels[i + 2] = srcPixels[i + 2];
                    dstPixels[i + 3] = opacity;
                    }
                    return dstImageData;
                    };
            </script>
        </div>
    </body>
    <button onclick="upload('http://localhost:8080/Servidor/app/parklot/36');">Cargar</button>
    <button onclick="next()">Cortar</button>
    <button onclick="refresh()">Reiniciar</button>
    <div id="screen" style="
         display:none;">
        <canvas id="parking" style="
                border:3px solid #4aad52;"></canvas>
    </div>
</html>