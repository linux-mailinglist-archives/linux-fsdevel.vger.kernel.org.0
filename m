Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D1B306FC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhA1HjT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:39:19 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:20243 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhA1HPO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818114; x=1643354114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0nkVYESNcCP1ZuiY2joF5zZXurD0RzvJ1s1BM2N7jGA=;
  b=YipVePX+Totf43yYuE59C8jk+KS+oCYNMgKM6PER3DfdaHDnZm8N1AdV
   lHQdRFE67goXshB7kV/ehjWjHtczAfqHBr1MDUXNh1nsn1azCJMWx+R9r
   pc7RHwEqidO99PpWJHutZaiGdDttnemcK1X0whPRSCX3dbJ43WFklXKD8
   L5ol4bZRizexcdyOJMGkxsu/VhqubObI0yfQ0Bj7R4Fut571488gpRkcc
   qlNkZyym3GLKvETFq+BDIUslRaaqyXbj8zbuIijOz2/DwLhGtSNEDhy14
   DXRTfiznGiuNKL0y+ZoDDF6+1HcnxAv0pDSypgshCH5me2tcFHXyVtby7
   Q==;
IronPort-SDR: B9ndWAvDOT58Vb46vLd1SuXvpNjkCMWolsH/WkCquWFFeLNOGZKoB/qNEUnlSzpS2/FYmqV2HZ
 Qrpk+/krFtjWWt5GR2cgUVkoDBhyuANsmV8rQXmA4yWPvf2uV8Rg1wW/szHKi4xaEh1qCddArb
 Ptb3xoSjxHgKZT6Csv4NCqjoKwFvoutYi5tg5ocdgPymsrgmsLQi9ZdNpiIlrX8z2vrffsDuDe
 omLxYw0ib8KMnyeUzzwM4FJtg8M/mfSzf6dbbqXqAWnUllwM/6CQcQsGd0ZNgcqcgpY+0X2Y0j
 o9Q=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="159693902"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:14:10 +0800
IronPort-SDR: EoVw/u6eMCwrRFaD3MQG+hBmC7fivK1rJCn882+bDlhB6R1BOyi14oaoAhOpJcVQP21Ur95YVD
 7a0j2DpLKZmxyk0KtanFpyHqaAcS7JzFGEqlV9Sri3yz8bFIoolnO6jCzS0aDsZMkZGseED63F
 7jAz0G9ad8dswcozX5Ofuhjk13O1rXgFT/J46UeRGWic9DZUNNWFHiQFmqgaa1hnsAuiTM94qd
 6jeit8aCTaO6l1Slfh4nL4211osTc7YUAMSuUJXrh6sdmk3WVv7I4y/Jfls7eaPUNowRY39sHC
 FeBerITxT5rhACqHZ8xUMx/u
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:58:30 -0800
IronPort-SDR: lKKhoxaMeyOwXqrT2FSzD4wN8uVJ+mvKyFTUKLm7JjK92Do6Pp8LlRaYGgmaQWgAcNgigcbWq0
 dr8eH/C5m6jarJyZCPupuIjbqQYzS6I98zkdR7vs+3yNowqMQiZeF1CHZrTo/tpym1SjWfvRXs
 6jUItt1/GcDgh349QalPLGcjYuMZ5A1EKw0wTA/1PN33qNlegyypjYwNakr5Qt7Zi77XOTVrdO
 glPMuXb+RS4OnELTigLzoH/k3P2LKO+/yrMNDKd4LQa/txopqXKI4iyznrBVm1YJBPOgSOjnjZ
 uxk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:14:10 -0800
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
Subject: [RFC PATCH 17/34] iomap: use bio_new in iomap_dio_zero
Date:   Wed, 27 Jan 2021 23:11:16 -0800
Message-Id: <20210128071133.60335-18-chaitanya.kulkarni@wdc.com>
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
 fs/iomap/direct-io.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ea1e8f696076..f6c557a1bd25 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -189,15 +189,13 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 	int flags = REQ_SYNC | REQ_IDLE;
 	struct bio *bio;
 
-	bio = bio_alloc(GFP_KERNEL, 1);
-	bio_set_dev(bio, iomap->bdev);
-	bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
+	bio = bio_new(iomap->bdev, iomap_sector(iomap, pos), REQ_OP_WRITE,
+		      flags, 1, GFP_KERNEL);
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
 	get_page(page);
 	__bio_add_page(bio, page, len, 0);
-	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
 	iomap_dio_submit_bio(dio, iomap, bio, pos);
 }
 
-- 
2.22.1

