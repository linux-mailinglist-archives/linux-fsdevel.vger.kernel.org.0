Return-Path: <linux-fsdevel+bounces-63063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1F3BAAEF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 03:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BD63C1F51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 01:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833811FF7BC;
	Tue, 30 Sep 2025 01:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Np6/YvNe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC579198E91;
	Tue, 30 Sep 2025 01:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759197526; cv=none; b=bqnYjhfHEd0b6btnQHvKwcgtRzMHINXsUZp3Wyz//VBI0o0D84e7NdYrkvqEHhm5FAl6qLFAzhpNKrurYgOzboPTbrMmD7Ora5t0PHseGbjTMu0/WmgQQPqGlLIlVMT4q1+dEv6LqXC6b1qknzEK2IsmYjCFTnyHmLW9UMz9o5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759197526; c=relaxed/simple;
	bh=tB20YtoaQNm1TRsLJW3oQQhC60mlpvbrxY7xlXH5rUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0xOX5tcOpEpxfmkTuu7kHxsQI9m4CwkczY0ioIQOQ9tfT+CngtEfl1gQpxiEtOQXxGBa/HSfG4h84eJQkcSn9wJVM7OXQrBTt/DX9L4Hmh8YygF5c6LEVI4cN2F4RvMHs1OhrYQOxsoufve4hmeiJ9Jof6f4rIEtu3ij7j/cjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Np6/YvNe; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759197525; x=1790733525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tB20YtoaQNm1TRsLJW3oQQhC60mlpvbrxY7xlXH5rUU=;
  b=Np6/YvNeJWnyYLLEBboMY+4eRiINgUYy4IvRU9RBE0LRolH5fl3GiNdY
   7PVqeBRE1G3e0BX64shv5/9XlravVuTlpdUyE//vVabQ1OhfzEEueXPor
   9E41LlMcmQxOL+Z5iYopFEnMyeiyxlkfx7Zrih8CzUKZdDHLBIEseU2tZ
   e+q/nWXMjN7kxjIevB4JJ30QT+EWxSfCM5PU6Rm30xI4TtTKGKNcG9BXb
   bNol9Mc4ftc6/6436b82GfsRRZ/Nzc5znFaz+RrKRA7BBSQaIlAGY2NmE
   6WFwAARnRnbi2ESembHJYIAfkTdDgAWCidVmqmjDMRk6wScX+nIHVKNgP
   w==;
X-CSE-ConnectionGUID: 8Dd5lULFSqSyXoAMpjtTwA==
X-CSE-MsgGUID: 7NdW80GpTRel8Pqs3yBeXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61489964"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61489964"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 18:58:44 -0700
X-CSE-ConnectionGUID: uCXbLUXmRxehKCeiFvuH/A==
X-CSE-MsgGUID: vc2P2cxGS5ujUsnH2zHRzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="178188959"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 29 Sep 2025 18:58:40 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3PdV-0000p5-1R;
	Tue, 30 Sep 2025 01:58:37 +0000
Date: Tue, 30 Sep 2025 09:57:37 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Sun <sunjunchao@bytedance.com>, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, clm@fb.com, dsterba@suse.com,
	xiubli@redhat.com, idryomov@gmail.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, jaegeuk@kernel.org, chao@kernel.org,
	willy@infradead.org, jack@suse.cz, brauner@kernel.org,
	agruenba@redhat.com
Subject: Re: [PATCH v2] fs: Make wbc_to_tag() inline and use it in fs.
Message-ID: <202509300940.yjAtss49-lkp@intel.com>
References: <20250929111349.448324-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929111349.448324-1-sunjunchao@bytedance.com>

Hi Julian,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on ceph-client/testing ceph-client/for-linus tytso-ext4/dev jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev gfs2/for-next akpm-mm/mm-everything linus/master v6.17 next-20250929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Julian-Sun/fs-Make-wbc_to_tag-inline-and-use-it-in-fs/20250929-191847
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20250929111349.448324-1-sunjunchao%40bytedance.com
patch subject: [PATCH v2] fs: Make wbc_to_tag() inline and use it in fs.
config: arc-randconfig-001-20250930 (https://download.01.org/0day-ci/archive/20250930/202509300940.yjAtss49-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250930/202509300940.yjAtss49-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509300940.yjAtss49-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/page-writeback.c: In function 'writeback_get_folio':
>> mm/page-writeback.c:2456:5: error: implicit declaration of function 'wbc_to_tag' [-Werror=implicit-function-declaration]
    2456 |     wbc_to_tag(wbc), &wbc->fbatch);
         |     ^~~~~~~~~~
   cc1: some warnings being treated as errors
