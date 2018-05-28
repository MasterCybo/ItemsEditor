package core.commands
{
	import base.commands.Command;
	
	import core.models.AppSettings;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class SaveAs extends Command
	{
		private var _saveData:*;
		
		public function SaveAs()
		{
			super();
		}
		
		override public function execute(data:* = null):void
		{
			_saveData = data;
			
			var file:File;
			
			if (AppSettings.me.lastPath) {
				file = new File(AppSettings.me.lastPath);
			} else {
				file = File.desktopDirectory;
			}
			
			file.browseForSave("Save As");
			file.addEventListener(Event.CANCEL, fileSaveHandler);
			file.addEventListener(Event.SELECT, fileSaveHandler);
		}
		
		private function fileSaveHandler(event:Event):void
		{
			var file:File = event.target as File;
			file.removeEventListener(Event.CANCEL, fileSaveHandler);
			file.removeEventListener(Event.SELECT, fileSaveHandler);
			
			switch (event.type) {
				case Event.SELECT:
					saveFile(file);
					break;
				case Event.CANCEL:
					file.cancel();
					complete();
					break;
			}
		}
		
		private function saveFile(file:File):void
		{
			if (file.extension != "json") {
				file.nativePath = file.nativePath + ".json";
			}
			
			AppSettings.me.lastFile = file.nativePath;
			AppSettings.me.lastPath = file.nativePath.replace(file.name, "");
			AppSettings.me.save();
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(_saveData);
			fileStream.close();
			
			complete();
		}
	}
}
