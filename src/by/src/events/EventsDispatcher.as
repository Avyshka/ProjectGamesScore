package by.src.events
{
	import starling.events.EventDispatcher;

	public class EventsDispatcher extends EventDispatcher
	{
		private static var _instance: EventsDispatcher;

		public function EventsDispatcher()
		{
			super();

			if (_instance != null)
			{
				throw("Error: Class уже существует. Используйте ClassName.getInstance();");
			}
			_instance = this;
		}

		public static function getInstance(): EventsDispatcher
		{
			return (_instance == null) ? new EventsDispatcher() : _instance;
		}
	}
}