--
   fs/f2fs/data.c: In function 'f2fs_write_cache_pages':
>> fs/f2fs/data.c:3006:8: error: implicit declaration of function 'wbc_to_tag' [-Werror=implicit-function-declaration]
    3006 |  tag = wbc_to_tag(wbc);
         |        ^~~~~~~~~~
   cc1: some warnings being treated as errors
--
   fs/btrfs/extent_io.c: In function 'extent_write_cache_pages':
>> fs/btrfs/extent_io.c:2463:8: error: implicit declaration of function 'wbc_to_tag' [-Werror=implicit-function-declaration]
    2463 |  tag = wbc_to_tag(wbc);
         |        ^~~~~~~~~~
   cc1: some warnings being treated as errors
--
   fs/ext4/inode.c: In function 'mpage_prepare_extent_to_map':
>> fs/ext4/inode.c:2622:8: error: implicit declaration of function 'wbc_to_tag' [-Werror=implicit-function-declaration]
    2622 |  tag = wbc_to_tag(mpd->wbc);
         |        ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/wbc_to_tag +2456 mm/page-writeback.c

751e0d559c62a8 Matthew Wilcox (Oracle  2024-02-15  2444) 
e6d0ab87c8efe9 Matthew Wilcox (Oracle  2024-02-15  2445) static struct folio *writeback_get_folio(struct address_space *mapping,
751e0d559c62a8 Matthew Wilcox (Oracle  2024-02-15  2446) 		struct writeback_control *wbc)
751e0d559c62a8 Matthew Wilcox (Oracle  2024-02-15  2447) {
e6d0ab87c8efe9 Matthew Wilcox (Oracle  2024-02-15  2448) 	struct folio *folio;
e6d0ab87c8efe9 Matthew Wilcox (Oracle  2024-02-15  2449) 
a2cbc13638d909 Matthew Wilcox (Oracle  2024-02-15  2450) retry:
e6d0ab87c8efe9 Matthew Wilcox (Oracle  2024-02-15  2451) 	folio = folio_batch_next(&wbc->fbatch);
e6d0ab87c8efe9 Matthew Wilcox (Oracle  2024-02-15  2452) 	if (!folio) {
751e0d559c62a8 Matthew Wilcox (Oracle  2024-02-15  2453) 		folio_batch_release(&wbc->fbatch);
751e0d559c62a8 Matthew Wilcox (Oracle  2024-02-15  2454) 		cond_resched();
751e0d559c62a8 Matthew Wilcox (Oracle  2024-02-15  2455) 		filemap_get_folios_tag(mapping, &wbc->index, wbc_end(wbc),
751e0d559c62a8 Matthew Wilcox (Oracle  2024-02-15 @2456) 				wbc_to_tag(wbc), &wbc->fbatch);
e6d0ab87c8efe9 Matthew Wilcox (Oracle  2024-02-15  2457) 		folio = folio_batch_next(&wbc->fbatch);
a2cbc13638d909 Matthew Wilcox (Oracle  2024-02-15  2458) 		if (!folio)
a2cbc13638d909 Matthew Wilcox (Oracle  2024-02-15  2459) 			return NULL;
e6d0ab87c8efe9 Matthew Wilcox (Oracle  2024-02-15  2460) 	}
e6d0ab87c8efe9 Matthew Wilcox (Oracle  2024-02-15  2461) 
a2cbc13638d909 Matthew Wilcox (Oracle  2024-02-15  2462) 	folio_lock(folio);
a2cbc13638d909 Matthew Wilcox (Oracle  2024-02-15  2463) 	if (unlikely(!folio_prepare_writeback(mapping, wbc, folio))) {
a2cbc13638d909 Matthew Wilcox (Oracle  2024-02-15  2464) 		folio_unlock(folio);
a2cbc13638d909 Matthew Wilcox (Oracle  2024-02-15  2465) 		goto retry;
a2cbc13638d909 Matthew Wilcox (Oracle  2024-02-15  2466) 	}
a2cbc13638d909 Matthew Wilcox (Oracle  2024-02-15  2467) 
a2cbc13638d909 Matthew Wilcox (Oracle  2024-02-15  2468) 	trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
e6d0ab87c8efe9 Matthew Wilcox (Oracle  2024-02-15  2469) 	return folio;
751e0d559c62a8 Matthew Wilcox (Oracle  2024-02-15  2470) }
751e0d559c62a8 Matthew Wilcox (Oracle  2024-02-15  2471) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

