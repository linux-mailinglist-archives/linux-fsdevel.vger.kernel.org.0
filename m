Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCF7536644
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 19:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351525AbiE0RBx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 13:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240823AbiE0RBv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 13:01:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963B912FEFE;
        Fri, 27 May 2022 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653670910; x=1685206910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BdDeiQFwZ1xXaQfqDjb+Gm9LS0kjkErg8VaAhvHaTQU=;
  b=hfZu4QquL1V/601FjgmMz1UHY27znw7DBQHfAZf1oiA9MVEihUBex555
   8h4/dvMQxc/a4GfMynB0tLaRm+nHott31vkGYPdWvea4+8jlTEVX7+4p6
   j5vHwnHt6hirfbMvi6Y8D1qCjEpy4Z9xYPr8sX89OBj+EvxcUSGx49grH
   ngQjYlXzosUXdlUs1+tTfjU1wrhEoeX7UyCqcDcarkXpjpkBc4bAp6oVu
   oW9Q5mpRKxVaQaW0tZJ1VmeJR3jhqyZgIc6xEdyJtYzVf1nKJFoAbfRuF
   UkMsvZJSUo9+65b5RTKQSoW/2nrJmrOabKkqseCMvQTb7NuOK5m2Fgv4x
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="262146502"
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="262146502"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 10:01:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="528199319"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 May 2022 10:01:46 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nudLN-0004xh-M6;
        Fri, 27 May 2022 17:01:45 +0000
Date:   Sat, 28 May 2022 01:00:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhang Yuchen <zhangyuchen.lcr@bytedance.com>,
        akpm@linux-foundation.org, david@redhat.com, peterz@infradead.org,
        mingo@redhat.com, ast@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-api@vger.kernel.org, fam.zheng@bytedance.com,
        Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
