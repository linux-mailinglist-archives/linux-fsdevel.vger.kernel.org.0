Return-Path: <linux-fsdevel+bounces-64562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B54BEC587
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 04:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D7D19A74CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 02:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67D3242D9D;
	Sat, 18 Oct 2025 02:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bRBpL8hd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78579134CB;
	Sat, 18 Oct 2025 02:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760755140; cv=none; b=egqp2lc0Pcca7cwZ+/U8VZ4IQs8ISOb+TC0YNfdpsklRVu2ER8rQQ9llnz8X15902Q8m+JMY+QWb+VlcZWk4Of3dwDAW/2O9VzdXWVALPOuZYaIY7wzDVPnsueoJURoH6DNz3uQm4gyJv9cVNDpRYA2m4Fqi6mzBP5T57b//nok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760755140; c=relaxed/simple;
	bh=/ZPmH4lYkHsggufwvRdkbwQ+doZooO3d11W3wHF8eTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYMl5iC3iakbLV6Ow33t7lGeS9L34z9bqyn6ozkpQtq61qcmSf/nGs07Z2P/uCdfKsII3yqQgOEVka1QX8VRLBjRj1lVY90WzfwiJJ0ydOlw3yH+CMtBODc3uLZXUZRbVOkfI21r/uqaNAPWdoCOVqxpDhfOrcfn+fbeETtQ+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bRBpL8hd; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760755138; x=1792291138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/ZPmH4lYkHsggufwvRdkbwQ+doZooO3d11W3wHF8eTQ=;
  b=bRBpL8hddjgwYu0MivnHWEwwFi/f5KefZDTNiFm8oLKC53IrEOcuF91E
   DWKSSqT/EnTZI+/YLvBJv78XLyQgjqh7GBFg4iJC4jOxFz2+mWkaZdGrg
   Bs9HpecmoRogN0/TDUYF/I5VbI8mXIMcPGn6FtTK+ArYyAZTcCHGn8MUk
   Aow8i4jw14MSbAmcXiCBTbQbW5q5GgQ5jMQLQm92H/p0ezDWLErFpNIHD
   8OtfFAucbvJ0GC7m2zPXeZt6m2Oi3bGM1A81/9D5JiU7ucTRh5W8XGv62
   nn4rJLX4Zv9VofTrjal61t0xOoA8z9ZoepgR43tga1ryYVUm/M0k9fykF
   g==;
X-CSE-ConnectionGUID: j4VdCiv2TDSWeLonYfk2kQ==
X-CSE-MsgGUID: BfG8O2pOSbqruQsCsENpjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="62002275"
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="62002275"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 19:38:58 -0700
X-CSE-ConnectionGUID: 2DnvxapsRK+7j8rtICLRzg==
X-CSE-MsgGUID: GxiTUOrDQKmJFNciETW/fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="182064327"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 17 Oct 2025 19:38:54 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9wqI-00080Z-2r;
	Sat, 18 Oct 2025 02:38:50 +0000
Date: Sat, 18 Oct 2025 10:38:42 +0800
From: kernel test robot <lkp@intel.com>
To: Kiryl Shutsemau <kirill@shutemov.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
Message-ID: <202510181054.Fmf1S18u-lkp@intel.com>
References: <20251017141536.577466-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017141536.577466-1-kirill@shutemov.name>

Hi Kiryl,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Kiryl-Shutsemau/mm-filemap-Implement-fast-short-reads/20251017-221655
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251017141536.577466-1-kirill%40shutemov.name
patch subject: [PATCH] mm/filemap: Implement fast short reads
config: riscv-randconfig-001-20251018 (https://download.01.org/0day-ci/archive/20251018/202510181054.Fmf1S18u-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251018/202510181054.Fmf1S18u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510181054.Fmf1S18u-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/sched.h:45,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/dcache.h:8,
                    from include/linux/fs.h:9,
                    from fs/inode.c:7:
   fs/inode.c: In function '__address_space_init_once':
>> fs/inode.c:486:28: error: invalid type argument of '->' (have 'struct xarray')
              &mapping->i_pages->xa_lock);
                               ^~
   include/linux/seqlock_types.h:57:26: note: in definition of macro '__SEQ_LOCK'
    #define __SEQ_LOCK(expr) expr
                             ^~~~
   include/linux/seqlock.h:131:42: note: in expansion of macro 'seqcount_LOCKNAME_init'
    #define seqcount_spinlock_init(s, lock)  seqcount_LOCKNAME_init(s, lock, spinlock)
                                             ^~~~~~~~~~~~~~~~~~~~~~
   fs/inode.c:485:2: note: in expansion of macro 'seqcount_spinlock_init'
     seqcount_spinlock_init(&mapping->i_pages_delete_seqcnt,
     ^~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ARCH_HAS_ELF_CORE_EFLAGS
   Depends on [n]: BINFMT_ELF [=n] && ELF_CORE [=n]
   Selected by [y]:
   - RISCV [=y]


vim +486 fs/inode.c

   481	
   482	static void __address_space_init_once(struct address_space *mapping)
   483	{
   484		xa_init_flags(&mapping->i_pages, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ACCOUNT);
   485		seqcount_spinlock_init(&mapping->i_pages_delete_seqcnt,
 > 486				       &mapping->i_pages->xa_lock);
   487		init_rwsem(&mapping->i_mmap_rwsem);
   488		INIT_LIST_HEAD(&mapping->i_private_list);
   489		spin_lock_init(&mapping->i_private_lock);
   490		mapping->i_mmap = RB_ROOT_CACHED;
   491	}
   492	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

