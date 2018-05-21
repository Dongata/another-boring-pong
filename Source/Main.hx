package;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.events.KeyboardEvent;
import openfl.Lib;

class Main extends Sprite {

	//Game Properties
	var player1 : Platform;
	var player2 : Platform;
	var ball : Ball;

	//Game Output
	var scoreField:TextField;
	var messageField:TextField;

	///State
	var initiated : Bool;
	var gameState : GameState;
	var player1Score : Int;
	var player2Score : Int;
	var xSize:Float = 500;
	var ySize:Float = 500;
	var gameSpeed: Int = 4;

	function Resize(e){
		if (!initiated) Init();
		this.xSize = this.width;
		this.ySize = this.height;
	}
	
	function Init(){
		initBall();
		initPlayers();
		initScore();
		initOutput();
		addComponents();

		initListeners();

		setGameState(GameState.paused);
		this.initiated = true;
	}
	
	function added(e){
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, Resize);
		Init();
	}
	
	
	public function new () {
		super();
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	public static function main() 
	{
		Lib.current.stage.align = openfl.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = openfl.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}

	function initScore(){
		player1Score = 0;
		player2Score = 0;
	}

	function initPlayers(){
		player1 = new Platform();
		player2 = new AIPlatform(this.ball);
		resetPlayers();
	}

	function initBall(){
		ball = new Ball();
		resetBall();
	}

	function addComponents(){
		addChild(player1);
		addChild(player2);
		addChild(ball);
		addChild(scoreField);
		addChild(messageField);
	}

	function initOutput(){
		var scoreFormat = new TextFormat("Verdana", 24, 0xBBBBBB, true);
		scoreFormat.align = TextFormatAlign.CENTER;

		scoreField = new TextField();
		scoreField.width = 500;
		scoreField.y = 30;
		scoreField.defaultTextFormat = scoreFormat;
		scoreField.selectable = false;
		updateScore();

		var messageFormat = new TextFormat("Verdana", 24, 0xBBBBBB, false);
		messageFormat.align = TextFormatAlign.CENTER;

		messageField = new TextField();
		messageField.width = 500;
		messageField.y = 450;
		messageField.defaultTextFormat = messageFormat;
		messageField.selectable = false;
		messageField.text = "Paused";
	}

	function updateScore(){
		if(scoreField != null){
			scoreField.text = player1Score + " : " + player2Score;
		}
	}

	function setGameState(state:GameState){
		gameState = state;
		updateScore();
		if(state == GameState.paused){
			messageField.alpha = 1;
		}else{
			messageField.alpha = 0;
		}
	}

	function initListeners(){
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		stage.addEventListener(Event.ENTER_FRAME, everyFrame);
	}

	function keyDown(event:KeyboardEvent){
		if(event.keyCode == 32){
			if(gameState == GameState.paused){
				setGameState(GameState.playing);
			}else{
				setGameState(GameState.paused);
			}
		}else{
			if(gameState != GameState.paused){
				switch(event.keyCode){
					case 38:{
						player1.speed = gameSpeed;
					}
					case 40:{
						player1.speed = -gameSpeed;
					}
				}
			}
		}
	}

	function keyUp(event: KeyboardEvent){
		if(gameState != GameState.paused){
			switch(event.keyCode){
				case 38:{
					player1.speed = 0;
				}
				case 40:{
					player1.speed = 0;
				}
			}
		}
	}

	function everyFrame(event:Event){
		if(gameState != GameState.paused){
			player1.Update(this);
			player2.Update(this);
			var winner = ball.Update(this, player1, player2);
			if(winner == "player1"){
				player1Score ++;
				updateScore();
				resetBall();
			}
			if(winner == "player2"){
				player2Score ++;
				updateScore();
				resetBall();
			}
		}
	}

	function resetBall(){
		ball.x = 250;
		ball.y = 250;
		ball.xSpeed = 4;
		ball.ySpeed = 2;
	}

	function resetPlayers(){
		player1.x = 0;
		player1.y = (this.xSize - player1.height) / 2;
		player1.speed = 0;

		player2.y = (this.ySize - player2.height) / 2;
		player2.x = 480;
		player2.speed = 4;
	}
}
