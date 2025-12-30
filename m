Return-Path: <linux-fsdevel+bounces-72248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E20FCE9D6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 14:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51AB43006704
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 13:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5DB2417FB;
	Tue, 30 Dec 2025 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hhP+rDhb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A57242D76;
	Tue, 30 Dec 2025 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767103147; cv=none; b=DM3pEeV97bwj5PAIxWURxYO11R7w+ZYerv0TYain27aYzErxZ72xipHPosljZOWxCofVcuzRySZZp12gcVgt6Zin6Had3cbHQ+ffVgHRff1p3v4dtiqoc6T7l5ErzSEL2jCmevw/OfK9b6+bF6iotHPlXSr0nnu5ilyRJ+QEROE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767103147; c=relaxed/simple;
	bh=OksRJgvU8zlQcIDRIgwO1NsjY/+/9nbvL8rYxjG4X4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZcvHQOQDM6OOc3zNljFhmD8dX/j1c4VU8obArmaAJyjLTJB2P2TAcw+nlXsarjbq1ECXr671k1yHz2tLXnm3lDh5yX2A181jsg0QjVRr0aW6IJHjBZvaCk+0E+k30F15u2ndYYb/AB7hZb2YH/kTB2sVLQ1yEDJouRYs35ZNB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hhP+rDhb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767103146; x=1798639146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OksRJgvU8zlQcIDRIgwO1NsjY/+/9nbvL8rYxjG4X4w=;
  b=hhP+rDhbbA4t40ml7uMkPslluvGMa9njD9zdUpvxhcDljFnTH3uzdDYV
   0eIPPsNYvEAGac5NNZ8LT20yJXFjhKNaULPJSytDoy6AbH8yx9E+1hIGI
   GUGChKFI0CiPy0ymvJt8SLB2Vw3Ru3Mu9ZUj231XHvVzwl/DTBmAlfRii
   EkvJmHdU2E971/WunE+l/2jyUKkqT+QIHw1m99Z12LA4rVFHgJEmgRpDz
   pY7tdAbLen1hmwmWnaLR0Akw2OcY2M7+PPakWTyT0dRyhe+IefP5JiWFe
   yPjxdI+P6GpQ9NH3tQO4i239hlYbqOetMJu35ECqf9mp4Vo0VzU9Xwzci
   Q==;
X-CSE-ConnectionGUID: 1rhPycVlTpyAKOHa2JWbJA==
X-CSE-MsgGUID: nVs5L9+YSaW20pfIU9cFXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="72541486"
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="72541486"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 05:59:03 -0800
X-CSE-ConnectionGUID: XNxBiNSFS+Oh5TvNDeBnbA==
X-CSE-MsgGUID: Cq0f+igbRYuoswcP3DcGXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="201217998"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 30 Dec 2025 05:59:01 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vaaFW-000000000QT-11C8;
	Tue, 30 Dec 2025 13:58:58 +0000
Date: Tue, 30 Dec 2025 21:58:40 +0800
From: kernel test robot <lkp@intel.com>
To: Yuto Ohnuki <ytohnuki@amazon.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Yuto Ohnuki <ytohnuki@amazon.com>
Subject: Re: [PATCH] fs: remove stale and duplicate forward declarations
Message-ID: <202512302139.Wl0soAlz-lkp@intel.com>
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
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20251230/202512302139.Wl0soAlz-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251230/202512302139.Wl0soAlz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512302139.Wl0soAlz-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from block/bdev.c:14:
>> include/linux/blkdev.h:1656:41: warning: declaration of 'struct hd_geometry' will not be visible outside of this function [-Wvisibility]
    1656 |         int (*getgeo)(struct gendisk *, struct hd_geometry *);
         |                                                ^
   1 warning generated.
--
   In file included from block/ioctl.c:4:
>> include/linux/blkdev.h:1656:41: warning: declaration of 'struct hd_geometry' will not be visible outside of this function [-Wvisibility]
    1656 |         int (*getgeo)(struct gendisk *, struct hd_geometry *);
         |                                                ^
>> block/ioctl.c:564:33: error: incompatible pointer types passing 'struct hd_geometry *' to parameter of type 'struct hd_geometry *' [-Werror,-Wincompatible-pointer-types]
     564 |         ret = disk->fops->getgeo(disk, &geo);
         |                                        ^~~~
   1 warning and 1 error generated.


vim +564 block/ioctl.c

d30a2605be9d513 David Woodhouse   2008-08-11  545  
d8e4bb8103df02a Christoph Hellwig 2015-10-15  546  static int blkdev_getgeo(struct block_device *bdev,
d8e4bb8103df02a Christoph Hellwig 2015-10-15  547  		struct hd_geometry __user *argp)
d8e4bb8103df02a Christoph Hellwig 2015-10-15  548  {
d8e4bb8103df02a Christoph Hellwig 2015-10-15  549  	struct gendisk *disk = bdev->bd_disk;
a885c8c4316e1c1 Christoph Hellwig 2006-01-08  550  	struct hd_geometry geo;
d8e4bb8103df02a Christoph Hellwig 2015-10-15  551  	int ret;
a885c8c4316e1c1 Christoph Hellwig 2006-01-08  552  
d8e4bb8103df02a Christoph Hellwig 2015-10-15  553  	if (!argp)
a885c8c4316e1c1 Christoph Hellwig 2006-01-08  554  		return -EINVAL;
a885c8c4316e1c1 Christoph Hellwig 2006-01-08  555  	if (!disk->fops->getgeo)
a885c8c4316e1c1 Christoph Hellwig 2006-01-08  556  		return -ENOTTY;
a885c8c4316e1c1 Christoph Hellwig 2006-01-08  557  
a885c8c4316e1c1 Christoph Hellwig 2006-01-08  558  	/*
a885c8c4316e1c1 Christoph Hellwig 2006-01-08  559  	 * We need to set the startsect first, the driver may
a885c8c4316e1c1 Christoph Hellwig 2006-01-08  560  	 * want to override it.
a885c8c4316e1c1 Christoph Hellwig 2006-01-08  561  	 */
a014741c0adfb8f Vasiliy Kulikov   2010-11-08  562  	memset(&geo, 0, sizeof(geo));
a885c8c4316e1c1 Christoph Hellwig 2006-01-08  563  	geo.start = get_start_sect(bdev);
4fc8728aa34f548 Al Viro           2024-05-21 @564  	ret = disk->fops->getgeo(disk, &geo);
a885c8c4316e1c1 Christoph Hellwig 2006-01-08  565  	if (ret)
a885c8c4316e1c1 Christoph Hellwig 2006-01-08  566  		return ret;
d8e4bb8103df02a Christoph Hellwig 2015-10-15  567  	if (copy_to_user(argp, &geo, sizeof(geo)))
a885c8c4316e1c1 Christoph Hellwig 2006-01-08  568  		return -EFAULT;
a885c8c4316e1c1 Christoph Hellwig 2006-01-08  569  	return 0;
a885c8c4316e1c1 Christoph Hellwig 2006-01-08  570  }
d8e4bb8103df02a Christoph Hellwig 2015-10-15  571  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

