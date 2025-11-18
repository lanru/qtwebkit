#!/bin/bash 
cd /data/arm-bio/qtwebkit-A40/Source/WebCore/generated
bison -d -p cssyy CSSGrammar.y
mv CSSGrammar.tab.c CSSGrammar.cpp
mv CSSGrammar.tab.h CSSGrammar.hpp
ln -sf CSSGrammar.hpp CSSGrammar.tab.h

cd /data/arm-bio/qtwebkit-A40/Source/WebCore/xml
bison -d -p xpathyy XPathGrammar.y


