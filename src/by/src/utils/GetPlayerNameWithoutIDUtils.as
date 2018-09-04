package by.src.utils
{
	public class GetPlayerNameWithoutIDUtils
	{
		public static function cutPlayerName(playerName: String): String
		{
			return playerName.substr(playerName.indexOf("_") + 1);
		}
	}
}
