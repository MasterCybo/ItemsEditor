package ru.arslanov.starling.mvc.injection
{
	import flash.utils.Dictionary;
	
	import ru.arslanov.starling.mvc.injection.IInjector;
	import ru.arslanov.starling.mvc.injection.IInjectorSetter;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class Injector implements IInjector, IInjectorSetter
	{
		private var _map:Dictionary = new Dictionary();
		private var _types:Vector.<*> = new Vector.<*>();
		
		private var _mappedType:*;
		
		public function Injector() {}
		
		public function getOf(type:*):* { return _map[type]; }
		public function hasOf(type:*):Boolean { return getOf(type) != null; }
		
		public function unmap(type:*):void
		{
			var instance:Object = getOf(type);
			if (instance) {
				var idx:int = _types.indexOf(type);
				if (idx != -1) _types.splice(idx, 1);
				delete _map[type];
				trace(this, "Unmapped " + type + " to value " + instance.constructor);
			}
		}
		
		public function map(type:*):IInjectorSetter
		{
			_mappedType = type;
			return this;
		}
		
		public function asSingleton(singletonClass:Class):*
		{
			var instance:* = getOf(_mappedType);
			if (instance) {
				trace("WARNING Injector! Type " + _mappedType + " already mapped to " + instance);
				_mappedType = null;
				return instance;
			}
			return toValue(new singletonClass());
		}
		
		public function toValue(value:Object):*
		{
			var instance:* = getOf(_mappedType);
			if (instance) {
				trace("WARNING Injector! Type " + _mappedType + " already to " + instance);
				return instance;
			}
			
			_map[_mappedType] = value;
			_types.push(_mappedType);
			
			trace(this, "Mapped " + _mappedType + " to value " + value.constructor);
			
			_mappedType = null;
			return value;
		}
		
		public function unmapAll():void
		{
			for (var i:int = 0; i < _types.length; i++) {
				unmap(_types[i]);
			}
		}
		
		public function getAllTypes():Vector.<*> { return _types; }
	}
}