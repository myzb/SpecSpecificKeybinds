# Specialization Specific Keybinds

An addon for World of Warcraft that enables per-specialization key binding support. After being set, the current key binding layout
will automatically change whenever the active specialization is changed. This includes situations when the active
specialization is automatically changed by the game (i.e when entering arenas).

The addon is under 150 lines of code and tries to keep things simple. This means 1 key bind profile for each
class specialization and no fancy extra options. The addon uses the standard key bindings menu to trigger it's actions.

Have a look at [Action Bar Profiles](https://github.com/Silencer2K/wow-action-bar-profiles), if you need multiple profiles
per specialization and/or support for macro and talent profiles.

## How to Use

1. **Setting Keybinds:** Using the in-game talent window, activate the specialization you want to set key bindings for. Set your binds using the key binding menu.

1. **Loading Keybinds:** Using the in-game talent window, activate the desired specialization.

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

## Compatibility & Limitations

Only key bindings belonging to the standard blizzard interface are supported. These _usually_ are the ones you can set
using the default blizzard key binding menu. Be aware that some mods extend the key binding menu. Tracking key bindings
for these extra options cannot be guaranteed as it depends on how the mod author programmed his addon.

**Action Bar Mods (ElvUI, Dominos, Bartender, ..)**

These mods usually use the default action bar buttons as base and add support for a few extra bars. Be aware that the default game only
has 5 fully customizable action bars. Mods that add extra bars will have to properly register these extra bars with the game or SpecSpecificKeybinds won't know they exist. It also depends whether said action bar mod uses the default way of handling key bindings implemented by the game. Dominos fully works, with ElvUI only use bars 1,3,4,5,6.

## FAQ

Q: What about the 'Character Specific Key Bindings' toggle in the Key Bindings menu?  
_A: The addon will save the current active key bindings as character bindings. This means that this toggle will be implicitly set._

Q: Why are (some) of my action bar key bindings not properly getting tracked?  
_A: See the limitations. For mods like ElvUI use bars 1,3,4,5,6. Put things that don't have to change on a spec by spec basis on the other bars._

Q: Can you add support for AddonName?  
_A: SpecSpecificKeybinds use the default game functionality to set and retrieve key bindings. Addons that also make use of this mechanism will be supported by default. I don't plan to add special workarounds since it will cause dependencies and make the addon more complex. Keeping the addon short and concise will increase the chance of the addon staying compatible with future versions of WoW._

## Feedback
To give feedback or report a bug, please use the [issues](https://github.com/myzb/SpecSpecificKeybinds/issues)

## Legal
Please see the [LICENSE](https://github.com/myzb/SpecSpecificKeybinds/blob/master/LICENSE.txt) file.
