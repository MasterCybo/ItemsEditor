package properties.controllers
{
	import base.controllers.ControllerFeathers;
	
	import graphics.Assets;
	import graphics.events.AtlasEvent;
	
	import properties.views.PropertyImageSelector;
	
	public class PropertyImageSelectorController extends ControllerFeathers
	{
		public function PropertyImageSelectorController(view:PropertyImageSelector)
		{
			super(view);
		}
		
		public function get view():PropertyImageSelector {return getView() as PropertyImageSelector;}
		
		override protected function initialize():void
		{
			super.initialize();
			
			setupImagesList();
			
			eventDispatcher.addEventListener(AtlasEvent.ATLAS_LOADED, atlasHandler);
		}
		
		override public function destroy():void
		{
			eventDispatcher.removeEventListener(AtlasEvent.ATLAS_LOADED, atlasHandler);
			super.destroy();
		}
		
		private function atlasHandler(event:AtlasEvent):void
		{
			setupImagesList();
		}
		
		private function setupImagesList():void
		{
			var imageNames:Vector.<String> = Assets.me.getTextureNames();
			view.images = imageNames;
		}
	}
}
