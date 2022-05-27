Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA401536408
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 16:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353196AbiE0OYM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 10:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbiE0OYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 10:24:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E615C1207E4;
        Fri, 27 May 2022 07:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653661449; x=1685197449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8EpuGnusmRkbVa3/ggOWrpg5luflE/dlqIUDi652zT4=;
  b=LQvWsZtuLPjcvRpFj3BPgWw2/cmVdWKJy/SQqWGpWi3jLlrpinOzXNzC
   Gvl8pwkHv8noz+d/+ME3aBextokGjzIVdD1eS6PY8XQW4LEp02+KN5RYV
   uIGzh0QtzG9XjywzU1K3Ob9z7bViAXOh/N4ertSKqx1pCnr5/EZwNZbkG
   fVF4xd07OagOioefHI7rPtkVDlFtA0e+G4ftFP4bAZ7NBwQSmX/XUtKf4
   oJCxrx3FfV40TXaeotFgiJx1ND/qS1NjJGQxZl39JN4lkrAtwOpVhA+Zx
   XU7/NdhEbpys8m9beGf3n1AqzPaexpy1QBNy5ks5XWBjhJFcihxuzmg4k
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="360878303"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="360878303"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 07:24:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="574857026"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 May 2022 07:24:06 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuasn-0004qu-Bg;
        Fri, 27 May 2022 14:24:05 +0000
Date:   Fri, 27 May 2022 22:23:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhang Yuchen <zhangyuchen.lcr@bytedance.com>,
        akpm@linux-foundation.org, david@redhat.com, mingo@redhat.com,
        ast@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-api@vger.kernel.org, fam.zheng@bytedance.com,
        Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
Subject: Re: [PATCH] procfs: add syscall statistics
Message-ID: <202205272216.w7dE4biW-lkp@intel.com>
References: <20220527110959.54559-1-zhangyuchen.lcr@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527110959.54559-1-zhangyuchen.lcr@bytedance.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Zhang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on next-20220527]
[cannot apply to akpm-mm/mm-everything arm64/for-next/core s390/features tip/x86/core v5.18]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhang-Yuchen/procfs-add-syscall-statistics/20220527-191241
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 7e284070abe53d448517b80493863595af4ab5f0
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220527/202205272216.w7dE4biW-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/979bf5b1b085588caab1cbdce55e40e823c12db9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zhang-Yuchen/procfs-add-syscall-statistics/20220527-191241
        git checkout 979bf5b1b085588caab1cbdce55e40e823c12db9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/proc/syscall.c:13:5: warning: no previous prototype for 'show_syscalls' [-Wmissing-prototypes]
      13 | int show_syscalls(struct seq_file *p, void *v)
         |     ^~~~~~~~~~~~~


vim +/show_syscalls +13 fs/proc/syscall.c

    12	
  > 13	int show_syscalls(struct seq_file *p, void *v)
    14	{
    15		int i = *(loff_t *)v, j;
    16		static int prec;
    17		const char *syscall_name = get_syscall_name(i);
    18	
    19		if (i > NR_syscalls)
    20			return 0;
    21	
    22		/* print header and calculate the width of the first column */
    23		if (i == 0) {
    24			for (prec = 3, j = 1000; prec < 10 && j <= NR_syscalls; ++prec)
    25				j *= 10;
    26			seq_printf(p, "%*s", prec + 8, "");
    27			for_each_online_cpu(j)
    28				seq_printf(p, "CPU%-8d", j);
    29			seq_putc(p, '\n');
    30		}
    31	
    32		if (syscall_name == NULL)
    33			return 0;
    34	
    35		seq_printf(p, "%*d: ", prec, i);
    36		for_each_online_cpu(j)
    37			seq_printf(p, "%10llu ",
    38				   per_cpu(__per_cpu_syscall_count, j)[i]);
    39		seq_printf(p, "  %s", syscall_name);
    40		seq_putc(p, '\n');
    41	
    42		return 0;
    43	}
    44	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
