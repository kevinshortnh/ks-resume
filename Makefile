#!/usr/bin/env make -f

default clean:
	make --directory=ks-resume $@

lint xmllint:
	xmllint --format - < index.html > index.pretty
