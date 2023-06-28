Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBEB7411C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 14:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjF1MzI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 08:55:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:58763 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231949AbjF1Mww (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687956772; x=1719492772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V7/fQJ+HZXkDt0pOeY106FEB7wN/9WZJhnYeLYgacr4=;
  b=QTOXyIeDQJ6w003pbFufKbvW2L00OKKyS8+y8CqQw3JjyCSg/INA092f
   zRQV8/2ZLkeCShbwT8cYUaZ9ZMQV+41gYhybYPXKQHBGck5/OHMhC5DAT
   7qRt+PQw/h29vSJnnqNwpp2VOwQpnSc46kCThl9uBFRchkW2HlcbflFj0
   Y0y+m4kt+ZRL3zYbg4lpnFmiIbkgQ+AZwwY39cH/3hc2DcsUI/aMgmL/S
   9dFxjvIWF79i6xRSOPTXTkfIC/5exkAyUb/UxSxFx3aKARGnz/V9gj/h2
   mpt6tv183WzpwGzWo1FLdmEpI5MDdieXrhabf515mORh0bWpHwoaVhoLl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="427840678"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="427840678"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 05:52:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="752247641"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="752247641"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 28 Jun 2023 05:52:41 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEUf2-000DGN-2m;
        Wed, 28 Jun 2023 12:52:40 +0000
Date:   Wed, 28 Jun 2023 20:52:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, dlemoal@kernel.org,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Anuj Gupta <anuj20.g@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 9/9] null_blk: add support for copy offload
Message-ID: <202306282001.ba1qWTf0-lkp@intel.com>
References: <20230627183629.26571-10-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627183629.26571-10-nj.shetty@samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Nitesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 53cdf865f90ba922a854c65ed05b519f9d728424]

url:    https://github.com/intel-lab-lkp/linux/commits/Nitesh-Shetty/block-Introduce-queue-limits-for-copy-offload-support/20230628-163126
base:   53cdf865f90ba922a854c65ed05b519f9d728424
patch link:    https://lore.kernel.org/r/20230627183629.26571-10-nj.shetty%40samsung.com
patch subject: [PATCH v13 9/9] null_blk: add support for copy offload
config: i386-randconfig-i006-20230628 (https://download.01.org/0day-ci/archive/20230628/202306282001.ba1qWTf0-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230628/202306282001.ba1qWTf0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306282001.ba1qWTf0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/block/null_blk/main.c:1295:2: warning: variable 'rem' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           __rq_for_each_bio(bio, req) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/blk-mq.h:1012:6: note: expanded from macro '__rq_for_each_bio'
           if ((rq->bio))                  \
               ^~~~~~~~~
   drivers/block/null_blk/main.c:1300:15: note: uninitialized use occurs here
           if (WARN_ON(!rem))
                        ^~~
   include/asm-generic/bug.h:123:25: note: expanded from macro 'WARN_ON'
           int __ret_warn_on = !!(condition);                              \
                                  ^~~~~~~~~
   drivers/block/null_blk/main.c:1295:2: note: remove the 'if' if its condition is always true
           __rq_for_each_bio(bio, req) {
           ^
   include/linux/blk-mq.h:1012:2: note: expanded from macro '__rq_for_each_bio'
           if ((rq->bio))                  \
           ^
   drivers/block/null_blk/main.c:1287:12: note: initialize the variable 'rem' to silence this warning
           size_t rem, temp;
                     ^
                      = 0
   1 warning generated.


vim +1295 drivers/block/null_blk/main.c

  1281	
  1282	static inline int nullb_setup_copy_write(struct nullb *nullb,
  1283			struct request *req, bool is_fua)
  1284	{
  1285		sector_t sector_in, sector_out;
  1286		void *in, *out;
  1287		size_t rem, temp;
  1288		struct bio *bio;
  1289		unsigned long offset_in, offset_out;
  1290		struct nullb_page *t_page_in, *t_page_out;
  1291		int ret = -EIO;
  1292	
  1293		sector_out = blk_rq_pos(req);
  1294	
> 1295		__rq_for_each_bio(bio, req) {
  1296			sector_in = bio->bi_iter.bi_sector;
  1297			rem = bio->bi_iter.bi_size;
  1298		}
  1299	
  1300		if (WARN_ON(!rem))
  1301			return BLK_STS_NOTSUPP;
  1302	
  1303		spin_lock_irq(&nullb->lock);
  1304		while (rem > 0) {
  1305			temp = min_t(size_t, nullb->dev->blocksize, rem);
  1306			offset_in = (sector_in & SECTOR_MASK) << SECTOR_SHIFT;
  1307			offset_out = (sector_out & SECTOR_MASK) << SECTOR_SHIFT;
  1308	
  1309			if (null_cache_active(nullb) && !is_fua)
  1310				null_make_cache_space(nullb, PAGE_SIZE);
  1311	
  1312			t_page_in = null_lookup_page(nullb, sector_in, false,
  1313				!null_cache_active(nullb));
  1314			if (!t_page_in)
  1315				goto err;
  1316			t_page_out = null_insert_page(nullb, sector_out,
  1317				!null_cache_active(nullb) || is_fua);
  1318			if (!t_page_out)
  1319				goto err;
  1320	
  1321			in = kmap_local_page(t_page_in->page);
  1322			out = kmap_local_page(t_page_out->page);
  1323	
  1324			memcpy(out + offset_out, in + offset_in, temp);
  1325			kunmap_local(out);
  1326			kunmap_local(in);
  1327			__set_bit(sector_out & SECTOR_MASK, t_page_out->bitmap);
  1328	
  1329			if (is_fua)
  1330				null_free_sector(nullb, sector_out, true);
  1331	
  1332			rem -= temp;
  1333			sector_in += temp >> SECTOR_SHIFT;
  1334			sector_out += temp >> SECTOR_SHIFT;
  1335		}
  1336	
  1337		ret = 0;
  1338	err:
  1339		spin_unlock_irq(&nullb->lock);
  1340		return ret;
  1341	}
  1342	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
