Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21378A097A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 20:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfH1Sap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 14:30:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35034 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfH1Sap (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=z/GTsMOG+FQ14Ym0CrHcgUMZHK5aHnNQzVskveU9sFI=; b=Li7H/9KkJmMz6GCqvX5y9EHsF
        +rH6LaBMZx+HpuK0K0fVeaPwkqeEY1bHnK1uLkYcKLTbU5fvUYUQsZZVRc+w7EyOHGM+7Pm+aYDzj
        lv8IwQQJ50WqfOtBlSURlzaBUdhASj25YJQ7zxbj80H3Y2I5+6G5Myhod459e8T1FtpYJEAYBUZ5U
        GS0vt/SFZ6+KktBYOHTZq7pqeYCBVaA/GqnfcFnifKwk87MaB8bOhlJa1A8tXAUQLW7RlbDFLUIfX
        Pg9C8cBK6CtV6Nh7SlVywqSv8sPTuM2gqLq2NRYZZgfTIe/QlRJpUQFOXuz/Yhbeyndl61cinK2yQ
        ZQyStrNTA==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i32iN-0003wd-MP; Wed, 28 Aug 2019 18:30:39 +0000
Subject: Re: mmotm 2019-08-27-20-39 uploaded (sound/hda/intel-nhlt.c)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
References: <20190828034012.sBvm81sYK%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <274054ef-8611-2661-9e67-4aabae5a7728@infradead.org>
Date:   Wed, 28 Aug 2019 11:30:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828034012.sBvm81sYK%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/27/19 8:40 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2019-08-27-20-39 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.

(from linux-next tree, but problem found/seen in mmotm)

Sorry, I don't know who is responsible for this driver.

~~~~~~~~~~~~~~~~~~~~~~
on i386:

  CC      sound/hda/intel-nhlt.o
../sound/hda/intel-nhlt.c:14:25: error: redefinition of ‘intel_nhlt_init’
 struct nhlt_acpi_table *intel_nhlt_init(struct device *dev)
                         ^~~~~~~~~~~~~~~
In file included from ../sound/hda/intel-nhlt.c:5:0:
../include/sound/intel-nhlt.h:134:39: note: previous definition of ‘intel_nhlt_init’ was here
 static inline struct nhlt_acpi_table *intel_nhlt_init(struct device *dev)
                                       ^~~~~~~~~~~~~~~
../sound/hda/intel-nhlt.c: In function ‘intel_nhlt_init’:
../sound/hda/intel-nhlt.c:39:14: error: dereferencing pointer to incomplete type ‘struct nhlt_resource_desc’
  if (nhlt_ptr->length)
              ^~
../sound/hda/intel-nhlt.c:41:4: error: implicit declaration of function ‘memremap’; did you mean ‘ioremap’? [-Werror=implicit-function-declaration]
    memremap(nhlt_ptr->min_addr, nhlt_ptr->length,
    ^~~~~~~~
    ioremap
../sound/hda/intel-nhlt.c:42:6: error: ‘MEMREMAP_WB’ undeclared (first use in this function)
      MEMREMAP_WB);
      ^~~~~~~~~~~
../sound/hda/intel-nhlt.c:42:6: note: each undeclared identifier is reported only once for each function it appears in
../sound/hda/intel-nhlt.c:45:25: error: dereferencing pointer to incomplete type ‘struct nhlt_acpi_table’
      (strncmp(nhlt_table->header.signature,
                         ^~
../sound/hda/intel-nhlt.c:48:3: error: implicit declaration of function ‘memunmap’; did you mean ‘vunmap’? [-Werror=implicit-function-declaration]
   memunmap(nhlt_table);
   ^~~~~~~~
   vunmap
../sound/hda/intel-nhlt.c: At top level:
../sound/hda/intel-nhlt.c:56:6: error: redefinition of ‘intel_nhlt_free’
 void intel_nhlt_free(struct nhlt_acpi_table *nhlt)
      ^~~~~~~~~~~~~~~
In file included from ../sound/hda/intel-nhlt.c:5:0:
../include/sound/intel-nhlt.h:139:20: note: previous definition of ‘intel_nhlt_free’ was here
 static inline void intel_nhlt_free(struct nhlt_acpi_table *addr)
                    ^~~~~~~~~~~~~~~
../sound/hda/intel-nhlt.c:62:5: error: redefinition of ‘intel_nhlt_get_dmic_geo’
 int intel_nhlt_get_dmic_geo(struct device *dev, struct nhlt_acpi_table *nhlt)
     ^~~~~~~~~~~~~~~~~~~~~~~
In file included from ../sound/hda/intel-nhlt.c:5:0:
../include/sound/intel-nhlt.h:143:19: note: previous definition of ‘intel_nhlt_get_dmic_geo’ was here
 static inline int intel_nhlt_get_dmic_geo(struct device *dev,
                   ^~~~~~~~~~~~~~~~~~~~~~~
../sound/hda/intel-nhlt.c: In function ‘intel_nhlt_get_dmic_geo’:
../sound/hda/intel-nhlt.c:76:11: error: dereferencing pointer to incomplete type ‘struct nhlt_endpoint’
   if (epnt->linktype == NHLT_LINK_DMIC) {
           ^~
../sound/hda/intel-nhlt.c:76:25: error: ‘NHLT_LINK_DMIC’ undeclared (first use in this function)
   if (epnt->linktype == NHLT_LINK_DMIC) {
                         ^~~~~~~~~~~~~~
../sound/hda/intel-nhlt.c:79:15: error: dereferencing pointer to incomplete type ‘struct nhlt_dmic_array_config’
    switch (cfg->array_type) {
               ^~
../sound/hda/intel-nhlt.c:80:9: error: ‘NHLT_MIC_ARRAY_2CH_SMALL’ undeclared (first use in this function)
    case NHLT_MIC_ARRAY_2CH_SMALL:
         ^~~~~~~~~~~~~~~~~~~~~~~~
../sound/hda/intel-nhlt.c:81:9: error: ‘NHLT_MIC_ARRAY_2CH_BIG’ undeclared (first use in this function); did you mean ‘NHLT_MIC_ARRAY_2CH_SMALL’?
    case NHLT_MIC_ARRAY_2CH_BIG:
         ^~~~~~~~~~~~~~~~~~~~~~
         NHLT_MIC_ARRAY_2CH_SMALL
../sound/hda/intel-nhlt.c:82:16: error: ‘MIC_ARRAY_2CH’ undeclared (first use in this function); did you mean ‘NHLT_MIC_ARRAY_2CH_BIG’?
     dmic_geo = MIC_ARRAY_2CH;
                ^~~~~~~~~~~~~
                NHLT_MIC_ARRAY_2CH_BIG
../sound/hda/intel-nhlt.c:85:9: error: ‘NHLT_MIC_ARRAY_4CH_1ST_GEOM’ undeclared (first use in this function); did you mean ‘NHLT_MIC_ARRAY_2CH_BIG’?
    case NHLT_MIC_ARRAY_4CH_1ST_GEOM:
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         NHLT_MIC_ARRAY_2CH_BIG
../sound/hda/intel-nhlt.c:86:9: error: ‘NHLT_MIC_ARRAY_4CH_L_SHAPED’ undeclared (first use in this function); did you mean ‘NHLT_MIC_ARRAY_4CH_1ST_GEOM’?
    case NHLT_MIC_ARRAY_4CH_L_SHAPED:
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         NHLT_MIC_ARRAY_4CH_1ST_GEOM
  AR      sound/i2c/other/built-in.a
../sound/hda/intel-nhlt.c:87:9: error: ‘NHLT_MIC_ARRAY_4CH_2ND_GEOM’ undeclared (first use in this function); did you mean ‘NHLT_MIC_ARRAY_4CH_1ST_GEOM’?
    case NHLT_MIC_ARRAY_4CH_2ND_GEOM:
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         NHLT_MIC_ARRAY_4CH_1ST_GEOM
../sound/hda/intel-nhlt.c:88:16: error: ‘MIC_ARRAY_4CH’ undeclared (first use in this function); did you mean ‘MIC_ARRAY_2CH’?
     dmic_geo = MIC_ARRAY_4CH;
                ^~~~~~~~~~~~~
                MIC_ARRAY_2CH
  AR      sound/i2c/built-in.a
  CC      drivers/bluetooth/btmtksdio.o
../sound/hda/intel-nhlt.c:90:9: error: ‘NHLT_MIC_ARRAY_VENDOR_DEFINED’ undeclared (first use in this function); did you mean ‘NHLT_MIC_ARRAY_4CH_L_SHAPED’?
    case NHLT_MIC_ARRAY_VENDOR_DEFINED:
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         NHLT_MIC_ARRAY_4CH_L_SHAPED
../sound/hda/intel-nhlt.c:92:26: error: dereferencing pointer to incomplete type ‘struct nhlt_vendor_dmic_array_config’
     dmic_geo = cfg_vendor->nb_mics;
                          ^~
../sound/hda/intel-nhlt.c: At top level:
../sound/hda/intel-nhlt.c:106:16: error: expected declaration specifiers or ‘...’ before string constant
 MODULE_LICENSE("GPL v2");
                ^~~~~~~~
../sound/hda/intel-nhlt.c:107:20: error: expected declaration specifiers or ‘...’ before string constant
 MODULE_DESCRIPTION("Intel NHLT driver");
                    ^~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[3]: *** [../scripts/Makefile.build:266: sound/hda/intel-nhlt.o] Error 1



-- 
~Randy
