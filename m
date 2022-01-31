Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEB74A3F90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 10:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242142AbiAaJyV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 04:54:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:52494 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232052AbiAaJyU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:54:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643622860; x=1675158860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dGdu6BNETMJJIPnryMKcNJujVe5VAQ7gKMhy5tod+K4=;
  b=VpSj/tgKxQStUEWM1itgyWi397pnub4JBHGZy/GOipfuz1zQU4B1KvTL
   v8jCkzpJmtCeZvXkw1RI86xNRfdyvBoZxeAKx4f4aijhGPn2qLGEuDN6s
   /AvrRKxbCGrkXSTpSCg1gm5g8UJ84Be/aIoS7Z4I09bd9z4nwcQag/44b
   po4tE6HoGEAnr5InrjSiaytEGUgHpwoqodMpGj0TQfKUtTE3VKSvcCHHb
   ZDIzDXcqOxXDoFYfc+R0RgTj/rRAvbbe9asC3WZZbw7FImOPpN+PdcPT+
   0mVTkmyJBTX1LJTV/XLu0sE4UtM/cct5eaQNaqt82kV8SYicA1nSTWJdp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="310741459"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="310741459"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 01:54:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="629956376"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 31 Jan 2022 01:54:17 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nETO5-000Rki-7a; Mon, 31 Jan 2022 09:54:17 +0000
Date:   Mon, 31 Jan 2022 17:53:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     tangmeng <tangmeng@uniontech.com>, tglx@linutronix.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        john.stultz@linaro.org, sboyd@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tangmeng <tangmeng@uniontech.com>
Subject: Re: [PATCH v4] kernel/time: move timer sysctls to its own file
Message-ID: <202201311703.8ZHlxEUI-lkp@intel.com>
References: <20220131065728.6823-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131065728.6823-1-tangmeng@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi tangmeng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/timers/core]
[also build test ERROR on linus/master kees/for-next/pstore v5.17-rc2 next-20220128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/tangmeng/kernel-time-move-timer-sysctls-to-its-own-file/20220131-145847
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 35e13e9da9afbce13c1d36465504ece4e65f24fe
config: arc-randconfig-r043-20220131 (https://download.01.org/0day-ci/archive/20220131/202201311703.8ZHlxEUI-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/f32d255b81d227c1491a06a5d7b016eb9bd54087
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review tangmeng/kernel-time-move-timer-sysctls-to-its-own-file/20220131-145847
        git checkout f32d255b81d227c1491a06a5d7b016eb9bd54087
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
