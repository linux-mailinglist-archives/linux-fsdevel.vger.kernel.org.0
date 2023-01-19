Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AB8672DD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 02:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjASBGb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 20:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjASBGa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:06:30 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81E0611FF;
        Wed, 18 Jan 2023 17:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674090388; x=1705626388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BPmuKu3ALXclWFXWYEerlnT/WujFOtJ7HOkbe6NnTqc=;
  b=NeFTwucmzbT66JAoOXSispTexKqmB+nmEgKIr6PjIXDkHPvKYlIawsGv
   yPsHewROUXqQT9Eyjg19cTtVZ0hWcLBdkUmoMgn+UPetadXanAVsdkcIW
   rxlf5N5BifbCwhDFhHdyV0xROzFBKDxqAsBCTS9FfPy88MCmi3g3UR90J
   DTd55ryN695LZ/nlELRPyGuQekiF8V2XfNl+atsWT4MzEyg+61rYbUgFJ
   9M1pYea4bT5RlNdsuCFu3ysZwDOebhkVxVmm14rWzj95U7z+8DAdRC87J
   5GIKcrry2tOlTWfYQ/1mmUerCRJkgM+1KjZIDzbAIVMsFGMxPvThyI75M
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="308715844"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="308715844"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 17:06:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="767990286"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="767990286"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2023 17:06:24 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIJNn-0000vH-1h;
        Thu, 19 Jan 2023 01:06:23 +0000
Date:   Thu, 19 Jan 2023 09:06:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        oleg@redhat.com, ebiederm@xmission.com, akpm@linux-foundation.org,
        adobriyan@gmail.com, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 3/3] ptrace,syscall_user_dispatch: add a getter/setter
 for sud configuration
Message-ID: <202301190817.vjgEwo3J-lkp@intel.com>
References: <20230118201055.147228-4-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118201055.147228-4-gregory.price@memverge.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Gregory,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.2-rc4 next-20230118]
[cannot apply to tip/core/entry]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gregory-Price/ptrace-syscall_user_dispatch-Implement-Syscall-User-Dispatch-Suspension/20230119-041259
patch link:    https://lore.kernel.org/r/20230118201055.147228-4-gregory.price%40memverge.com
patch subject: [PATCH 3/3] ptrace,syscall_user_dispatch: add a getter/setter for sud configuration
config: sparc-buildonly-randconfig-r005-20230118 (https://download.01.org/0day-ci/archive/20230119/202301190817.vjgEwo3J-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bd6833b41ed48c444c09346f695efe229deec2e9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gregory-Price/ptrace-syscall_user_dispatch-Implement-Syscall-User-Dispatch-Suspension/20230119-041259
        git checkout bd6833b41ed48c444c09346f695efe229deec2e9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash arch/sparc/mm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/sched.h:31,
                    from include/linux/mm.h:28,
                    from arch/sparc/mm/tlb.c:9:
>> include/linux/syscall_user_dispatch.h:45:5: error: no previous prototype for 'syscall_user_dispatch_get_config' [-Werror=missing-prototypes]
      45 | int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/syscall_user_dispatch.h:51:5: error: no previous prototype for 'syscall_user_dispatch_set_config' [-Werror=missing-prototypes]
      51 | int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from include/linux/sched.h:31,
                    from arch/sparc/mm/init_64.c:11:
>> include/linux/syscall_user_dispatch.h:45:5: error: no previous prototype for 'syscall_user_dispatch_get_config' [-Werror=missing-prototypes]
      45 | int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/syscall_user_dispatch.h:51:5: error: no previous prototype for 'syscall_user_dispatch_set_config' [-Werror=missing-prototypes]
      51 | int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/sparc/mm/init_64.c: In function 'arch_hugetlb_valid_size':
   arch/sparc/mm/init_64.c:355:24: error: variable 'hv_pgsz_idx' set but not used [-Werror=unused-but-set-variable]
     355 |         unsigned short hv_pgsz_idx;
         |                        ^~~~~~~~~~~
   arch/sparc/mm/init_64.c: At top level:
   arch/sparc/mm/init_64.c:2630:6: error: no previous prototype for 'vmemmap_free' [-Werror=missing-prototypes]
    2630 | void vmemmap_free(unsigned long start, unsigned long end,
         |      ^~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/syscall_user_dispatch_get_config +45 include/linux/syscall_user_dispatch.h

    44	
  > 45	int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
    46		void __user *data)
    47	{
    48		return -EINVAL;
    49	}
    50	
  > 51	int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
    52		void __user *data)
    53	{
    54		return -EINVAL;
    55	}
    56	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
