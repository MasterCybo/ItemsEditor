package base.views
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class View extends Sprite
	{
		public function View()
		{
			super();
			stage ? initialize() : addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			initialize();
		}
		
		override public function dispose():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			super.dispose();
		}
		
		public function initialize():void
		{
		
		}
	}
}
