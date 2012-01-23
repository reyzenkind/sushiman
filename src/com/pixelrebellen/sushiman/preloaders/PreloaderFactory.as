/*
 * Copyright 2010 Netzbewegung GmbH
 * All Rights Reserved.
 * 
 * NOTICE: Netzbewegung GmbH permits you to use, modify, and distribute this 
 * file in accordance with the terms of the license agreement accompanying it.
 *
 * Created by Gunnar Herzog <g.herzog[at]netzbewegung.com>  on 03.08.2010. 
 */
package com.pixelrebellen.sushiman.preloaders 
{
	import com.pixelrebellen.sushiman.Main;
	import com.pixelrebellen.sushiman.hud.fonts.FontEmbedder;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import flash.utils.setTimeout;



    /**
     * @author Gunnar Herzog <g.herzog[at]netzbewegung.com> 
     * @author Daniel Kuenkel <d.kuenkel[at]netzbewegung.com>
     */
    public class PreloaderFactory extends MovieClip
    {
        private static const MAIN_CLASS_NAME : String = "com.pixelrebellen.sushiman.Main";

        private var main:Main;

        /**
         * Creates a new <code>PreloaderFactory</code> object.
         */
        public function PreloaderFactory() // NO PMD
        {
            stop();
            
            new FontEmbedder();

            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
            
        }
        
        
        private function onAddedToStage(event : Event) : void 
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            
            checkStage();
        }

        
        private function checkStage() : void 
        {
            if(stage.stageWidth > 0 && stage.stageHeight > 0)
            {
                init();
            }
            else
            {
                setTimeout(checkStage, 10);
            }
        }

        
        private function init() : void 
        {
        	nextFrame();
            initContent();
        }

        
        
        private function initContent() : void 
        {
            var mainClass : Class = Class(getDefinitionByName(MAIN_CLASS_NAME));
            if(mainClass)
            {
                main = new mainClass();
                addChild(main);
            }
        }
    }
}
