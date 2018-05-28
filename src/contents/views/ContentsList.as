package contents.views
{
	import base.views.AppList;
	
	import contents.collections.ContentsTypeEnum;
	import contents.controllers.ContentsListController;
	import contents.models.IContentItem;
	
	import feathers.controls.LayoutGroup;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.IListCollection;
	import feathers.data.VectorCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.VerticalAlign;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	
	import starling.events.Event;
	
	public class ContentsList extends LayoutGroup
	{
		private static var _thisLayout:VerticalLayout;
		
		private var _list:AppList;
		
		public function ContentsList()
		{
			super();
			addEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
		}
		
		private static function thisLayout():VerticalLayout
		{
			if (!_thisLayout) {
				_thisLayout = new VerticalLayout();
				_thisLayout.horizontalAlign = HorizontalAlign.JUSTIFY;
				_thisLayout.verticalAlign = VerticalAlign.JUSTIFY;
			}
			return _thisLayout;
		}
		
		private static function itemRenderFactory():IListItemRenderer
		{
			var itemRenderer:ItemContentListItemRenderer = new ItemContentListItemRenderer();
			return itemRenderer;
		}
		
		private static function effectRenderFactory():IListItemRenderer
		{
			var itemRenderer:EffectListItemRenderer = new EffectListItemRenderer();
			return itemRenderer;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			layout = thisLayout();
			layoutData = new VerticalLayoutData(100, 100);
			
			_list = new AppList();
			_list.layoutData = new VerticalLayoutData(100, 100);
			_list.dataProvider = new VectorCollection();
			
			addChild(_list);
			
			new ContentsListController(this);
		}
		
		override public function dispose():void
		{
			removeEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
			super.dispose();
		}
		
		private function creationCompleteHandler(event:Event):void
		{
			removeEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
		}
		
		public function get numItems():int {return _list.dataProvider.length;}
		public function get dataProvider():IListCollection {return _list.dataProvider;}
		
		public function setData(type:ContentsTypeEnum = null, contents:Vector.<IContentItem> = null):void
		{
			_list.dataProvider.removeAll();
			
			if (type == ContentsTypeEnum.EFFECTS) {
				_list.itemRendererFactory = effectRenderFactory;
			} else if (type == ContentsTypeEnum.CONTAINER) {
				_list.itemRendererFactory = itemRenderFactory;
			}
			
			if (contents) {
				for (var i:int = 0; i < contents.length; i++) {
					addItem(contents[ i ]);
				}
			}
		}
		
		public function addItem(contentItem:IContentItem):void
		{
			_list.dataProvider.push(contentItem);
		}
		
		public function removeItem(contentItem:IContentItem):void
		{
			_list.dataProvider.removeItem(contentItem);
		}
	}
}
