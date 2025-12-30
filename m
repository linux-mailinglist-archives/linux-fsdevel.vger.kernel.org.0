Return-Path: <linux-fsdevel+bounces-72246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5720CE9D66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 14:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82ED5301FC0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D44242D7F;
	Tue, 30 Dec 2025 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fa2A+fVy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83288221F06;
	Tue, 30 Dec 2025 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767103145; cv=none; b=KqrseKk2IbSIdSt/hnm1v8zgdyhs4K0h6WZPnohpoq3QUA/KXiKauph8o2XdYUh/y5m/STbrW5EoNNC+NimXL5BYGpz+DzuVSUNej64/qyS22TtiWOvmEA2AxBxX14V2k88PwJSVFxCaxkl0+EIUledw/iz20IsKOldqxvgmttA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767103145; c=relaxed/simple;
	bh=7NMdGuYD5bOH/FpLOWsysMA0IhxfI/E8nBordouRb98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLLBmcGXysos9/2ZiHVBhlIYwflFZ/jc0rNA409IWMGnhz3P7KYhNIXpSEe6dR0D05aGTkCO8IV69aVeFYfH/RRkxR1A9oeokxGswH7YK3d1y5xTQY2S46UOijS1u72l0/KIM2LtCw+etUuWUfircrTIHZmM0K7tmnbDXmW1X2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fa2A+fVy; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767103144; x=1798639144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7NMdGuYD5bOH/FpLOWsysMA0IhxfI/E8nBordouRb98=;
  b=fa2A+fVy0jXp0TQg+1jgWrAZbjfbbGBb+tbbpXlhJEgtymMF16fTdZNw
   rcU3J18z1istlCjFA3KsOd8FDvgmZ2rZ7bndBsRETHUW4pue+utgO1z/P
   QlKtBQ37nU4jJ+Y7z+bhf5gfIhG+y/Djwnp79QHClU4Y4auqUdJEdk9bG
   RTxVI1ztiEVTr7aF5o8pEbYJTEJAqpWkWWU+HhnXjJFz/BQOoAwC9AHm9
   8LMK33jRlTmhqh8S58yRUk/jW9kh5Z6KiCbT77ZgUgMwi7k3jl0GVMVDp
   HDc7isYGVRFTCrD/HuLaciIst1/VrNm7srSf98b/Fjywu4UtA26w52Yvv
   Q==;
X-CSE-ConnectionGUID: H2w0+RdkRACZVueJQIBbOA==
X-CSE-MsgGUID: kYmQV2dqSBadx1tp3N8GcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="72541472"
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="72541472"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 05:59:03 -0800
X-CSE-ConnectionGUID: mzBiJ0LPQIqIodlzBN48jw==
X-CSE-MsgGUID: 520gFskfTnSeGNTOM/Kk5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="201217999"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 30 Dec 2025 05:59:01 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vaaFW-000000000QX-19WS;
	Tue, 30 Dec 2025 13:58:58 +0000
