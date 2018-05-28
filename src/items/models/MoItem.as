package items.models
{
	import categories.models.MoCategory;
	
	import contents.models.IContentItem;
	
	import core.serialize.ISerializer;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import items.collections.ItemPropertyEnum;
	import items.events.ItemPropertyEvent;
	
	import contents.events.ContentsEvent;
	import contents.models.EffectContent;
	
	public class MoItem extends EventDispatcher
	{
		private static var _serializer:ISerializer;
		public static function config(serializer:ISerializer):void {_serializer = serializer;}
		public static function get serializer():ISerializer {return _serializer;}
		
		private var _id:String;
		private var _name:String;
		private var _category:MoCategory;
		
		private var _propStore:Dictionary = new Dictionary();
		private var _properties:Vector.<ItemPropertyEnum>;
		private var _propertyNames:Vector.<String> = new Vector.<String>();
		
		private var _contents:Vector.<IContentItem> = new Vector.<IContentItem>();
		
		public function MoItem()
		{
			super();
			
//			_properties = Vector.<ItemPropertyEnum>(Enum.getElementsList(ItemPropertyEnum));
			
			_properties = Vector.<ItemPropertyEnum>(
					[
							ItemPropertyEnum.ID,
							ItemPropertyEnum.IMAGE,
							ItemPropertyEnum.NAME,
							ItemPropertyEnum.PRICE,
							ItemPropertyEnum.WEIGHT,
							ItemPropertyEnum.DESCRIPTION
					]
			);
			
			var prop:ItemPropertyEnum;
			for (var i:int = 0; i < _properties.length; i++) {
				prop = _properties[ i ];
				_propertyNames.push(prop.getString());
			}
			
//			setValue(ItemPropertyEnum.ID, "-");
			setValue(ItemPropertyEnum.PRICE, 0);
			setValue(ItemPropertyEnum.WEIGHT, 0);
			setValue(ItemPropertyEnum.DESCRIPTION, "");
			setValue(ItemPropertyEnum.IMAGE, "");
		}
		
		public function serialize():Object {return _serializer.serialize(this);}
		
		public function get category():MoCategory {return _category;}
		public function set category(value:MoCategory):void
		{
			if (_category && _category.equals(value)) return;
			_category = value;
		}
		
		public function get id():String {return _id;}
		public function set id(value:String):void
		{
			if (value == _id) return;
			_id = value;
			setValue(ItemPropertyEnum.ID, _id);
		}
		
		public function get name():String {return _name;}
		public function set name(value:String):void
		{
			if (value == _name) return;
			_name = value;
			setValue(ItemPropertyEnum.NAME, _name);
		}
		
		public function get numContent():int {return _contents.length}
		public function get contents():Vector.<IContentItem> {return _contents.concat();}
		public function set contents(value:Vector.<IContentItem>):void {_contents = value;}
		
		public function get properties():Vector.<ItemPropertyEnum> {return _properties;}
		public function get propertyNames():Vector.<String> {return _propertyNames;}
		
		public function hasProperty(property:ItemPropertyEnum):Boolean {return _propStore[property] != undefined;}
		
		public function getValue(property:ItemPropertyEnum, defaultValue:* = null):*
		{
			return hasProperty(property) ? _propStore[property] : defaultValue;
		}
		
		public function setValue(property:ItemPropertyEnum, value:*):void
		{
			if (hasProperty(property) && value == _propStore[property]) return;
			
			if(property.equalsType(String)) {
				switch (property) {
					case ItemPropertyEnum.ID:
						_id = String(value);
						break;
					case ItemPropertyEnum.NAME:
						_name = value;
						break;
				}
				_propStore[property] = value;
			} else if(property.equalsType(Number)) {
				_propStore[property] = toNumber(value);
			}
			
			dispatchEvent(new ItemPropertyEvent(ItemPropertyEvent.CHANGED_VALUE, property.getString(), value));
		}
		
		private function toNumber(value:*):Number
		{
			value = String(value).replace(",", ".");
			return parseFloat(value);
		}
		
		public function addContent(contentItem:IContentItem):void
		{
			_contents.push(contentItem);
			dispatchEvent(new ContentsEvent(ContentsEvent.ADDED_CONTENT, contentItem));
			dispatchEvent(new ContentsEvent(ContentsEvent.UPDATE_CONTENT));
		}
		
		public function removeContent(contentItem:IContentItem):void
		{
			var idx:int = _contents.indexOf(contentItem);
			if (idx == -1) return;
			_contents.splice(idx, 1);
			dispatchEvent(new ContentsEvent(ContentsEvent.REMOVED_CONTENT, contentItem));
			dispatchEvent(new ContentsEvent(ContentsEvent.UPDATE_CONTENT));
		}
	}
}
