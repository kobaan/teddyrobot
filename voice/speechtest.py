#!/usr/bin/env python
# might have to import multiple times to work around error: import pocketsphinx as ps
try:
  import pocketsphinx as ps
except:
  import pocketsphinx as ps
speechRec = ps.Decoder()
wavFile = file("/root/sphinx-setup/vf_de_test/wav/ralfherzog-20071219-de33_de33-83.wav",'rb')
wavFile.seek(44)
speechRec.decode_raw(wavFile)
result = speechRec.get_hyp()
print "Recognized: "
print result[0]
