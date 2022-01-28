Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4F849F5E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 10:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbiA1JGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 04:06:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:12610 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231806AbiA1JGJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643360769; x=1674896769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AiHV+Hg/X7fIRO65fl2bhp054IVzZkdbb+vKsLN50GA=;
  b=BxyxGGjGFZbQ9qaFdHTDL4nPBhrFnVNvV2e5/5lIuGo2WKWi3NNwFui3
   YJKIcBCoBTezH41cwagzgTUYkujTYS5WgUBJQWnjmP5erHUJMOUo0Ia3H
   PpTm07fIlgj2zhN/2Gjjy6b59lJLv4m+D1raOm6X1I1ZSdKdIa2ng3/e8
   yTv+sHmKgbzZwECO2EiRJJl1JUA0NH9e87u+iHhtc7KUOoIa24tHMq20R
   SUmIEUxoAds3FNyU9iIiXvGVERPbjeyVQ/ngEP+5AYI0G0kGLsmHrUhXN
   fUyadU5JTKIpfGJU8TQUiLjEpzpCxn3p0neprBWps6JQeaatyXbuFCaWR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="247029823"
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="247029823"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 01:06:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="521623732"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Jan 2022 01:06:07 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDNCo-000NgI-H5; Fri, 28 Jan 2022 09:06:06 +0000
Date:   Fri, 28 Jan 2022 17:05:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     tangmeng <tangmeng@uniontech.com>, tglx@linutronix.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        john.stultz@linaro.org, sboyd@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: Re: [PATCH] kernel/time: move timer sysctls to its own file
Message-ID: <202201281650.adOMvtOO-lkp@intel.com>
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
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20220128/202201281650.adOMvtOO-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/5b925ed59a284ee735fd46cb2afa74858509887b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review tangmeng/kernel-time-move-timer-sysctls-to-its-own-file/20220128-145647
        git checkout 5b925ed59a284ee735fd46cb2afa74858509887b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/time/timer.c:2047:2: error: implicit declaration of function 'timer_sysctl_init' [-Werror,-Wimplicit-function-declaration]
           timer_sysctl_init();
           ^
   1 error generated.


vim +/timer_sysctl_init +2047 kernel/time/timer.c

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
