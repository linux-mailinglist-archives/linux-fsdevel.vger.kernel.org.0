Return-Path: <linux-fsdevel+bounces-69039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE81C6C78B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 03:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF5E64F43B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 02:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAAC2DE6F1;
	Wed, 19 Nov 2025 02:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgZNmtWL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7602DC79C;
	Wed, 19 Nov 2025 02:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520711; cv=none; b=WFuDxUWg2e4tQQyCI+3Zv1jmNlr/3g6TKzwjDsFgdTLHWCmgmvIAGLoEHju3vESkFUmPTpsDDaf9PCdosDHfY03osfScoknB1E2pCjdXnMtpehN5yh0KC+7YWLONyqgMNB2I2JpQwbsdtzbiC8OY+Gw992eXvCaHetsHPvnXXpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520711; c=relaxed/simple;
	bh=f59lkW1kLsorsgVtNx1U5dbGIq5GqpNOYfD81YTZl84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UY8Kznpnp8H8wU20t58NGymHDYMuhhq6z7gK1rQZBPgbVICDov2q6LJKr6IiHT7r9KeCxAcfiLslzom+mKJrNX87Jmi6sOpbIMii8V1sOBmNMQYdr/RA0Uh8XTs3wCqk5Vmg0BnECk1KlEUrwzhfszhXzsdb3fnOhN7OGD8eELU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgZNmtWL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763520709; x=1795056709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f59lkW1kLsorsgVtNx1U5dbGIq5GqpNOYfD81YTZl84=;
  b=PgZNmtWLfdGW2jJJh0bP+vGjj4UelcnRs6ku5gbhF5d/Yd6e6oR4/lS2
   X5R95FbWCE7ZTAMUwzpSpe42dYxI4k/ZGoNArbSWW34E1PAe01DIBZUsh
   H1qHXiZw2iu7TDLX38bulSovZAAl0p9hPi4KTVJVeN4nPGV0F3e7AzzXh
   YCLdl2b/MdCAc2MY0IlWgPt+dh66Ibm37JueWGtshqKfEQ3Dp2YUUm3JG
   bwq0S/IlEl+k+2dl4gouTtPy4YQeFeAHsknqiJed0DXw94hmnw8+XnD9c
   rTy79UzaSxs2i10e74ORbt5zuS2kvlnz865k5xH6odtyVNRrVG/wD1YDb
   g==;
X-CSE-ConnectionGUID: Uv3MgbifTrqTdSdew6GGRg==
X-CSE-MsgGUID: zvthpDdFQPGIp4kghLF3KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76660157"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="76660157"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 18:51:48 -0800
X-CSE-ConnectionGUID: /UTULZkSSMeUHoEUgtgfBA==
X-CSE-MsgGUID: UGMkM4H5QlOWBxOgduCEMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="195855738"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 18 Nov 2025 18:51:47 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLYIL-0002NT-0I;
	Wed, 19 Nov 2025 02:51:45 +0000
Date: Wed, 19 Nov 2025 10:51:02 +0800
From: kernel test robot <lkp@intel.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: Re: [PATCH] fs/ntfs3: check for shutdown in fsync
Message-ID: <202511191004.GdiCxONs-lkp@intel.com>
References: <20251118130705.411336-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118130705.411336-1-almaz.alexandrovich@paragon-software.com>

Hi Konstantin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v6.18-rc6 next-20251118]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Konstantin-Komarov/fs-ntfs3-check-for-shutdown-in-fsync/20251118-210835
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20251118130705.411336-1-almaz.alexandrovich%40paragon-software.com
patch subject: [PATCH] fs/ntfs3: check for shutdown in fsync
config: i386-buildonly-randconfig-004-20251119 (https://download.01.org/0day-ci/archive/20251119/202511191004.GdiCxONs-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251119/202511191004.GdiCxONs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511191004.GdiCxONs-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/ntfs3/file.c:1381:5: warning: no previous prototype for function 'ntfs_file_fsync' [-Wmissing-prototypes]
    1381 | int ntfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync)
         |     ^
   fs/ntfs3/file.c:1381:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1381 | int ntfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync)
         | ^
         | static 
   fs/ntfs3/file.c:1415:12: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
    1415 |         .fsync          = ntfs_file_fsync,
         |                           ^~~~~~~~~~~~~~~
   fs/ntfs3/file.c:1412:12: note: previous initialization is here
    1412 |         .fsync          = generic_file_fsync,
         |                           ^~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +/ntfs_file_fsync +1381 fs/ntfs3/file.c

  1377	
  1378	/*
  1379	 * ntfs_file_fsync - file_operations::fsync
  1380	 */
> 1381	int ntfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync)
  1382	{
  1383		struct inode *inode = file_inode(file);
  1384		if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
  1385			return -EIO;
  1386	
  1387		return generic_file_fsync(file, start, end, datasync);
  1388	}
  1389	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

