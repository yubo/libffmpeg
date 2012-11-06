CODEC_NAMES_SH := libavcodec/codec_names.sh
AVCODEC_H      := libavcodec/avcodec.h
codec_names.h: $(CODEC_NAMES_SH) config.h $(AVCODEC_H)
	cc  -E $(AVCODEC_H) | \
	$(CODEC_NAMES_SH) config.h $@
