Lab1Automation
==============

# Description:

Matlab automation framework for automating a Instek GFG-3015 function generator and a Tektronix TDS1012 Oscilloscope for SFU ENSC Lab1 using Matlab.

# Installation:
Copy the files inside the src folder to My Documents/Matlab/


# Examples:
  
Tested with Matlab Rev 2009b, Instek GFG-3015 Function Generator, Tektronix TDS1012 Oscilloscope.

First instantiate a function generator object (fgen) and an Oscilloscope object (osc):
``` js
  fgen = Fgen()
  osc = Osc()
```

Matlab now has access to all the internal methods contained within the fgen and osc objects. The internal methods can be called by:
``` js
  fgen.setVoltAmp(1)
  fgen.getVoltAmp()
  osc.getVoltage()
```

# Authors:

  **Lester Chee,**
  **Ryley Morgan,**
  **Jacky Jiang,**
  **Yao Li,**
  **Joshua Kong,**
  **Richard Xie,**
  **Jeremy Borys**
