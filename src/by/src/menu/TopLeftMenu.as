package by.src.menu
{
	import by.framework.Language;
	import by.src.Main;
	import by.src.events.Events;
	import by.src.events.EventsDispatcher;
	import by.src.gui.strategies.ChangeColorStrategy;
	import by.src.menu.actions.EndGameAction;
	import by.src.menu.actions.ShowMessageBoxAddPlayerAction;
	import by.src.menu.actions.ShowMessageBoxEndGameAction;
	import by.src.menu.commands.ChangeVisibilityDelButtonBalloonsCommand;
	import by.src.menu.commands.ConcreteCommand;
	import by.src.menu.submenus.SubMenu;

	import flash.geom.Point;

	import starling.display.Sprite;
	import starling.events.Event;

	public class TopLeftMenu extends Sprite
	{
		private var _dispatcher: EventsDispatcher = EventsDispatcher.getInstance();
		private var _subMenu: SubMenu;

		public function TopLeftMenu()
		{
			_subMenu = new SubMenu();
			addChild(_subMenu);

			_subMenu.setCommand(new ConcreteCommand(new ShowMessageBoxAddPlayerAction()));
			_subMenu.setCommand(new ChangeVisibilityDelButtonBalloonsCommand());
			_subMenu.setCommand(new ConcreteCommand(new ShowMessageBoxEndGameAction()));

			_subMenu.setButton(Language.ADD_PLAYER);
			_subMenu.setToggle(Language.getText(Language.DEL_PLAYER), Language.getText(Language.DEL_PLAYER), new ChangeColorStrategy(0xFF9900, 0xFFFFFF));
			_subMenu.setButton(Language.RESET_GAME);

			_dispatcher.addEventListener(Events.CHANGE_VISIBILITY_DEL_BUTTON_BALLONS, onChangeVisibilityDelButtons);
		}

		public function init(): void
		{
			_subMenu.init();

			var pointPosition: Point = new Point(width / 2 + 20, height / 2 + 20);
			Main.getCorrectPosition(pointPosition);

			x = pointPosition.x;
			y = pointPosition.y;
		}

		private function onChangeVisibilityDelButtons(event: Event): void
		{
			const enable: Boolean = event.data as Boolean;
			_subMenu.changeEnableButtons(!enable);
		}
	}
}
