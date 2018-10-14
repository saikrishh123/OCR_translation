# -*- coding: utf-8 -*-
"""
Created on Sat Oct 13 21:10:25 2018

@author: Sai Krishna
"""
f=open("trans.txt","r");
txt=f.read();
f.close();
from googletrans import Translator
translator=Translator()
w=translator.translate(txt,dest='nl')

f = open("trans.txt", "w")
f.write(w.text)
f.close()