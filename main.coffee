class GridManager
	constructor: (@width, @height, @stage) ->
		@squares = []
		# makes a width x height matrix
		@grid = ((new Point(x, y) for y in [0...@height]) for x in [0...@width])

	step: ->
		for square in @squares
			do (square) ->

	at: (point) ->
		@grid[point.x][point.y]

	inBounds: (point) ->
		if (point.x <= @width) and (point.x >= 0) and (point.y <= @height) and (point.y >= 0)
			return true
		else
			return false


class GameManager extends GridManager
	addSquare: (square) ->
		if this.at(square.point).object == null
			@squares << square
			square.moveTo(square.point)
			@stage.addChild(square.shape)
			@stage.addChild(square.counter)
		else if (this.at(square.point).object instanceof Square) and (this.at(square.point).object.color == square.color)
			this.at(square.point).object.quantity += square.quantity
			square.setQuantityView()


class Point
	constructor: (@x, @y) ->
		@object = null

class Entity
	constructor: (@point, @grid) ->

	moveTo: (point) ->
		if @grid.inBounds(point)
			@shape.x = point.x * 55
			@shape.y = point.y * 55
			@grid.at(point).object = this
			@point.object = null
			@point = @grid.at(point)

class Square extends Entity
	constructor: (@point, @grid, @color) ->
		@shape = new createjs.Shape()
		@shape.graphics.beginFill(@color).drawRoundRect(0, 0, 50, 50, 3)
		@shape.x = @point.x * 55
		@shape.y = @point.y * 55
		@quantity = 1
		@counter = new createjs.Text(@quantity, "16px Arial", "grey")
		this.setQuantityView()

	setQuantityView: ->
		@counter.text = @quantity
		@counter.x = 10 + @point.x * 55
		@counter.y = 10 + @point.y * 55

	moveTo: (point) ->
		super point
		this.setQuantityView()

class Action
	constructor: (@entity, @action) ->
	activate: -> do @action

# class ArrowSquare

# For debug in console
gm = 1
stage = 1

p = (x, y) ->
	new Point(x, y)

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
	
	gm = new GameManager(10, 8, stage);
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

	createjs.Ticker.addEventListener("tick", stage)
	#createjs.Ticker.setInterval(1000);