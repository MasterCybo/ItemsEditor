package graphics.commands
{
	import core.models.AppSettings;
	
	import flash.filesystem.File;
	
	import graphics.Assets;
	import graphics.events.AtlasEvent;
	
	import ru.aa.march.commands.Command;
	
	public class LoadAtlas extends Command
	{
		public function LoadAtlas()
		{
			super();
		}
		
		override public function execute(data:* = null):void
		{
			if (!data) {
				complete();
				return;
			}
			var file:File = new File(data as String);
			var fileAtlas:String = file.nativePath.replace(".xml", ".png");
			
			AppSettings.me.atlasFile = data;
			AppSettings.me.save();
			
			Assets.me.dispose();
			Assets.me.enqueue(file.nativePath, fileAtlas);
			Assets.me.loadQueue(loadingProgress);
		}
		
		private function loadingProgress(ratio:Number):void
		{
			if (ratio == 1.0) {
				loadingComplete();
			}
		}
		
		private function loadingComplete():void
		{
			eventDispatcher.dispatchEvent(new AtlasEvent(AtlasEvent.ATLAS_LOADED));
			complete();
		}
	}
}
