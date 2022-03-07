Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF8F4D0A5A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 22:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244607AbiCGVzg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 16:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbiCGVze (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 16:55:34 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B58E7E083;
        Mon,  7 Mar 2022 13:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646690079; x=1678226079;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KrlomCi+xi56zFEkkkk2ibceDMmqy1RzWIr/d2LiwPk=;
  b=Wy+9SH81ACrCP8vjyye75XKWvQlH1leZwfE2tm3V/0o0jTn7VA9268JU
   A7rPqqRZTWmEopzVY1Of04dZsa9IgS5iwCUo6BF17akTfVU04PK3FNAWv
   Y7E5jWn5ZhWUD6ClHvTb4pU8/KMQblUR+EoQvzohjM7cPGBF37fZW49gM
   v+pLoYwOiLAr8TxAuVJuS0DtKJ5aqBEXBAmysh4WZ7MhRRdPh+J8a0L6s
   S7xKcjuyVAtgGgBNMgNf+TbdQA6AwweCrWb15puWvZ+zwx2NNPPGAd8UY
   DfiCspj2e9F6OYw5LzVCO+kYmvT2M9tIWOx0USwTid0J5JdLVHv3G2CCD
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="241950441"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="241950441"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 13:54:39 -0800
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="643410572"
Received: from rhack-mobl1.amr.corp.intel.com (HELO [10.209.14.71]) ([10.209.14.71])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 13:54:38 -0800
Message-ID: <178c7536-7b54-5f73-b759-745db4fae2bc@linux.intel.com>
Date:   Mon, 7 Mar 2022 15:54:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: mmotm 2022-03-06-20-33 uploaded (sound/soc/intel/boards/)
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
References: <20220307043435.251DBC340E9@smtp.kernel.org>
 <39c76613-3fb4-651b-1838-f460c4f76a17@infradead.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <39c76613-3fb4-651b-1838-f460c4f76a17@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/7/22 15:12, Randy Dunlap wrote:
> 
> 
> On 3/6/22 20:34, Andrew Morton wrote:
>> The mm-of-the-moment snapshot 2022-03-06-20-33 has been uploaded to
>>
>>     https://www.ozlabs.org/~akpm/mmotm/
>>
>> mmotm-readme.txt says
>>
>> README for mm-of-the-moment:
>>
>> https://www.ozlabs.org/~akpm/mmotm/
>>
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
>>
>> You will need quilt to apply these patches to the latest Linus release (5.x
>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>> https://ozlabs.org/~akpm/mmotm/series
> 
> on x86_64:
> 
> ERROR: modpost: "sof_dai_get_bclk" [sound/soc/intel/boards/snd-soc-intel-sof-cirrus-common.ko] undefined!
> ERROR: modpost: "sof_dai_get_mclk" [sound/soc/intel/boards/snd-soc-intel-sof-realtek-common.ko] undefined!
> 
> 
> Full randconfig file is attached.

Thanks Randy for the report. Indeed there's a problem with the 
SND_SOC_INTEL_SOF_SSP_AMP_MACH option. It should be conditional on at 
least one Intel/SOF platform being selected, as all the other platforms 
are already.

The following diff makes the problem go away:

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig

index 6884ddf9edad..81e012c164b0 100644

--- a/sound/soc/intel/boards/Kconfig

+++ b/sound/soc/intel/boards/Kconfig

@@ -615,6 +615,8 @@ config SND_SOC_INTEL_SOF_DA7219_MAX98373_MACH



  endif ## SND_SOC_SOF_JASPERLAKE



+if SND_SOC_SOF_HDA_LINK

+

  config SND_SOC_INTEL_SOF_SSP_AMP_MACH

         tristate "SOF with amplifiers in I2S Mode"

         depends on I2C && ACPI

@@ -631,6 +633,7 @@ config SND_SOC_INTEL_SOF_SSP_AMP_MACH

            with RT1308/CS35L41 I2S audio codec.

            Say Y if you have such a device.

            If unsure select "N".

+endif ## SND_SOC_SOF_HDA_LINK



  if SND_SOC_SOF_ELKHARTLAKE



