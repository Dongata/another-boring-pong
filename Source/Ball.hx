package;

import openfl.display.Sprite;

class Ball extends Sprite{
    public var xSpeed:Int;
    public var ySpeed:Int;
    public var pongNumber:Int;

    public function new(){
        super();
        graphics.beginFill(0xffffff);
        graphics.drawCircle(0,0,10);
        graphics.endFill();
        pongNumber = 0;
    }

    public function Update(father: Sprite, player1: Platform, player2: Platform): PlayersEnum{
		this.y = this.y - this.ySpeed;
		this.x = this.x - this.xSpeed;

        if(pongNumber == 3){
            this.ySpeed = MetalToThePedal(this.ySpeed);
            this.xSpeed = MetalToThePedal(this.xSpeed);
            pongNumber = 0;
            trace(this.xSpeed );
            trace(this.ySpeed );
        }

		if(this.y < 0){
			this.y = 0;
			this.ySpeed = -this.ySpeed;
		}

		if(this.y > father.width - this.height){
			this.y = father.width - this.height;
			this.ySpeed = -this.ySpeed;
        }

        if(player1.x + player1.width > this.x){
            if(player1.y < this.y && player1.height + player1.y > this.y){
                this.xSpeed = -xSpeed;
                pongNumber++;
            } else {
                return PlayersEnum.Player2;
            }
        }
        
        if(player2.x < this.x){
            if(player2.y < this.y && player2.height + player2.y > this.y){
                this.xSpeed = -xSpeed;
                pongNumber++;
            } else {
                return PlayersEnum.Player1;
            }
        }

        return null;
	}

    private function MetalToThePedal(int:Int):Int{
        if (int>=0){
            return int+1;
        }else{
            return int-1;
        }
    }
}