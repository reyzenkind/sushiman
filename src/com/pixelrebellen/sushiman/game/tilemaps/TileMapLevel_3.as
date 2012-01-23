/*
 * Copyright 2011 Netzbewegung GmbH
 * All Rights Reserved.
 * 
 * NOTICE: Netzbewegung GmbH permits you to use, modify, and distribute this 
 * file in accordance with the terms of the license agreement accompanying it.
 *
 * Created by Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com> on 14.03.2011. 
 */
package com.pixelrebellen.sushiman.game.tilemaps
{
	import com.pixelrebellen.sushiman.game.MovieClipBitmaps.WallTilesMovieClipBitmap;
	import com.pixelrebellen.sushiman.game.config.GameConfig;
	import org.flixel.FlxTilemap;


    /**
     * @author Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com>
     */
    public class TileMapLevel_3 extends FlxTilemap
    {
        
        [Embed(source="/levels/map3.csv", mimeType="application/octet-stream")] 
        public var LevelBitmap:Class;
        
        public function TileMapLevel_3()
        {
            super();
            
            this.loadMap( new LevelBitmap(), WallTilesMovieClipBitmap, GameConfig.BASE_TILE_WIDTH, GameConfig.BASE_TILE_HEIGHT); 
            
            this.x = 0.000000;
			this.y = 0.000000;
			this.scrollFactor.x = 1.000000;
			this.scrollFactor.y = 1.000000;
        }
    }
}
