package by.framework
{
	import by.framework.artist.Artist;

	import flash.utils.setTimeout;

	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.core.starling_internal;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;

	public class Builder extends Sprite
	{
		public static const FONT_MONO:String = "fontAivaMono";
		
		public function Builder(){}

		public static function createTextField(w: int,
											   h: int,
											   txt: String,
											   size: int,
											   color: uint,
											   posX: Number,
											   posY: Number,
											   s: Sprite,
											   fontName: String = Builder.FONT_MONO): TextField
		{
			var tf: TextField = new TextField(w, h, txt, fontName, size, color, true);
			tf.alignPivot();
			tf.x = posX;
			tf.y = posY;
			s.addChild(tf);

			return tf;
		}

		public static function createImage(nameImage: String,
										   parentSprite: Sprite = null,
										   alignCenter: Boolean = true): Image
		{
			var img: Image = new Image(Artist.getTexture(nameImage));

			if (alignCenter) img.alignPivot();
			if (parentSprite) parentSprite.addChild(img);

			return img;
		}

		public static function addTween(obj: DisplayObject,
										posX: Number,
										posY: Number,
										angle: Number = 0,
										scale: Number = 1,
										alph: Number = 1,
										time: Number = .75,
										onComplete: Function = null,
										transition: String = Transitions.EASE_OUT,
										delay: int = 0): Tween
		{
			if (Starling.juggler.containsTweens(obj))
			{
				Starling.juggler.removeTweens(obj);
			}

			var t: Tween = Tween.starling_internal::fromPool(obj, time, transition);
			t.moveTo(posX, posY);
			t.rotateTo(AMath.toRadians(angle));
			t.scaleTo(scale);
			t.fadeTo(alph);
			Starling.juggler.add(t);

			t.onComplete = function():void
			{
				Starling.juggler.remove(t);
				Tween.starling_internal::toPool(t);
				if(onComplete != null)
				{
					setTimeout(onComplete, delay);
				}
			};

			return t;
		}

		public static function addTweenScaleStack(obj: DisplayObject,
												 scale: Number,
												 time: Number,
												 transition: String = Transitions.EASE_OUT,
												 autoStart: Boolean = true,
												 onComplete = null): Tween
		{
			var t: Tween = Tween.starling_internal::fromPool(obj, time, transition);
			t.scaleTo(scale);
			if (autoStart) Starling.juggler.add(t);

			t.onComplete = function(): void
			{
				if (onComplete) onComplete();
			};

			return t;
		}

		public static function addTweenScale(obj: DisplayObject,
											 scale: Number = 1,
											 time: Number = .75,
											 transition: String = Transitions.EASE_OUT,
											 onComplete: Function = null): Tween
		{
			return Builder.addTween(obj, obj.x, obj.y, obj.rotation, scale, obj.alpha, time, onComplete, transition);
		}

		public static function addTweenScaleY(obj: DisplayObject,
											 scale: Number = 1,
											 time: Number = .75,
											 transition: String = Transitions.EASE_OUT,
											 onComplete: Function = null): Tween
		{
			if (Starling.juggler.containsTweens(obj))
			{
				Starling.juggler.removeTweens(obj);
			}

			var t: Tween = Tween.starling_internal::fromPool(obj, time, transition);
			t.scaleToY(scale);
			Starling.juggler.add(t);

			t.onComplete = function():void
			{
				Starling.juggler.remove(t);
				Tween.starling_internal::toPool(t);
				if(onComplete != null)
				{
					onComplete();
				}
			};

			return t;
		}
		
		public static function addTweenAlpha(obj: DisplayObject,
											 alph: Number = 1,
											 time: Number = .75,
											 transition: String = Transitions.EASE_OUT,
											 onComplete: Function = null): Tween
		{
			return Builder.addTween(obj, obj.x, obj.y, obj.rotation, obj.scaleX, alph, time, onComplete, transition);
		}
	}
}
