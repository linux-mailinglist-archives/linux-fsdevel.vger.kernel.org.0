Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C5A4A027C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 22:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347782AbiA1VEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 16:04:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:5208 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344384AbiA1VEG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643403846; x=1674939846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2ua0ogojoYzFfFxMCbaqaB6rcAVtjhTSL7aCX4FeOT0=;
  b=AqGm6I1BSarwPkEoPdWiqPnPv40vctPSMxX3xOL/8L610IHVtG+ogevu
   dkw8B8hkKp2My4BFwwhjpFYwfeYWmaVkhFgsJygq9cE5i+BD+sGSHscap
   vDZd+l5IN8RN3rEQwLQ76QAUTvbNvFYrVL+ohr3o/Ot8CiWIt1504EjNj
   8HmLr2zo2qxCMxHb2axkMC904YLcHzh/a2ocnDSIXrCUhjTMijeGT8bYP
   3PRNHS7czsd34CikEvYnLhb7dH3tZiytFi2CRfs4FzE2hgHEt66EJKjTf
   qE6wYjDB/zR1mZ00ghL50ZwnHpq84B+KquavLosQBwV41X7QXimhSv4h+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="230773512"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="230773512"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 13:04:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="521853178"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Jan 2022 13:04:02 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDYPa-000OJe-1J; Fri, 28 Jan 2022 21:04:02 +0000
Date:   Sat, 29 Jan 2022 05:03:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     tangmeng <tangmeng@uniontech.com>, tglx@linutronix.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        john.stultz@linaro.org, sboyd@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tangmeng <tangmeng@uniontech.com>
Subject: Re: [PATCH v2] kernel/time: move timer sysctls to its own file
Message-ID: <202201290325.Jyor2i8O-lkp@intel.com>
References: <20220128085106.27031-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128085106.27031-1-tangmeng@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi tangmeng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/timers/core]
[also build test ERROR on linus/master kees/for-next/pstore v5.17-rc1 next-20220128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/tangmeng/kernel-time-move-timer-sysctls-to-its-own-file/20220128-165225
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 35e13e9da9afbce13c1d36465504ece4e65f24fe
config: arm64-randconfig-r026-20220127 (https://download.01.org/0day-ci/archive/20220129/202201290325.Jyor2i8O-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/8bd44d33085f8ab50523016cbdb0c918dc4b4f3c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review tangmeng/kernel-time-move-timer-sysctls-to-its-own-file/20220128-165225
        git checkout 8bd44d33085f8ab50523016cbdb0c918dc4b4f3c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/time/timer.c: In function 'timer_sysctl_init':
>> kernel/time/timer.c:283:9: error: implicit declaration of function 'register_sysctl_init'; did you mean 'timer_sysctl_init'? [-Werror=implicit-function-declaration]
     283 |         register_sysctl_init("kerneli/timer", timer_sysctl);
         |         ^~~~~~~~~~~~~~~~~~~~
         |         timer_sysctl_init
   cc1: some warnings being treated as errors


vim +283 kernel/time/timer.c

   280	
   281	static int __init timer_sysctl_init(void)
   282	{
 > 283		register_sysctl_init("kerneli/timer", timer_sysctl);
   284		return 0;
   285	}
   286	#else
   287	#define timer_sysctl_init() do { } while (0)
   288	#endif
   289	static inline bool is_timers_nohz_active(void)
   290	{
   291		return static_branch_unlikely(&timers_nohz_active);
   292	}
   293	#else
   294	static inline bool is_timers_nohz_active(void) { return false; }
   295	#endif /* NO_HZ_COMMON */
   296	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
