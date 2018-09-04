package by.framework
{
	public class Singleton
	{
		private static var _instance: Singleton;

		public function Singleton()
		{
			if (_instance != null)
			{
				throw("Error: Singleton уже существует. Используйте Singleton.getInstance();");
			}
			_instance = this;
		}

		public static function getInstance(): Singleton
		{
			return (_instance == null) ? new Singleton() : _instance;
		}
	}
}
