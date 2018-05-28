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
	public class WinLogFile implements IFileLogger
	{
		private var _file:File;
		private var _fs:FileStream;

		public function WinLogFile(fileName:String = "logger.log")
		{
			try {
				_file = File.applicationStorageDirectory.resolvePath(fileName);
			} catch( error:Error ) {
				Log.traceError(error.message);
				return;
			}
			Log.traceText("Log file : " + _file.url);
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
			trace(event.text);
		}

		private function onSecurityError(event:SecurityErrorEvent):void
		{
			trace(event.text);
		}
	}
}
