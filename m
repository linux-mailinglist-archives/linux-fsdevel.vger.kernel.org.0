Return-Path: <linux-fsdevel+bounces-63841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEBABCF386
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 12:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CD73AB836
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 10:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DBA259CB9;
	Sat, 11 Oct 2025 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5kSCWll"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DB523D7E8;
	Sat, 11 Oct 2025 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760178232; cv=none; b=aw9OfAcKr7Z+3hFdsxcp1fTVqtLiHadiyi9OwTCEinldVP10U8qBS1ZEhPVwNrLgXYcmSXrJY8Hmx6DIdbzpD67y8cGbgIf+XTMPPkVlI37pdkMbmIBGz/QdBXNd8e9DWeeFUR3uv9sDlC7pq7uBKRy2cg5UkZmDKkFBqYAgfj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760178232; c=relaxed/simple;
	bh=7xxrjwQLnAEK+AEZDLjrFqRqjtY9w5ULoaYVjJZBy7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSFaIHhFV/R6fbQoSm5GqcurVmLwIok80ArpIqbc0oG1p4bVikKaSOLg/5O7ATVXI/JLY2C7EkFtmkd+rsBroQUkfvYvfOlt0Lk3GevI09HpxMsmMi/IGG3rhzXMxDiOYDKjYbK2d8z6q7xzPNAxT4npO0lAf5e9/DN1VxYh/34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5kSCWll; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760178227; x=1791714227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7xxrjwQLnAEK+AEZDLjrFqRqjtY9w5ULoaYVjJZBy7I=;
  b=E5kSCWlljeHCWb0bwwS08eg7s6j+CqCc0BDNPcYE5DObhmdYslni4JHL
   d826DkBAzY8Rd1I4tL2u2LcOKL577S5+w0txqnQ6SNqQcm3iI6Y2bjeda
   idsN6gh7NayYpvu6Rj/kjOLHAfUlGgRxcXZaQrdL1vCdSlC2FfQXJkgi9
   lBLkIJcz0Tcb541hf4bh0RiZ/k4/+ytK/qJA7Ak7vrvymm3KJsJ+CAUyd
   ULbeo+XtRg8WX2V7Z1vmYEA5FjY2u19UxMyaSHWn5ojmSj0yvbzmYZqRI
   +klu1W+28lWLEnQW0xLWiybtGZV0tpLNpLzkVLJsKkhWLu5FNtg9bHBVX
   A==;
X-CSE-ConnectionGUID: 3vQt0FP+SF69y8nQtk1xZA==
X-CSE-MsgGUID: PKbOn+iATM6eQWhCvx9Dnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="73068036"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="73068036"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 03:23:46 -0700
X-CSE-ConnectionGUID: q15MogiAQ/m4KIDBFh45bg==
X-CSE-MsgGUID: +j2+D1jDREGAw53FMXAyQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="186459433"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 Oct 2025 03:23:41 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7WlG-0003hz-2R;
	Sat, 11 Oct 2025 10:23:38 +0000
Date: Sat, 11 Oct 2025 18:23:37 +0800
From: kernel test robot <lkp@intel.com>
To: Zi Yan <ziy@nvidia.com>, linmiaohe@huawei.com, david@redhat.com,
	jane.chu@oracle.com, kernel@pankajraghav.com,
	syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Cc: oe-kbuild-all@lists.linux.dev, ziy@nvidia.com,
	akpm@linux-foundation.org, mcgrof@kernel.org,
	nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/memory-failure: improve large block size folio
 handling.
Message-ID: <202510111805.rg0AewVk-lkp@intel.com>
References: <20251010173906.3128789-3-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010173906.3128789-3-ziy@nvidia.com>

Hi Zi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.17 next-20251010]
[cannot apply to akpm-mm/mm-everything]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zi-Yan/mm-huge_memory-do-not-change-split_huge_page-target-order-silently/20251011-014145
base:   linus/master
patch link:    https://lore.kernel.org/r/20251010173906.3128789-3-ziy%40nvidia.com
patch subject: [PATCH 2/2] mm/memory-failure: improve large block size folio handling.
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20251011/202510111805.rg0AewVk-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510111805.rg0AewVk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510111805.rg0AewVk-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/memory-failure.c: In function 'memory_failure':
>> mm/memory-failure.c:2278:33: error: implicit declaration of function 'min_order_for_split' [-Wimplicit-function-declaration]
    2278 |                 int new_order = min_order_for_split(folio);
         |                                 ^~~~~~~~~~~~~~~~~~~


