package by.framework
{
	import flash.net.SharedObject;
	
	public class Keeper
	{
		public function Keeper() {
			// constructor code
		}
		
		public static function clear():void
		{
			var read:SharedObject = SharedObject.getLocal("template");
			read.clear();
		}
		
		public static function loadLanguage():String
		{
			var read:SharedObject = SharedObject.getLocal("template");
			
			if(read.data.language != undefined)
				return read.data.language;
				
			return "eng";
		}
		
		public static function saveLanguage(lang:String):void
		{
			var save:SharedObject = SharedObject.getLocal("template");
			save.data.language = lang;
			save.flush();
		}

		public static function saveSounds(_idToggle: String, vol: Number): void
		{
			var save:SharedObject = SharedObject.getLocal("template");
			save.data[_idToggle] = vol;
			save.flush();
		}

		// загрузка результатов
		public static function loadSounds(_idToggle: String):Number
		{
			var read:SharedObject = SharedObject.getLocal("template");
			
			if(read.data[_idToggle] == null)
			{
				return 1;
			}
			return read.data[_idToggle];
		}
	}
	
}
