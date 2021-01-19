Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C6D2FB428
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 09:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389091AbhASFXn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:23:43 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:33624 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbhASFJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033608; x=1642569608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tvJHgqE+W7G2ML+CypUNmJZ3x4g/IlwhC+0r2ps0VWM=;
  b=rarcNysrAfxCKlOSY1uDQGGS8dD7wdBzz2EggkNpOdruE47kShSdAen2
   vi5FjwbSpja6ehTdqbsJN+3uvGWrZDncvYOgVFYwiWj5mMj3TKlcMG8Zq
   5mQiYCLT9gYSCJ9ezHrfZTRhyUCy/fLdGHJ77jn6r38Jiy+Tc/L53J4hG
   X3I7F96l/rARbODakszu8d/N/GVEVTLXMG6BCVnePOl1MEmvEoZZbsKNm
   VdV5E10yAuloxmPEqHj38X1Fj0T9cjUpSAbLKVcrSxPIdzJUy41joE7hC
   GtqgS7+kb9YBgrCZrwBrAdgg5JPcL8T6ysjqwypCByWeMgjn5Vnms4l4L
   w==;
IronPort-SDR: f/ts4orLfs7X3aUKKOJ6nihL7kS07V3wsip7PdqJTrhi6LZ1l+SgdrepA/CM9NESOR3DlVfHMl
 3yjTj17FqsLJNfEi0UUbnieVKnkVF3Z4DTsWhZJQZFNqWPuP1Sb5Mf2XmqQI6a/PYbysJ3ZJow
 DuCUxaRWqDOB8yRNSbbV1dy0y1mR/o0go0R3dlzSveN4x0UwTLuI10JvCHEnalh4AedggSqux3
 YpLlEzIt8OdsuVk1K+vuKEr2xuBbnsj0vOMZWjEmfJsoP6QGiQgt5gVW5czIKRRnCDWANlzkZJ
 3zA=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="261722189"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:18:18 +0800
IronPort-SDR: Q5ruBnf7xAnrSQuXn5faj9Of4WoP5Um/EkkJpO1Uyi55E6mUT+HTidqnkQdJmUuzr6NKacMIZl
 2JEodiGWCxxuAE0O/hcQThORDPTXnqZyB7bVEX4xQWp5RjAsd26rv1QXZCNCCdGzRtkigUvo4i
 x1Gui6r55Vosc9IkgC6Nge5x4IHAzb3nq8vUOS7EdxrUvkqE7nxBGYS6RkROoS+lojbVKqBlhW
 aqeREjGZ1StTHubtEH7aRdGxL0zrKiPQ+6dc73bRJx7dIIt8FE3NrTFLxW3MGW9peL/4DcG3i0
 Io5duPItdk0LJ4GmEQZcRbq1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:52:32 -0800
IronPort-SDR: HfWY3om+yf0xJZDCeO7vzX4qVknDvDGJ6ma4/WV7I62vTgKsXgZzhM0ZULmlPQ+OArppKpZagb
 2D+mRhA2IGb1emIpbOZ6FTF970SZgSIja2ei7WMigALEAQdtMpSzVo//nIAbZ1wNVJo/414BKz
 A1WUO/T5vGii4BJKAkPud7zlDfpbr9iZjAmuNFOXPO1Y6zbT0Inzt3aMei0oz3YT9sfu+Dztk5
 Fg0ppCRIMSkEdmvmSQl8FchZI4H3p6KBElZq4HVESV4gQgEhlwohxssYunDRqcI1BVUhdQDk7h
 o0c=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:07:54 -0800
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
Subject: [RFC PATCH 11/37] jfs: use bio_init_fields in logmgr
Date:   Mon, 18 Jan 2021 21:06:05 -0800
Message-Id: <20210119050631.57073-12-chaitanya.kulkarni@wdc.com>
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
 fs/jfs/jfs_logmgr.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 9330eff210e0..ee7407ca32c0 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1980,15 +1980,11 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
 	bp->l_flag |= lbmREAD;
 
 	bio = bio_alloc(GFP_NOFS, 1);
-
-	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
-	bio_set_dev(bio, log->bdev);
-
+	bio_init_fields(bio, log->bdev, bp->l_blkno << (log->l2bsize - 9),
+			log->bdev, 0, lbmIODone, bp, 0, 0);
 	bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
 
-	bio->bi_end_io = lbmIODone;
-	bio->bi_private = bp;
 	bio->bi_opf = REQ_OP_READ;
 	/*check if journaling to disk has been disabled*/
 	if (log->no_integrity) {
@@ -2125,14 +2121,10 @@ static void lbmStartIO(struct lbuf * bp)
 	jfs_info("lbmStartIO");
 
 	bio = bio_alloc(GFP_NOFS, 1);
-	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
-	bio_set_dev(bio, log->bdev);
-
+	bio_init_fields(bio, log->bdev, bp->l_blkno << (log->l2bsize - 9),
+			log->bdev, 0, lbmIODone, bp, 0, 0);
 	bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
-
-	bio->bi_end_io = lbmIODone;
-	bio->bi_private = bp;
 	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC;
 
 	/* check if journaling to disk has been disabled */
-- 
2.22.1

