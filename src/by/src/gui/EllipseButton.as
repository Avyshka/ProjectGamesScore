package by.src.gui
{
	import by.framework.Builder;
	import by.src.constants.Colors;

	import flash.utils.getQualifiedClassName;

	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.deg2rad;

	public class EllipseButton extends Button
	{
		public static const COLOR_GREEN: String = "Green";
		public static const COLOR_RED: String = "Red";

		public function EllipseButton(color: String, text: String)
		{
			super(Texture.empty(20, 20), text);

			fontSize = 20;
			fontName = Builder.FONT_MONO;
			fontColor = Colors.COLOR_DARK;

			var tf: TextField = getTextField();
			tf.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;

			var sprite: Sprite = new Sprite();

			var body: Image = Builder.createImage("btnBox" + color, sprite);
			body.width = tf.width;

			var capLeft: Image = Builder.createImage("btnBoxCap" + color, sprite);
			capLeft.alignPivot(HAlign.RIGHT);
			capLeft.x = -body.width / 2 + 5;

			var capRight: Image = Builder.createImage("btnBoxCap" + color, sprite);
			capRight.rotation = deg2rad(180);
			capRight.alignPivot(HAlign.RIGHT);
			capRight.x = body.width / 2 - 5;

			sprite.addChild(body);

			upState = Texture.empty(sprite.width, sprite.height);

			sprite.x = sprite.width / 2;
			sprite.y = sprite.height / 2;

			tf.autoSize = TextFieldAutoSize.NONE;
			readjustSize(true);

			(this.getChildAt(0) as Sprite).addChildAt(sprite, 0);
		}

		private function getTextField(): TextField
		{
			var content: Sprite = this.getChildAt(0) as Sprite;
			var numChildren: int = content.numChildren;

			for (var i: int = 0; i < numChildren; i++)
			{
				if (getQualifiedClassName(content.getChildAt(i)) == "starling.text::TextField")
				{
					return content.getChildAt(i) as TextField;
				}
			}
			return null;
		}
	}
}
