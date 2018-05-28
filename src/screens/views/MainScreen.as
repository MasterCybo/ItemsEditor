package screens.views {
	import base.views.AppButton;
	
	import categories.views.CategoriesListPanel;
	import categories.views.CategoryEditorPanel;
	
	import feathers.controls.AutoSizeMode;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.PanelScreen;
	import feathers.events.FeathersEventType;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalAlign;
	
	import properties.views.PropertiesPanel;
	
	import screens.controllers.MainScreenController;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class MainScreen extends PanelScreen
	{
		public static const OPEN_BUTTON:String = "openButton";
		public static const SAVE_BUTTON:String = "saveButton";
		public static const SAVE_AS_BUTTON:String = "saveAsButton";
		public static const NEW_BUTTON:String = "newButton";
		public static const LOAD_ATLAS_BUTTON:String = "loadAtlasButton";
		
		protected var _header:Header;
		
		private var _categoriesList:CategoriesListPanel;
		private var _itemsList:CategoryEditorPanel;
		private var _propsPanel:PropertiesPanel;
		
		private var _atlasNameLabel:Label;
		
		public function MainScreen()
		{
			super();
			addEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
		}
		
		override public function dispose():void
		{
			removeEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
			super.dispose();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			autoSizeMode = AutoSizeMode.STAGE;
			
			var contentLayout:HorizontalLayout = new HorizontalLayout();
			contentLayout.distributeWidths = true;
			contentLayout.horizontalAlign = HorizontalAlign.JUSTIFY;
			contentLayout.verticalAlign = VerticalAlign.JUSTIFY;
			layout = contentLayout;
			
			_categoriesList = new CategoriesListPanel();
			addChild(_categoriesList);
			
			_itemsList = new CategoryEditorPanel();
			addChild(_itemsList);
			
			_propsPanel = new PropertiesPanel();
			addChild(_propsPanel);
		}
		
		private function creationCompleteHandler(event:Event):void
		{
			removeEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
			
			_header = Header(header);
			_header.title = "Items Editor";
			_header.paddingTop = _header.paddingBottom = 10;
			
			var newButton:AppButton = new AppButton("New", NEW_BUTTON);
			var openButton:AppButton = new AppButton("Open", OPEN_BUTTON);
			var saveButton:AppButton = new AppButton("Save", SAVE_BUTTON);
			var saveAsButton:AppButton = new AppButton("Save As", SAVE_AS_BUTTON);
			
			_header.leftItems = Vector.<DisplayObject>([newButton, openButton, saveButton, saveAsButton]);
			
			var loadAtlasButton:AppButton = new AppButton("Load Atlas", LOAD_ATLAS_BUTTON);
			_atlasNameLabel = new Label();
			_atlasNameLabel.paddingRight = 20;
			_atlasNameLabel.text = "no atlas";
			
			_header.rightItems = Vector.<DisplayObject>([_atlasNameLabel, loadAtlasButton]);
			
			new MainScreenController(this);
		}
		
		public function set atlasName(value:String):void
		{
			_atlasNameLabel.text = value;
		}
	}
}
