Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227683EF42D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 22:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbhHQUh3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 16:37:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:49830 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234027AbhHQUh2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 16:37:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="216187189"
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="gz'50?scan'50,208,50";a="216187189"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 13:36:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="gz'50?scan'50,208,50";a="531221721"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2021 13:36:50 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mG5pJ-000SBF-9L; Tue, 17 Aug 2021 20:36:49 +0000
Date:   Wed, 18 Aug 2021 04:35:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     SelvaKumar S <selvakuma.s1@samsung.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        asml.silence@gmail.com
Subject: Re: [PATCH 3/7] block: copy offload support infrastructure
Message-ID: <202108180431.JPZU44Bn-lkp@intel.com>
References: <20210817101423.12367-4-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20210817101423.12367-4-selvakuma.s1@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi SelvaKumar,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on block/for-next]
[also build test WARNING on dm/for-next linus/master v5.14-rc6 next-20210817]
[cannot apply to linux-nvme/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/SelvaKumar-S/block-make-bio_map_kern-non-static/20210817-193111
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: hexagon-randconfig-r013-20210816 (attached as .config)
compiler: clang version 12.0.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/35fc502a7f20a7cd42432cee2777a621c40a3bd3
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review SelvaKumar-S/block-make-bio_map_kern-non-static/20210817-193111
        git checkout 35fc502a7f20a7cd42432cee2777a621c40a3bd3
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=hexagon 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> block/blk-lib.c:197:5: warning: no previous prototype for function 'blk_copy_offload_submit_bio' [-Wmissing-prototypes]
   int blk_copy_offload_submit_bio(struct block_device *bdev,
       ^
   block/blk-lib.c:197:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int blk_copy_offload_submit_bio(struct block_device *bdev,
   ^
   static 
>> block/blk-lib.c:250:5: warning: no previous prototype for function 'blk_copy_offload_scc' [-Wmissing-prototypes]
   int blk_copy_offload_scc(struct block_device *src_bdev, int nr_srcs,
       ^
   block/blk-lib.c:250:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int blk_copy_offload_scc(struct block_device *src_bdev, int nr_srcs,
   ^
   static 
   2 warnings generated.


vim +/blk_copy_offload_submit_bio +197 block/blk-lib.c

   196	
 > 197	int blk_copy_offload_submit_bio(struct block_device *bdev,
   198			struct blk_copy_payload *payload, int payload_size,
   199			struct cio *cio, gfp_t gfp_mask)
   200	{
   201		struct request_queue *q = bdev_get_queue(bdev);
   202		struct bio *bio;
   203	
   204		bio = bio_map_kern(q, payload, payload_size, gfp_mask);
   205		if (IS_ERR(bio))
   206			return PTR_ERR(bio);
   207	
   208		bio_set_dev(bio, bdev);
   209		bio->bi_opf = REQ_OP_COPY | REQ_NOMERGE;
   210		bio->bi_iter.bi_sector = payload->dest;
   211		bio->bi_end_io = cio_bio_end_io;
   212		bio->bi_private = cio;
   213		atomic_inc(&cio->refcount);
   214		submit_bio(bio);
   215	
   216		return 0;
   217	}
   218	
   219	/* Go through all the enrties inside user provided payload, and determine the
   220	 * maximum number of entries in a payload, based on device's scc-limits.
   221	 */
   222	static inline int blk_max_payload_entries(int nr_srcs, struct range_entry *rlist,
   223			int max_nr_srcs, sector_t max_copy_range_sectors, sector_t max_copy_len)
   224	{
   225		sector_t range_len, copy_len = 0, remaining = 0;
   226		int ri = 0, pi = 1, max_pi = 0;
   227	
   228		for (ri = 0; ri < nr_srcs; ri++) {
   229			for (remaining = rlist[ri].len; remaining > 0; remaining -= range_len) {
   230				range_len = min3(remaining, max_copy_range_sectors,
   231									max_copy_len - copy_len);
   232				pi++;
   233				copy_len += range_len;
   234	
   235				if ((pi == max_nr_srcs) || (copy_len == max_copy_len)) {
   236					max_pi = max(max_pi, pi);
   237					pi = 1;
   238					copy_len = 0;
   239				}
   240			}
   241		}
   242	
   243		return max(max_pi, pi);
   244	}
   245	
   246	/*
   247	 * blk_copy_offload_scc	- Use device's native copy offload feature
   248	 * Go through user provide payload, prepare new payload based on device's copy offload limits.
   249	 */
 > 250	int blk_copy_offload_scc(struct block_device *src_bdev, int nr_srcs,
   251			struct range_entry *rlist, struct block_device *dest_bdev,
   252			sector_t dest, gfp_t gfp_mask)
   253	{
   254		struct request_queue *q = bdev_get_queue(dest_bdev);
   255		struct cio *cio = NULL;
   256		struct blk_copy_payload *payload;
   257		sector_t range_len, copy_len = 0, remaining = 0;
   258		sector_t src_blk, cdest = dest;
   259		sector_t max_copy_range_sectors, max_copy_len;
   260		int ri = 0, pi = 0, ret = 0, payload_size, max_pi, max_nr_srcs;
   261	
   262		cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
   263		if (!cio)
   264			return -ENOMEM;
   265		atomic_set(&cio->refcount, 0);
   266	
   267		max_nr_srcs = q->limits.max_copy_nr_ranges;
   268		max_copy_range_sectors = q->limits.max_copy_range_sectors;
   269		max_copy_len = q->limits.max_copy_sectors;
   270	
   271		max_pi = blk_max_payload_entries(nr_srcs, rlist, max_nr_srcs,
   272						max_copy_range_sectors, max_copy_len);
   273		payload_size = struct_size(payload, range, max_pi);
   274	
   275		payload = kvmalloc(payload_size, gfp_mask);
   276		if (!payload) {
   277			ret = -ENOMEM;
   278			goto free_cio;
   279		}
   280		payload->src_bdev = src_bdev;
   281	
   282		for (ri = 0; ri < nr_srcs; ri++) {
   283			for (remaining = rlist[ri].len, src_blk = rlist[ri].src; remaining > 0;
   284							remaining -= range_len, src_blk += range_len) {
   285	
   286				range_len = min3(remaining, max_copy_range_sectors,
   287									max_copy_len - copy_len);
   288				payload->range[pi].len = range_len;
   289				payload->range[pi].src = src_blk;
   290				pi++;
   291				copy_len += range_len;
   292	
   293				/* Submit current payload, if crossing device copy limits */
   294				if ((pi == max_nr_srcs) || (copy_len == max_copy_len)) {
   295					payload->dest = cdest;
   296					payload->copy_nr_ranges = pi;
   297					ret = blk_copy_offload_submit_bio(dest_bdev, payload,
   298									payload_size, cio, gfp_mask);
   299					if (ret)
   300						goto free_payload;
   301	
   302					/* reset index, length and allocate new payload */
   303					pi = 0;
   304					cdest += copy_len;
   305					copy_len = 0;
   306					payload = kvmalloc(payload_size, gfp_mask);
   307					if (!payload) {
   308						ret = -ENOMEM;
   309						goto free_cio;
   310					}
   311					payload->src_bdev = src_bdev;
   312				}
   313			}
   314		}
   315	
   316		if (pi) {
   317			payload->dest = cdest;
   318			payload->copy_nr_ranges = pi;
   319			ret = blk_copy_offload_submit_bio(dest_bdev, payload, payload_size, cio, gfp_mask);
   320			if (ret)
   321				goto free_payload;
   322		}
   323	
   324		/* Wait for completion of all IO's*/
   325		ret = cio_await_completion(cio);
   326	
   327		return ret;
   328	
   329	free_payload:
   330		kvfree(payload);
   331	free_cio:
   332		cio_await_completion(cio);
   333		return ret;
   334	}
   335	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--HcAYCG3uE/tztfnV
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
lpFsKh02ylJT/x8Dff95qGcBAA==

--HcAYCG3uE/tztfnV--