vim +/min_order_for_split +2278 mm/memory-failure.c

  2147	
  2148	/**
  2149	 * memory_failure - Handle memory failure of a page.
  2150	 * @pfn: Page Number of the corrupted page
  2151	 * @flags: fine tune action taken
  2152	 *
  2153	 * This function is called by the low level machine check code
  2154	 * of an architecture when it detects hardware memory corruption
  2155	 * of a page. It tries its best to recover, which includes
  2156	 * dropping pages, killing processes etc.
  2157	 *
  2158	 * The function is primarily of use for corruptions that
  2159	 * happen outside the current execution context (e.g. when
  2160	 * detected by a background scrubber)
  2161	 *
  2162	 * Must run in process context (e.g. a work queue) with interrupts
  2163	 * enabled and no spinlocks held.
  2164	 *
  2165	 * Return:
  2166	 *   0             - success,
  2167	 *   -ENXIO        - memory not managed by the kernel
  2168	 *   -EOPNOTSUPP   - hwpoison_filter() filtered the error event,
  2169	 *   -EHWPOISON    - the page was already poisoned, potentially
  2170	 *                   kill process,
  2171	 *   other negative values - failure.
  2172	 */
  2173	int memory_failure(unsigned long pfn, int flags)
  2174	{
  2175		struct page *p;
  2176		struct folio *folio;
  2177		struct dev_pagemap *pgmap;
  2178		int res = 0;
  2179		unsigned long page_flags;
  2180		bool retry = true;
  2181		int hugetlb = 0;
  2182	
  2183		if (!sysctl_memory_failure_recovery)
  2184			panic("Memory failure on page %lx", pfn);
  2185	
  2186		mutex_lock(&mf_mutex);
  2187	
  2188		if (!(flags & MF_SW_SIMULATED))
  2189			hw_memory_failure = true;
  2190	
  2191		p = pfn_to_online_page(pfn);
  2192		if (!p) {
  2193			res = arch_memory_failure(pfn, flags);
  2194			if (res == 0)
  2195				goto unlock_mutex;
  2196	
  2197			if (pfn_valid(pfn)) {
  2198				pgmap = get_dev_pagemap(pfn);
  2199				put_ref_page(pfn, flags);
  2200				if (pgmap) {
  2201					res = memory_failure_dev_pagemap(pfn, flags,
  2202									 pgmap);
  2203					goto unlock_mutex;
  2204				}
  2205			}
  2206			pr_err("%#lx: memory outside kernel control\n", pfn);
  2207			res = -ENXIO;
  2208			goto unlock_mutex;
  2209		}
  2210	
  2211	try_again:
  2212		res = try_memory_failure_hugetlb(pfn, flags, &hugetlb);
  2213		if (hugetlb)
  2214			goto unlock_mutex;
  2215	
  2216		if (TestSetPageHWPoison(p)) {
  2217			res = -EHWPOISON;
  2218			if (flags & MF_ACTION_REQUIRED)
  2219				res = kill_accessing_process(current, pfn, flags);
  2220			if (flags & MF_COUNT_INCREASED)
  2221				put_page(p);
  2222			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
  2223			goto unlock_mutex;
  2224		}
  2225	
  2226		/*
  2227		 * We need/can do nothing about count=0 pages.
  2228		 * 1) it's a free page, and therefore in safe hand:
  2229		 *    check_new_page() will be the gate keeper.
  2230		 * 2) it's part of a non-compound high order page.
  2231		 *    Implies some kernel user: cannot stop them from
  2232		 *    R/W the page; let's pray that the page has been
  2233		 *    used and will be freed some time later.
  2234		 * In fact it's dangerous to directly bump up page count from 0,
  2235		 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
  2236		 */
  2237		if (!(flags & MF_COUNT_INCREASED)) {
  2238			res = get_hwpoison_page(p, flags);
  2239			if (!res) {
  2240				if (is_free_buddy_page(p)) {
  2241					if (take_page_off_buddy(p)) {
  2242						page_ref_inc(p);
  2243						res = MF_RECOVERED;
  2244					} else {
  2245						/* We lost the race, try again */
  2246						if (retry) {
  2247							ClearPageHWPoison(p);
  2248							retry = false;
  2249							goto try_again;
  2250						}
  2251						res = MF_FAILED;
  2252					}
  2253					res = action_result(pfn, MF_MSG_BUDDY, res);
  2254				} else {
  2255					res = action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
  2256				}
  2257				goto unlock_mutex;
  2258			} else if (res < 0) {
  2259				res = action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
  2260				goto unlock_mutex;
  2261			}
  2262		}
  2263	
  2264		folio = page_folio(p);
  2265	
  2266		/* filter pages that are protected from hwpoison test by users */
  2267		folio_lock(folio);
  2268		if (hwpoison_filter(p)) {
  2269			ClearPageHWPoison(p);
  2270			folio_unlock(folio);
  2271			folio_put(folio);
  2272			res = -EOPNOTSUPP;
  2273			goto unlock_mutex;
  2274		}
  2275		folio_unlock(folio);
  2276	
  2277		if (folio_test_large(folio)) {
> 2278			int new_order = min_order_for_split(folio);
  2279			/*
  2280			 * The flag must be set after the refcount is bumped
  2281			 * otherwise it may race with THP split.
  2282			 * And the flag can't be set in get_hwpoison_page() since
  2283			 * it is called by soft offline too and it is just called
  2284			 * for !MF_COUNT_INCREASED.  So here seems to be the best
  2285			 * place.
  2286			 *
  2287			 * Don't need care about the above error handling paths for
  2288			 * get_hwpoison_page() since they handle either free page
  2289			 * or unhandlable page.  The refcount is bumped iff the
  2290			 * page is a valid handlable page.
  2291			 */
  2292			folio_set_has_hwpoisoned(folio);
  2293			/*
  2294			 * If the folio cannot be split to order-0, kill the process,
  2295			 * but split the folio anyway to minimize the amount of unusable
  2296			 * pages.
  2297			 */
  2298			if (try_to_split_thp_page(p, new_order, false) || new_order) {
  2299				/* get folio again in case the original one is split */
  2300				folio = page_folio(p);
  2301				res = -EHWPOISON;
  2302				kill_procs_now(p, pfn, flags, folio);
  2303				put_page(p);
  2304				action_result(pfn, MF_MSG_UNSPLIT_THP, MF_FAILED);
  2305				goto unlock_mutex;
  2306			}
  2307			VM_BUG_ON_PAGE(!page_count(p), p);
  2308			folio = page_folio(p);
  2309		}
  2310	
  2311		/*
  2312		 * We ignore non-LRU pages for good reasons.
  2313		 * - PG_locked is only well defined for LRU pages and a few others
  2314		 * - to avoid races with __SetPageLocked()
  2315		 * - to avoid races with __SetPageSlab*() (and more non-atomic ops)
  2316		 * The check (unnecessarily) ignores LRU pages being isolated and
  2317		 * walked by the page reclaim code, however that's not a big loss.
  2318		 */
  2319		shake_folio(folio);
  2320	
  2321		folio_lock(folio);
  2322	
  2323		/*
  2324		 * We're only intended to deal with the non-Compound page here.
  2325		 * The page cannot become compound pages again as folio has been
  2326		 * splited and extra refcnt is held.
  2327		 */
  2328		WARN_ON(folio_test_large(folio));
  2329	
  2330		/*
  2331		 * We use page flags to determine what action should be taken, but
  2332		 * the flags can be modified by the error containment action.  One
  2333		 * example is an mlocked page, where PG_mlocked is cleared by
  2334		 * folio_remove_rmap_*() in try_to_unmap_one(). So to determine page
  2335		 * status correctly, we save a copy of the page flags at this time.
  2336		 */
  2337		page_flags = folio->flags.f;
  2338	
  2339		/*
  2340		 * __munlock_folio() may clear a writeback folio's LRU flag without
  2341		 * the folio lock. We need to wait for writeback completion for this
  2342		 * folio or it may trigger a vfs BUG while evicting inode.
  2343		 */
  2344		if (!folio_test_lru(folio) && !folio_test_writeback(folio))
  2345			goto identify_page_state;
  2346	
  2347		/*
  2348		 * It's very difficult to mess with pages currently under IO
  2349		 * and in many cases impossible, so we just avoid it here.
  2350		 */
  2351		folio_wait_writeback(folio);
  2352	
  2353		/*
  2354		 * Now take care of user space mappings.
  2355		 * Abort on fail: __filemap_remove_folio() assumes unmapped page.
  2356		 */
  2357		if (!hwpoison_user_mappings(folio, p, pfn, flags)) {
  2358			res = action_result(pfn, MF_MSG_UNMAP_FAILED, MF_FAILED);
  2359			goto unlock_page;
  2360		}
  2361	
  2362		/*
  2363		 * Torn down by someone else?
  2364		 */
  2365		if (folio_test_lru(folio) && !folio_test_swapcache(folio) &&
  2366		    folio->mapping == NULL) {
  2367			res = action_result(pfn, MF_MSG_TRUNCATED_LRU, MF_IGNORED);
  2368			goto unlock_page;
  2369		}
  2370	
  2371	identify_page_state:
  2372		res = identify_page_state(pfn, p, page_flags);
  2373		mutex_unlock(&mf_mutex);
  2374		return res;
  2375	unlock_page:
  2376		folio_unlock(folio);
  2377	unlock_mutex:
  2378		mutex_unlock(&mf_mutex);
  2379		return res;
  2380	}
  2381	EXPORT_SYMBOL_GPL(memory_failure);
  2382	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

