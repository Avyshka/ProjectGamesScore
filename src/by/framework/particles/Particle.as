package by.framework.particles
{
	import by.framework.AMath;
	import by.framework.ATween;
	import by.framework.Avector;
	import by.framework.ComponentPool;
	import by.framework.artist.Artist;

	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;

	public class Particle extends Sprite implements IAnimatable
	{
		private static const POWER:int = 50;
		
		private var _sprite: MovieClip;
		
		private var _vector: Avector;
		private var _koef: Number;
		
		private var _lastDist:Number;
		
		// Initialization:
		public function Particle()
		{
			_vector = new Avector();
			_sprite = new MovieClip(Artist.getTextures("particle"), 1);
			_sprite.alignPivot();
			addChild(_sprite);
			
			this.touchable = false;
			this.touchGroup = false;
		}
		
		public function init(posX: Number, posY: Number, power: Number = 1): void
		{		
			// устанавливаем графический образ
			x = posX;
			y = posY;

			_sprite.x = 0;
			_sprite.y = 0;
			
			_sprite.scaleX = _sprite.scaleY = (Math.random() + .5) * (power * 1.5);
			_sprite.color = 0xFFFFFF;
			_sprite.currentFrame = AMath.random(0, _sprite.numFrames - 1);

			var startSpeed: Number = power * POWER;
			var speed: Number = AMath.random(startSpeed * .75, startSpeed * 1.25);
			var angle: Number = AMath.toRadians(360 * Math.random());

			_koef = AMath.random(8, 10);
			_vector.asSpeed(speed, angle);
			
			_lastDist = speed;
			
			//добавляем цену в игру
			Starling.juggler.add(this);
		}
		
		public function advanceTime(passedTime: Number): void
		{
			_sprite.x += ATween.velFriction(_sprite.x, _vector.x, _koef);
			_sprite.y += ATween.velFriction(_sprite.y, _vector.y, _koef);
			
			var range: Number = AMath.distance(_sprite.x, _sprite.y, _vector.x, _vector.y);
			if (range <= 1 || range > _lastDist)
			{
				free();
			}
			_lastDist = range;
		}
		
		public function free():void
		{
			Starling.juggler.remove(this);
			ComponentPool.dispose(this);
			parent.removeChild(this);
		}

		public function setColor(color: uint): void
		{
			_sprite.color = color;
		}
	}
}