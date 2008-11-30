/*
 PureMVC Demo for AS3 - StopWatch
 Copyright(c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.multicore.demos.flex.stopwatch.controller
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.demos.flex.stopwatch.view.ApplicationMediator;

	public class PrepViewCommand extends SimpleCommand
	{
		override public function execute ( note:INotification ) : void
		{
			// Register the ApplicationMediator
			var app:StopWatch = note.getBody() as StopWatch;
			facade.registerMediator( new ApplicationMediator( app ) );
		}
	}
}
