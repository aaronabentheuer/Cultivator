# Cultivator
Speculative design project about bioprinting of meat and how it could end up in the kitchen of tomorrow.

![cultivatorPerspective](https://github.com/aaronabentheuer/Cultivator/blob/master/Images/CultivatorPerspective.jpg)

##Prototype Software
It became clear to us that to really get the message across the way we wanted to at the exhibition we had to get the best performance possible out of our prototype or it would ruin the illusion, that’s why we chose Swift. The entire software-part of the prototype was done in under a week but still very performant even on an old iPad.

![screencast](https://github.com/aaronabentheuer/Cultivator/blob/master/Images/screencast.gif)

This prototype includes several interesting bits and pieces that marked the first time using several features of UIKit for us, which was an interesting experience. We experimented with **UICollectionView** and came up with a **user-presence detection** using [GPUImage by Brad Larson](https://github.com/BradLarson/GPUImage), which works very realiably in detecting a user’s intent of interaction. We originally tried to make the detection more reliable by using face-detection, which resulted in [AAFaceDetection](https://github.com/aaronabentheuer/AAFaceDetection).

*In the prototype we had to replace the originally used font [“Colfax” by Process Type Foundry](https://processtypefoundry.com/fonts/colfax/) with Avenir due to licensing problems. Feel free to replace it again if you got a proper license for the original font.*

##Prototype Hardware
Presenting the software without the hardware wouldn’t work at all of course. That’s why we came up with a rather timeless hardware-design that we think could fit in the kitchen of tomorrow at a size smaller than a microwave.

![technicalDraft](https://github.com/aaronabentheuer/Cultivator/blob/master/Images/Technical%20Draft.png)

Cultivator was built (without any initial knowledge about the processes) in about two weeks but could be built with a little experience much faster. If you want to build Cultivator on your own or use it as a reference feel free to do so and don’t hesitate contacting us with any questions.

![workshop](https://github.com/aaronabentheuer/Cultivator/blob/master/Images/workshop.png)

The white body of Cultivator is deep-drawn expandable polysterene, which gives you a nice matte plastic finish. The model used to deep-draw the shell is still in the prototype to give it the weight it needs to feel like a real thing. We used a material called “Ureol”, which is a synthetical very similar to wood in the way it can be treated, to build the model. Make sure to make it very robust since the deep-drawing process can be quite impactful at that size.
Everything else is just laser-cut acrylic glass in either black (for the top) or white (for the compartments, etc.) and a very simple rubber mount inside to hold the iPad in place.
