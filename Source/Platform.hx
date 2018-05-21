package;

import openfl.display.Sprite;

class Platform extends Sprite{

	public var speed:Int;

	public function new() 
	{
		super();
		graphics.beginFill(0xFFFFFF);
		graphics.drawRect(0, 0, 15, 100);
		graphics.endFill();
	}

	public function DoNotGetOutOf(anSprite: Sprite){
		if(this.y < 0){
			this.y = 0;
		}

		if(this.y > anSprite.width - this.height){
			this.y = anSprite.width - this.height;
		}
	}

	public function Update(father: Sprite){
		if(father.width >= this.y - this.height && this.y >= 0){
			this.y = this.y - this.speed;
		}

		DoNotGetOutOf(father);
	}
}