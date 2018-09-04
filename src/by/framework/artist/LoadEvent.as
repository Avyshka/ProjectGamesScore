package by.framework.artist
{
	import flash.events.Event;

	import starling.textures.TextureAtlas;

	public class LoadEvent extends Event
	{
		public static const LOADING_COMPLETE: String = "LoadEvent.LOADING_COMPLETE";

		public var atlas: TextureAtlas;

		public function LoadEvent(type: String,
								  bubbles: Boolean = false,
								  cancelable: Boolean = false,
								  atlas: TextureAtlas = null)
		{
			super(type, bubbles, cancelable);
			this.atlas = atlas;
		}

		override public function clone():Event
		{
			return new LoadEvent(type, bubbles, cancelable, atlas);
		}

		override public function toString(): String
		{
			return formatToString("LoadEvent", "type", "bubbles", "cancelable", "eventPhase", "atlas");
		}
	}
}
