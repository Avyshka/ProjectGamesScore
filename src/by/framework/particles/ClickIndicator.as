package by.src.particles
{
	import starling.display.Sprite;
	import starling.display.Image;
	import by.framework.ComponentPool;
	import by.src.components.Builder;
	
	public class ClickIndicator extends Sprite
	{
		private static const SCALE:Number = 1;
		private static const TIME:Number = 1.25;
		
		private var _sprite:Image;
		private var _scale:Number;
		
		public function ClickIndicator() 
		{
			_sprite = Builder.createImage("wave", this);
			
			this.touchable = false;
			this.touchGroup = false;
		}
		
		public function init(posX:Number, posY:Number, color:uint, scale:Number = 1.0):void
		{
			x = posX;
			y = posY;
			_scale = scale;
			_sprite.color  = color;
			
			alpha = 1;
			scaleX = scaleY = _scale;
			
			if(!contains(_sprite))
				addChild(_sprite);
			
			Builder.addTween(this, x, y, 0, _scale + SCALE, 0, TIME, free);
		}
		
		public function free():void
		{
			ComponentPool.dispose(this);
			
			if(contains(_sprite))
				removeChild(_sprite);
			
			parent.removeChild(this);
		}
	}
	
}
