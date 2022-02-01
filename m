Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBEC4A54CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 02:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiBABzJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 20:55:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:11932 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231608AbiBABzI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 20:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643680508; x=1675216508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tP281LU5FVVTq81VC2aHBtQy8YHucSmLMeFGwR6GT1M=;
  b=HfGlVH/fRmbq8wcUjK79k5myD6taPW0bcbq2isOVAGaugNIysLVT4+F2
   HESkS+jwS2SlszwNqQSz6LADIYyqUzdS+HlqUSxIVexBgGqjHF4C7uBjW
   F/zM6WW15W/vpjpSjX0Cb/6GRk2nnwKi/XZx5NvcDCD2CQk1Ol3O7Q94v
   h8nvsbB2+d7hS+hS46/ooauN4f66rpvAPbZlmYw8cyKi5K6Aymqw/+lDg
   WrMLH47+zewTfrwtqX/2EKixA2aU8Joj/+3p6w2t4/sjRrO36AS/Z8i/J
   xgdCwK8J6MyOPg/eI8Vgy1xkCzf3tgNCXeU5xKjCHUKXjinhVbZafrgeI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="227577131"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="227577131"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 17:55:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="582880223"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 31 Jan 2022 17:55:06 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEiNt-000Sa7-CJ; Tue, 01 Feb 2022 01:55:05 +0000
Date:   Tue, 1 Feb 2022 09:54:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>
Cc:     kbuild-all@lists.01.org, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <liam.howlett@oracle.com>
Subject: Re: [PATCH 1/5] coredump: Move definition of struct coredump_params
 into coredump.h
Message-ID: <202202010957.uywEsvch-lkp@intel.com>
References: <875ypzoiae.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875ypzoiae.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi "Eric,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.17-rc2 next-20220131]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Eric-W-Biederman/coredump-Move-definition-of-struct-coredump_params-into-coredump-h/20220201-034653
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 26291c54e111ff6ba87a164d85d4a4e134b7315c
config: m68k-m5208evb_defconfig (https://download.01.org/0day-ci/archive/20220201/202202010957.uywEsvch-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/51661b08028418cf7e46f97d7e7dbee927cd61e0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Eric-W-Biederman/coredump-Move-definition-of-struct-coredump_params-into-coredump-h/20220201-034653
        git checkout 51661b08028418cf7e46f97d7e7dbee927cd61e0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:29,
                    from fs/binfmt_flat.c:21:
   fs/binfmt_flat.c: In function 'flat_core_dump':
>> fs/binfmt_flat.c:118:50: error: invalid use of undefined type 'struct coredump_params'
     118 |                 current->comm, current->pid, cprm->siginfo->si_signo);
         |                                                  ^~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:499:9: note: in expansion of macro 'printk'
     499 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   fs/binfmt_flat.c:117:9: note: in expansion of macro 'pr_warn'
     117 |         pr_warn("Process %s:%d received signr %d and should have core dumped\n",
         |         ^~~~~~~


vim +118 fs/binfmt_flat.c

^1da177e4c3f41 Linus Torvalds   2005-04-16  108  
^1da177e4c3f41 Linus Torvalds   2005-04-16  109  /****************************************************************************/
^1da177e4c3f41 Linus Torvalds   2005-04-16  110  /*
^1da177e4c3f41 Linus Torvalds   2005-04-16  111   * Routine writes a core dump image in the current directory.
^1da177e4c3f41 Linus Torvalds   2005-04-16  112   * Currently only a stub-function.
^1da177e4c3f41 Linus Torvalds   2005-04-16  113   */
^1da177e4c3f41 Linus Torvalds   2005-04-16  114  
f6151dfea21496 Masami Hiramatsu 2009-12-17  115  static int flat_core_dump(struct coredump_params *cprm)
^1da177e4c3f41 Linus Torvalds   2005-04-16  116  {
4adbb6ac4b807e Nicolas Pitre    2016-07-24  117  	pr_warn("Process %s:%d received signr %d and should have core dumped\n",
13c3f50c914e6a Nicolas Pitre    2016-07-24 @118  		current->comm, current->pid, cprm->siginfo->si_signo);
13c3f50c914e6a Nicolas Pitre    2016-07-24  119  	return 1;
^1da177e4c3f41 Linus Torvalds   2005-04-16  120  }
^1da177e4c3f41 Linus Torvalds   2005-04-16  121  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
