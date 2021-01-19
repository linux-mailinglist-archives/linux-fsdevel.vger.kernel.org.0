Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3D92FB08A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 06:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390393AbhASF37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:29:59 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:40916 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389695AbhASFMd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033152; x=1642569152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CEdgjJXFGgEM2vVXbkhgIZw1T1rq8VUMRvKmaMfgKhs=;
  b=K6Sc8u+1aHwDoDoUjWq2qe1FD8ylUlcKuP2atuiLEGbdtbOp4iG1q0ff
   qoOH+3hu3HQCGpEFTs+u3cWTs2FTfs9CypUCc9hD+fsi6+LiptlmnQeKJ
   Mp4MR1xBzTW4j6UOd+XV5OQ2Zx0mhwnNm2JYuxgV+FGZC/mOiFiEvoKtw
   gBwTLkTlRCbbZ2wA2Hjgju6WLNJyM7tFE9zVI9VOrt5lc3nQso9AQw8zW
   kgutGawJaMvq9bsztGyB0tZJKTefh5sDSyxJYb8c2RlJfW7f0CKcxE0A+
   XcfxRnJxbBD1UgT6tIzUs/W4pfML0ZntSd8w4UzSmPqh4SCB2+v5EMHcx
   Q==;
IronPort-SDR: ZZT3dTC3LgrQnMc0YvYmSzw0J5KCJZpEqCnugPU0w0sIVLBviznV6s5FyxiWLWAw05I2QiLrO0
 tNehEyJ8nRJW7/eoUmbDtumOK80CwYopuK7EgkUxppEM30zoRxT/tgXPttw3Rm/XiCoGMpGA5S
 wuTDcZMXoEpIMpn5T8wBrmJlv4QhnhTyHFUOP2YltITAnfO/4xOQ9hOEhXobD62k/gxAl+O1ro
 VTwz1Yq3QKklhBj63JOoe32jZDBT9Oc0FOd71pUkwCOGDZjCoA6Rt6dYKQfmSWTB0mFS4Q5pVb
 I0c=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="157758782"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:09:57 +0800
IronPort-SDR: emmkH4Lr39KJWKJg8IcWQtuK7MQstWVyMU+jg4t1xvZC9yGl0lBJJXPFVvZMAswgGuGUq05SBL
 uMsEfxHkK5QbAl3dJWnHt84fh/EGS9DdzVxBV6YE2fhW6pYcaUEbHnKWZmESdFx3U/2HBuOVH3
 ebvcVLJ9G5NDhjbkhoFZMWI41B+WZZ+qQtayVJ/iwVhJ1o743TbdpbreUmrnGIxffNJtoXrBuT
 QdhTCaSEGBYp/JqjB5p4fIBBgjvdwgYRiXG4fFqvuW+PdPN/Z+nSrlq0KWmNaIVb1YR2I6lGVb
 bVb6yLdCjz7ALKV7Zr24/PjW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:52:32 -0800
IronPort-SDR: a+gnNfhBGlfndCUXu2PRYuff1boYNdHfSgVMM4QGOo0gBqok0UAFSw+CakQqID9DiHlkJTF/tk
 tfTEZKWrBtDq0dUvqYcf+WsTdC0Igy/6eIFaVKPX3skORR8vkvebU+R6xmJfb/vQkDxguYmQjy
 ooWIxSrSXOWgrTQsQSnSH8xsuNu9hFytU9enoqFYqBIe5DbNODHACUTbxgGCYD+JsMeKIy4eA6
 k/5Kfh84EPk4WfgFSkdXjOf+OkCHZJ/80U/a+Ke2lW0oT2ODaSYtQOG1ltNBLA3AQquOKSkivD
 2TA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:09:57 -0800
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
Subject: [RFC PATCH 28/37] target: use bio_init_fields in iblock
Date:   Mon, 18 Jan 2021 21:06:22 -0800
Message-Id: <20210119050631.57073-29-chaitanya.kulkarni@wdc.com>
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
 drivers/target/target_core_iblock.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 8ed93fd205c7..ec65a9494bee 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -324,10 +324,7 @@ iblock_get_bio(struct se_cmd *cmd, sector_t lba, u32 sg_num, int op,
 		return NULL;
 	}
 
-	bio_set_dev(bio, ib_dev->ibd_bd);
-	bio->bi_private = cmd;
-	bio->bi_end_io = &iblock_bio_done;
-	bio->bi_iter.bi_sector = lba;
+	bio_init_fields(bio, ib_dev->ibd_bd, lba, cmd, &iblock_bio_done, 0, 0);
 	bio_set_op_attrs(bio, op, op_flags);
 
 	return bio;
@@ -380,11 +377,9 @@ iblock_execute_sync_cache(struct se_cmd *cmd)
 		target_complete_cmd(cmd, SAM_STAT_GOOD);
 
 	bio = bio_alloc(GFP_KERNEL, 0);
-	bio->bi_end_io = iblock_end_io_flush;
-	bio_set_dev(bio, ib_dev->ibd_bd);
+	bio_init_fields(bio, ib_dev->ibd_bd, 0, immed ? NULL : cmd,
+			iblock_end_io_flush, 0, 0);
 	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
-	if (!immed)
-		bio->bi_private = cmd;
 	submit_bio(bio);
 	return 0;
 }
-- 
2.22.1

