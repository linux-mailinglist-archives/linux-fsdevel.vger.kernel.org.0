Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DE66C4898
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 12:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCVLHm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 07:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjCVLHl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:07:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C026231D;
        Wed, 22 Mar 2023 04:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679483259; x=1711019259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P2mPW/WRUDwJB8jKQQeQja24bidu3yN8jymHDJ02YSM=;
  b=JsncLSxclOu8LbEkWhdStJ5fFjlGn5DcK6aVO9S42DLVo0/ZD3yLxSJc
   zIt8/xkTUElMkofnFoEzXK6kYToyyF9cs7Af8OpVZhHGfsewB3+nEjR14
   nOup+RKknlfAViE8c/EM9WaXbPNHBP2vs2wYDOnQAUWQxSls8QCjgj91o
   BSlDKetfabmpo8QHSBSJiva6GraSuUtUlVnURtP5d2zhch3NfoMh1ugzb
   EkwJ4qzUuPlKKnoOItxbQ24U70GnHfEBA8cbrAKfOn84boIsFHLe/vsZ8
   w9oqFOfOI+0hQv0XLd5LPiKXwdqkK0albmGlGb9gSp4Hyhasrt+F//h2Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="339224441"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="339224441"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 04:07:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="750992316"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="750992316"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2023 04:07:34 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pewJZ-000DDQ-27;
        Wed, 22 Mar 2023 11:07:33 +0000
