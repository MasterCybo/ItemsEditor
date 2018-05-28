package contents.models
{
	import core.serialize.ISerializer;
	
	import flash.events.EventDispatcher;
	
	public class EffectContent extends EventDispatcher implements IContentItem
	{
		private static var _serializer:ISerializer;
		public static function config(serializer:ISerializer):void {_serializer = serializer;}
		public static function get serializer():ISerializer {return _serializer;}
		
		private var _property:String = "";
		private var _additive:Number = 0;
		
		public function EffectContent(property:String, additive:Number)
		{
			super();
			_property = property;
			_additive = additive;
		}
		
		public function get property():String {return _property;}
		public function set property(value:String):void {_property = value;}
		
		public function get additive():Number {return _additive;}
		public function set additive(value:Number):void {_additive = value;}
		
		public function serialize():Object {return _serializer.serialize(this);}
	}
}
