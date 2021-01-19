Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4D92FB2AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 08:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390018AbhASF0P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:26:15 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:47648 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389152AbhASFK3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033028; x=1642569028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sO8d5HxadQ7ae8msAnPJWRe2/j+HLSlO2d0uhqsgZy0=;
  b=CcxWsEgVyp8522UroxXUsqQZtb4jcbMKaIdKqwRxbpGl/H/b820a1nr6
   tmgQspoLxuLbMDcejuhKj9aAUoXn5dRy2oyu3qHg1clawqFrq19E2a+dW
   vO/uW3JUi/SDeBEsWvtk9xyAzOb4hmZkLeIPnJq8GV8bb1GNoZeUJwlVf
   ExKNO0oaiomYh7/JPRLld3/P9eEwlkGluq6vx6laypts6dtX3XPtFwCN3
   1DCGE4KzpPKEZgNIeFhFMrPhIO3dw3oVBu+OHrSKFZwEdhlWeHuOjhIUU
   KilqviCEz2/3+p5HImDxj8Ihho5+t93E2RwxG2Xpw44oJnHCSnHcljNB+
   w==;
IronPort-SDR: OX04FDWr81SnGK0GDWomOiceOLlU76zu+VeNyl0WDuaFclNc3q3T64TFsWIbHiWGOJkHf6Tikd
 WPwxwTwd0zgdIZ0p5DTgor3nje+obr94JX7lrpSxn2mtOTCQJMQzm1giN9vJy9Moa2GJJxYtiq
 QQ3uAa61H0qeFHGI4EqOQiJauZX5E2vFasLsP0HKX7gTBBTHKmbwQyPjek7HrFSnJD9xVmZY5w
 r+sQy2tbj9vjibNc0+soKNgoBqcMNcm9gjHhyYa/JZAVE7VEmh6Q7k/6czbkJu28s+B3ZXj4Rm
 KNI=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="158940680"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:09:23 +0800
IronPort-SDR: SoWs0I9slbUxr6J4YrqfUlj+HvZ1+AOwF7ay/awPOdPyDIt5wNCiH2piPui8e5eD//rvZvVEUU
 GMtxjS+9wIjJBBZjWLtGk17BPOuPeIeX5S/9Yx173Y7K8V+vEuiyHsVvNNkX8vLFcai/UbsK5Q
 96mbU30iHSYGsaahiSfc2Hm2e/mNbPLo6BB4wfKeCoiX/ziuq4q5Sg5NHqjOugzegE+85nzqAx
 PuzCkXg5Py6S8CnRdTK4STn0FIfWulqvz2S0S5SYa+7yqkazEb1xy8ieJfsdvjPj8mBwI3OD2S
 u5ykalC/cYUV77BSWkWLYmvd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:54:00 -0800
IronPort-SDR: WDMfO4KSjZ85dQnSqJHGqhPnau1IPWBJa7ouAx7fSY8Jjs07UadggeWCP1wGZdoVsyHikSCSBo
 NjR3hTBoDZYf083INEVXN/g/gzRcE8c69hDQ3bHF1CnrxKItq/1x7A8KFxUF9hsEZwznMnu465
 WdZoTY5ZKFKbPPmsD6E9kgpTCXMTN98PIQwHFSUfz5GsmitLQ4YX+7Kt3he3pE680JbUdUcIwc
 w3TKORGekwZavC6DFj/L4eyCUg1ECleXwXNyg9AYomurOycfkdloWjts9kBTsEWz8yA/ZIB3I9
 J7c=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:09:22 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com
Cc:     jfs-discussion@lists.sourceforge.net, dm-devel@redhat.com,
        axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, efremov@linux.com, colyli@suse.de,
        kent.overstreet@gmail.com, agk@redhat.com, snitzer@redhat.com,
        song@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        darrick.wong@oracle.com, shaggy@kernel.org, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, tj@kernel.org,
        osandov@fb.com, bvanassche@acm.org, gustavo@embeddedor.com,
        asml.silence@gmail.com, jefflexu@linux.alibaba.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 23/37] dm-zoned: use bio_init_fields metadata
Date:   Mon, 18 Jan 2021 21:06:17 -0800
Message-Id: <20210119050631.57073-24-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/md/dm-zoned-metadata.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index b298fefb022e..f114d595ce23 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -577,10 +577,8 @@ static struct dmz_mblock *dmz_get_mblock_slow(struct dmz_metadata *zmd,
 	spin_unlock(&zmd->mblk_lock);
 
 	/* Submit read BIO */
-	bio->bi_iter.bi_sector = dmz_blk2sect(block);
-	bio_set_dev(bio, dev->bdev);
-	bio->bi_private = mblk;
-	bio->bi_end_io = dmz_mblock_bio_end_io;
+	bio_init_fields(bio, dev->bdev, dmz_blk2sect(block), mblk,
+			dmz_mblock_bio_end_io, 0, 0);
 	bio_set_op_attrs(bio, REQ_OP_READ, REQ_META | REQ_PRIO);
 	bio_add_page(bio, mblk->page, DMZ_BLOCK_SIZE, 0);
 	submit_bio(bio);
@@ -733,10 +731,8 @@ static int dmz_write_mblock(struct dmz_metadata *zmd, struct dmz_mblock *mblk,
 
 	set_bit(DMZ_META_WRITING, &mblk->state);
 
-	bio->bi_iter.bi_sector = dmz_blk2sect(block);
-	bio_set_dev(bio, dev->bdev);
-	bio->bi_private = mblk;
-	bio->bi_end_io = dmz_mblock_bio_end_io;
+	bio_init_fields(bio, dev->bdev, dmz_blk2sect(block), mblk,
+			dmz_mblock_bio_end_io, 0, 0);
 	bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_META | REQ_PRIO);
 	bio_add_page(bio, mblk->page, DMZ_BLOCK_SIZE, 0);
 	submit_bio(bio);
@@ -763,8 +759,7 @@ static int dmz_rdwr_block(struct dmz_dev *dev, int op,
 	if (!bio)
 		return -ENOMEM;
 
-	bio->bi_iter.bi_sector = dmz_blk2sect(block);
-	bio_set_dev(bio, dev->bdev);
+	bio_init_fields(bio, dev->bdev, dmz_blk2sect(block), NULL, NULL, 0, 0);
 	bio_set_op_attrs(bio, op, REQ_SYNC | REQ_META | REQ_PRIO);
 	bio_add_page(bio, page, DMZ_BLOCK_SIZE, 0);
 	ret = submit_bio_wait(bio);
-- 
2.22.1

