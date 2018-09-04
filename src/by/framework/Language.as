package by.framework
{
	public class Language
	{
		public static const ADD_PLAYER: String = "Language.ADD_PLAYER";
		public static const ADD_PLAYER_BUTTON: String = "Language.ADD_PLAYER_BUTTON";
		public static const ADD_POINTS_BUTTON: String = "Language.ADD_POINTS_BUTTON";
		public static const DEL_PLAYER: String = "Language.DEL_PLAYER";
		public static const RESET_GAME: String = "Language.RESET_GAME";
		public static const ADD_PLAYER_TITLE: String = "Language.ADD_PLAYER_TITLE";
		public static const TOGGLE_MIN: String = "Language.TOGGLE_MIN";
		public static const TOGGLE_MAX: String = "Language.TOGGLE_MAX";
		public static const BTN_YES: String = "Language.BTN_YES";
		public static const BTN_NO: String = "Language.BTN_NO";
		public static const DEL_APPROVAL: String = "Language.DEL_APPROVAL";
		public static const END_GAME_APPROVAL: String = "Language.END_GAME_APPROVAL";

		public static var current: String = "none";
		
		private static var _labels: Object = {};

		// английский язык
		public static function setEnglish(): void
		{
			_labels[ADD_PLAYER] = "ADD";
			_labels[ADD_PLAYER_BUTTON] = "ADD PLAYER";
			_labels[ADD_POINTS_BUTTON] = "ADD POINTS";
			_labels[DEL_PLAYER] = "DEL";
			_labels[RESET_GAME] = "END";
			_labels[ADD_PLAYER_TITLE] = "INPUT NAME PLAYER:";
			_labels[TOGGLE_MIN] = "MIN";
			_labels[TOGGLE_MAX] = "MAX";
			_labels[BTN_YES] = "YES";
			_labels[BTN_NO] = "NO";
			_labels[DEL_APPROVAL] = "DO YOU WANT TO REMOVE";
			_labels[END_GAME_APPROVAL] = "DO YOU WANT TO END\nTHE GAME?";

			current = "en";
		}
		
		// русский язык
		public static function setRussian(): void
		{
			_labels[ADD_PLAYER] = "ДОБАВИТЬ\nИГРОКА";
			_labels[ADD_PLAYER_BUTTON] = "ДОБАВИТЬ ИГРОКА";
			_labels[DEL_PLAYER] = "УДАЛИТЬ\nИГРОКА";
			_labels[RESET_GAME] = "СБРОСИТЬ\nИГРУ";
			
			current = "ru";
		}
		
		// получить текст для объекта
		public static function getText(id:String): String
		{
			return (_labels[id] == null) ? "запись не найдена" : _labels[id].toString().toUpperCase();
		}
	}
	
}