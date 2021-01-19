Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209EE2FB295
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 08:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389369AbhASF1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:27:32 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34587 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388519AbhASFKu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033049; x=1642569049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nnZ15L+rQ/6NXzNuwsPySOITMggjv2dpPGtghDgn/3I=;
  b=c6ge3YWau1INJmsjVAk3miP9WZn9TgseoFv6EOqoQC6pEZ1nSdc2v4H+
   XY7xema/PlZUxMm7UmjFeo7N94HtuCKqcVmUHVSG17A8tROWpS6b1vg6x
   OmpR5Xs/adYB4YsjvoN9Z0qY2bjx/cv9YKELvArFRHD/OdsoQmYfUxAw4
   1ke950X9ux0Ug+67BzioxQ82+yXZrBTEFdBsWBfWCeANgT5qsjxk0SLjq
   eBqYmFgwZPkUOG7tsdeJlEfFiAj5Bk0/g7eUZ2Zq7rZmBlu7K1Ec3dckX
   cWC9kPtWyY4GLFws9H6mMDWx+i3m9ecfp7hUwUtov6N2EY0IwWGcn1YTE
   w==;
IronPort-SDR: gbGAu7FMM9M8ra3+i2OKLO6Jioiv358lVgEzPKNEu2wQS2qvvMBn6sOibH+3TH04xLAK7LIkk0
 PxKEz+YInFHNc3iYphlT1w60bC1eS/YF66wsTlun+GeGNw+ngTePoNAvj67HmSnOP4C7ntmrTe
 41fMi5wApz9NqDKehY7r/diqAfT1k15t8QCgpkKP9Kzh+zENpuX+s/DJwP0BX86Nmz6SiEHyTQ
 PYspGTVIesP99QfunG+h138RXlV0gUS6hKCM3+WKxFlL9b+Pq62pCAU2ABPVI/vq57691S3NHu
 5nw=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="268081200"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:10:04 +0800
IronPort-SDR: xpJbTCxWpzCZeo36vMY6XjlmHCGC4zjkb4E++k4PpAOJx4m0PY9+lr8a7JAIsOXY9q6Lq8PKZN
 eF/dP5iQOP3fnZEQKtZdFSb/stFf1HUhyR3XfKv4jQh6M4J5FBp3lvEQ729h1QEurdQqZLnRIP
 yCEms2/NAZpbOCE0Ambs8Za1BZJHvf/X5MByCHb8470orI8KDjjFGzqmTSqCkb8BVJgqODQSJv
 RhBCTpJbLbO7M5o/x6p8TsI8oQTYHne7dOmBwld9Uq6ubcEYAg7YVteWfcYW5SV+8rJq41lijO
 flzi/OFrhDmWNYU5lKeuvhIh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:54:41 -0800
IronPort-SDR: fQMFfgdtSu8nKcxUqzclyRB9P+rBI21YWfB4xejgzd1WEdOnHm3L4SakDlfU6oc/GiImWBi40s
 xrwXfD+NR0eoiSPOERNl2yA3hT/FAiC6WXYJT29OBzUhR33jyW2a44OEEyaO8RW7lmq0Kfdbp8
 zCQCZgyL3cFPfEB3ClOgIrUgLmRSb/JHMwYFzZiPt3rsP6BzAQG3FZAe7E697plU5PyJKHWhGY
 W00r37LQP39Cea2s9M16j4CR51XnjLw+rlD/Eucyelmc2VgMjnWu4RGUyCYihZR6I9F/PiTOxm
 QL8=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:10:04 -0800
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
Subject: [RFC PATCH 29/37]  btrfs: use bio_init_fields in scrub
Date:   Mon, 18 Jan 2021 21:06:23 -0800
Message-Id: <20210119050631.57073-30-chaitanya.kulkarni@wdc.com>
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
 fs/btrfs/scrub.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 5f4f88a4d2c8..1e533966ccf1 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1650,10 +1650,8 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 			sbio->bio = bio;
 		}
 
-		bio->bi_private = sbio;
-		bio->bi_end_io = scrub_wr_bio_end_io;
-		bio_set_dev(bio, sbio->dev->bdev);
-		bio->bi_iter.bi_sector = sbio->physical >> 9;
+		bio_init_fields(bio, sbio->dev->bdev, sbio->physical >> 9,
+				sbio, scrub_wr_bio_end_io, 0, 0);
 		bio->bi_opf = REQ_OP_WRITE;
 		sbio->status = 0;
 	} else if (sbio->physical + sbio->page_count * PAGE_SIZE !=
-- 
2.22.1

