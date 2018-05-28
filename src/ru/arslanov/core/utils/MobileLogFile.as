/**
 * Copyright (c) 2015 Artem Arslanov. All rights reserved.
 */
package ru.arslanov.core.utils
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;


	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class MobileLogFile implements IFileLogger
	{
		private var _file:File;
		private var _fs:FileStream;

		public function MobileLogFile(fileName:String = "logger.log")
		{
			_file = File.applicationStorageDirectory.resolvePath(fileName);
			Log.traceText("Log file : " + _file.nativePath);
			Log.traceText("File exists : " + _file.exists);
			if (_file.exists) _file.deleteFileAsync();
			_fs = new FileStream();
			_fs.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			_fs.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			_file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}

		public function write(text:String):void
		{
			_fs.open(_file, FileMode.APPEND);
			_fs.writeUTFBytes("\n" + text);
			_fs.close();
		}

		private function onIoError(event:IOErrorEvent):void
		{
			Log.traceError(event.text);
		}

		private function onSecurityError(event:SecurityErrorEvent):void
		{
			Log.traceError(event.text);
		}
	}
}
