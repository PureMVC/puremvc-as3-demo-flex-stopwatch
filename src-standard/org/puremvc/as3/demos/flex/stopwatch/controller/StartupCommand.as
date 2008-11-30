/*
 PureMVC Demo for AS3 - StopWatch
 Copyright(c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.stopwatch.controller
{
	import org.puremvc.as3.patterns.command.MacroCommand;

	public class StartupCommand extends MacroCommand
	{
		override protected function initializeMacroCommand():void
		{
			addSubCommand( PrepModelCommand );
			addSubCommand( PrepViewCommand  );
			addSubCommand( InjectFSMCommand ); 
		}
	}
}
