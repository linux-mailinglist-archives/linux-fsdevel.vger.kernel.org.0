Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1D7306F5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhA1H1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:27:41 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57280 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhA1HQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818178; x=1643354178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XPaYjcRaIFpnYMD3YBMMFWgQznGRHjSurwf/uHFVwCI=;
  b=mh8DeKCkzzXjcxZfxs5WPaEw2wZ3KVrR7I00sGEYnYIojTJP8cq/S9wh
   arO0pE1rTrxT5fi92TaJypjR/vST0FyugDJzIBhGsnLPtDHesqjY1Nvi5
   1gkA1T1gE+tNylkkmxqtPHnQw+pgtd5HkIWRgqsOb8NAyqg/xSvS5wlOn
   5am9myvNe4qoOzSJv2Ct1lGTCiV/8910amLE5una6c6ekWY45y1m9xtyG
   1AQmcnzmI4dCBKkB/yUQ6Jq3qHrLEWZd1Dd22z3LZPpg/Vr2o9GTNalD7
   n0/y8qBYRbP7lOa+gw4+qVycak8bsTdcPKXWwcMKeTDcbQYzeCccFfnBr
   A==;
IronPort-SDR: eR4rkKeZG+rbkBxixHoRdNezHV8pDF1zC0Mg6AxDzm7Chn0GXqpY8TwnUuQwts9+UiShR0ugPx
 dBPMh6lKeuoe7C7CBhEHpvCbGMiFcmk8CRItjWwjQDcuDB2fR9ZFIJE1NdJiZ2+/Ob46pSR02K
 zCYAcNqFVUMuPpSADHFQh9YNJibXxzD5y1SO9PC5hkOnmwnvEaiusSNYFD7Bt94ypURxJaNkMm
 uL7bmVae3wei/ROIR0LrdN5Aht7nOQTYzCTVeEoq8jhKMf7JbCMr+RB2L+J2KB1Ltn+rSsWTMk
 PAQ=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="162963394"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:14:54 +0800
IronPort-SDR: bm6iwWpjOfZ/qPbrHwU5clEMvD+MV3im/2zF6CP8Vx6WjW6+Fyt2JkGKOs4GZaVC0kMpJM255w
 /ZHmcPmFXrk2wb8Tso9hshlGQXaMaVc8HWZqEUeExVj1faaBS85SLfzt6n/1mI0T/rDCrenMEw
 CO+J/ZDOUOmNC09NpldhTQ8jln+D1hN6Wh0rFjwhsjmSQAKgfuU3l7NQqxHZgHYQuZ+kyM162d
 ouBR4yDRBQ1U25Ucc3u7SCnzAOHD3+LMkGCnWFzZBLNcP3/f2NyPAdZNzNgIekT7cbNDikXahm
 Ia5Uezgnjin7X0xr9aqu68Re
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:59:14 -0800
IronPort-SDR: m1TZ+g0HqYnNuuEaVgIMmloDXGiOQeWVkBatefSwdP931h6/Qc9uK8rnz+JHWAn0f3QBmOsUC2
 fXJ41UlgQQnfdBQndrwCq+hQtl7mr6AQW85+ZjLVP2rPUrLfDej915AJE+NjNtCGI740sa3D8g
 UGQ9bx3fpoJbY98zSPHF13CT5IYtiyfyvVxvvVA5VfTuNLKWU4ZEgYs5jdqkUbRYa6sajX3DSU
 E+nFYRIRokBPoO+x05JGw6lqTR47HYfSK6LYXKwXfQUKv6zaLN0igntqoauBJYDwbicxGnznwF
 roE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:14:54 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        xen-devel@lists.xenproject.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-pm@vger.kernel.org,
        linux-mm@kvack.org
Cc:     axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, konrad.wilk@oracle.com,
        roger.pau@citrix.com, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, agk@redhat.com,
        snitzer@redhat.com, hch@lst.de, sagi@grimberg.me,
        chaitanya.kulkarni@wdc.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, tytso@mit.edu, jaegeuk@kernel.org,
        ebiggers@kernel.org, djwong@kernel.org, shaggy@kernel.org,
        konishi.ryusuke@gmail.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, rjw@rjwysocki.net,
        len.brown@intel.com, pavel@ucw.cz, akpm@linux-foundation.org,
        hare@suse.de, gustavoars@kernel.org, tiwai@suse.de,
        alex.shi@linux.alibaba.com, asml.silence@gmail.com,
        ming.lei@redhat.com, tj@kernel.org, osandov@fb.com,
        bvanassche@acm.org, jefflexu@linux.alibaba.com
Subject: [RFC PATCH 23/34] fs/mpage.c: use bio_new mpage_alloc
Date:   Wed, 27 Jan 2021 23:11:22 -0800
Message-Id: <20210128071133.60335-24-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 fs/mpage.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 830e6cc2a9e7..01725126e81f 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -68,25 +68,21 @@ static struct bio *mpage_bio_submit(int op, int op_flags, struct bio *bio)
 }
 
 static struct bio *
-mpage_alloc(struct block_device *bdev,
-		sector_t first_sector, int nr_vecs,
-		gfp_t gfp_flags)
+mpage_alloc(struct block_device *bdev, sector_t first_sector, int nr_vecs,
+	    gfp_t gfp_flags)
 {
 	struct bio *bio;
 
 	/* Restrict the given (page cache) mask for slab allocations */
 	gfp_flags &= GFP_KERNEL;
-	bio = bio_alloc(gfp_flags, nr_vecs);
+	bio = bio_new(bdev, first_sector, 0, 0, nr_vecs, gfp_flags);
 
 	if (bio == NULL && (current->flags & PF_MEMALLOC)) {
 		while (!bio && (nr_vecs /= 2))
-			bio = bio_alloc(gfp_flags, nr_vecs);
+			bio = bio_new(bdev, first_sector, 0, 0, nr_vecs,
+					gfp_flags);
 	}
 
-	if (bio) {
-		bio_set_dev(bio, bdev);
-		bio->bi_iter.bi_sector = first_sector;
-	}
 	return bio;
 }
 
@@ -304,9 +300,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 				goto out;
 		}
 		args->bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
-					min_t(int, args->nr_pages,
-					      BIO_MAX_PAGES),
-					gfp);
+					args->nr_pages, gfp);
 		if (args->bio == NULL)
 			goto confused;
 	}
-- 
2.22.1

