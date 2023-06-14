Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AB572FA13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 12:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243528AbjFNKG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 06:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243814AbjFNKGa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:06:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230F5E52;
        Wed, 14 Jun 2023 03:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686737185; x=1718273185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g2QfR8bmYgD+CN0RFxMr1eU3YYzbjEOX8nWdKHOLO6M=;
  b=MFmHPI3ixsBtdNO2NJtXr6XaCBM68f6KDYOrwDZcpUYt7n2rKUgeS1x8
   ri/iK+WiLcYgDekhyh5pBuVCImSrm0qN7Wq3PjdAkCX9EbihWSlttcrmY
   7n642PFY9eN8r/NWbVVFP1wMUSj7fQaJWeDFEdwBzKEV4KNlmY4NF8/Al
   K56PO/CgYHJBo5vJGA8Kx9AenIC/5+aPDr1GHstZFMXMCT6nreHfH63V+
   2kNj6qt+Yp32/rIFYaPVoC+tcSlvq28Y7dLngmKlOR4zw7lWVtK5ZIbw5
   xnbmSByl0tubEXQo72TDGL6PZzovxxgISpW1XTYv12tG7lsRHDDdifG7M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="444943713"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="444943713"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 03:06:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="824753394"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="824753394"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2023 03:06:21 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9NOP-0000Vn-06;
        Wed, 14 Jun 2023 10:06:21 +0000
Date:   Wed, 14 Jun 2023 18:05:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wei Chin Tsai <Wei-chin.Tsai@mediatek.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     oe-kbuild-all@lists.linux.dev, wsd_upstream@mediatek.com,
        wei-chin.tsai@mediatek.com, mel.lee@mediatek.com,
        ivan.tseng@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 2/3] memory: export symbols for memory related
 functions
Message-ID: <202306141627.fYoZPKxi-lkp@intel.com>
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
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.4-rc6 next-20230614]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Chin-Tsai/kernel-process-fork-exit-export-symbol-for-fork-exit-tracing-functions/20230614-112218
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20230614032038.11699-3-Wei-chin.Tsai%40mediatek.com
patch subject: [PATCH v2 2/3] memory: export symbols for memory related functions
config: csky-randconfig-r011-20230612 (https://download.01.org/0day-ci/archive/20230614/202306141627.fYoZPKxi-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=csky olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash fs/proc/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306141627.fYoZPKxi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/proc/task_mmu.c:776:6: warning: no previous prototype for 'smap_gather_stats' [-Wmissing-prototypes]
     776 | void smap_gather_stats(struct vm_area_struct *vma,
         |      ^~~~~~~~~~~~~~~~~


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
