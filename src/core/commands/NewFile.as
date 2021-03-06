package core.commands
{
	import core.models.AppSettings;
	import core.models.DataStore;
	
	import graphics.Assets;
	import graphics.events.AtlasEvent;
	
	import ru.aa.march.commands.Command;
	
	public class NewFile extends Command
	{
		public function NewFile()
		{
			super();
		}
		
		override public function execute(data:* = null):void
		{
			AppSettings.me.lastFile = null;
			
			DataStore.me.categoriesManager.removeAll();
			DataStore.me.itemsManager.removeAll();
			
			Assets.me.dispose();
			eventDispatcher.dispatchEvent(new AtlasEvent(AtlasEvent.ATLAS_DISPOSED));
			
			complete();
		}
	}
}
