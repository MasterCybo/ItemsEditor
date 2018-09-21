package core.commands
{
	import core.events.PopupEvent;
	import core.models.AppSettings;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import ru.aa.march.commands.Command;
	
	public class QuickSave extends Command
	{
		public function QuickSave()
		{
			super();
		}
		
		override public function execute(data:* = null):void
		{
			var file:File = new File(AppSettings.me.lastFile);
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(data);
			fileStream.close();
			
			eventDispatcher.dispatchEvent(new PopupEvent(PopupEvent.SHOW_ALERT, "Successful save", "Saved to " + file.nativePath));
			
			complete();
		}
	}
}