Subject: Re: [PATCH] procfs: add syscall statistics
Message-ID: <202205280044.z43jIWts-lkp@intel.com>
References: <20220527110959.54559-1-zhangyuchen.lcr@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527110959.54559-1-zhangyuchen.lcr@bytedance.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Zhang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on next-20220527]
[cannot apply to akpm-mm/mm-everything arm64/for-next/core s390/features tip/x86/core v5.18]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhang-Yuchen/procfs-add-syscall-statistics/20220527-191241
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 7e284070abe53d448517b80493863595af4ab5f0
config: csky-randconfig-r002-20220526 (https://download.01.org/0day-ci/archive/20220528/202205280044.z43jIWts-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/979bf5b1b085588caab1cbdce55e40e823c12db9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zhang-Yuchen/procfs-add-syscall-statistics/20220527-191241
        git checkout 979bf5b1b085588caab1cbdce55e40e823c12db9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash arch/csky/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/csky/kernel/syscall_table.c:11:14: error: conflicting types for 'sys_call_table'; have 'void * const[451]'
      11 | void * const sys_call_table[__NR_syscalls] __page_aligned_data = {
         |              ^~~~~~~~~~~~~~
   In file included from include/linux/syscalls.h:89,
                    from arch/csky/kernel/syscall_table.c:4:
   arch/csky/include/asm/syscall.h:11:14: note: previous declaration of 'sys_call_table' with type 'void *[]'
      11 | extern void *sys_call_table[];
         |              ^~~~~~~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: warning: initialized field overwritten [-Woverride-init]
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:29:37: note: in expansion of macro '__SYSCALL'
      29 | #define __SC_COMP(_nr, _sys, _comp) __SYSCALL(_nr, _sys)
         |                                     ^~~~~~~~~
   include/uapi/asm-generic/unistd.h:34:1: note: in expansion of macro '__SC_COMP'
      34 | __SC_COMP(__NR_io_setup, sys_io_setup, compat_sys_io_setup)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: note: (near initialization for 'sys_call_table[0]')
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:29:37: note: in expansion of macro '__SYSCALL'
      29 | #define __SC_COMP(_nr, _sys, _comp) __SYSCALL(_nr, _sys)
         |                                     ^~~~~~~~~
   include/uapi/asm-generic/unistd.h:34:1: note: in expansion of macro '__SC_COMP'
      34 | __SC_COMP(__NR_io_setup, sys_io_setup, compat_sys_io_setup)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: warning: initialized field overwritten [-Woverride-init]
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:36:1: note: in expansion of macro '__SYSCALL'
      36 | __SYSCALL(__NR_io_destroy, sys_io_destroy)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: note: (near initialization for 'sys_call_table[1]')
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:36:1: note: in expansion of macro '__SYSCALL'
      36 | __SYSCALL(__NR_io_destroy, sys_io_destroy)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: warning: initialized field overwritten [-Woverride-init]
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:29:37: note: in expansion of macro '__SYSCALL'
      29 | #define __SC_COMP(_nr, _sys, _comp) __SYSCALL(_nr, _sys)
         |                                     ^~~~~~~~~
   include/uapi/asm-generic/unistd.h:38:1: note: in expansion of macro '__SC_COMP'
      38 | __SC_COMP(__NR_io_submit, sys_io_submit, compat_sys_io_submit)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: note: (near initialization for 'sys_call_table[2]')
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:29:37: note: in expansion of macro '__SYSCALL'
      29 | #define __SC_COMP(_nr, _sys, _comp) __SYSCALL(_nr, _sys)
         |                                     ^~~~~~~~~
   include/uapi/asm-generic/unistd.h:38:1: note: in expansion of macro '__SC_COMP'
      38 | __SC_COMP(__NR_io_submit, sys_io_submit, compat_sys_io_submit)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: warning: initialized field overwritten [-Woverride-init]
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:40:1: note: in expansion of macro '__SYSCALL'
      40 | __SYSCALL(__NR_io_cancel, sys_io_cancel)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: note: (near initialization for 'sys_call_table[3]')
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:40:1: note: in expansion of macro '__SYSCALL'
      40 | __SYSCALL(__NR_io_cancel, sys_io_cancel)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: warning: initialized field overwritten [-Woverride-init]
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:20:34: note: in expansion of macro '__SYSCALL'
      20 | #define __SC_3264(_nr, _32, _64) __SYSCALL(_nr, _32)
         |                                  ^~~~~~~~~
   include/uapi/asm-generic/unistd.h:43:1: note: in expansion of macro '__SC_3264'
      43 | __SC_3264(__NR_io_getevents, sys_io_getevents_time32, sys_io_getevents)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: note: (near initialization for 'sys_call_table[4]')
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:20:34: note: in expansion of macro '__SYSCALL'
      20 | #define __SC_3264(_nr, _32, _64) __SYSCALL(_nr, _32)
         |                                  ^~~~~~~~~
   include/uapi/asm-generic/unistd.h:43:1: note: in expansion of macro '__SC_3264'
      43 | __SC_3264(__NR_io_getevents, sys_io_getevents_time32, sys_io_getevents)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: warning: initialized field overwritten [-Woverride-init]
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:48:1: note: in expansion of macro '__SYSCALL'
      48 | __SYSCALL(__NR_setxattr, sys_setxattr)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: note: (near initialization for 'sys_call_table[5]')
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:48:1: note: in expansion of macro '__SYSCALL'
      48 | __SYSCALL(__NR_setxattr, sys_setxattr)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: warning: initialized field overwritten [-Woverride-init]
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^


vim +11 arch/csky/kernel/syscall_table.c

4859bfca11c7d6 Guo Ren 2018-09-05   9  
4859bfca11c7d6 Guo Ren 2018-09-05  10  #define sys_fadvise64_64 sys_csky_fadvise64_64
4859bfca11c7d6 Guo Ren 2018-09-05 @11  void * const sys_call_table[__NR_syscalls] __page_aligned_data = {

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
