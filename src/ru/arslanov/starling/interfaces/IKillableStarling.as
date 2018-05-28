package ru.arslanov.starling.interfaces
{
	import flash.display.IBitmapDrawable;
	import flash.geom.Point;


	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public interface IKillableStarling extends IBitmapDrawable
	{
		function kill():void;

		function get isKilled():Boolean;
		
		function get height():Number;
		function set height(value:Number):void;
		
		function get width():Number;
		function set width(value:Number):void;
		
		function get x():Number;
		function set x(value:Number):void;
		
		function get y():Number;
		function set y(value:Number):void;
		
		function get pos():Point;
		function set pos(value:Point):void;
		
		function setXY(x:Number = 0, y:Number = 0, round:Boolean = true):void;

		//function setSize( width:Number, height:Number, rounded:Boolean = true ):void;
		
		//function getBounds( space:DisplayObject ):Rectangle;
		//function getRect( space:DisplayObject ):Rectangle;
		
		//function set mouseEnabled( value:Boolean ):void;
		
		//function get graphics():Graphics;
	}
}