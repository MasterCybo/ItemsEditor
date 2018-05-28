package graphics.commands
{
	import base.commands.Command;
	
	import core.models.AppSettings;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	
	import graphics.Assets;
	import graphics.events.AtlasEvent;
	
	public class OpenAtlas extends Command
	{
		public function OpenAtlas()
		{
			super();
		}
		
		override public function execute(data:* = null):void
		{
			if (!data) {
				complete();
				return;
			}
			
			var file:File;
			
			if (AppSettings.me.lastPath) {
				trace(AppSettings.me.lastPath);
				file = new File(AppSettings.me.lastPath);
			} else {
				file = File.desktopDirectory;
			}
			
			var fileFilter:FileFilter = new FileFilter("XML files", "*.xml");
			
			file.browseForOpen("Open file", [fileFilter]);
			file.addEventListener(Event.CANCEL, fileOpenHandler);
			file.addEventListener(Event.SELECT, fileOpenHandler);
		}
		
		private function fileOpenHandler(event:Event):void
		{
			var file:File = event.target as File;
			
			switch (event.type) {
				case Event.SELECT:
					loadFile(file);
					break;
				case Event.CANCEL:
					file.cancel();
					complete();
					break;
			}
		}
		
		private function loadFile(file:File):void
		{
			new LoadAtlas().execute(file.nativePath);
			complete();
		}
	}
}
