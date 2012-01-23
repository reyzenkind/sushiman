/*
 * Copyright 2011 Netzbewegung GmbH
 * All Rights Reserved.
 * 
 * NOTICE: Netzbewegung GmbH permits you to use, modify, and distribute this 
 * file in accordance with the terms of the license agreement accompanying it.
 *
 * Created by Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com> on 31.03.2011. 
 */
package com.pixelrebellen.sushiman.game.items
{
    /**
     * @author Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com>
     */
    public interface ICollectable
    {
    	function get type():int;
    	function set type(value:int):void;
    }
}
