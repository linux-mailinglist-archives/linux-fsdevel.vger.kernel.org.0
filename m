Return-Path: <linux-fsdevel+bounces-5417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8A980B685
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 22:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E221D1C20929
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 21:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C43E1D6AF;
	Sat,  9 Dec 2023 21:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJk8Robz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D05103;
	Sat,  9 Dec 2023 13:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702157063; x=1733693063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZiDja0DRjGF8V4kOTELVdfHO8iGqBQYFHxa1g/OKJdg=;
  b=YJk8RobzwK80RSYfwStPmErT38PjWyAaUAJmsU2nZT9PqKiUKkQTCJ5n
   z9WRNIxEwPlWt4w6SmxDtrBr8bW2LkYxwpyvZcQ/CpAO4n3mGLHXL9Puh
   ZmnfCzLcZJVNKtoXOPK6vg1hshD5ioIX+0W3qBMfyieMlG6/4Z6CpRuf/
   REolgjKNdo6rtM+qHYi7B02M8WvGZGQT86ZcV7wsm+3xnophEMfBmIaWY
   HChlYkiyojWJs0Toq821pR9H4EcRJbHnx5vsYp4/dGYQwlm4sG0UD1pC1
   kr+A3HhOQXMlRGviy21VVFCR9JshVBRTb054Zg1hDYNxTOQWBNdPTqUPh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="7850927"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="7850927"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 13:24:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="20490955"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 09 Dec 2023 13:24:16 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rC4o1-000Fxn-17;
	Sat, 09 Dec 2023 21:24:13 +0000
Date: Sun, 10 Dec 2023 05:24:03 +0800
From: kernel test robot <lkp@intel.com>
To: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	arnd@arndb.de, tglx@linutronix.de, luto@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, mhocko@kernel.org, tj@kernel.org,
	ying.huang@intel.com, gregory.price@memverge.com, corbet@lwn.net,
	rakie.kim@sk.com, hyeongtak.ji@sk.com, honggyu.kim@sk.com,
	vtavarespetr@micron.com, peterz@infradead.org, jgroves@micron.com,
	ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, Hasan.Maruf@amd.com
Subject: Re: [PATCH v2 02/11] mm/mempolicy: introduce
 MPOL_WEIGHTED_INTERLEAVE for weighted interleaving
Message-ID: <202312100543.ix4jxw81-lkp@intel.com>
References: <20231209065931.3458-3-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209065931.3458-3-gregory.price@memverge.com>

Hi Gregory,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on deller-parisc/for-next powerpc/next powerpc/fixes s390/features jcmvbkbc-xtensa/xtensa-for-next arnd-asm-generic/master linus/master v6.7-rc4 next-20231208]
[cannot apply to tip/x86/asm geert-m68k/for-next geert-m68k/for-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gregory-Price/mm-mempolicy-implement-the-sysfs-based-weighted_interleave-interface/20231209-150314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231209065931.3458-3-gregory.price%40memverge.com
patch subject: [PATCH v2 02/11] mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE for weighted interleaving
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231210/202312100543.ix4jxw81-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312100543.ix4jxw81-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312100543.ix4jxw81-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/mempolicy.c:2355:3: warning: variable 'weight_total' is uninitialized when used here [-Wuninitialized]
                   weight_total += weight;
                   ^~~~~~~~~~~~
   mm/mempolicy.c:2341:27: note: initialize the variable 'weight_total' to silence this warning
           unsigned int weight_total;
                                    ^
                                     = 0
   1 warning generated.


vim +/weight_total +2355 mm/mempolicy.c

  2329	
  2330	static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
  2331			struct mempolicy *pol, unsigned long nr_pages,
  2332			struct page **page_array)
  2333	{
  2334		struct task_struct *me = current;
  2335		unsigned long total_allocated = 0;
  2336		unsigned long nr_allocated;
  2337		unsigned long rounds;
  2338		unsigned long node_pages, delta;
  2339		unsigned char weight;
  2340		unsigned char weights[MAX_NUMNODES];
  2341		unsigned int weight_total;
  2342		unsigned long rem_pages = nr_pages;
  2343		nodemask_t nodes = pol->nodes;
  2344		int nnodes, node, prev_node;
  2345		int i;
  2346	
  2347		/* Stabilize the nodemask on the stack */
  2348		barrier();
  2349	
  2350		nnodes = nodes_weight(nodes);
  2351	
  2352		/* Collect weights and save them on stack so they don't change */
  2353		for_each_node_mask(node, nodes) {
  2354			weight = iw_table[node];
> 2355			weight_total += weight;
  2356			weights[node] = weight;
  2357		}
  2358	
  2359		/* Continue allocating from most recent node and adjust the nr_pages */
  2360		if (pol->wil.cur_weight) {
  2361			node = next_node_in(me->il_prev, nodes);
  2362			node_pages = pol->wil.cur_weight;
  2363			if (node_pages > rem_pages)
  2364				node_pages = rem_pages;
  2365			nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
  2366							  NULL, page_array);
  2367			page_array += nr_allocated;
  2368			total_allocated += nr_allocated;
  2369			/* if that's all the pages, no need to interleave */
  2370			if (rem_pages <= pol->wil.cur_weight) {
  2371				pol->wil.cur_weight -= rem_pages;
  2372				return total_allocated;
  2373			}
  2374			/* Otherwise we adjust nr_pages down, and continue from there */
  2375			rem_pages -= pol->wil.cur_weight;
  2376			pol->wil.cur_weight = 0;
  2377			prev_node = node;
  2378		}
  2379	
  2380		/* Now we can continue allocating as if from 0 instead of an offset */
  2381		rounds = rem_pages / weight_total;
  2382		delta = rem_pages % weight_total;
  2383		for (i = 0; i < nnodes; i++) {
  2384			node = next_node_in(prev_node, nodes);
  2385			weight = weights[node];
  2386			node_pages = weight * rounds;
  2387			if (delta) {
  2388				if (delta > weight) {
  2389					node_pages += weight;
  2390					delta -= weight;
  2391				} else {
  2392					node_pages += delta;
  2393					delta = 0;
  2394				}
  2395			}
  2396			/* We may not make it all the way around */
  2397			if (!node_pages)
  2398				break;
  2399			/* If an over-allocation would occur, floor it */
  2400			if (node_pages + total_allocated > nr_pages) {
  2401				node_pages = nr_pages - total_allocated;
  2402				delta = 0;
  2403			}
  2404			nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
  2405							  NULL, page_array);
  2406			page_array += nr_allocated;
  2407			total_allocated += nr_allocated;
  2408			prev_node = node;
  2409		}
  2410	
  2411		/*
  2412		 * Finally, we need to update me->il_prev and pol->wil.cur_weight
  2413		 * if there were overflow pages, but not equivalent to the node
  2414		 * weight, set the cur_weight to node_weight - delta and the
  2415		 * me->il_prev to the previous node. Otherwise if it was perfect
  2416		 * we can simply set il_prev to node and cur_weight to 0
  2417		 */
  2418		if (node_pages) {
  2419			me->il_prev = prev_node;
  2420			node_pages %= weight;
  2421			pol->wil.cur_weight = weight - node_pages;
  2422		} else {
  2423			me->il_prev = node;
  2424			pol->wil.cur_weight = 0;
  2425		}
  2426	
  2427		return total_allocated;
  2428	}
  2429	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

