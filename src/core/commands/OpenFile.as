package core.commands
{
	import base.commands.Command;
	
	import core.models.AppSettings;
	import core.models.DataStore;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	
	public class OpenFile extends Command
	{
		public function OpenFile()
		{
			super();
		}
		
		override public function execute(data:* = null):void
		{
			var file:File;
			
			if (AppSettings.me.lastPath) {
				trace(AppSettings.me.lastPath);
				file = new File(AppSettings.me.lastPath);
			} else {
				file = File.desktopDirectory;
			}
			
			var fileFilter:FileFilter = new FileFilter("JSON files", "*.json");
			
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
			AppSettings.me.lastFile = file.nativePath;
			AppSettings.me.lastPath = file.nativePath.replace(file.name, "");
			AppSettings.me.save();
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			var loadedData:String = fileStream.readUTFBytes(fileStream.bytesAvailable);
			fileStream.close();
			
			complete(loadedData);
			
//			new ParseFile(loadedData).execute();
			
//			if (store) {
//				DataStore.me.setData(store);
//			} else {
//				eventDispatcher.dispatchEvent(new PopupEvent(PopupEvent.SHOW_ALERT, "Error", "Invalid file format."));
//			}
		}
	}
}
