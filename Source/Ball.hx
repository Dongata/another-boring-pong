package;

import openfl.display.Sprite;

class Ball extends Sprite{
    public var xSpeed:Int;
    public var ySpeed:Int;

    public function new(){
        super();
        graphics.beginFill(0xffffff);
        graphics.drawCircle(0,0,10);
        graphics.endFill();
    }

    public function Update(father: Sprite, player1: Platform, player2: Platform): String{
		this.y = this.y - this.ySpeed;
		this.x = this.x - this.xSpeed;

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
            } else {
                return "player2";
            }
        }
        
        if(player2.x < this.x){
            if(player2.y < this.y && player2.height + player2.y > this.y){
                this.xSpeed = -xSpeed;
            } else {
                return "player1";
            }
        }

        return null;
	}
}