/*
 * Copyright 2011 Netzbewegung GmbH
 * All Rights Reserved.
 * 
 * NOTICE: Netzbewegung GmbH permits you to use, modify, and distribute this 
 * file in accordance with the terms of the license agreement accompanying it.
 *
 * Created by Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com> on 19.07.2011. 
 */
package org.flixel
{
    import org.flixel.FlxGroup;

    /**
     * @author Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com>
     */
    public class FlxPathfindingGroupe extends FlxGroup
    {
        public var tiles:Array;
        
        public function FlxPathfindingGroupe(MaxSize : uint = 0)
        {
            super(MaxSize);
            tiles = new Array();
        }
    }
}
