Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4C46D5472
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 00:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjDCWEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 18:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjDCWEF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:04:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2493D44A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 15:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680559427; x=1712095427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aE4erBFDQ9k50cdEZopS3gU8PItFGlNZIOx7Pl8Nlzw=;
  b=SV141uPcmvGY0PHNetVrYoFIxg4SBLP/ljCz/PTOyWpvLgGvm5AQhmwg
   AF5BOUYQC4MkHQ1InjCvdXMu91gvq256dxVFGXpweOq68iva9hrG2Wokw
   kRmqasqaIyjFxjYg092UuW2yRdpbvO2MobyF1sVkVSKG2xYW4rtZJsXhX
   PyCjVq8/9iZJMvMzYdi8qeV8AHp6L/79RdPTDcW99JTjVd4kX8rfRWfpS
   mtSYklD55G6WBSDoxofuLTnYF1VI76zNPKTGewRH29BHirLU2pl5zG1a1
   kIDKM5igkzO8YyQuqPEUBX9Q/VbCcYc2xhsSaXBALZS183+C7Kxnlgxim
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="342051932"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="342051932"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 15:03:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="718696058"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="718696058"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Apr 2023 15:03:43 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjSH8-000Oru-34;
        Mon, 03 Apr 2023 22:03:42 +0000
Date:   Tue, 4 Apr 2023 06:03:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     cem@kernel.org, hughd@google.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jack@suse.cz,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org
Subject: Re: [PATCH 5/6] shmem: quota support
Message-ID: <202304040523.Z5vLqfkr-lkp@intel.com>
References: <20230403084759.884681-6-cem@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403084759.884681-6-cem@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.3-rc5]
[cannot apply to akpm-mm/mm-everything next-20230403]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/cem-kernel-org/shmem-make-shmem_inode_acct_block-return-error/20230403-165022
patch link:    https://lore.kernel.org/r/20230403084759.884681-6-cem%40kernel.org
patch subject: [PATCH 5/6] shmem: quota support
config: hexagon-randconfig-r045-20230403 (https://download.01.org/0day-ci/archive/20230404/202304040523.Z5vLqfkr-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e060b9e86fd92d5e87f5b0c447e4bc610a3d3bbe
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review cem-kernel-org/shmem-make-shmem_inode_acct_block-return-error/20230403-165022
        git checkout e060b9e86fd92d5e87f5b0c447e4bc610a3d3bbe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304040523.Z5vLqfkr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from mm/shmem.c:29:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from mm/shmem.c:29:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from mm/shmem.c:29:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> mm/shmem.c:4252:1: warning: unused label 'out3' [-Wunused-label]
   out3:
   ^~~~~
   mm/shmem.c:1534:20: warning: unused function 'shmem_show_mpol' [-Wunused-function]
   static inline void shmem_show_mpol(struct seq_file *seq, struct mempolicy *mpol)
                      ^
   8 warnings generated.


vim +/out3 +4252 mm/shmem.c

  4224	
  4225		error = register_filesystem(&shmem_fs_type);
  4226		if (error) {
  4227			pr_err("Could not register tmpfs\n");
  4228			goto out2;
  4229		}
  4230	
  4231		shm_mnt = kern_mount(&shmem_fs_type);
  4232		if (IS_ERR(shm_mnt)) {
  4233			error = PTR_ERR(shm_mnt);
  4234			pr_err("Could not kern_mount tmpfs\n");
  4235			goto out1;
  4236		}
  4237	
  4238	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
  4239		if (has_transparent_hugepage() && shmem_huge > SHMEM_HUGE_DENY)
  4240			SHMEM_SB(shm_mnt->mnt_sb)->huge = shmem_huge;
  4241		else
  4242			shmem_huge = SHMEM_HUGE_NEVER; /* just in case it was patched */
  4243	#endif
  4244		return;
  4245	
  4246	out1:
  4247		unregister_filesystem(&shmem_fs_type);
  4248	out2:
  4249	#ifdef CONFIG_TMPFS_QUOTA
  4250		unregister_quota_format(&shmem_quota_format);
  4251	#endif
> 4252	out3:
  4253		shmem_destroy_inodecache();
  4254		shm_mnt = ERR_PTR(error);
  4255	}
  4256	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
