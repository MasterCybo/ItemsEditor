package screens.controllers
{
	import base.controllers.ControllerFeathers;
	import base.views.AppButton;
	
	import core.commands.NewFile;
	import core.commands.OpenFile;
	import core.commands.ParseFile;
	import core.commands.QuickSave;
	import core.commands.SaveAs;
	import core.events.PopupEvent;
	import core.models.AppSettings;
	import core.models.DataStore;
	
	import flash.filesystem.File;
	
	import graphics.commands.OpenAtlas;
	import graphics.events.AtlasEvent;
	
	import screens.views.MainScreen;
	
	import starling.events.Event;
	
	public class MainScreenController extends ControllerFeathers
	{
		public function MainScreenController(view:MainScreen)
		{
			super(view);
		}
		
		public function get view():MainScreen {return getView() as MainScreen;}
		
		override protected function initialize():void
		{
			super.initialize();
			
			view.addEventListener(Event.TRIGGERED, triggeredButtonHandler);
			eventDispatcher.addEventListener(AtlasEvent.ATLAS_LOADED, atlasHandler);
			eventDispatcher.addEventListener(AtlasEvent.ATLAS_DISPOSED, atlasHandler);
		}
		
		override public function destroy():void
		{
			view.removeEventListener(Event.TRIGGERED, triggeredButtonHandler);
			eventDispatcher.removeEventListener(AtlasEvent.ATLAS_LOADED, atlasHandler);
			eventDispatcher.removeEventListener(AtlasEvent.ATLAS_DISPOSED, atlasHandler);
			super.destroy();
		}
		
		private function triggeredButtonHandler(event:Event):void
		{
			var button:AppButton = event.target as AppButton;
			if (!button) return;
			
			switch (button.name) {
				case MainScreen.NEW_BUTTON:
					if (DataStore.me.isDirty) {
						eventDispatcher.dispatchEvent(
								new PopupEvent(
										PopupEvent.SHOW_PERMISSION,
										"Create new data base?",
										"All entities will be deleted.",
										acceptHandler
								)
						);
					} else {
						acceptHandler();
					}
					
					break;
				case MainScreen.OPEN_BUTTON:
					new OpenFile().next(new ParseFile()).execute();
					break;
				case MainScreen.SAVE_BUTTON:
					save(true);
					break;
				case MainScreen.SAVE_AS_BUTTON:
					save();
					break;
				case MainScreen.LOAD_ATLAS_BUTTON:
					new OpenAtlas().execute();
					break;
			}
		}
		
		private function acceptHandler():void
		{
			new NewFile().execute();
		}
		
		private function save(quickly:Boolean = false):void
		{
			var data:Object = DataStore.serializer.serialize(DataStore.me);
			data.atlas = AppSettings.me.atlasFile;
			
			var saveData:String = JSON.stringify(data, null, "\t");
			
			if (quickly && AppSettings.me.lastFile) {
				new QuickSave().execute(saveData);
			} else {
				new SaveAs().execute(saveData);
			}
		}
		
		private function atlasHandler(event:AtlasEvent):void
		{
			var text:String = "no atlas";
			
			switch (event.type) {
				case AtlasEvent.ATLAS_LOADED:
					var path:Array = AppSettings.me.atlasFile.split(File.separator);
					text = path.pop();
					break;
				case AtlasEvent.ATLAS_DISPOSED:
					break;
			}
			view.atlasName = text;
		}
	}
}
