# Specialization Specific Keybinds

An addon for World of Warcraft that enables per-specialization key binding support. After being set, the current key binding layout
will automatically change whenever the active specialization is changed. This includes situations when the active
specialization is automatically changed by the game (i.e when entering arenas).

The addon is under 150 lines of code and tries to keep things simple. This means 1 key bind profile for each
class specialization and no fancy extra options. The addon uses the standard key bindings menu to trigger it's actions.

Have a look at [Action Bar Profiles](https://github.com/Silencer2K/wow-action-bar-profiles), if you need multiple profiles
per specialization and/or support for macro and talent profiles.

## How to Use

1. **Setting Keybinds:** Activate the specialization you want to set key bindings for, using the in-game talent menu. Set your binds as you would do normally, through the in-game key binding menu.

1. **Loading Keybinds:** Activate the desired specialization using the in-game talent menu.

_A message similar to the one bellow will be printed whenever key bindings change_

![SpecSpecificKeybinds](https://i.imgur.com/Pi7GAol.jpg)

**To manually load a key binding**

Use the following chat command: ``/ssb load <spec-num>``  
``<spec-num>`` is the specialization number to load. Usually a number between 1 and 3 (4 for druids). The numbering
follows the order the specializations are listed in the in-game talent menu. This option has been added mostly for convenience
and should rarely be needed.

**Additional Info**

Specs that haven't been key bound yet will use the current set of key bindings as a template.

Key bindings will be saved locally within the __WTF__ folder of your game installation. Only the active key bindings
are stored on the game server. The location of your saved key binds is:
``WTF\Account\<account>\<realm>\<character>\SavedVariables\SpecSpecificKeybinds.lua``

## Limitations

Only key bindings belonging to the standard blizzard interface are supported. These _usually_ are the ones you can set
using the default blizzard key binding menu. Be aware that some mods extend the key binding menu. These bindings won't 
be tracked by the addon. 

**Action Bar Mods (Dominos, Bartender, ..)**

These mods usually use the default action bar buttons and add support for a few extra bars. Key bindings for buttons that belong to the default interface action bars are supported. Extra action bar buttons which are specific to the action bar mod are not.

## FAQ

Q: What about the 'Character Specific Key Bindings' toggle in the Key Bindings menu?  
_A: You can check or un-check this option, it does not matter. It is not used by the addon._

## Feedback
To give feedback or report a bug, please use the [issues](https://github.com/myzb/SpecSpecificKeybinds/issues)

## Legal
Please see the [LICENSE](https://github.com/myzb/SpecSpecificKeybinds/blob/master/LICENSE.txt) file.
