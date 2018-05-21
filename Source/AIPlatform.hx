package;

import openfl.display.Sprite;

class AIPlatform extends Platform{
    private var ball: Ball;

    public function new (ball: Ball){
        super();
        this.ball = ball;
    }

    public override function Update(father:Sprite){
        var centricYpos = this.y + (this.height/2);
        if(centricYpos - ball.y < 0){
            this.y = this.y + this.speed;
        }
        if(centricYpos - ball.y > 0){
            this.y = this.y - this.speed;
        }

        DoNotGetOutOf(father);
    }
}