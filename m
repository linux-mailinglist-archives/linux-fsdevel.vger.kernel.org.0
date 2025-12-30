Return-Path: <linux-fsdevel+bounces-72247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA316CE9D60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 14:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96DA73015D09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8294F23C4F3;
	Tue, 30 Dec 2025 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YEA+GjbP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620B723F439;
	Tue, 30 Dec 2025 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767103146; cv=none; b=Cz/MzdzFEuvpUP1j0ZDjfntmoDGKJz1gk3TVza+4qekJiQgi+TR2QYwMSERu+eofu3Ad9y+HzVuwzxHVgGMinDgzf96rrZYDUcKw6EFTSVKrP2ZVfnNjMjzPemdO0rcdWlrZO9ervcVb7JXmzhHfKtFupUHuVN59M7Pn/H9yV1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767103146; c=relaxed/simple;
	bh=zr0a5l35puzJeHz5VaAboFBERkXHqdW6CLGXMWN6V2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwSCua/8omyCKHxaU/gWt1N3l8XsTkbASJmmT3tBzz2n/gRLvTenV3ygPaV7+IxGFDGosXyLMJcdoeLN1M1ljsAdJhHeA59IKwktuOb7N8uL5e1/zsd9Qq5VCja3H9/J+LBoaX+6JJzggs4YZe0EF9Y4XGGH2SSBfWrK1JsRLdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YEA+GjbP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767103145; x=1798639145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zr0a5l35puzJeHz5VaAboFBERkXHqdW6CLGXMWN6V2U=;
  b=YEA+GjbPBNcH0Z7u0KAd95S7tls22nz6EKr2KL6b8gPeYvOBSmzRPT/s
   wfkH8KI4JnSBzVjpSTO8NTDYhLHKTTlXk2gOkzSEk3frti+oKQNJZzetM
   tvkO3t+naDpCRBWmCHI28hDtPLPZxnw0JOTkIaAo7nD4DxlHN7JXoLbHq
   TleNUGQfHCv+ZK12q5Obf4LYpDcF835a1vQucMge+N5cq7vPM71sB4Er6
   502C5hpbW6hhe94trMab0ZXPtoOyyYJc8hnLAWfq6L9+x0f9POobRNGOT
   cvNt4ngmoq6zLkz+Bjlw04uOsfBD795/5x+udrt1XNZ4qJqp982rsV+rh
   A==;
X-CSE-ConnectionGUID: gZdrWcxEQ76BqUjQqjK/3Q==
X-CSE-MsgGUID: 9EGkRAC0RcSoWDiTzvjOgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="72541480"
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="72541480"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 05:59:03 -0800
X-CSE-ConnectionGUID: nIYqTiGvR+CNWAFQDPM1xw==
X-CSE-MsgGUID: fSZUODPgT86ktuzo8cygIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="201217997"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 30 Dec 2025 05:59:01 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vaaFW-000000000QV-14l8;
	Tue, 30 Dec 2025 13:58:58 +0000
Date: Tue, 30 Dec 2025 21:58:41 +0800
From: kernel test robot <lkp@intel.com>
To: Yuto Ohnuki <ytohnuki@amazon.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Yuto Ohnuki <ytohnuki@amazon.com>
Subject: Re: [PATCH] fs: remove stale and duplicate forward declarations
Message-ID: <202512302105.pmzYfmcV-lkp@intel.com>
References: <20251229071401.98146-1-ytohnuki@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229071401.98146-1-ytohnuki@amazon.com>

Hi Yuto,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v6.19-rc3 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuto-Ohnuki/fs-remove-stale-and-duplicate-forward-declarations/20251229-151612
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20251229071401.98146-1-ytohnuki%40amazon.com
patch subject: [PATCH] fs: remove stale and duplicate forward declarations
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20251230/202512302105.pmzYfmcV-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 86b9f90b9574b3a7d15d28a91f6316459dcfa046)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251230/202512302105.pmzYfmcV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512302105.pmzYfmcV-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from block/ioctl.c:4:
   include/linux/blkdev.h:1656:41: warning: declaration of 'struct hd_geometry' will not be visible outside of this function [-Wvisibility]
    1656 |         int (*getgeo)(struct gendisk *, struct hd_geometry *);
         |                                                ^
>> block/ioctl.c:564:33: error: incompatible pointer types passing 'struct hd_geometry *' to parameter of type 'struct hd_geometry *' [-Wincompatible-pointer-types]
     564 |         ret = disk->fops->getgeo(disk, &geo);
         |                                        ^~~~
   1 warning and 1 error generated.


vim +564 block/ioctl.c

d30a2605be9d51 David Woodhouse   2008-08-11  545  
d8e4bb8103df02 Christoph Hellwig 2015-10-15  546  static int blkdev_getgeo(struct block_device *bdev,
d8e4bb8103df02 Christoph Hellwig 2015-10-15  547  		struct hd_geometry __user *argp)
d8e4bb8103df02 Christoph Hellwig 2015-10-15  548  {
d8e4bb8103df02 Christoph Hellwig 2015-10-15  549  	struct gendisk *disk = bdev->bd_disk;
a885c8c4316e1c Christoph Hellwig 2006-01-08  550  	struct hd_geometry geo;
d8e4bb8103df02 Christoph Hellwig 2015-10-15  551  	int ret;
a885c8c4316e1c Christoph Hellwig 2006-01-08  552  
d8e4bb8103df02 Christoph Hellwig 2015-10-15  553  	if (!argp)
a885c8c4316e1c Christoph Hellwig 2006-01-08  554  		return -EINVAL;
a885c8c4316e1c Christoph Hellwig 2006-01-08  555  	if (!disk->fops->getgeo)
a885c8c4316e1c Christoph Hellwig 2006-01-08  556  		return -ENOTTY;
a885c8c4316e1c Christoph Hellwig 2006-01-08  557  
a885c8c4316e1c Christoph Hellwig 2006-01-08  558  	/*
a885c8c4316e1c Christoph Hellwig 2006-01-08  559  	 * We need to set the startsect first, the driver may
a885c8c4316e1c Christoph Hellwig 2006-01-08  560  	 * want to override it.
a885c8c4316e1c Christoph Hellwig 2006-01-08  561  	 */
a014741c0adfb8 Vasiliy Kulikov   2010-11-08  562  	memset(&geo, 0, sizeof(geo));
a885c8c4316e1c Christoph Hellwig 2006-01-08  563  	geo.start = get_start_sect(bdev);
4fc8728aa34f54 Al Viro           2024-05-21 @564  	ret = disk->fops->getgeo(disk, &geo);
a885c8c4316e1c Christoph Hellwig 2006-01-08  565  	if (ret)
a885c8c4316e1c Christoph Hellwig 2006-01-08  566  		return ret;
d8e4bb8103df02 Christoph Hellwig 2015-10-15  567  	if (copy_to_user(argp, &geo, sizeof(geo)))
a885c8c4316e1c Christoph Hellwig 2006-01-08  568  		return -EFAULT;
a885c8c4316e1c Christoph Hellwig 2006-01-08  569  	return 0;
a885c8c4316e1c Christoph Hellwig 2006-01-08  570  }
d8e4bb8103df02 Christoph Hellwig 2015-10-15  571  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

