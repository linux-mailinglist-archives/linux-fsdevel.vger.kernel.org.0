Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BC84A55D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 05:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiBAEIV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 23:08:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:50378 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbiBAEIU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 23:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643688501; x=1675224501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/x7TOBX5uHS+20FJ041rft4SPIF/fKJuWpp9urRIQOk=;
  b=Iks4ocyNOlz8HOQNM3qWR972H1p1GjEyV9i+f30ZVfcD9aSNMFom6Ll0
   aydYHdkf/XE2OuENzITutfXrvsi937+l36mYJE+UKm8SoKBoFfma7LKZX
   wNo7LxF7+Bnzp9g1cHfWv4Ayfo2u4qZ09SyjOCmkmSMoLf/tUjQ7/4O7l
   ydfzB5LblVLbWgFGxX5A2uYT814JO7nUtmLdOuq8bg6t639sOF6qZh3U6
   Pjp4nyqrmTxaa8nTslS/2xD3lMVr/CmL8/WLQCv8OpySbN3gFa3zj5MsD
   yPJm0NmvWJh6AWtL3NTZ1Cl1J06hCCI85d7DMvexnDZj8OV53OUn/YtV3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="235009148"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="235009148"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 20:08:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="582900360"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 31 Jan 2022 20:08:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEkSl-000Sl1-Lc; Tue, 01 Feb 2022 04:08:15 +0000
Date:   Tue, 1 Feb 2022 12:07:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <liam.howlett@oracle.com>
Subject: Re: [PATCH 1/5] coredump: Move definition of struct coredump_params
 into coredump.h
Message-ID: <202202011230.eerL23uM-lkp@intel.com>
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
config: riscv-buildonly-randconfig-r005-20220131 (https://download.01.org/0day-ci/archive/20220201/202202011230.eerL23uM-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2cdbaca3943a4d6259119f185656328bd3805b68)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/51661b08028418cf7e46f97d7e7dbee927cd61e0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Eric-W-Biederman/coredump-Move-definition-of-struct-coredump_params-into-coredump-h/20220201-034653
        git checkout 51661b08028418cf7e46f97d7e7dbee927cd61e0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/binfmt_flat.c:118:36: error: incomplete definition of type 'struct coredump_params'
                   current->comm, current->pid, cprm->siginfo->si_signo);
                                                ~~~~^
   include/linux/printk.h:499:37: note: expanded from macro 'pr_warn'
           printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
                                              ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                              ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                                   ^~~~~~~~~~~
   include/linux/binfmts.h:11:8: note: forward declaration of 'struct coredump_params'
   struct coredump_params;
          ^
   1 error generated.


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
