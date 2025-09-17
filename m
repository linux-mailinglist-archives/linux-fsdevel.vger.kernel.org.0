Return-Path: <linux-fsdevel+bounces-62032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 604B8B82015
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50341891A3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAD030DED7;
	Wed, 17 Sep 2025 21:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3EM8y5L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996222BDC33;
	Wed, 17 Sep 2025 21:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145286; cv=none; b=ucqgt3Con/TN2wH5aNYoELYazM7hn0yKAS0plPojXLEFO8R8X1U3/4Z2PKFLKQplIKDO4kCYOeu+WWNg7PXLubI1VxSC3YkMmkYBD9riSc1zx5T9g2bxcgPXSK3Zcbia4oZu3d/DA3fYBA/zYbdOycN36gi6OS7nTFYiKi5XhpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145286; c=relaxed/simple;
	bh=LFfVCJuauYXP84lOUN45XcIK3FpxUQkSFwCjspvozzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elhQBRVriEifu+rvrwK2cQdUEDyILH+2fBYkbVR3cs8WT2J9df4BPIIXH5A8O5bW1d0jNdLF1E2EZT+UaPBtpPpogj2++KLznRQICrzBO7HgIMojlLK5nqVBTbrej+bqT8kqqrU7U2QMsXX/g8D7bk0DWqzv4RGUh13QZA1BJ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3EM8y5L; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758145285; x=1789681285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LFfVCJuauYXP84lOUN45XcIK3FpxUQkSFwCjspvozzM=;
  b=M3EM8y5LwuXMrJhJcPmVb4pNwZtzgXCf6FimY554COa85vYcl+qsfRtE
   BhHrbzJkbVF4/erBfNhGUUczecVn3eXLGiL9fTOZN/VQT5+0Sxn2Ymgnn
   lQJ/OUew8m8KxT0t0ZRxm/MO67zBnU7Ffo24hMCfk6vbzyjzFGuTg8J3o
   eZYpwukWq4OXR7Y/NZ1nAyo1kL/jQEh1kPvicqWp9q7f6wH20D3QCSP8C
   mv0Vk5HowRX+AI5vKLpn5JR1RHew27uMudkXG17KVoobrsoV+yjToY1FU
   kHOx3qO/VYcQOkneXbhekR693jsALLlPzuPmFzzv7pceRGzYhq+DEgpAh
   A==;
X-CSE-ConnectionGUID: 9eSqf2NLQi6c2Vm2zH5TSQ==
X-CSE-MsgGUID: 95k95iexRSanKUlcwIXo/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64268266"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64268266"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 14:41:25 -0700
X-CSE-ConnectionGUID: lSanHIgkQaaxnWD72A5IPg==
X-CSE-MsgGUID: 2DE8UQ91TFq3DAlmDMeSVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,273,1751266800"; 
   d="scan'208";a="206146643"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 17 Sep 2025 14:41:20 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyztu-0002Tf-2Z;
	Wed, 17 Sep 2025 21:41:18 +0000
Date: Thu, 18 Sep 2025 05:40:53 +0800
From: kernel test robot <lkp@intel.com>
To: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	miklos@szeredi.hu
Cc: oe-kbuild-all@lists.linux.dev, hch@infradead.org, djwong@kernel.org,
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 11/15] iomap: move buffered io bio logic into new file
Message-ID: <202509180515.Cc8A1Wu9-lkp@intel.com>
References: <20250916234425.1274735-12-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916234425.1274735-12-joannelkoong@gmail.com>

Hi Joanne,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on mszeredi-fuse/for-next axboe-block/for-next xiang-erofs/dev-test xiang-erofs/dev xiang-erofs/fixes gfs2/for-next xfs-linux/for-next linus/master v6.17-rc6 next-20250917]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/iomap-move-bio-read-logic-into-helper-function/20250917-075255
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250916234425.1274735-12-joannelkoong%40gmail.com
patch subject: [PATCH v3 11/15] iomap: move buffered io bio logic into new file
config: x86_64-randconfig-071-20250918 (https://download.01.org/0day-ci/archive/20250918/202509180515.Cc8A1Wu9-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250918/202509180515.Cc8A1Wu9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509180515.Cc8A1Wu9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/iomap/buffered-io.c:11:
>> fs/iomap/internal.h:13:5: warning: no previous prototype for 'iomap_bio_read_folio_range_sync' [-Wmissing-prototypes]
      13 | int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/iomap_bio_read_folio_range_sync +13 fs/iomap/internal.h

     8	
     9	#ifdef CONFIG_BLOCK
    10	int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
    11			struct folio *folio, loff_t pos, size_t len);
    12	#else
  > 13	int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
    14			struct folio *folio, loff_t pos, size_t len)
    15	{
    16		WARN_ON_ONCE(1);
    17		return -EIO;
    18	}
    19	#endif /* CONFIG_BLOCK */
    20	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

