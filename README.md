Lab1Automation
==============

## Description:

Matlab automation framework for automating a Instek GFG-3015 function generator and a Tektronix TDS1012 Oscilloscope for SFU ENSC Lab1 using Matlab.

## Installation:
Download and extract all the files to the local matlab path "C:\Documents and Settings\<username>\My Documents\Matlab\"


## Examples:
  
Tested with Matlab Rev 2009b, Instek GFG-3015 Function Generator, Tektronix TDS1012 Oscilloscope.

First you must force Matlab to recognize the sourcefolder by executing the setPath.m file. From Matlabs "Command Window" type and send the command:
``` js
  setPath
```

Next instantiate a function generator object (fgen) and an Oscilloscope object (osc):
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

From inside of matlab, the user can access a description of the objects or internal methods by typing:
``` js
  help Osc
  help Fgen
  help Fgen.setVoltAmp
  help Fgen.getVoltAmp
  help Osc.getVoltage
```

Deleting the both the fgen and osc objects. Do *not* delete the objects inside of the Workspace. Instead delete them by calling matlab's clear method:
``` js
  clear fgen
  clear osc
```

Example: Set the amplitude of the GFG-3015 Function Generator
``` js
  setPath
  fgen = Fgen()
  fgen.setVoltAmp(1)
  clear fgen
```

## Authors:

  **Lester Chee,**
  **Ryley Morgan,**
  **Jacky Jiang,**
  **Yao Li,**
  **Joshua Kong,**
  **Richard Xie,**
  **Jeremy Borys**