Date: Tue, 30 Dec 2025 21:58:42 +0800
From: kernel test robot <lkp@intel.com>
To: Yuto Ohnuki <ytohnuki@amazon.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Yuto Ohnuki <ytohnuki@amazon.com>
Subject: Re: [PATCH] fs: remove stale and duplicate forward declarations
Message-ID: <202512302125.FNgHwu5z-lkp@intel.com>
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
config: nios2-allnoconfig (https://download.01.org/0day-ci/archive/20251230/202512302125.FNgHwu5z-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251230/202512302125.FNgHwu5z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512302125.FNgHwu5z-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from block/bdev.c:14:
>> include/linux/blkdev.h:1656:48: warning: 'struct hd_geometry' declared inside parameter list will not be visible outside of this definition or declaration
    1656 |         int (*getgeo)(struct gendisk *, struct hd_geometry *);
         |                                                ^~~~~~~~~~~
--
   In file included from block/ioctl.c:4:
>> include/linux/blkdev.h:1656:48: warning: 'struct hd_geometry' declared inside parameter list will not be visible outside of this definition or declaration
    1656 |         int (*getgeo)(struct gendisk *, struct hd_geometry *);
         |                                                ^~~~~~~~~~~
   block/ioctl.c: In function 'blkdev_getgeo':
>> block/ioctl.c:564:40: error: passing argument 2 of 'disk->fops->getgeo' from incompatible pointer type [-Werror=incompatible-pointer-types]
     564 |         ret = disk->fops->getgeo(disk, &geo);
         |                                        ^~~~
         |                                        |
         |                                        struct hd_geometry *
   block/ioctl.c:564:40: note: expected 'struct hd_geometry *' but argument is of type 'struct hd_geometry *'
   cc1: some warnings being treated as errors


vim +1656 include/linux/blkdev.h

9208d414975895 Christoph Hellwig 2021-10-21  1642  
08f85851215100 Al Viro           2007-10-08  1643  struct block_device_operations {
3e08773c3841e9 Christoph Hellwig 2021-10-12  1644  	void (*submit_bio)(struct bio *bio);
69fe0f29892077 Ming Lei          2022-03-04  1645  	int (*poll_bio)(struct bio *bio, struct io_comp_batch *iob,
69fe0f29892077 Ming Lei          2022-03-04  1646  			unsigned int flags);
05bdb9965305bb Christoph Hellwig 2023-06-08  1647  	int (*open)(struct gendisk *disk, blk_mode_t mode);
ae220766d87cd6 Christoph Hellwig 2023-06-08  1648  	void (*release)(struct gendisk *disk);
05bdb9965305bb Christoph Hellwig 2023-06-08  1649  	int (*ioctl)(struct block_device *bdev, blk_mode_t mode,
05bdb9965305bb Christoph Hellwig 2023-06-08  1650  			unsigned cmd, unsigned long arg);
05bdb9965305bb Christoph Hellwig 2023-06-08  1651  	int (*compat_ioctl)(struct block_device *bdev, blk_mode_t mode,
05bdb9965305bb Christoph Hellwig 2023-06-08  1652  			unsigned cmd, unsigned long arg);
77ea887e433ad8 Tejun Heo         2010-12-08  1653  	unsigned int (*check_events) (struct gendisk *disk,
77ea887e433ad8 Tejun Heo         2010-12-08  1654  				      unsigned int clearing);
c3e33e043f5e9c Tejun Heo         2010-05-15  1655  	void (*unlock_native_capacity) (struct gendisk *);
4fc8728aa34f54 Al Viro           2024-05-21 @1656  	int (*getgeo)(struct gendisk *, struct hd_geometry *);
e00adcadf3af7a Christoph Hellwig 2020-11-03  1657  	int (*set_read_only)(struct block_device *bdev, bool ro);
76792055c4c8b2 Christoph Hellwig 2022-02-15  1658  	void (*free_disk)(struct gendisk *disk);
b3a27d0529c6e5 Nitin Gupta       2010-05-17  1659  	/* this callback is with swap_lock and sometimes page table lock held */
b3a27d0529c6e5 Nitin Gupta       2010-05-17  1660  	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
e76239a3748c90 Christoph Hellwig 2018-10-12  1661  	int (*report_zones)(struct gendisk *, sector_t sector,
fdb9aed869f34d Damien Le Moal    2025-11-05  1662  			    unsigned int nr_zones,
fdb9aed869f34d Damien Le Moal    2025-11-05  1663  			    struct blk_report_zones_args *args);
050a4f341f35bf Jens Axboe        2023-01-04  1664  	char *(*devnode)(struct gendisk *disk, umode_t *mode);
9208d414975895 Christoph Hellwig 2021-10-21  1665  	/* returns the length of the identifier or a negative errno: */
9208d414975895 Christoph Hellwig 2021-10-21  1666  	int (*get_unique_id)(struct gendisk *disk, u8 id[16],
9208d414975895 Christoph Hellwig 2021-10-21  1667  			enum blk_unique_id id_type);
08f85851215100 Al Viro           2007-10-08  1668  	struct module *owner;
bbd3e064362e50 Christoph Hellwig 2015-10-15  1669  	const struct pr_ops *pr_ops;
0bdfbca8a623e2 Dmitry Osipenko   2021-08-20  1670  
0bdfbca8a623e2 Dmitry Osipenko   2021-08-20  1671  	/*
0bdfbca8a623e2 Dmitry Osipenko   2021-08-20  1672  	 * Special callback for probing GPT entry at a given sector.
0bdfbca8a623e2 Dmitry Osipenko   2021-08-20  1673  	 * Needed by Android devices, used by GPT scanner and MMC blk
0bdfbca8a623e2 Dmitry Osipenko   2021-08-20  1674  	 * driver.
0bdfbca8a623e2 Dmitry Osipenko   2021-08-20  1675  	 */
0bdfbca8a623e2 Dmitry Osipenko   2021-08-20  1676  	int (*alternative_gpt_sector)(struct gendisk *disk, sector_t *sector);
08f85851215100 Al Viro           2007-10-08  1677  };
08f85851215100 Al Viro           2007-10-08  1678  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

