# Medieval Melody Mayhem

![Medieval Melody Mayhem Thumbnail][thumbnail]

This is a jam game made in __74 hours__ for [__Ludum Dare 41__][ludum-dare-game]!  

The theme was __Combine 2 Incompatible Genres__.  
Our two genres were __Tower Defense X Rhythm Game__.

---


## Gameplay
You need to __protect the Fort!__  
Enemies will come rushing from both sides, if they reach the castle in the center, they will deal damage to it.  
To protect the fort, you will need to hit the __prompt keys__ displayed above the enemies,  
as they cross one of the lines to the left or the right of the castle.  

There are __two enemy types__:
- __Zombies__  
  These are the regular enemies.  
  They are killable with __a single key press__.  
- __Wizards__  
  These guys are tougher than zombies.  
  They take __two key presses__ to kill and they __deal more damage__.  

As you kill the enemies, you get to listen to some little tunes :)  
_(If you don't miss them, that is)_  

The longer you survive, the more difficult the game becomes;  
enemies start moving and spawning quicker.  

## Controls
Hit the __keys__ shown in the __prompts__ above the enemies,  
as they cross one of the gray lines.  

__Escape__ - __Quit__ the game

## Win / Lose Conditions
### Lose Condition
You will lose the game if the Fort runs out of Health.
### Win Condition
None. The game continues indefinitely,  
and becomes exponentially more difficult as time goes on.  
Try to survive as long as you can, and gain as many points as possible,  
before you reach your _inevitable death_.

## Software Used
|                                |                                   |
| ------------------------------ | --------------------------------- |
| __VIM__                        | Text Editor                       |
| __Gimp__                       | Graphics                          |
| __[Bosca Ceoil][bosca-ceoil]__ | For the tunes                     |
| __[Audacity][audacity]__       | For extracting the tunes          |
| __Git__                        | Version Control                   |
| [__Gosu__][gosu]               | Ruby game library                 |
| [__Ocra__][ocra-gem]           | For building windows executable   |

## Credits
|              |           |
| ------------ | --------- |
| __Graphics__ | @hoichael |
| __Audio__    | A Friend  |
| __Coding__   | @noahro   |

## Development Information
This game is written in __Ruby__ version __2.5.1__ using the game library [__Gosu__][gosu].  
We used [this Trello Board][trello-board] for task management during development.

## Installation
If you are on __Windows__ you should have no problems downloading and running the [executable][windows-executable].

---

If you are on __Linux__ or __MacOS__ it will probably be the easiest to install [wine][wine]  
and run the [executable][windows-executable] with it, after having cloned the repository.
```
$ wine ./MedievalMelodyMayhem.exe
```

In case the above doesn't work for you, or you already have Ruby and ruby-bundler installed,  
you can install the game's dependencies and run the game directly with the Ruby interpreter.  

You will need to have __Ruby__ installed. The game was developed with version __2.5.1__,  
but it'll probably work with versions 2.2 and up.  

After having cloned the [repository][github-repository], run either:  
```
$ bundle install
```
if you have __ruby-bundler__ installed, else run:  
```
$ gem install gosu
```
to install [Gosu][gosu] manually.  
You might need to install some more dependencies for Gosu to work on your platform.  
Check their [homepage][gosu] for more information on that.  

After that, you should be able to just start the game.
```
$ ./MedievalMelodyMayhem.rb
```

---

This was our second Ludum Dare game jam, and compared to our [previous entry][ludum-dare-game-previous],  
I am _extremely_ happy the way it turned out.  
There were some features and ideas we had to cut out, but I managed to implement almost everything that I had planned.  

I was very unpleased with our previous ([failed/unfinished][ludum-dare-game-previous]) attempt at LD40,  
so being able to release a _finished_ (and some-what fun, IMO) product this time makes me _very happy!_ :)  
I hope some of you get a bit of enjoyment out of this game!

---

__Have fun playing all these interesting LD41 games!__

[thumbnail]:                https://raw.githubusercontent.com/Noah2610/LD41/master/Thumbnail.png
[ludum-dare-game]:          https://ldjam.com/events/ludum-dare/41/medieval-melody-mayhem
[bosca-ceoil]:              https://boscaceoil.net/
[audacity]:                 http://www.audacityteam.org/
[ocra-gem]:                 https://github.com/larsch/ocra/
[gosu]:                     https://www.libgosu.org/ruby.html
[trello-board]:             https://trello.com/b/pkaQPFyW/ld41
[windows-executable]:       https://github.com/Noah2610/LD41/raw/master/MedievalMelodyMayhem.exe
[wine]:                     https://wiki.winehq.org/Download
[github-repository]:        https://github.com/Noah2610/LD41
[ludum-dare-game-previous]: https://ldjam.com/events/ludum-dare/40/mother-earth-failed-planet
