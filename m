Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DE04A37DE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jan 2022 18:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355723AbiA3RXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jan 2022 12:23:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:25423 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231483AbiA3RXr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jan 2022 12:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643563427; x=1675099427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z41kZajtIAnMiLyXovp+V7S7W4wvza+xH4q2uSbrxTY=;
  b=cB5KcEwvVWSaYFhNcrAHzEhgj+Q0FD+6LdXu9ehhtMmVVuL4k+5xjY0W
   Sd5o3fgBfy/WHnLBPuMHSXnytlC1TLunhlNOHSleTuQpeUBwAMaEywwV9
   GWHSIGb30RFjmfyeR08+CpkpbYocsgUq4g1kiwdJJDCIvrEyXvGe1kmD/
   ZnUvW45yXe4Ezh7PLWD3nlIQcb2TEd4Hp+cesiu9Wv9+AuDCp/z/mIG/P
   HEysGFzuW7RMyla+6PV5ymd/8KNEdhHblopAspoMuRZkDkDqO+r72wmGv
   FZyfh9bKUeStX42+HAx5wQ7+w29/JSje826x3VnbnrX5HMXK1+NIK5Ipk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="247581846"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="247581846"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 09:23:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="675540706"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jan 2022 09:23:44 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEDvU-000Qmg-48; Sun, 30 Jan 2022 17:23:44 +0000
Date:   Mon, 31 Jan 2022 01:23:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     tangmeng <tangmeng@uniontech.com>, tglx@linutronix.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        john.stultz@linaro.org, sboyd@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tangmeng <tangmeng@uniontech.com>
Subject: Re: [PATCH v3] kernel/time: move timer sysctls to its own file
Message-ID: <202201310156.2msV5y5H-lkp@intel.com>
References: <20220130151338.6533-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130151338.6533-1-tangmeng@uniontech.com>
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

url:    https://github.com/0day-ci/linux/commits/tangmeng/kernel-time-move-timer-sysctls-to-its-own-file/20220130-231458
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 35e13e9da9afbce13c1d36465504ece4e65f24fe
config: arc-randconfig-r013-20220130 (https://download.01.org/0day-ci/archive/20220131/202201310156.2msV5y5H-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/40476bc60525c2a3aeffa4af1080bf1c4bfb8f10
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review tangmeng/kernel-time-move-timer-sysctls-to-its-own-file/20220130-231458
        git checkout 40476bc60525c2a3aeffa4af1080bf1c4bfb8f10
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/time/timer.c: In function 'init_timers':
>> kernel/time/timer.c:2048:9: error: implicit declaration of function 'timer_sysctl_init'; did you mean 'sysctl_init'? [-Werror=implicit-function-declaration]
    2048 |         timer_sysctl_init();
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


vim +2048 kernel/time/timer.c

  2042	
  2043	void __init init_timers(void)
  2044	{
  2045		init_timer_cpus();
  2046		posix_cputimers_init_work();
  2047		open_softirq(TIMER_SOFTIRQ, run_timer_softirq);
> 2048		timer_sysctl_init();
  2049	}
  2050	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
