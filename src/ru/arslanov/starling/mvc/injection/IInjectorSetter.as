package ru.arslanov.starling.mvc.injection
{
	public interface IInjectorSetter
	{
		function asSingleton(singletonClass:Class):*;
		function toValue(value:Object):*;
	}
}
