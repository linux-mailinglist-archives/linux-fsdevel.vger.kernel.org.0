Return-Path: <linux-fsdevel+bounces-56912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C2CB1CDEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3395B189B6A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F16E2BF011;
	Wed,  6 Aug 2025 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqczba0S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335E22BDC14;
	Wed,  6 Aug 2025 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512872; cv=none; b=PUs+/AImt06jXC9msuTDpaXiPxdM+ADR/CM01w9f6iAi92vkmXWRMPburXL16t3vT3WsKA6F5davjhk7mBNPL3fWYknXMlgm6ahtxFHL5heZIFi5e0wo4SYeMgnMRNohXN4RlTzOl44AqqF06culf5Y7NQPMaXD+o9dh8cBmmnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512872; c=relaxed/simple;
	bh=+Kj3Cp8LPwva2q9gWj1Lp/dXKJzRTOeU9qOHIURBHpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMrP+1jqym7ZSJQKoSfEGA1Esyv3Bq8+WwUdRrJA5eEDD3P0rULZUeXZOMPsU/BzSLFtLYA9x4ilrv3te9z4I0ZOGqXU4R9wf5E3CeA8mfmY+nsZA00Yvh6BnFE0AGQqUj4zOS270y7bJE+dr9EV0WIk5rNYc1kszdDsT+Xtsko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqczba0S; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754512869; x=1786048869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Kj3Cp8LPwva2q9gWj1Lp/dXKJzRTOeU9qOHIURBHpg=;
  b=iqczba0SVZH1hmrOMT9nNyDZEaI3l/kD4cl1wVj75h4WNH1yDZ53anR5
   N7h8GigbPSbueliESEf75aW80NDlK7wpUYh2TdHr/585vPOTUbqcyUjRV
   miiKKEktLbXh2ayJJhxGPtQ8bF2fp7sMmAIFCYGrWCGtTRpzyt3YGnkBA
   CrCj+qOghNeRc3jWXTwvw7OQyx2Sm0wJ804gfmTbcoBAwiZ5o6Gnu1ZK9
   r8DHJCvYwBtvoty3dx6/AA1UqeRKNiuQXFLhQ/yb3ec93irv/t2e6rRog
   qiSrm1+8xM1Y4E8ttCXrW0Qn/bPptLXPwSkyKnu1JPiWgpm+NK8m31ilS
   w==;
X-CSE-ConnectionGUID: U4siwIweT9SvrkUn/U4O7w==
X-CSE-MsgGUID: 8sXdHjpYSSioI9R9yoZrww==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="68292953"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="68292953"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:41:09 -0700
X-CSE-ConnectionGUID: 4UCBIf49RfezSkorl0A6/A==
X-CSE-MsgGUID: b09J71hZS5icy2vQddJOYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="170139148"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 06 Aug 2025 13:41:06 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujkwR-00024s-04;
	Wed, 06 Aug 2025 20:41:02 +0000
Date: Thu, 7 Aug 2025 04:40:16 +0800
From: kernel test robot <lkp@intel.com>
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com
Cc: oe-kbuild-all@lists.linux.dev, shakeel.butt@linux.dev,
	hch@infradead.org, wqu@suse.com
Subject: Re: [PATCH 3/3] mm: add vmstat for cgroup uncharged pages
Message-ID: <202508070434.6EpRsRF3-lkp@intel.com>
References: <eae30d630ba07de8966d09a3e1700f53715980c2.1754438418.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eae30d630ba07de8966d09a3e1700f53715980c2.1754438418.git.boris@bur.io>

