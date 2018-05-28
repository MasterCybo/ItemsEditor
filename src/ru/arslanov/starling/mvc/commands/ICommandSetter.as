/**
 * Created by Artem-Home on 13.02.2017.
 */
package ru.arslanov.starling.mvc.commands
{
	public interface ICommandSetter
	{
		function toCommand(commandClass:Class):void;
	}
}
