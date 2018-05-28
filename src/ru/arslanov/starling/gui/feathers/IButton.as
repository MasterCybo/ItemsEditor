/**
 * Created by Artem-Home on 29.08.2016.
 */
package ru.arslanov.starling.gui.feathers
{
	import feathers.core.IFeathersEventDispatcher;
	
	public interface IButton extends IFeathersEventDispatcher
	{
		function get name():String;
		function set name(value:String):void;
	}
}