Hi Boris,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on v6.16]
[cannot apply to akpm-mm/mm-everything linus/master next-20250806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Boris-Burkov/mm-filemap-add-filemap_add_folio_nocharge/20250806-130147
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/eae30d630ba07de8966d09a3e1700f53715980c2.1754438418.git.boris%40bur.io
patch subject: [PATCH 3/3] mm: add vmstat for cgroup uncharged pages
config: i386-buildonly-randconfig-003-20250807 (https://download.01.org/0day-ci/archive/20250807/202508070434.6EpRsRF3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508070434.6EpRsRF3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508070434.6EpRsRF3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/filemap.c: In function 'filemap_unaccount_folio':
   mm/filemap.c:209:9: error: implicit declaration of function 'filemap_mod_uncharged_vmstat'; did you mean 'filemap_mod_uncharged_cgroup_vmstat'? [-Werror=implicit-function-declaration]
     209 |         filemap_mod_uncharged_vmstat(folio, -1);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         filemap_mod_uncharged_cgroup_vmstat
   mm/filemap.c: At top level:
>> mm/filemap.c:158:13: warning: 'filemap_mod_uncharged_cgroup_vmstat' defined but not used [-Wunused-function]
     158 | static void filemap_mod_uncharged_cgroup_vmstat(struct folio *folio, int sign)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/filemap_mod_uncharged_cgroup_vmstat +158 mm/filemap.c

   148	
   149	#ifdef CONFIG_MEMCG
   150	static void filemap_mod_uncharged_vmstat(struct folio *folio, int sign)
   151	{
   152		long nr = folio_nr_pages(folio) * sign;
   153	
   154		if (!folio_memcg(folio))
   155			__lruvec_stat_mod_folio(folio, NR_UNCHARGED_FILE_PAGES, nr);
   156	}
   157	#else
 > 158	static void filemap_mod_uncharged_cgroup_vmstat(struct folio *folio, int sign)
   159	{
   160		return;
   161	}
   162	#endif
   163	
   164	
   165	static void filemap_unaccount_folio(struct address_space *mapping,
   166			struct folio *folio)
   167	{
   168		long nr;
   169	
   170		VM_BUG_ON_FOLIO(folio_mapped(folio), folio);
   171		if (!IS_ENABLED(CONFIG_DEBUG_VM) && unlikely(folio_mapped(folio))) {
   172			pr_alert("BUG: Bad page cache in process %s  pfn:%05lx\n",
   173				 current->comm, folio_pfn(folio));
   174			dump_page(&folio->page, "still mapped when deleted");
   175			dump_stack();
   176			add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
   177	
   178			if (mapping_exiting(mapping) && !folio_test_large(folio)) {
   179				int mapcount = folio_mapcount(folio);
   180	
   181				if (folio_ref_count(folio) >= mapcount + 2) {
   182					/*
   183					 * All vmas have already been torn down, so it's
   184					 * a good bet that actually the page is unmapped
   185					 * and we'd rather not leak it: if we're wrong,
   186					 * another bad page check should catch it later.
   187					 */
   188					atomic_set(&folio->_mapcount, -1);
   189					folio_ref_sub(folio, mapcount);
   190				}
   191			}
   192		}
   193	
   194		/* hugetlb folios do not participate in page cache accounting. */
   195		if (folio_test_hugetlb(folio))
   196			return;
   197	
   198		nr = folio_nr_pages(folio);
   199	
   200		__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
   201		if (folio_test_swapbacked(folio)) {
   202			__lruvec_stat_mod_folio(folio, NR_SHMEM, -nr);
   203			if (folio_test_pmd_mappable(folio))
   204				__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, -nr);
   205		} else if (folio_test_pmd_mappable(folio)) {
   206			__lruvec_stat_mod_folio(folio, NR_FILE_THPS, -nr);
   207			filemap_nr_thps_dec(mapping);
   208		}
 > 209		filemap_mod_uncharged_vmstat(folio, -1);
   210	
   211		/*
   212		 * At this point folio must be either written or cleaned by
   213		 * truncate.  Dirty folio here signals a bug and loss of
   214		 * unwritten data - on ordinary filesystems.
   215		 *
   216		 * But it's harmless on in-memory filesystems like tmpfs; and can
   217		 * occur when a driver which did get_user_pages() sets page dirty
   218		 * before putting it, while the inode is being finally evicted.
   219		 *
   220		 * Below fixes dirty accounting after removing the folio entirely
   221		 * but leaves the dirty flag set: it has no effect for truncated
   222		 * folio and anyway will be cleared before returning folio to
   223		 * buddy allocator.
   224		 */
   225		if (WARN_ON_ONCE(folio_test_dirty(folio) &&
   226				 mapping_can_writeback(mapping)))
   227			folio_account_cleaned(folio, inode_to_wb(mapping->host));
   228	}
   229	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