Date:   Wed, 22 Mar 2023 19:07:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        viro@zeniv.linux.org.uk
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] fs/buffer: Remove redundant assignment to err
Message-ID: <202303221812.QiRW1CXX-lkp@intel.com>
References: <20230322065949.29223-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322065949.29223-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jiapeng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on vfs-idmapping/for-next]
[also build test WARNING on linus/master v6.3-rc3 next-20230322]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiapeng-Chong/fs-buffer-Remove-redundant-assignment-to-err/20230322-150022
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git for-next
patch link:    https://lore.kernel.org/r/20230322065949.29223-1-jiapeng.chong%40linux.alibaba.com
patch subject: [PATCH] fs/buffer: Remove redundant assignment to err
config: hexagon-randconfig-r036-20230322 (https://download.01.org/0day-ci/archive/20230322/202303221812.QiRW1CXX-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3e00c2b4797c228b1939a15506c9ab807d0fa809
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jiapeng-Chong/fs-buffer-Remove-redundant-assignment-to-err/20230322-150022
        git checkout 3e00c2b4797c228b1939a15506c9ab807d0fa809
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303221812.QiRW1CXX-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/buffer.c:24:
   In file included from include/linux/syscalls.h:88:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
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
   In file included from fs/buffer.c:24:
   In file included from include/linux/syscalls.h:88:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
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
   In file included from fs/buffer.c:24:
   In file included from include/linux/syscalls.h:88:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
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
>> fs/buffer.c:2639:1: warning: unused label 'out' [-Wunused-label]
   out:
   ^~~~
   fs/buffer.c:2282:5: warning: stack frame size (2144) exceeds limit (1024) in 'block_read_full_folio' [-Wframe-larger-than]
   int block_read_full_folio(struct folio *folio, get_block_t *get_block)
       ^
   79/2144 (3.68%) spills, 2065/2144 (96.32%) variables
   8 warnings generated.


vim +/out +2639 fs/buffer.c

^1da177e4c3f41 Linus Torvalds     2005-04-16  2572  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2573  int block_truncate_page(struct address_space *mapping,
^1da177e4c3f41 Linus Torvalds     2005-04-16  2574  			loff_t from, get_block_t *get_block)
^1da177e4c3f41 Linus Torvalds     2005-04-16  2575  {
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  2576  	pgoff_t index = from >> PAGE_SHIFT;
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  2577  	unsigned offset = from & (PAGE_SIZE-1);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2578  	unsigned blocksize;
54b21a7992a31d Andrew Morton      2006-01-08  2579  	sector_t iblock;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2580  	unsigned length, pos;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2581  	struct inode *inode = mapping->host;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2582  	struct page *page;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2583  	struct buffer_head *bh;
3e00c2b4797c22 Jiapeng Chong      2023-03-22  2584  	int err = 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2585  
93407472a21b82 Fabian Frederick   2017-02-27  2586  	blocksize = i_blocksize(inode);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2587  	length = offset & (blocksize - 1);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2588  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2589  	/* Block boundary? Nothing to do */
^1da177e4c3f41 Linus Torvalds     2005-04-16  2590  	if (!length)
^1da177e4c3f41 Linus Torvalds     2005-04-16  2591  		return 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2592  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2593  	length = blocksize - length;
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  2594  	iblock = (sector_t)index << (PAGE_SHIFT - inode->i_blkbits);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2595  	
^1da177e4c3f41 Linus Torvalds     2005-04-16  2596  	page = grab_cache_page(mapping, index);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2597  	if (!page)
3e00c2b4797c22 Jiapeng Chong      2023-03-22  2598  		return -ENOMEM;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2599  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2600  	if (!page_has_buffers(page))
^1da177e4c3f41 Linus Torvalds     2005-04-16  2601  		create_empty_buffers(page, blocksize, 0);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2602  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2603  	/* Find the buffer that contains "offset" */
^1da177e4c3f41 Linus Torvalds     2005-04-16  2604  	bh = page_buffers(page);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2605  	pos = blocksize;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2606  	while (offset >= pos) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  2607  		bh = bh->b_this_page;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2608  		iblock++;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2609  		pos += blocksize;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2610  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  2611  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2612  	if (!buffer_mapped(bh)) {
b0cf2321c65991 Badari Pulavarty   2006-03-26  2613  		WARN_ON(bh->b_size != blocksize);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2614  		err = get_block(inode, iblock, bh, 0);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2615  		if (err)
^1da177e4c3f41 Linus Torvalds     2005-04-16  2616  			goto unlock;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2617  		/* unmapped? It's a hole - nothing to do */
^1da177e4c3f41 Linus Torvalds     2005-04-16  2618  		if (!buffer_mapped(bh))
^1da177e4c3f41 Linus Torvalds     2005-04-16  2619  			goto unlock;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2620  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  2621  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2622  	/* Ok, it's mapped. Make sure it's up-to-date */
^1da177e4c3f41 Linus Torvalds     2005-04-16  2623  	if (PageUptodate(page))
^1da177e4c3f41 Linus Torvalds     2005-04-16  2624  		set_buffer_uptodate(bh);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2625  
33a266dda9fbbe David Chinner      2007-02-12  2626  	if (!buffer_uptodate(bh) && !buffer_delay(bh) && !buffer_unwritten(bh)) {
e7ea1129afab0e Zhang Yi           2022-09-01  2627  		err = bh_read(bh, 0);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2628  		/* Uhhuh. Read error. Complain and punt. */
e7ea1129afab0e Zhang Yi           2022-09-01  2629  		if (err < 0)
^1da177e4c3f41 Linus Torvalds     2005-04-16  2630  			goto unlock;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2631  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  2632  
eebd2aa355692a Christoph Lameter  2008-02-04  2633  	zero_user(page, offset, length);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2634  	mark_buffer_dirty(bh);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2635  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2636  unlock:
^1da177e4c3f41 Linus Torvalds     2005-04-16  2637  	unlock_page(page);
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  2638  	put_page(page);
^1da177e4c3f41 Linus Torvalds     2005-04-16 @2639  out:
^1da177e4c3f41 Linus Torvalds     2005-04-16  2640  	return err;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2641  }
1fe72eaa0f46a0 H Hartley Sweeten  2009-09-22  2642  EXPORT_SYMBOL(block_truncate_page);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2643  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
