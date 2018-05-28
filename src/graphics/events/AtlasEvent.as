package graphics.events
{
	import flash.events.Event;
	
	public class AtlasEvent extends Event
	{
		public static const ATLAS_LOADED:String = "loadedAtlasEvent";
		public static const ATLAS_DISPOSED:String = "disposedAtlasEvent";
		
		public function AtlasEvent(type:String)
		{
			super(type);
		}
	}
}
