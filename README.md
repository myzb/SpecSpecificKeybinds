# Specialization Specific Keybinds

An addon for World of Warcraft that enables per-specialization key binding support. The current key binding layout
will automatically change whenever the active specialization is changed. This includes situations when the active
specialization is automatically changed by the game (i.e when entering arenas).

The addon is under 150 lines of code and tries to keep things simple. This means 1 key bind profile for each
class specialization and no fancy extra options. The addon uses the standard key bindings menu to trigger it's actions.

Have a look at [Action Bar Profiles](https://github.com/Silencer2K/wow-action-bar-profiles), if you need multiple profiles
per specialization and/or support for macro and talent profiles.

## How to Use

1. **Saving Keybinds:** Set your binds normally through the in-game key binding menu. Once you are happy hit 'okay'.

1. **Loading Keybinds:** Activate the desired specialization using the in-game talent menu.

_A message similar to the one bellow will be printed whenever key bindings change_

![SpecSpecificKeybinds](https://i.imgur.com/Pi7GAol.jpg)

**To manually load a key binding**

Use the following chat command: ``/ssb load <spec-num>``  
``spec-num`` is the specialization number to load. Usually a number between 1 and 3 (4 for druids). The numbering
follows the order the specializations are listed in the in-game talent menu.

**Additional Info**

Specs that haven't been key bound yet will use the current set of key bindings as a template.

Key bindings will be saved locally within the __WTF__ folder of your game installation. Only the active key bindings
are stored on the game server. The location of your saved key binds is:
``WTF\Account\<account>\<realm>\<character>\SavedVariables\SpecSpecificKeybinds.lua``

## Feedback
To give feedback or report a bug, please use the [issues](https://github.com/myzb/SpecSpecificKeybinds/issues)

## Legal
Please see the [LICENSE](https://github.com/myzb/SpecSpecificKeybinds/blob/master/LICENSE.txt) file.
