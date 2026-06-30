<< RISC`HolonomicFunctions`
ann = Annihilator[z^n0*(1 - z)^n1, {Der[z], S[n0], S[n1]}]
FindCreativeTelescoping[ann, Der[z]]
  {(2 + n0 + n1) S_n1 + (-1 - n1), 
   (2 + n0 + n1) S_n0 + (-1 - n0)}
