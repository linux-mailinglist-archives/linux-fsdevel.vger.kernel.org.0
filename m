Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4283949F5EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 10:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbiA1JGL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 04:06:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:58006 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231806AbiA1JGL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643360771; x=1674896771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ErjsXDgw1zcYUyJCH4F/5Es1o0tzYO07CJyPW7u/PWQ=;
  b=gMgaShS5GG6tfHfDVnQ73jSi0He5BtP3XCjSLDgyWhleIOQ6ytIM8AN8
   YfT0I26RtD5s0xu1QIb3JDtxaQ6jIJc7dFYJhTPTIJz/0SLMoy/HwkzMa
   VMncnT7hb+LcB7zUxOOiQIezs+eKaQkIMKNMMHnp1jlXazvzaSmru3z35
   MwLEyQwm64A2dkSvo9YYWyrtguSgUlTFvc0LIqw0NumDucFhc2A0O2njr
   7//cyfF0iXsDADor37uSMa5pdtDSs5gnk7P0OppQj0rvPscDfcqIGcAq9
   RZsltNkN7GuKdh+2HLrRGwuiZFPKPl6OPeT4O3zwhqVXfgTP5Y7C+2cHN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="271543133"
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="271543133"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 01:06:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="496076015"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Jan 2022 01:06:07 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDNCo-000NgL-JB; Fri, 28 Jan 2022 09:06:06 +0000
Date:   Fri, 28 Jan 2022 17:05:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     tangmeng <tangmeng@uniontech.com>, tglx@linutronix.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        john.stultz@linaro.org, sboyd@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tangmeng <tangmeng@uniontech.com>
Subject: Re: [PATCH] kernel/time: move timer sysctls to its own file
Message-ID: <202201281620.Rwng44TW-lkp@intel.com>
References: <20220128065505.16685-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128065505.16685-1-tangmeng@uniontech.com>
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

url:    https://github.com/0day-ci/linux/commits/tangmeng/kernel-time-move-timer-sysctls-to-its-own-file/20220128-145647
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 35e13e9da9afbce13c1d36465504ece4e65f24fe
config: arc-randconfig-r012-20220128 (https://download.01.org/0day-ci/archive/20220128/202201281620.Rwng44TW-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/5b925ed59a284ee735fd46cb2afa74858509887b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review tangmeng/kernel-time-move-timer-sysctls-to-its-own-file/20220128-145647
        git checkout 5b925ed59a284ee735fd46cb2afa74858509887b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/time/timer.c: In function 'init_timers':
>> kernel/time/timer.c:2047:9: error: implicit declaration of function 'timer_sysctl_init'; did you mean 'sysctl_init'? [-Werror=implicit-function-declaration]
    2047 |         timer_sysctl_init();
         |         ^~~~~~~~~~~~~~~~~
         |         sysctl_init
   In file included from include/linux/perf_event.h:25,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/time/timer.c:35:
   At top level:
   arch/arc/include/asm/perf_event.h:126:27: warning: 'arc_pmu_cache_map' defined but not used [-Wunused-const-variable=]
     126 | static const unsigned int arc_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
         |                           ^~~~~~~~~~~~~~~~~
   arch/arc/include/asm/perf_event.h:91:27: warning: 'arc_pmu_ev_hw_map' defined but not used [-Wunused-const-variable=]
      91 | static const char * const arc_pmu_ev_hw_map[] = {
         |                           ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +2047 kernel/time/timer.c

  2041	
  2042	void __init init_timers(void)
  2043	{
  2044		init_timer_cpus();
  2045		posix_cputimers_init_work();
  2046		open_softirq(TIMER_SOFTIRQ, run_timer_softirq);
> 2047		timer_sysctl_init();
  2048	}
  2049	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
