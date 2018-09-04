package by.src.menu.submenus
{
	import by.framework.Builder;
	import by.framework.Language;
	import by.framework.Organizer;
	import by.framework.artist.Artist;
	import by.src.constants.Colors;
	import by.src.gui.Toggle;
	import by.src.gui.strategies.interfaces.IChangeColorStrategy;
	import by.src.menu.interfaces.ICommand;
	import by.src.menu.interfaces.IToggleCommand;

	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;

	import starling.display.Button;

	import starling.display.Sprite;
	import starling.events.Event;

	public class SubMenu extends Sprite
	{
		private static const GAP: int = 80;

		private var _vButtonsList: Vector.<Button>;
		private var _vCommandsList: Vector.<ICommand>;

		private var _count: int;

		public function SubMenu()
		{
			_vButtonsList = new Vector.<Button>();
			_vCommandsList = new Vector.<ICommand>();
		}

		public function setCommand(command: ICommand): void
		{
			_vCommandsList.push(command);
		}

		public function setButton(txtID: String): void
		{
			const btn: Button = new Button(Artist.getTexture("btnCircle"), Language.getText(txtID));
			btn.alignPivot();

			btn.fontColor = Colors.COLOR_VERY_LIGHT;
			btn.fontName = Builder.FONT_MONO;
			btn.fontSize = 20;

			addChild(btn);

			_vButtonsList.push(btn);
			_count = _vButtonsList.length;

			arrange();
		}

		public function setToggle(txtON: String, txtOFF: String, strategy: IChangeColorStrategy = null): void
		{
			const toggle: Toggle = new Toggle("btnCircle", "btnCircle");
			toggle.setTextValues(txtON, txtOFF);

			if (strategy)
			{
				toggle.addStrategy(strategy);
			}

			toggle.init(false);
			addChild(toggle);

			_vButtonsList.push(toggle);
			_count = _vButtonsList.length;

			arrange();
		}

		private function arrange(): void
		{
			var positions: Vector.<Point> = Organizer.line(_count, new Point(GAP, 0));

			for (var indexBtn: int = 0; indexBtn < _count; indexBtn++)
			{
				_vButtonsList[indexBtn].x = positions[indexBtn].x;
			}
		}

		public function init(): void
		{
			for (var indexBtn: int = 0; indexBtn < _count; indexBtn++)
			{
				_vButtonsList[indexBtn].addEventListener(Event.TRIGGERED, onClickBtn);
			}
		}

		public function free(): void
		{
			for (var indexBtn: int = 0; indexBtn < _count; indexBtn++)
			{
				_vButtonsList[indexBtn].removeEventListener(Event.TRIGGERED, onClickBtn);
			}
		}

		public function changeEnableButtons(enable: Boolean): void
		{
			for (var indexBtn: int = 0; indexBtn < _count; indexBtn++)
			{
				if (getQualifiedClassName(_vButtonsList[indexBtn]) == "by.src.gui::Toggle")
				{
					var toggle: Toggle = _vButtonsList[indexBtn] as Toggle;
					if (!toggle.isSwitched)
					{
						toggle.enabled = enable;
					}
				}
				else
				{
					_vButtonsList[indexBtn].enabled = enable;
				}
			}
		}

		private function onClickBtn(event: Event): void
		{
			const indexCurrentButton: int = _vButtonsList.indexOf(event.currentTarget as Button);
			const command: ICommand = _vCommandsList[indexCurrentButton];

			if (getQualifiedClassName(event.currentTarget) == "by.src.gui::Toggle")
			{
				(command as IToggleCommand).setReceiver(event.currentTarget as Toggle);
			}
			_vCommandsList[indexCurrentButton].execute();
		}
	}
}
