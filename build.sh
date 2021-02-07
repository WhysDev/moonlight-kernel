#!/bin/bash

export KERNELNAME=Moonlight

export LOCALVERSION=nightly

export KBUILD_BUILD_USER=Frost

export KBUILD_BUILD_HOST=Weaboo

export TOOLCHAIN=clang

export DEVICES=whyred,tulip,lavender,a26x

export CI_ID=-1001463706805

export GROUP_ID=-1001401101008

source helper

gen_toolchain

send_msg "⏳ Start building ${KERNELNAME} ${LOCALVERSION} EAS | DEVICES: whyred,tulip,lavender,wayne and jasmine..."

send_pesan "⏳ Start building ${KERNELNAME} ${LOCALVERSION} EAS | DEVICES: whyred,tulip,lavender,wayne and jasmine..."

START=$(date +"%s")

for i in ${DEVICES//,/ }
do
	build ${i} -oldcam

	build ${i} -newcam
done

send_msg "⏳ Start building Overclock version for whyred and tulip..."

send_pesan "⏳ Start building Overclock version for whyred and tulip..."

git apply oc.patch

for i in ${DEVICES//,/ }
do
	if [ $i == "whyred" ] || [ $i == "tulip" ]
	then
		build ${i} -oldcam -overclock

		build ${i} -newcam -overclock
	fi
done

END=$(date +"%s")

DIFF=$(( END - START ))

send_msg "✅ Build completed in $((DIFF / 60))m $((DIFF % 60))s, get nightly builds in @MoonlightCI | Last commit : $(git log --pretty=format:'%s' -5)"

send_pesan "✅ Build completed in $((DIFF / 60))m $((DIFF % 60))s | Last commit: $(git log --pretty=format:'%s' -5)"
