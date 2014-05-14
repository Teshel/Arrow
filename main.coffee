class FieldManager
	constructor: (@width, @height) ->
		@squares = []
		@grid = ((new Point(x, y) for y in [0..@height]) for x in [0...@width])

	step: ->
		for square in @squares
			do (square) ->

	redraw: ->

	inBounds: (point) ->
		if (point.x <= @width) and (point.x >= 0) and (point.y <= @height) and (point.y >= 0)
			return true
		else
			return false

class Point
	@object
	constructor: (@x, @y) ->

class Square
	constructor: (@point, @world, @color) ->
		@shape = new createjs.Shape()
		@shape.graphics.beginFill("blue").drawRoundRect(0, 0, 40, 40, 1)
		@shape.x = @point.x
		@shape.y = @point.y
		@world.stage.addChild(@shape)

	moveTo: (@point) ->
		if @grid.inBounds(@point)
			shape.x = @point.x * 50
			shape.y = @point.y * 50

# class ArrowSquare

# For debug in console
Entity = 1
Renderer = 1
stage = 1

$(document).ready ->
	canvas = document.getElementById("myCanvas")
	# // if (window.devicePixelRatio) {
 # //        var canvasWidth = $(canvas).attr('width')
 # //        var canvasHeight = $(canvas).attr('height')
 # //        var canvasCssWidth = canvasWidth;
 # //        var canvasCssHeight = canvasHeight;

 # //        $(canvas).attr('width', canvasWidth * window.devicePixelRatio);
 # //        $(canvas).attr('height', canvasHeight * window.devicePixelRatio);
 # //        $(canvas).css('width', canvasCssWidth);
 # //        $(canvas).css('height', canvasCssHeight);
 # //        context.scale(window.devicePixelRatio, window.devicePixelRatio);
 # //    }
	stage = new createjs.Stage("myCanvas")
	if (window.devicePixelRatio)
	    # grab the width and height from canvas
	    height = canvas.getAttribute('height')
	    width = canvas.getAttribute('width')
	    # reset the canvas width and height with window.devicePixelRatio applied
	    canvas.setAttribute('width', Math.round(width * window.devicePixelRatio))
	    canvas.setAttribute('height', Math.round( height * window.devicePixelRatio))
	    # force the canvas back to the original size using css
	    canvas.style.width = width+"px"
	    canvas.style.height = height+"px"
	    # set CreateJS to render scaled
	    stage.scaleX = stage.scaleY = window.devicePixelRatio
	
	# circle = new createjs.Shape()
	# circle.graphics.beginFill("red").drawCircle(0, 0, 50)
	# circle.x = 100
	# circle.y = 100
	# stage.addChild(circle)

	# rect = new createjs.Shape()
	# rect.graphics.beginFill("blue").drawRoundRect(0, 0, 10, 10, 1)
	# rect.x = 300
	# rect.y = 100
	# stage.addChild(rect)

	createjs.Ticker.addEventListener("tick", stage).setInterval(1000);