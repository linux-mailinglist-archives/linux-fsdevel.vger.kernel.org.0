Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A3C4A5C25
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 13:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbiBAMYk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 07:24:40 -0500
Received: from mga01.intel.com ([192.55.52.88]:7560 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232944AbiBAMYj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643718279; x=1675254279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qy/S5Wg+GNTNM50gTtSk1KLN3h4xh4PZO5YQLecJvYk=;
  b=l1q6Ltaw68192TLkcmDvXvRZRcGtQZvsyD9t/ROFIBRjcc72J6/htPHt
   xTZcFj5mzydfat3tbVmY+KkM4YyS17Bpjzu3iXUrzlJTjL1w7dE0YKHko
   lh0gEq1gbuGYNfm0JdCWxxzPBhZ3OvNg2To/TV0SGCHJQK41CN60PLG0n
   aFSnO1H2iySkgLBtfCZxK1AuMt9TsXIc5XvtYf0m25s6qi0PAcrjkTAjC
   3RRWM1hVNg2sUMsXqpSIG8de3VfsZjuWZk6Lta3KcWRYzjHyl6eUqjnXx
   5Xpgk1+wdU1as0A8xfF68pNA0d70+YuKKC45Yh4ssPjOH4579vqkuXoAW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="272156525"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="272156525"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 04:24:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="583014028"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Feb 2022 04:24:37 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEsD6-000TFr-JD; Tue, 01 Feb 2022 12:24:36 +0000
Date:   Tue, 1 Feb 2022 20:24:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     tangmeng <tangmeng@uniontech.com>, tglx@linutronix.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        john.stultz@linaro.org, sboyd@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tangmeng <tangmeng@uniontech.com>
Subject: Re: [PATCH v5] kernel/time: move timer sysctls to its own file
Message-ID: <202202012049.OHxc9ybu-lkp@intel.com>
References: <20220131102214.2284-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131102214.2284-1-tangmeng@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi tangmeng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/timers/core]
[also build test ERROR on linus/master kees/for-next/pstore v5.17-rc2 next-20220131]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/tangmeng/kernel-time-move-timer-sysctls-to-its-own-file/20220131-182433
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 35e13e9da9afbce13c1d36465504ece4e65f24fe
config: arc-randconfig-r043-20220131 (https://download.01.org/0day-ci/archive/20220201/202202012049.OHxc9ybu-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c54967d83b26ebacf4a1b686c6b659150b73306c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review tangmeng/kernel-time-move-timer-sysctls-to-its-own-file/20220131-182433
        git checkout c54967d83b26ebacf4a1b686c6b659150b73306c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/time/timer.c: In function 'timer_sysctl_init':
>> kernel/time/timer.c:284:9: error: implicit declaration of function 'register_sysctl_init'; did you mean 'timer_sysctl_init'? [-Werror=implicit-function-declaration]
     284 |         register_sysctl_init("kernel", timer_sysctl);
         |         ^~~~~~~~~~~~~~~~~~~~
         |         timer_sysctl_init
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


vim +284 kernel/time/timer.c

   281	
   282	static int __init timer_sysctl_init(void)
   283	{
 > 284		register_sysctl_init("kernel", timer_sysctl);
   285		return 0;
   286	}
   287	__initcall(timer_sysctl_init);
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
