Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A854A37C7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jan 2022 17:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355610AbiA3Qwt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jan 2022 11:52:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:58248 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355650AbiA3Qwr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jan 2022 11:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643561567; x=1675097567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JZACT/iyqB2JhN54jTXkwvGud6/ti13dN/JMDd1WVyA=;
  b=nttdoLp90qJ7fsZB0mBWd0hMalS8rxUJVM3tmXTpHexc+7DFUWoOkXF+
   BH/dYaKYN3iQCmJOI4gbzNFq8RfeCYfKOlE5ZzfQsPUJ1rFLmxzPuYjw0
   mx7DwMXn+NokM0Y2oImXnY7NA51tI7k1+Wgn2I3uDzOzA6vAXORCJcUvn
   QRybgX1zLnPvuhPw516+3y5x2PdsZ8RjYQkS7miqzGJ6320Pdr7CCTwoz
   8SBSFt2HUB7BNhv1tPWM69mgGZwm9jMSWnC0jl4p1lcjFZxUZpzOnbUu/
   kh078SqI59US+z5ucDjg9plkzeUcyi1YmSyy1v89B8EGSXftTw6gu8VbK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="244956608"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="244956608"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 08:52:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="770566800"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jan 2022 08:52:43 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEDRT-000Qkd-8u; Sun, 30 Jan 2022 16:52:43 +0000
Date:   Mon, 31 Jan 2022 00:52:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     tangmeng <tangmeng@uniontech.com>, tglx@linutronix.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        john.stultz@linaro.org, sboyd@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: Re: [PATCH v3] kernel/time: move timer sysctls to its own file
Message-ID: <202201310051.QnG1PthP-lkp@intel.com>
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
config: hexagon-randconfig-r045-20220130 (https://download.01.org/0day-ci/archive/20220131/202201310051.QnG1PthP-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f1c18acb07aa40f42b87b70462a6d1ab77a4825c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/40476bc60525c2a3aeffa4af1080bf1c4bfb8f10
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review tangmeng/kernel-time-move-timer-sysctls-to-its-own-file/20220130-231458
        git checkout 40476bc60525c2a3aeffa4af1080bf1c4bfb8f10
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/time/timer.c:2048:2: error: implicit declaration of function 'timer_sysctl_init' [-Werror,-Wimplicit-function-declaration]
           timer_sysctl_init();
           ^
   1 error generated.


vim +/timer_sysctl_init +2048 kernel/time/timer.c

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
