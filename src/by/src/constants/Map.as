package by.src.constants
{
	import by.src.App;
	import by.src.Main;

	public class Map
	{
		public static const HEIGHT_MIN: int = 50;
		public static const HEIGHT_MAX: int = Main.heightFull - (App.SCR_H - 250);
		public static const RANGE: int = ((App.SCR_W - 200) / App.SCR_W) * Main.widthFull;
		public static const RANGE_HALF: int = RANGE / 2;
	}
}
