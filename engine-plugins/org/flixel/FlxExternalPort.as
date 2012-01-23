/*
 * Copyright 2011 Netzbewegung GmbH
 * All Rights Reserved.
 * 
 * NOTICE: Netzbewegung GmbH permits you to use, modify, and distribute this 
 * file in accordance with the terms of the license agreement accompanying it.
 *
 * Created by Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com> on 29.03.2011. 
 */
package org.flixel
{
    import flash.events.EventDispatcher;

    /**
     * @author Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com>
     */
    public class FlxExternalPort extends EventDispatcher
    {
        private static var _instance: FlxExternalPort;
        
        private static var allowInstantiation:Boolean;
        
        public function FlxExternalPort()
        {
            if (!allowInstantiation) {
				trace("Error: Instantiation failed: Use SingletonDemo.getInstance() instead of new.");
			}
			else
			{
				super();
			}
        }

        public static function get instance() : FlxExternalPort
        {
            if(_instance == null)
            {
            	allowInstantiation = true;
            	_instance = new FlxExternalPort();
            	allowInstantiation = false;
            }
            
            return _instance;
        }
    }
}
