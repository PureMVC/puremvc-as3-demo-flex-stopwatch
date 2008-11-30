/*
 PureMVC Demo for AS3 - StopWatch
 Copyright(c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.stopwatch.controller
{
	import org.puremvc.as3.demos.flex.stopwatch.proxy.StopWatchProxy;
	import org.puremvc.as3.demos.flex.stopwatch.view.ApplicationMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class ResetDisplayCommand extends SimpleCommand
	{
		override public function execute ( note:INotification ) : void
		{
			var proxy:StopWatchProxy = StopWatchProxy( facade.retrieveProxy( StopWatchProxy.NAME ) );
			proxy.resetTimer();
		}
	}
}
