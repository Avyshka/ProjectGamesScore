package by.src.messageBox.messageBoxes
{
	import by.framework.Builder;
	import by.framework.Language;
	import by.src.App;
	import by.src.Main;
	import by.src.constants.Colors;
	import by.src.gui.EllipseButton;
	import by.src.menu.commands.AddPlayerCommand;
	import by.src.messageBox.MessageBoxWithCancel;

	import flash.geom.Rectangle;
	import flash.text.StageText;
	import flash.text.TextFormatAlign;
	import flash.text.engine.FontWeight;

	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	public class MessageBoxAddPlayer extends MessageBoxWithCancel
	{
		private var _title: TextField;
		private var _tfNamePlayer: StageText;
		private var _rectangleForTheInputText: Sprite;
		private var _btnAddPlayer: EllipseButton;

		private var _command: AddPlayerCommand;

		public function MessageBoxAddPlayer()
		{
			super();

			_title = Builder.createTextField(300, 30, Language.getText(Language.ADD_PLAYER_TITLE), 20, 0xFFFFFF, 0, -40, _content);

			// прямоугольная область для поля ввода
			_rectangleForTheInputText = new Sprite();
			_content.addChild(_rectangleForTheInputText);

			var borderInput: Quad = new Quad(354, 44, Colors.COLOR_LIGHT);
			borderInput.alignPivot();
			_rectangleForTheInputText.addChild(borderInput);

			var backgroundInput: Quad = new Quad(350, 40, Colors.COLOR_DARK);
			backgroundInput.alignPivot();
			_rectangleForTheInputText.addChild(backgroundInput);

			// поле ввода
			_tfNamePlayer = createTextFieldInput(0xFFFF00, 30);
			_tfNamePlayer.visible = false;

			_btnAddPlayer = new EllipseButton(EllipseButton.COLOR_GREEN, Language.getText(Language.ADD_PLAYER_BUTTON));
			_btnAddPlayer.alignPivot();
			_btnAddPlayer.y = 50;
			_content.addChild(_btnAddPlayer);

			_command = new AddPlayerCommand(_tfNamePlayer);

			arrange();
		}

		private function createTextFieldInput(color: int, size: int): StageText
		{
			var myTextField: StageText = new StageText();

			var scaleX: Number = Main.deltaScaleX;
			var scaleY: Number = Main.deltaScaleY;

			myTextField.stage = Starling.current.nativeOverlay.stage;
			myTextField.color = color;
			myTextField.fontFamily = "Verdana";
			myTextField.fontSize = int(size * scaleX);
			myTextField.maxChars = 10;
			myTextField.fontWeight = FontWeight.BOLD;
			myTextField.textAlign = TextFormatAlign.CENTER;

			var rect: Rectangle = new Rectangle(0, _content.y + App.SCR_H_HALF + _rectangleForTheInputText.y - _rectangleForTheInputText.height / 2 + 3, App.SCR_W, size + 10);
			rect.x *= scaleX;
			rect.y *= scaleY;
			rect.width *= scaleX;
			rect.height *= scaleY;

			myTextField.viewPort = rect;

			return myTextField;
		}

		override public function init():void
		{
			super.init();

			_tfNamePlayer.text = "";
			_tfNamePlayer.visible = true;
			_btnAddPlayer.addEventListener(Event.TRIGGERED, onTriggerButton);
		}

		override public function free():void
		{
			_tfNamePlayer.visible = false;
			_btnAddPlayer.removeEventListener(Event.TRIGGERED, onTriggerButton);
			super.free();
		}

		private function onTriggerButton(event: Event):void
		{
			if (_tfNamePlayer.text.length > 0)
			{
				_command.execute();
				free();
			}
		}
	}
}
