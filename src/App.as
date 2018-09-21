package
{
	import base.views.View;
	
	import core.commands.FeathersConfigurator;
	import core.commands.LoadSettings;
	import core.commands.SerializeConfigurator;
	import core.views.PopupLayer;
	
	import feathers.controls.AutoSizeMode;
	import feathers.controls.StackScreenNavigator;
	import feathers.controls.StackScreenNavigatorItem;
	
	import ru.aa.march.March;
	
	import screens.collections.ScreenID;
	import screens.views.MainScreen;
	
	public class App extends View
	{
		public function App()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			March.me.config();
			
			new FeathersConfigurator().execute();
			new SerializeConfigurator().execute();
			new LoadSettings().execute();
			
			var navigator:StackScreenNavigator = new StackScreenNavigator();
			navigator.autoSizeMode = AutoSizeMode.STAGE;
			addChild(navigator);
			
			var popupLayer:PopupLayer = new PopupLayer();
			addChild(popupLayer);
			
			var screenItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(MainScreen);
			navigator.addScreen(ScreenID.MAIN_SCREEN, screenItem);
			
			navigator.pushScreen(ScreenID.MAIN_SCREEN);
		}
	}
}
