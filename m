Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 618A2A0A74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 21:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfH1T2E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 15:28:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:25308 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfH1T2E (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 15:28:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 12:28:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="380519016"
Received: from amathu3-mobl1.amr.corp.intel.com (HELO [10.254.179.245]) ([10.254.179.245])
  by fmsmga005.fm.intel.com with ESMTP; 28 Aug 2019 12:28:01 -0700
Subject: Re: mmotm 2019-08-27-20-39 uploaded (sound/hda/intel-nhlt.c)
To:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        moderated for non-subscribers <alsa-devel@alsa-project.org>
References: <20190828034012.sBvm81sYK%akpm@linux-foundation.org>
 <274054ef-8611-2661-9e67-4aabae5a7728@infradead.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5ac8a7a7-a9b4-89a5-e0a6-7c97ec1fabc6@linux.intel.com>
Date:   Wed, 28 Aug 2019 14:28:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <274054ef-8611-2661-9e67-4aabae5a7728@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/28/19 1:30 PM, Randy Dunlap wrote:
> On 8/27/19 8:40 PM, akpm@linux-foundation.org wrote:
>> The mm-of-the-moment snapshot 2019-08-27-20-39 has been uploaded to
>>
>>     http://www.ozlabs.org/~akpm/mmotm/
>>
>> mmotm-readme.txt says
>>
>> README for mm-of-the-moment:
>>
>> http://www.ozlabs.org/~akpm/mmotm/
>>
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
>>
>> You will need quilt to apply these patches to the latest Linus release (5.x
>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>> http://ozlabs.org/~akpm/mmotm/series
>>
>> The file broken-out.tar.gz contains two datestamp files: .DATE and
>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
>> followed by the base kernel version against which this patch series is to
>> be applied.
> 
> (from linux-next tree, but problem found/seen in mmotm)
> 
> Sorry, I don't know who is responsible for this driver.

That would be me.

I just checked with Mark Brown's for-next tree 
8aceffa09b4b9867153bfe0ff6f40517240cee12
and things are fine in i386 mode, see below.

next-20190828 also works fine for me in i386 mode.

if you can point me to a tree and configuration that don't work I'll 
look into this, I'd need more info to progress.

make ARCH=i386
   Using /data/pbossart/ktest/broonie-next as source for kernel
   GEN     Makefile
   CALL    /data/pbossart/ktest/broonie-next/scripts/checksyscalls.sh
   CALL    /data/pbossart/ktest/broonie-next/scripts/atomic/check-atomics.sh
   CHK     include/generated/compile.h
   CC [M]  sound/hda/ext/hdac_ext_bus.o
   CC [M]  sound/hda/ext/hdac_ext_controller.o
   CC [M]  sound/hda/ext/hdac_ext_stream.o
   LD [M]  sound/hda/ext/snd-hda-ext-core.o
   CC [M]  sound/hda/hda_bus_type.o
   CC [M]  sound/hda/hdac_bus.o
   CC [M]  sound/hda/hdac_device.o
   CC [M]  sound/hda/hdac_sysfs.o
   CC [M]  sound/hda/hdac_regmap.o
   CC [M]  sound/hda/hdac_controller.o
   CC [M]  sound/hda/hdac_stream.o
   CC [M]  sound/hda/array.o
   CC [M]  sound/hda/hdmi_chmap.o
   CC [M]  sound/hda/trace.o
   CC [M]  sound/hda/hdac_component.o
   CC [M]  sound/hda/hdac_i915.o
   LD [M]  sound/hda/snd-hda-core.o
   CC [M]  sound/hda/intel-nhlt.o
   LD [M]  sound/hda/snd-intel-nhlt.o
Kernel: arch/x86/boot/bzImage is ready  (#18)
   Building modules, stage 2.
   MODPOST 156 modules
   CC      sound/hda/ext/snd-hda-ext-core.mod.o
   LD [M]  sound/hda/ext/snd-hda-ext-core.ko
   CC      sound/hda/snd-hda-core.mod.o
   LD [M]  sound/hda/snd-hda-core.ko
   CC      sound/hda/snd-intel-nhlt.mod.o
   LD [M]  sound/hda/snd-intel-nhlt.ko


> 
> ~~~~~~~~~~~~~~~~~~~~~~
> on i386:
> 
>    CC      sound/hda/intel-nhlt.o
> ../sound/hda/intel-nhlt.c:14:25: error: redefinition of ‘intel_nhlt_init’
>   struct nhlt_acpi_table *intel_nhlt_init(struct device *dev)
>                           ^~~~~~~~~~~~~~~
> In file included from ../sound/hda/intel-nhlt.c:5:0:
> ../include/sound/intel-nhlt.h:134:39: note: previous definition of ‘intel_nhlt_init’ was here
>   static inline struct nhlt_acpi_table *intel_nhlt_init(struct device *dev)
>                                         ^~~~~~~~~~~~~~~
> ../sound/hda/intel-nhlt.c: In function ‘intel_nhlt_init’:
> ../sound/hda/intel-nhlt.c:39:14: error: dereferencing pointer to incomplete type ‘struct nhlt_resource_desc’
>    if (nhlt_ptr->length)
>                ^~
> ../sound/hda/intel-nhlt.c:41:4: error: implicit declaration of function ‘memremap’; did you mean ‘ioremap’? [-Werror=implicit-function-declaration]
>      memremap(nhlt_ptr->min_addr, nhlt_ptr->length,
>      ^~~~~~~~
>      ioremap
> ../sound/hda/intel-nhlt.c:42:6: error: ‘MEMREMAP_WB’ undeclared (first use in this function)
>        MEMREMAP_WB);
>        ^~~~~~~~~~~
> ../sound/hda/intel-nhlt.c:42:6: note: each undeclared identifier is reported only once for each function it appears in
> ../sound/hda/intel-nhlt.c:45:25: error: dereferencing pointer to incomplete type ‘struct nhlt_acpi_table’
>        (strncmp(nhlt_table->header.signature,
>                           ^~
> ../sound/hda/intel-nhlt.c:48:3: error: implicit declaration of function ‘memunmap’; did you mean ‘vunmap’? [-Werror=implicit-function-declaration]
>     memunmap(nhlt_table);
>     ^~~~~~~~
>     vunmap
> ../sound/hda/intel-nhlt.c: At top level:
> ../sound/hda/intel-nhlt.c:56:6: error: redefinition of ‘intel_nhlt_free’
>   void intel_nhlt_free(struct nhlt_acpi_table *nhlt)
>        ^~~~~~~~~~~~~~~
> In file included from ../sound/hda/intel-nhlt.c:5:0:
> ../include/sound/intel-nhlt.h:139:20: note: previous definition of ‘intel_nhlt_free’ was here
>   static inline void intel_nhlt_free(struct nhlt_acpi_table *addr)
>                      ^~~~~~~~~~~~~~~
> ../sound/hda/intel-nhlt.c:62:5: error: redefinition of ‘intel_nhlt_get_dmic_geo’
>   int intel_nhlt_get_dmic_geo(struct device *dev, struct nhlt_acpi_table *nhlt)
>       ^~~~~~~~~~~~~~~~~~~~~~~
> In file included from ../sound/hda/intel-nhlt.c:5:0:
> ../include/sound/intel-nhlt.h:143:19: note: previous definition of ‘intel_nhlt_get_dmic_geo’ was here
>   static inline int intel_nhlt_get_dmic_geo(struct device *dev,
>                     ^~~~~~~~~~~~~~~~~~~~~~~
> ../sound/hda/intel-nhlt.c: In function ‘intel_nhlt_get_dmic_geo’:
> ../sound/hda/intel-nhlt.c:76:11: error: dereferencing pointer to incomplete type ‘struct nhlt_endpoint’
>     if (epnt->linktype == NHLT_LINK_DMIC) {
>             ^~
> ../sound/hda/intel-nhlt.c:76:25: error: ‘NHLT_LINK_DMIC’ undeclared (first use in this function)
>     if (epnt->linktype == NHLT_LINK_DMIC) {
>                           ^~~~~~~~~~~~~~
> ../sound/hda/intel-nhlt.c:79:15: error: dereferencing pointer to incomplete type ‘struct nhlt_dmic_array_config’
>      switch (cfg->array_type) {
>                 ^~
> ../sound/hda/intel-nhlt.c:80:9: error: ‘NHLT_MIC_ARRAY_2CH_SMALL’ undeclared (first use in this function)
>      case NHLT_MIC_ARRAY_2CH_SMALL:
>           ^~~~~~~~~~~~~~~~~~~~~~~~
> ../sound/hda/intel-nhlt.c:81:9: error: ‘NHLT_MIC_ARRAY_2CH_BIG’ undeclared (first use in this function); did you mean ‘NHLT_MIC_ARRAY_2CH_SMALL’?
>      case NHLT_MIC_ARRAY_2CH_BIG:
>           ^~~~~~~~~~~~~~~~~~~~~~
>           NHLT_MIC_ARRAY_2CH_SMALL
> ../sound/hda/intel-nhlt.c:82:16: error: ‘MIC_ARRAY_2CH’ undeclared (first use in this function); did you mean ‘NHLT_MIC_ARRAY_2CH_BIG’?
>       dmic_geo = MIC_ARRAY_2CH;
>                  ^~~~~~~~~~~~~
>                  NHLT_MIC_ARRAY_2CH_BIG
> ../sound/hda/intel-nhlt.c:85:9: error: ‘NHLT_MIC_ARRAY_4CH_1ST_GEOM’ undeclared (first use in this function); did you mean ‘NHLT_MIC_ARRAY_2CH_BIG’?
>      case NHLT_MIC_ARRAY_4CH_1ST_GEOM:
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>           NHLT_MIC_ARRAY_2CH_BIG
> ../sound/hda/intel-nhlt.c:86:9: error: ‘NHLT_MIC_ARRAY_4CH_L_SHAPED’ undeclared (first use in this function); did you mean ‘NHLT_MIC_ARRAY_4CH_1ST_GEOM’?
>      case NHLT_MIC_ARRAY_4CH_L_SHAPED:
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>           NHLT_MIC_ARRAY_4CH_1ST_GEOM
>    AR      sound/i2c/other/built-in.a
> ../sound/hda/intel-nhlt.c:87:9: error: ‘NHLT_MIC_ARRAY_4CH_2ND_GEOM’ undeclared (first use in this function); did you mean ‘NHLT_MIC_ARRAY_4CH_1ST_GEOM’?
>      case NHLT_MIC_ARRAY_4CH_2ND_GEOM:
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>           NHLT_MIC_ARRAY_4CH_1ST_GEOM
> ../sound/hda/intel-nhlt.c:88:16: error: ‘MIC_ARRAY_4CH’ undeclared (first use in this function); did you mean ‘MIC_ARRAY_2CH’?
>       dmic_geo = MIC_ARRAY_4CH;
>                  ^~~~~~~~~~~~~
>                  MIC_ARRAY_2CH
>    AR      sound/i2c/built-in.a
>    CC      drivers/bluetooth/btmtksdio.o
> ../sound/hda/intel-nhlt.c:90:9: error: ‘NHLT_MIC_ARRAY_VENDOR_DEFINED’ undeclared (first use in this function); did you mean ‘NHLT_MIC_ARRAY_4CH_L_SHAPED’?
>      case NHLT_MIC_ARRAY_VENDOR_DEFINED:
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>           NHLT_MIC_ARRAY_4CH_L_SHAPED
> ../sound/hda/intel-nhlt.c:92:26: error: dereferencing pointer to incomplete type ‘struct nhlt_vendor_dmic_array_config’
>       dmic_geo = cfg_vendor->nb_mics;
>                            ^~
> ../sound/hda/intel-nhlt.c: At top level:
> ../sound/hda/intel-nhlt.c:106:16: error: expected declaration specifiers or ‘...’ before string constant
>   MODULE_LICENSE("GPL v2");
>                  ^~~~~~~~
> ../sound/hda/intel-nhlt.c:107:20: error: expected declaration specifiers or ‘...’ before string constant
>   MODULE_DESCRIPTION("Intel NHLT driver");
>                      ^~~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> make[3]: *** [../scripts/Makefile.build:266: sound/hda/intel-nhlt.o] Error 1
> 
> 
> 
