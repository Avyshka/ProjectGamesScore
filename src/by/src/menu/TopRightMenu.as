package by.src.menu
{
	import by.framework.Language;
	import by.src.App;
	import by.src.Main;
	import by.src.menu.commands.ChangeGameToMaxMinCommand;
	import by.src.menu.submenus.SubMenu;

	import flash.geom.Point;

	import starling.display.Sprite;

	public class TopRightMenu extends Sprite
	{
		private var _subMenu: SubMenu;

		public function TopRightMenu()
		{
			_subMenu = new SubMenu();
			addChild(_subMenu);

			_subMenu.setCommand(new ChangeGameToMaxMinCommand());

			_subMenu.setToggle(Language.getText(Language.TOGGLE_MAX), Language.getText(Language.TOGGLE_MIN));
		}

		public function init(): void
		{
			_subMenu.init();

			var pointPosition: Point = new Point(App.SCR_W - width / 2 - 20, height / 2 + 20);
			Main.getCorrectPosition(pointPosition);

			x = pointPosition.x;
			y = pointPosition.y;
		}
	}
}
