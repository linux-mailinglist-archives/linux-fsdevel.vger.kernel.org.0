Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A0D79F424
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 23:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjIMVyn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 17:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjIMVym (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:54:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57C21739;
        Wed, 13 Sep 2023 14:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694642078; x=1726178078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k6McVuFoackSwgd9sS8FWogvUdhNDoHw5Xnjr3V+aUE=;
  b=lKk4yrEdaZd3ZFT6JRy0Do96lPyRhr0ZBGkm3OhRXaXSVlNN5ZCFF+iI
   QY4rNCXfqGUjd88QkvDN+zQDKScAphBXywOSKDFnORh8D5rmsrHYkFpsA
   uILzSSdBZxBCnzwlvV0X9gdgRBx2mA53lzVzJk+1cEQLJY+pehY0h00Ao
   qnHu1YUDjS/wwSxGFt9qjQcfRPRdt6nwNhvuM6e19BgriJDBeK5Z7F2t5
   xS3bTazX7gZ/THldYPnbf6j85vBLqJCjfpTFXVXARow8Fc4AeLyt3rDqw
   EUd1WDmoVSUratrm5EgHnL27Z8Ajo6NK6j6Iz9XdmCbA40gOr0+A3rIob
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="359054085"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="359054085"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 14:54:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="918012835"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="918012835"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Sep 2023 14:54:26 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgXo9-0000hx-14;
        Wed, 13 Sep 2023 21:54:16 +0000
Date:   Thu, 14 Sep 2023 05:53:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sourav Panda <souravpanda@google.com>, corbet@lwn.net,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, rppt@kernel.org, david@redhat.com,
        rdunlap@infradead.org, chenlinxuan@uniontech.com,
        yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com,
        bhelgaas@google.com, ivan@cloudflare.com,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        hannes@cmpxchg.org, shakeelb@google.com,
        kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
        adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 1/1] mm: report per-page metadata information
Message-ID: <202309140522.z5SLip5C-lkp@intel.com>
References: <20230913173000.4016218-2-souravpanda@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913173000.4016218-2-souravpanda@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Sourav,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.6-rc1 next-20230913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sourav-Panda/mm-report-per-page-metadata-information/20230914-013201
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230913173000.4016218-2-souravpanda%40google.com
patch subject: [PATCH v1 1/1] mm: report per-page metadata information
config: um-defconfig (https://download.01.org/0day-ci/archive/20230914/202309140522.z5SLip5C-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309140522.z5SLip5C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309140522.z5SLip5C-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: mm/mm_init.o: in function `alloc_node_mem_map':
>> mm/mm_init.c:1660: undefined reference to `mod_node_early_perpage_metadata'
   /usr/bin/ld: mm/page_alloc.o: in function `setup_per_cpu_pageset':
>> mm/page_alloc.c:5500: undefined reference to `writeout_early_perpage_metadata'
   collect2: error: ld returned 1 exit status


vim +1660 mm/mm_init.c

  1628	
  1629	#ifdef CONFIG_FLATMEM
  1630	static void __init alloc_node_mem_map(struct pglist_data *pgdat)
  1631	{
  1632		unsigned long __maybe_unused start = 0;
  1633		unsigned long __maybe_unused offset = 0;
  1634	
  1635		/* Skip empty nodes */
  1636		if (!pgdat->node_spanned_pages)
  1637			return;
  1638	
  1639		start = pgdat->node_start_pfn & ~(MAX_ORDER_NR_PAGES - 1);
  1640		offset = pgdat->node_start_pfn - start;
  1641		/* ia64 gets its own node_mem_map, before this, without bootmem */
  1642		if (!pgdat->node_mem_map) {
  1643			unsigned long size, end;
  1644			struct page *map;
  1645	
  1646			/*
  1647			 * The zone's endpoints aren't required to be MAX_ORDER
  1648			 * aligned but the node_mem_map endpoints must be in order
  1649			 * for the buddy allocator to function correctly.
  1650			 */
  1651			end = pgdat_end_pfn(pgdat);
  1652			end = ALIGN(end, MAX_ORDER_NR_PAGES);
  1653			size =  (end - start) * sizeof(struct page);
  1654			map = memmap_alloc(size, SMP_CACHE_BYTES, MEMBLOCK_LOW_LIMIT,
  1655					   pgdat->node_id, false);
  1656			if (!map)
  1657				panic("Failed to allocate %ld bytes for node %d memory map\n",
  1658				      size, pgdat->node_id);
  1659			pgdat->node_mem_map = map + offset;
> 1660			mod_node_early_perpage_metadata(pgdat->node_id,
  1661							PAGE_ALIGN(size) >> PAGE_SHIFT);
  1662		}
  1663		pr_debug("%s: node %d, pgdat %08lx, node_mem_map %08lx\n",
  1664					__func__, pgdat->node_id, (unsigned long)pgdat,
  1665					(unsigned long)pgdat->node_mem_map);
  1666	#ifndef CONFIG_NUMA
  1667		/*
  1668		 * With no DISCONTIG, the global mem_map is just set as node 0's
  1669		 */
  1670		if (pgdat == NODE_DATA(0)) {
  1671			mem_map = NODE_DATA(0)->node_mem_map;
  1672			if (page_to_pfn(mem_map) != pgdat->node_start_pfn)
  1673				mem_map -= offset;
  1674		}
  1675	#endif
  1676	}
  1677	#else
  1678	static inline void alloc_node_mem_map(struct pglist_data *pgdat) { }
  1679	#endif /* CONFIG_FLATMEM */
  1680	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
