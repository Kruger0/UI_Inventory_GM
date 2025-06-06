// Feather disable all

#macro __SCRIBBLE_DEBUG             false
#macro __SCRIBBLE_VERBOSE_GC        false
#macro __SCRIBBLE_RUNNING_FROM_IDE  (GM_build_type == "run")
#macro SCRIBBLE_LOAD_FONTS_ON_BOOT  true



__scribble_initialize();
function __scribble_initialize()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    with(_system)
    {
        __scribble_trace("Welcome to Scribble Deluxe by Juju Adams! This is version " + SCRIBBLE_VERSION + ", " + SCRIBBLE_DATE);
        
        if (SCRIBBLE_VERBOSE)
        {
            __scribble_trace("Verbose mode is on");
        }
        else
        {
            __scribble_trace("Verbose mode is off, set SCRIBBLE_VERBOSE to <true> to see more information");
        }
        
        if (not shader_is_compiled(__shd_scribble))
        {
            __scribble_error("Shader failed to compile. Please check your version of GameMaker is compatible\nPlease report this error if it persists");
        }
        
        if (not font_exists(asset_get_index("scribble_fallback_font")))
        {
            __scribble_error("Fallback font was not found. This may indicate that unused assets have been stripped from the project\nPlease untick \"Automatically remove unused assets when compiling\" in Game Options");
        }
        
        var _fontInfo = font_get_info(asset_get_index("scribble_fallback_font"));
        if (_fontInfo[$ "sdfEnabled"] == undefined)
        {
            __scribble_error("Versions of GameMaker without SDF font support are not supported (versions pre-2023.1, including LTS 2022)");
        }
        
        try
        {
            time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, function()
            {
                //We use an anonymous function here because directly calling __scribble_tick() fails on HTML5
                __scribble_tick()
            }, [], -1));
        }
        catch(_error)
        {
            __scribble_trace(_error);
            __scribble_error("Versions earlier than GameMaker 2023.1 are not supported");
        }
        
        __useHandleParse = false;
        try
        {
            handle_parse(string(__scribble_initialize));
            __useHandleParse = true;
            
            __scribble_trace("Using handle_parse() where possible");
        }
        catch(_error)
        {
            __scribble_trace("handle_parse() not available");
        }
        
        __gmMightRemoveUnusedAssets = true;
        __gmVersionMajor = 0;
        __gmVersionMinor = 0;
        __gmVersionPatch = 0;
        __gmVersionBuild = 0;
        
        try
        {
            var _workString = GM_runtime_version;
            var _pos = string_pos(".", _workString);
            __gmVersionMajor = real(string_copy(_workString, 1, _pos-1));
            _workString = string_delete(_workString, 1, _pos);
            var _pos = string_pos(".", _workString);
            __gmVersionMinor = real(string_copy(_workString, 1, _pos-1));
            _workString = string_delete(_workString, 1, _pos);
            var _pos = string_pos(".", _workString);
            __gmVersionPatch = real(string_copy(_workString, 1, _pos-1));
            __gmVersionBuild = real(string_delete(_workString, 1, _pos));
        }
        catch(_error)
        {
            __scribble_trace("Warning! Failed to obtain runtime version");
        }
        
        __gmMightRemoveUnusedAssets = (__gmVersionMajor >= 2025) || ((__gmVersionMajor == 2024) && ((__gmVersionMinor >= 1100) || (__gmVersionMinor == 11)));
        
        //Initialize colours on boot before they need to be used
        __scribble_config_colours();
        
        __defaultPreprocessorFunc = __scribble_no_preprocessing;
        
        //Main lookup for fonts
        __font_data_map = ds_map_create();
        
        //Other caching maps
        __sprite_texture_index_map    = ds_map_create();
        __sprite_texture_material_map = ds_map_create();
        __material_map                = ds_map_create();
        
        //Multi-use buffers
        __buffer_a = buffer_create(1024, buffer_grow, 1);
        __buffer_b = buffer_create(1024, buffer_grow, 1);
        
        //Contains animation parameters. See scribble_anim_reset()
        __anim_properties = array_create(__SCRIBBLE_ANIM.__SIZE, undefined);
        
        //Contains global state information that is shared between various features
        __state = {
            __frames: 0,
            
            __default_font: "scribble_fallback_font",
            
            __blink_on_duration:  SCRIBBLE_DEFAULT_BLINK_ON_DURATION,
            __blink_off_duration: SCRIBBLE_DEFAULT_BLINK_OFF_DURATION,
            __blink_time_offset:  SCRIBBLE_DEFAULT_BLINK_TIME_OFFSET,
            
            __shader_anim_desync:            false,
            __shader_anim_desync_to_default: false,
            __shader_anim_default:           false,
            __shader_anim_disabled:          false,
            
            __sdf_thickness_offset: 0,
            
            __markdown_styles_struct: {},
            
            __sprite_whitelist_map: ds_map_create(),
            __sound_whitelist_map:  ds_map_create(),
        };
        
        //Contains state information for the Scribble cache
        __cache_state = {
            __mcache_dict:       {},
            __mcache_name_array: [],
            
            __ecache_dict:       {},
            __ecache_array:      [],
            __ecache_weak_array: [],
            __ecache_name_array: [],
            
            __gc_vbuff_refs: [],
            __gc_vbuff_ids:  [],
            
            __gc_grid_refs: [],
            __gc_grid_ids:  [],
        };
        
        //
        __generator_state = new __scribble_class_generator_state();
        
        //Contains Unicode data, necessary for extended language support
        __glyph_data                = __scribble_glyph_data_initialize();
        __krutidev_lookup_map       = __scribble_krutidev_lookup_map_initialize();
        __krutidev_matra_lookup_map = __scribble_krutidev_matra_lookup_map_initialize();
        
        //External sound reference storage
        __external_sprite_map = ds_map_create();
        __external_sound_map  = ds_map_create();
        
        //Lookup for user-defined macros
        __macros_map = ds_map_create();
        
        //Lookup for typewrite events
        //Pre-populated with native typewriter event types
        __typewriter_events_map = ds_map_create();
        __typewriter_events_map[? "pause" ] = undefined;
        __typewriter_events_map[? "delay" ] = undefined;
        __typewriter_events_map[? "sync"  ] = undefined;
        __typewriter_events_map[? "speed" ] = undefined;
        __typewriter_events_map[? "/speed"] = undefined;
        
        //Add bindings for default effect names
        //Effect index 0 is reserved for sprites
        __effects_map       = ds_map_create();
        __effects_slash_map = ds_map_create();
        
        __effects_map[?       "wave"    ] = 1;
        __effects_map[?       "shake"   ] = 2;
        __effects_map[?       "rainbow" ] = 3;
        __effects_map[?       "wobble"  ] = 4;
        __effects_map[?       "pulse"   ] = 5;
        __effects_map[?       "wheel"   ] = 6;
        __effects_map[?       "cycle"   ] = 7;
        __effects_map[?       "jitter"  ] = 8;
        __effects_map[?       "blink"   ] = 9;
        __effects_map[?       "slant"   ] = 10;
        __effects_slash_map[? "/wave"   ] = 1;
        __effects_slash_map[? "/shake"  ] = 2;
        __effects_slash_map[? "/rainbow"] = 3;
        __effects_slash_map[? "/wobble" ] = 4;
        __effects_slash_map[? "/pulse"  ] = 5;
        __effects_slash_map[? "/wheel"  ] = 6;
        __effects_slash_map[? "/cycle"  ] = 7;
        __effects_slash_map[? "/jitter" ] = 8;
        __effects_slash_map[? "/blink"  ] = 9;
        __effects_slash_map[? "/slant"  ] = 10;
        
        __effects_map[?       "WAVE"    ] = 1;
        __effects_map[?       "SHAKE"   ] = 2;
        __effects_map[?       "RAINBOW" ] = 3;
        __effects_map[?       "WOBBLE"  ] = 4;
        __effects_map[?       "PULSE"   ] = 5;
        __effects_map[?       "WHEEL"   ] = 6;
        __effects_map[?       "CYCLE"   ] = 7;
        __effects_map[?       "JITTER"  ] = 8;
        __effects_map[?       "BLINK"   ] = 9;
        __effects_map[?       "SLANT"   ] = 10;
        __effects_slash_map[? "/WAVE"   ] = 1;
        __effects_slash_map[? "/SHAKE"  ] = 2;
        __effects_slash_map[? "/RAINBOW"] = 3;
        __effects_slash_map[? "/WOBBLE" ] = 4;
        __effects_slash_map[? "/PULSE"  ] = 5;
        __effects_slash_map[? "/WHEEL"  ] = 6;
        __effects_slash_map[? "/CYCLE"  ] = 7;
        __effects_slash_map[? "/JITTER" ] = 8;
        __effects_slash_map[? "/BLINK"  ] = 9;
        __effects_slash_map[? "/SLANT"  ] = 10;
    }
    
    if (GM_build_type == "run")
    {
        global._scribble_debug = _system;
    }
    
    scribble_anim_reset();
    if (SCRIBBLE_LOAD_FONTS_ON_BOOT) __scribble_font_add_all_from_bundle();
    
    return _system;
}