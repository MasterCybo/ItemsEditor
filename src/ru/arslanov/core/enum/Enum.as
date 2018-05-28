package ru.arslanov.core.enum {
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;


	/**
	 * Перечисляемый тип - базовый класс
	 * @author Artem Arslanov
	 */
	public class Enum {
		
		public var value:* = null;
		
		public function Enum(val:* = null)
		{
			value = val;
		}
		
		public function equals(enum:Enum):Boolean
		{
			return value == enum.value;
		}
		
		protected function getClassName():String
		{
			return getQualifiedClassName(this).split(":").pop();
		}
		
		public function toString():String
		{
			return "[" + getClassName() + " " + value + "]";
		}
		
		/***************************************************************************
		 Static methods
		 ***************************************************************************/
		static public function getElementByValue(value:*, enumClass:Class, defaultValue:Enum = null):*
		{
			if (!value) {
				if (defaultValue) return defaultValue;
				throw new ArgumentError('Argument value:* is null!');
			}

			if (!enumClass) {
				if (defaultValue) return defaultValue;
				throw new ArgumentError('Argument enumClass:Class is null!');
			}
			
			var item:Enum;
			var items:Vector.<Enum> = getElementsList(enumClass);
			
			for each (item in items) {
				if (item.value == value) break;
				item = null;
			}
			
			return enumClass(item || defaultValue);
		}
		
		static public function getElementsList(enumClass:Class, sortFunction:Function = null):Vector.<Enum>
		{
			if (!enumClass) {
				throw new ArgumentError('Argument is null!');
			}
			
			var node:XML;
			var elements:Vector.<Enum> = new Vector.<Enum>();
			var constNodes:XMLList = describeType(enumClass).constant;
			
			for each (node in constNodes) {
				elements.push(enumClass[node.attribute("name")]);
			}
			
			if (sortFunction != null) elements = elements.sort(sortFunction);
			
			return elements;
		}
		
	}

}
