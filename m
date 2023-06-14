Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D3B72F816
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 10:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243701AbjFNIma (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 04:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243693AbjFNIm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:42:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A901AE4D;
        Wed, 14 Jun 2023 01:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686732146; x=1718268146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zJouC6bmMjLkzEvp7C/K2kpaga55aPlidd5musYLcrw=;
  b=l01O/CNgHNVkKXM0/xJ0HkgzSt8aSyy3FxAFioy0eWlLFOv+V5Hc6XZ2
   iCtq08GDUovnISJGBeTdtZeWnQqsC6AcgRyTtgQgHIV0n+GnnXuDjBkt1
   jSRfy6bFbbXAn/yHr6tuynIClaYokZpJUdaIlr/5BZBJji6VasbLyCFJx
   73meGDRXMx8GotFem0Y2PrFlqv54Mh6Qtvwm0ebwGQK/yiJ5Lkpkz9TKX
   L8gRgnyHLJFJ00lt/rlKZyhZwtUkYtZLCQX6b8qwgnGXB82w19lpR+F0b
   iey8K6RbDk5sM8+TcSC5l4taHgRH/weh8UkWoYtcoHqVUcNiVOAjH5N9e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="338910636"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="338910636"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 01:42:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="856426084"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="856426084"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jun 2023 01:42:23 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9M58-0000RX-2B;
        Wed, 14 Jun 2023 08:42:22 +0000
Date:   Wed, 14 Jun 2023 16:42:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wei Chin Tsai <Wei-chin.Tsai@mediatek.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        wsd_upstream@mediatek.com, wei-chin.tsai@mediatek.com,
        mel.lee@mediatek.com, ivan.tseng@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 2/3] memory: export symbols for memory related
 functions
Message-ID: <202306141630.EQtwoD5V-lkp@intel.com>
References: <20230614032038.11699-3-Wei-chin.Tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614032038.11699-3-Wei-chin.Tsai@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Wei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.4-rc6 next-20230613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Chin-Tsai/kernel-process-fork-exit-export-symbol-for-fork-exit-tracing-functions/20230614-112218
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20230614032038.11699-3-Wei-chin.Tsai%40mediatek.com
patch subject: [PATCH v2 2/3] memory: export symbols for memory related functions
config: hexagon-randconfig-r041-20230612 (https://download.01.org/0day-ci/archive/20230614/202306141630.EQtwoD5V-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add char-misc https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
        git fetch char-misc char-misc-testing
        git checkout char-misc/char-misc-testing
        b4 shazam https://lore.kernel.org/r/20230614032038.11699-3-Wei-chin.Tsai@mediatek.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/proc/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306141630.EQtwoD5V-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/proc/task_mmu.c:3:
   In file included from include/linux/mm_inline.h:7:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from fs/proc/task_mmu.c:3:
   In file included from include/linux/mm_inline.h:7:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from fs/proc/task_mmu.c:3:
   In file included from include/linux/mm_inline.h:7:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> fs/proc/task_mmu.c:776:6: warning: no previous prototype for function 'smap_gather_stats' [-Wmissing-prototypes]
     776 | void smap_gather_stats(struct vm_area_struct *vma,
         |      ^
   fs/proc/task_mmu.c:776:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     776 | void smap_gather_stats(struct vm_area_struct *vma,
         | ^
         | static 
   7 warnings generated.


vim +/smap_gather_stats +776 fs/proc/task_mmu.c

   769	
   770	/*
   771	 * Gather mem stats from @vma with the indicated beginning
   772	 * address @start, and keep them in @mss.
   773	 *
   774	 * Use vm_start of @vma as the beginning address if @start is 0.
   775	 */
 > 776	void smap_gather_stats(struct vm_area_struct *vma,
   777			       struct mem_size_stats *mss, unsigned long start)
   778	{
   779		const struct mm_walk_ops *ops = &smaps_walk_ops;
   780	
   781		/* Invalid start */
   782		if (start >= vma->vm_end)
   783			return;
   784	
   785		if (vma->vm_file && shmem_mapping(vma->vm_file->f_mapping)) {
   786			/*
   787			 * For shared or readonly shmem mappings we know that all
   788			 * swapped out pages belong to the shmem object, and we can
   789			 * obtain the swap value much more efficiently. For private
   790			 * writable mappings, we might have COW pages that are
   791			 * not affected by the parent swapped out pages of the shmem
   792			 * object, so we have to distinguish them during the page walk.
   793			 * Unless we know that the shmem object (or the part mapped by
   794			 * our VMA) has no swapped out pages at all.
   795			 */
   796			unsigned long shmem_swapped = shmem_swap_usage(vma);
   797	
   798			if (!start && (!shmem_swapped || (vma->vm_flags & VM_SHARED) ||
   799						!(vma->vm_flags & VM_WRITE))) {
   800				mss->swap += shmem_swapped;
   801			} else {
   802				ops = &smaps_shmem_walk_ops;
   803			}
   804		}
   805	
   806		/* mmap_lock is held in m_start */
   807		if (!start)
   808			walk_page_vma(vma, ops, mss);
   809		else
   810			walk_page_range(vma->vm_mm, start, vma->vm_end, ops, mss);
   811	}
   812	EXPORT_SYMBOL_GPL(smap_gather_stats);
   813	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
