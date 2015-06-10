BDFS = \
	tewi-normal-11.bdf \
	tewifw-normal-11.bdf
PCFS = $(addprefix out/,$(BDFS:%.bdf=%.pcf.gz))
CACHEFILES = out/fonts.dir out/fonts.scale

all: pcfs cache
pcfs: $(PCFS)
cache: $(CACHEFILES)

$(PCFS): out/%.pcf.gz: %.bdf
	bdftopcf $< | gzip > $@

out/fonts.dir: $(PCFS) out/fonts.scale
	cd out && mkfontdir
	xset fp rehash

out/fonts.scale: $(PCFS)
	cd out && mkfontscale

clean:
	rm -f out/* *.bak

.PHONY: all build clean
