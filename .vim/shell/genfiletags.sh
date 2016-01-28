#!/bin/sh
# generate filename tags for lookupfile plugin

echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/" > tags.fn
find . -not -wholename '*.svn*' -not -regex '.*\.\(png\|gif\)' -type f -printf "%f\t%p\t1\n" | sort -f >> tags.fn

