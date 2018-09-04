package by.src.balloons.views
{
	import by.framework.AMath;
	import by.framework.Builder;
	import by.framework.artist.Artist;
	import by.src.constants.BalloonConstants;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class Ball extends Sprite
	{
		private var _body: Image;
		private var _pattern: Image;

		public function Ball()
		{
			_body = Builder.createImage("balloonBody", this);
			_pattern = Builder.createImage("balloonPattern1", this);

			_body.alignPivot(HAlign.CENTER, VAlign.BOTTOM);
			_pattern.alignPivot(HAlign.CENTER, VAlign.BOTTOM);

			Builder.createImage("balloonLight", this).alignPivot(HAlign.CENTER, VAlign.BOTTOM);
		}

		public function init(colorBody: uint, colorPattern: uint): void
		{
			_pattern.texture = Artist.getTexture("balloonPattern" + AMath.random(BalloonConstants.INDEX_PATTERN_MIN, BalloonConstants.INDEX_PATTERN_MAX));

			_body.color = colorBody;
			_pattern.color = colorPattern;
		}
	}
}
