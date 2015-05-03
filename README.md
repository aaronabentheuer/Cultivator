# Cultivator
Speculative design project about bioprinting of meat and how it could end up in the kitchen of tomorrow.

![cultivatorPerspective](https://github.com/aaronabentheuer/Cultivator/blob/master/Images/CultivatorPerspective.jpg)

##Prototype Software
It became clear to us that to really get the message across the way we wanted to at the exhibition we had to get the best performance possible out of our prototype or it would ruin the illusion, that’s why we chose Swift. The entire software-part of the prototype was done in under a week but still very performant even on an old iPad.

![screencast](https://github.com/aaronabentheuer/Cultivator/blob/master/Images/screencast.gif)

This prototype includes several interesting bits and pieces that marked the first time using several features of UIKit for us, which was an interesting experience. We experimented with **UICollectionView** and came up with a **user-presence detection** using [GPUImage by Brad Larson](https://github.com/BradLarson/GPUImage), which works very realiably in detecting a user’s intent of interaction. We originally tried to make the detection more reliable by using face-detection, which resulted in [AAFaceDetection](https://github.com/aaronabentheuer/AAFaceDetection).

In the prototype we had to replace the originally used font [“Colfax” by Process Type Foundry](https://processtypefoundry.com/fonts/colfax/) with Avenir due to licensing problems. Feel free to replace it again if you got a proper license for the original font.
