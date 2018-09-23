package contents.views
{
	import base.views.AppButton;
	import base.views.AppPickerList;
	import base.views.AppTextInput;
	
	import contents.collections.EffectContentEnum;
	import contents.controllers.EffectContentListItemController;
	import contents.events.ContentListItemEvent;
	import contents.models.EffectContent;
	
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.IToggle;
	import feathers.data.VectorCollection;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.layout.VerticalAlign;
	
	import ru.aa.enums.Enum;
	
	import starling.events.Event;
	
	public class EffectListItemRenderer extends LayoutGroup implements IListItemRenderer, IToggle
	{
		private static const _pickerLayoutData:HorizontalLayoutData = new HorizontalLayoutData(60);
		private static const _inputLayoutData:HorizontalLayoutData = new HorizontalLayoutData(25);
		private static const _removeLayoutData:HorizontalLayoutData = new HorizontalLayoutData(15);
		private static var _thisLayout:HorizontalLayout;
		
		private static var _effectPickerList:VectorCollection;
		
		private var _index:int;
		private var _owner:List;
		private var _factoryID:String;
		private var _data:EffectContent;
		
		private var _pickerList:AppPickerList;
		private var _textInput:AppTextInput;
		private var _removeButton:AppButton;
		
		public function EffectListItemRenderer()
		{
			super();
		}
		
		private static function thisLayout():HorizontalLayout
		{
			if (!_thisLayout) {
				_thisLayout = new HorizontalLayout();
				_thisLayout.paddingTop = _thisLayout.paddingBottom = 5;
				_thisLayout.paddingLeft = _thisLayout.paddingRight = 5;
				_thisLayout.gap = 5;
				_thisLayout.verticalAlign = VerticalAlign.MIDDLE;
				_thisLayout.horizontalAlign = HorizontalAlign.JUSTIFY;
			}
			
			return _thisLayout;
		}
		
		private static function pickerItemRendererFactory():IListItemRenderer
		{
			var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			renderer.labelField = "locale";
			return renderer;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			if (!_effectPickerList) {
				_effectPickerList = new VectorCollection(Enum.getElementsList(EffectContentEnum));
			}
			
			layout = thisLayout();
			
			_pickerList = new AppPickerList();
			_pickerList.labelField = "locale";
			_pickerList.layoutData = _pickerLayoutData;
			_pickerList.dataProvider = _effectPickerList;
			_pickerList.itemRendererFactory = pickerItemRendererFactory;
			addChild(_pickerList);
			
			_textInput = new AppTextInput();
			_textInput.layoutData = _inputLayoutData;
			_textInput.restrict = "-.,0123456789";
			addChild(_textInput);
			
			_removeButton = new AppButton("‒");
			_removeButton.bubblingEvents = false;
			_removeButton.layoutData = _removeLayoutData;
			_removeButton.addEventListener(Event.TRIGGERED, triggeredButtonHandler);
			addChild(_removeButton);
			
			new EffectContentListItemController(this);
		}
		
		private function triggeredButtonHandler(event:Event):void
		{
			dispatchEvent(new ContentListItemEvent(ContentListItemEvent.TRIGGERED_REMOVE_BUTTON, _data, true));
		}
		
		override public function dispose():void
		{
			_removeButton.removeEventListener(Event.TRIGGERED, triggeredButtonHandler);
			_data = null;
			_owner = null;
			super.dispose();
		}
		
		public function get data():Object {return _data;}
		public function set data(value:Object):void
		{
			if (value == _data) return;
			
			_data = EffectContent(value);
			
			if (_data) {
				_pickerList.selectedItem = Enum.getElementByValue(_data.property, EffectContentEnum);
				updateLabel(String(_data.additive));
			} else {
				updateLabel("");
			}
		}
		
		public function get selectedItem():EffectContentEnum
		{
			return _pickerList.selectedItem as EffectContentEnum;
		}
		
		public function get additive():Number
		{
			return parseFloat(_textInput.text);
		}
		
		private function updateLabel(text:String):void
		{
			_textInput.text = text;
		}
		
		public function get index():int {return _index;}
		public function set index(value:int):void {_index = value;}
		
		public function get owner():List {return _owner;}
		public function set owner(value:List):void {_owner = value;}
		
		public function get factoryID():String {return _factoryID;}
		public function set factoryID(value:String):void {_factoryID = value;}
		
		public function get isSelected():Boolean
		{
			return false;
		}
		
		public function set isSelected(value:Boolean):void
		{
		}
	}
}
