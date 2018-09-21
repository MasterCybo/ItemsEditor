package core.commands
{
	import core.models.DataStore;
	
	import graphics.commands.LoadAtlas;
	
	import ru.aa.march.commands.Command;
	import ru.aa.march.commands.events.CommandEvent;
	
	public class ParseFile extends Command
	{
		private var _data:Object;
		
		public function ParseFile()
		{
			super();
		}
		
		override public function execute(jsonUTF:* = null):void
		{
			if (!jsonUTF) {
				complete();
				return;
			}
			
			_data = JSON.parse(jsonUTF);
			
			var atlasPath:String = _data["atlas"];
			
			var loadCommand:LoadAtlas = new LoadAtlas();
			loadCommand.addEventListener(CommandEvent.COMPLETE, completeAtlasHandler);
			loadCommand.execute(atlasPath);
		}
		
		private function completeAtlasHandler(event:CommandEvent):void
		{
			var loadCommand:LoadAtlas = event.target as LoadAtlas;
			loadCommand.removeEventListener(CommandEvent.COMPLETE, completeAtlasHandler);
			
			DataStore.serializer.deserialize(_data);
			complete();
		}
	}
}
