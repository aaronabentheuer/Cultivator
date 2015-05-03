# Cultivator
Speculative design project about bioprinting of meat and how it could end up in the kitchen of tomorrow.
An in-depth description about the project is available (in German) on the [HfG Schwäbisch Gmünd — IG Portfolio](http://ig.hfg-gmuend.de/Members/aaron_abentheuer/meine-projekte/cultivator).

![cultivatorPerspective](https://github.com/aaronabentheuer/Cultivator/blob/master/Images/CultivatorPerspective.jpg)

The general goal of the project was to build a prototype for an exhibition that stimulates a **discussion about the future of meat-consumption** and its implications in terms of energy-consumption and development of society. The aesthetics of food now and in the future was another topic that we wanted to tackle with our prototype.

We were inspired by the [“The state of food and agriculture.”](http://www.fao.org/docrep/018/i3300e/i3300e.pdf) study by the UN, [“2063 Dining”](http://www.londondesignfestival.com/news/2063-dining) by Trendstop for Miele and [“The future of kitchens.”](http://www.ikea.com/ms/en_GB/about_ikea/press/PR_FILES/Future_kitchens_report_FINAL.pdf) by IKEA on a conceptual level and by Otl Aicher’s “The Kitchen is for Cooking” (1982) and Ettore Sottsass’ “About Kitchens” (1992) in terms of how the kitchen has developed in the past and how it might develop.

Through these studies it became clear to us that (especially considering trends like [Entomophagy](http://en.wikipedia.org/wiki/Entomophagy) consumption of meat will be more of a luxury product than it already is in the future and that it will be consumed in smaller doses. Therefore we decided that this should be a product that people have at their homes.

### User Interface Design
The user interface was done under the consideration of getting out of the way of the discussion about the topic of bioprinting as much as possible but still being provocative and forward-thinking enough so it could act as a conversation-starter. After going through several iterations we ended up with something very simple.
From the beginning it was clear that we wanted to create the illusion of the interface being part of the hardware by using a black background that could blend in with the hardware. At the same time the interface should act more like a physical tool without a complicated menu-structure. That’s how we ended up with a horizontally scrolling menu of so-called “compositions” that can be printed with a simple touch of a button. 

![screencast](https://github.com/aaronabentheuer/Cultivator/blob/master/Images/screencast.gif)

* **Compositions** are a simple summary of all there is to know about the meat. Its creator (either the user or someone out of their network) a short summary and its ingredients and their impact related to the current user’s health. 
* **Glancability** was one of our most important issues because it is a kitchen appliance. While the basic “compositions” are very detailed, the moment you start scrolling everything collapses and animates into a very simple view with an image of the creator of the composition, which makes selection incredibly easy.
* The **Health-Magic-Wand Tool** is a reference to traditional photo-editing software which usese this tool to “simply make a photo better” (in most cases). That’s exactly what we wanted since it doesn’t make sense to let the user decide exactly about the chemical substances in the meat. Cultivator can, related to the user’s health simply enhance the meat while trying to keep the meat’s character.
* **Energy** was a huge concern, that’s why by default Cultivator enters a low-power mode with an animated signature pattern consisting out of small hexagons only showing the current energy source. (home-grid, public grid or the solar panel on top of the device). Only when the user approaches the device the home-screen is activated.

### Hardware Design
![cultivatorFront](https://github.com/aaronabentheuer/Cultivator/blob/master/Images/CultivatorFront.jpg)

##Prototype
To really get the message across we wanted to build a prototype that is close enough to a kitchen-appliance so that people can focus on discussing the topic of bioprinting meat without getting distracted by ostentatious design.
###Software
We realized we had to get the best performance possible out of our prototype or it would ruin the illusion and that’s why we chose Swift. The entire software-part of the prototype was done in under a week but still is very performant.

![screencast](https://github.com/aaronabentheuer/Cultivator/blob/master/Images/screencast.gif)

This prototype includes several interesting bits and pieces that marked the first time using several features of UIKit for us, which was an interesting experience. We experimented with **UICollectionView** and came up with a **user-presence detection** using [GPUImage by Brad Larson](https://github.com/BradLarson/GPUImage), which works very realiably in detecting a user’s intent of interaction. We originally tried to make the detection more reliable by using face-detection, which resulted in [AAFaceDetection](https://github.com/aaronabentheuer/AAFaceDetection).

*In the prototype we had to replace the originally used font [“Colfax” by Process Type Foundry](https://processtypefoundry.com/fonts/colfax/) with Avenir due to licensing problems. Feel free to replace it again if you got a proper license for the original font.*

###Hardware
Presenting the software without the hardware wouldn’t work at all of course. That’s why we came up with a rather timeless hardware-design that we think could fit in the kitchen of tomorrow at a size smaller than a microwave.

![technicalDraft](https://github.com/aaronabentheuer/Cultivator/blob/master/Images/Technical%20Draft.png)

Cultivator was built (without any initial knowledge about the processes) in about two weeks but could be built much faster with a little experience. If you want to build Cultivator on your own or use it as a reference feel free to do so and don’t hesitate contacting us with any questions.

![workshop](https://github.com/aaronabentheuer/Cultivator/blob/master/Images/workshop.jpg)

The white body of Cultivator is deep-drawn expandable polysterene, which gives you a nice matte plastic finish. The model used to deep-draw the shell is still in the prototype to give it the weight it needs to feel like a real thing. We used a material called “Ureol”, which is a synthetical very similar to wood in the way it can be treated, to build the model. Make sure to make it very robust since the deep-drawing process can be quite impactful at that size.
Everything else is just laser-cut acrylic glass in either black (for the top) or white (for the compartments, etc.) and a very simple rubber mount inside to hold the iPad in place.

##License
Released under the **MIT License**.
Copyright © 2015 [Sarah Mautsch](http://www.sarahmautsch.com) & [Aaron Abentheuer](http://www.aaronabentheuer.com).

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
