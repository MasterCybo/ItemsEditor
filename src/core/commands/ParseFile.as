package core.commands
{
	import base.commands.Command;
	import base.commands.events.CommandEvent;
	
	import core.models.DataStore;
	
	import graphics.commands.LoadAtlas;
	
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
