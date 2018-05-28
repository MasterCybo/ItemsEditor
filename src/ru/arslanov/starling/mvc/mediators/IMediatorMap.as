/**
 * Created by Artem-Home on 13.02.2017.
 */
package ru.arslanov.starling.mvc.mediators
{
	public interface IMediatorMap
	{
		function map(viewClass:Class):IMediateSetter;
		function unmap(mediatorClass:Class):void;
		function mediate(view:Object):void;
		function unmediate(view:Object):void;
		function hasMediator(mediatorClass:Class):Boolean;
		function isMapped(view:Object):Boolean;
		function isMediated(view:Object):Boolean;
	}
}
