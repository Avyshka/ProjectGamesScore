package by.src.utils
{
	import starling.utils.Color;

	public class ColorUtils
	{
		private static const RED: int = 0;
		private static const GREEN: int = 1;
		private static const BLUE: int = 2;
		private static const MAX_COLOR_VALUE: int = 254;

		public static function getRandomColor(): uint
		{
			var arrColors: Array = new Array(3);

			arrColors[RED] = getRandomSingleColor();
			arrColors[GREEN] = getRandomSingleColor();
			arrColors[BLUE] = getRandomSingleColor();

			var maxValueColor: int = Math.max(arrColors[RED], arrColors[GREEN], arrColors[BLUE]);
			var indexMaxValueColor: int = arrColors.indexOf(maxValueColor);

			arrColors[indexMaxValueColor] = MAX_COLOR_VALUE;

			return Color.rgb(arrColors[RED], arrColors[GREEN], arrColors[BLUE]);
		}

		private static function getRandomSingleColor(): uint
		{
			return 255 * Math.random();
		}
	}
}
