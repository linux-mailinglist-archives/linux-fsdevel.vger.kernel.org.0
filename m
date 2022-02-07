Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3294AB55D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 08:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbiBGG5z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 01:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiBGGmT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:42:19 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 22:42:18 PST
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B42C043181;
        Sun,  6 Feb 2022 22:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644216138; x=1675752138;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=DO7fkFsD6ms9AC+z9aJ2+Gye4czjk6wUqYi/MtAndZw=;
  b=SenG1Lc68mgHuV2vbwZGaVhe2LLhXrHiccGFcqcuPecfyjPxesBTSoSF
   XWQ2LNBmfra02Zr7Z9zPsjZbkqAcjDrGPh7gDnUxBEZQTQd8nJUrkWcdL
   DMYozX5VHuQRWLhaynJO6/pVyCGPJIMyDXw8+wDJoAfvu4UWvNo/Nt59J
   Z80uHYQ54SWhd1Q6f2aCtQjHr73fmh0AOHwenArtNBr9YJThlJTgyXEsD
   41paMofe7AV82uVbRwopLbMXSk/PMik+Y7eeHe1UsT3UFJmhiJDfRh2Ly
   n3wpg3Qvxu6YIJ3T/enYQBGa0r1osY6zorxXWZDXbvP9D4DmlelGCBcH2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="248864386"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="248864386"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 22:41:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="539967061"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.174.205]) ([10.249.174.205])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 22:41:10 -0800
Subject: Re: [kbuild-all] Re: [PATCH v2] kernel/time: move timer sysctls to
 its own file
To:     Luis Chamberlain <mcgrof@kernel.org>,
        kernel test robot <lkp@intel.com>
Cc:     tangmeng <tangmeng@uniontech.com>, tglx@linutronix.de,
        keescook@chromium.org, yzaikin@google.com, john.stultz@linaro.org,
        sboyd@kernel.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220128085106.27031-1-tangmeng@uniontech.com>
 <202201290325.Jyor2i8O-lkp@intel.com>
 <YfnvE9rPffDb4JHy@bombadil.infradead.org>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <fc36323c-dfd9-b98f-4147-5e5b9ecd1177@intel.com>
Date:   Mon, 7 Feb 2022 14:41:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YfnvE9rPffDb4JHy@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Luis,

Thanks for the feedback, we'll take a look.

Best Regards,
Rong Chen

On 2/2/2022 10:40 AM, Luis Chamberlain wrote:
> These complaints are using and assuming and older kernel.
> 
>   Luis
> 
> On Sat, Jan 29, 2022 at 05:03:38AM +0800, kernel test robot wrote:
>> Hi tangmeng,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on tip/timers/core]
>> [also build test ERROR on linus/master kees/for-next/pstore v5.17-rc1 next-20220128]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/tangmeng/kernel-time-move-timer-sysctls-to-its-own-file/20220128-165225
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 35e13e9da9afbce13c1d36465504ece4e65f24fe
>> config: arm64-randconfig-r026-20220127 (https://download.01.org/0day-ci/archive/20220129/202201290325.Jyor2i8O-lkp@intel.com/config)
>> compiler: aarch64-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://github.com/0day-ci/linux/commit/8bd44d33085f8ab50523016cbdb0c918dc4b4f3c
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review tangmeng/kernel-time-move-timer-sysctls-to-its-own-file/20220128-165225
>>          git checkout 8bd44d33085f8ab50523016cbdb0c918dc4b4f3c
>>          # save the config file to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash kernel/time/
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     kernel/time/timer.c: In function 'timer_sysctl_init':
>>>> kernel/time/timer.c:283:9: error: implicit declaration of function 'register_sysctl_init'; did you mean 'timer_sysctl_init'? [-Werror=implicit-function-declaration]
>>       283 |         register_sysctl_init("kerneli/timer", timer_sysctl);
>>           |         ^~~~~~~~~~~~~~~~~~~~
>>           |         timer_sysctl_init
>>     cc1: some warnings being treated as errors
>>
>>
>> vim +283 kernel/time/timer.c
>>
>>     280	
>>     281	static int __init timer_sysctl_init(void)
>>     282	{
>>   > 283		register_sysctl_init("kerneli/timer", timer_sysctl);
>>     284		return 0;
>>     285	}
>>     286	#else
>>     287	#define timer_sysctl_init() do { } while (0)
>>     288	#endif
>>     289	static inline bool is_timers_nohz_active(void)
>>     290	{
>>     291		return static_branch_unlikely(&timers_nohz_active);
>>     292	}
>>     293	#else
>>     294	static inline bool is_timers_nohz_active(void) { return false; }
>>     295	#endif /* NO_HZ_COMMON */
>>     296	
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
