package categories.models
{
	import categories.events.CategoryEvent;
	
	import core.serialize.ISerializer;
	
	import flash.events.EventDispatcher;
	
	import contents.collections.ContentsTypeEnum;
	
	public class MoCategory extends EventDispatcher
	{
		private static var _serializer:ISerializer;
		public static function config(serializer:ISerializer):void {_serializer = serializer;}
		public static function get serializer():ISerializer {return _serializer;}
		
		
		private var _name:String;
		private var _numItems:int;
		private var _contentsType:ContentsTypeEnum = ContentsTypeEnum.EFFECTS;
		
		public function MoCategory(name:String)
		{
			super();
			_name = name;
		}
		
		public function serialize():Object {return serializer.serialize(this);}
		
		public function get name():String {return _name;}
		public function set name(value:String):void
		{
			if (value == _name) return;
			_name = value;
			dispatchEvent(new CategoryEvent(CategoryEvent.CHANGED_NAME));
		}
		
		public function get contentsType():ContentsTypeEnum {return _contentsType;}
		public function set contentsType(value:ContentsTypeEnum):void
		{
			if (_contentsType && _contentsType.equals(value)) return;
			_contentsType = value;
			dispatchEvent(new CategoryEvent(CategoryEvent.CHANGED_CONTENTS_TYPE));
		}
		
		public function equals(category:MoCategory):Boolean
		{
			return category ? _name == category.name : false;
		}
	}
}
