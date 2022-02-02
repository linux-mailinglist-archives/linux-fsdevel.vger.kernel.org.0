Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9084A4A69FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 03:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243838AbiBBCk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 21:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiBBCk1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:40:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37EBC061714;
        Tue,  1 Feb 2022 18:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E/DYkJcqiKd/IrHJwhT2qRCg8TBxS2l30y/78Ai/o68=; b=sBY6DGY4k1yUN0tYd7ADcg5yck
        MtIq2bWMGIcbug4tiGEi3ROqA4nPx79oSq3hLG3jPsMz3wp6k2ZCxc6qtTklT1niFzkV0Nyo/9WQx
        41MXOWe8+wqt8eEElNVfzR0wryKaApvm16Nfm4FKuz2JEEhuEyqm/06Kf0wrv6Bzf8D58ZqAiGKwi
        qN9A+JDxpOPA7NRZY4eu+X9+0rH+ekjj7e1nHgRvcYLI3UXQEq90Q0mFy6LAFYJNWUCNjShFIADuy
        amXc4z0WoJh52GeFGsZwYS6cvSjl6R0ONCk5rnmRI8F6UqJehXOWPMW+7ClHZXtKn4SnX59ogz5jN
        BUpiClag==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nF5ZD-00DzuD-QP; Wed, 02 Feb 2022 02:40:19 +0000
Date:   Tue, 1 Feb 2022 18:40:19 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     tangmeng <tangmeng@uniontech.com>, tglx@linutronix.de,
        keescook@chromium.org, yzaikin@google.com, john.stultz@linaro.org,
        sboyd@kernel.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/time: move timer sysctls to its own file
Message-ID: <YfnvE9rPffDb4JHy@bombadil.infradead.org>
References: <20220128085106.27031-1-tangmeng@uniontech.com>
 <202201290325.Jyor2i8O-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201290325.Jyor2i8O-lkp@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These complaints are using and assuming and older kernel.

 Luis

On Sat, Jan 29, 2022 at 05:03:38AM +0800, kernel test robot wrote:
> Hi tangmeng,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on tip/timers/core]
> [also build test ERROR on linus/master kees/for-next/pstore v5.17-rc1 next-20220128]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/tangmeng/kernel-time-move-timer-sysctls-to-its-own-file/20220128-165225
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 35e13e9da9afbce13c1d36465504ece4e65f24fe
> config: arm64-randconfig-r026-20220127 (https://download.01.org/0day-ci/archive/20220129/202201290325.Jyor2i8O-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/8bd44d33085f8ab50523016cbdb0c918dc4b4f3c
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review tangmeng/kernel-time-move-timer-sysctls-to-its-own-file/20220128-165225
>         git checkout 8bd44d33085f8ab50523016cbdb0c918dc4b4f3c
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash kernel/time/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/time/timer.c: In function 'timer_sysctl_init':
> >> kernel/time/timer.c:283:9: error: implicit declaration of function 'register_sysctl_init'; did you mean 'timer_sysctl_init'? [-Werror=implicit-function-declaration]
>      283 |         register_sysctl_init("kerneli/timer", timer_sysctl);
>          |         ^~~~~~~~~~~~~~~~~~~~
>          |         timer_sysctl_init
>    cc1: some warnings being treated as errors
> 
> 
> vim +283 kernel/time/timer.c
> 
>    280	
>    281	static int __init timer_sysctl_init(void)
>    282	{
>  > 283		register_sysctl_init("kerneli/timer", timer_sysctl);
>    284		return 0;
>    285	}
>    286	#else
>    287	#define timer_sysctl_init() do { } while (0)
>    288	#endif
>    289	static inline bool is_timers_nohz_active(void)
>    290	{
>    291		return static_branch_unlikely(&timers_nohz_active);
>    292	}
>    293	#else
>    294	static inline bool is_timers_nohz_active(void) { return false; }
>    295	#endif /* NO_HZ_COMMON */
>    296	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
