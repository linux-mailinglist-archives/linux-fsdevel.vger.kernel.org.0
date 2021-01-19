Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF642FB066
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 06:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389848AbhASFZ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:25:59 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:56996 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731562AbhASFJo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611032983; x=1642568983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VllxQdSuETkut8jiQhHuy5FqGdkslwtr76oc8FFhzYc=;
  b=mXQoFRTpzsMI+SEv0cqbKQrXdS19iOWRBPavRwHUswWJrJ7nonsIMu11
   GxUU4sdJof12Iul4rCztRJuD6IdDuwFrHmJlJ9LSLorwh6vWaZggFb14F
   IT0aN8zHQQapMVdUjGoXZKXbaGITyze6F6a0YiAewS/aQdVxqYAojaUiJ
   3ceqsqrR/KRGvDXS7IcahF3L66p1LamaL/cbdbY4/YJGzzRXMGwJFPWl8
   pti0Om3e9YTL2Sby/GRB9lOXyJZlIQeGDpRQWK7HwGgKihQZId3eZE4d2
   bk/DttrAxtZ6eKCOivNkJYyvsYDT8onGtnDQwDzGpW6m5Azfi9nX6EQR7
   g==;
IronPort-SDR: 2uTT8eL1dRQtmu5OniOOmoi1RF6C+19qgjagFB3XRQ3/mSYSwu8vcge+qkyb3rSLw4TqSL/FWX
 AcMSsLedPiJG6ITz3IETTM3KDzkHuzfn0tnHFVOwMBF5CNw7btzWoXyktqUWgzp7ST1W135bKN
 E+5jV0f6U9EaNPUakuM2yj4WgPMEVvDWMsNt7ypL2W+FbtyzEeVrocK0/H31A9LFFJoqtBU2y6
 hCACAGTZZRNGDDoqtum0p52IpbTQIhO8YbiYtVPUdJQisaH3ssPk83S+125b9bqcLbyfsDJi4T
 LAM=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="162201061"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:08:22 +0800
IronPort-SDR: fvwAs+YVVhRtphEuD38L5yoRHEeupJ/V7awoOjPbhbDvanClaPhl/83ACTwaNff59py0AJVZSm
 xMiN8Oi0VKzRemLsC9o/6gzJY3FQ7CuraspYr3YNXDoQDTtAqJcLu5/te0r24tIL5Pa+KJ7X1j
 VbfjMskcKqfaGWcwaOZnyTxv8QBydXWkqKSwy//Hti2jA8UjV38Wd38qjEhOwUUHH8Rwm4IukF
 BZLDPe0f0QHXkE8xbPzjBmA6xfbRWAKpKzkNF8q8VnVFc1ilObZ2R61mBovZf7EKCgkXofTg/E
 tNuRe1VQqaztNdh7o2u7ZkLh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:52:59 -0800
IronPort-SDR: AukWeQ10GheUQlYR0D5EEj/feVa20cSuWNwottGMwE7opN0/I3RYtMUjQ5GxQSyfBE6/sdBk0k
 z4fxfv6aG+9JDmdOEZ65AwSHkGYtwddoOVkRqi4DvyiiLB8vtd/fOm44eFdRlx5N0V45fVA/G2
 Mrkem+bFgQ/7hMk41j/WbKXfrCn46pyu5FjaWYjPtBRdJOMYXrfOYhaNNWZEy5N5aQ3tw7GglR
 lppVbOb4m+51NXG4xiicKFxmfiLfz3Hlw8sn3kAgisMPSXvCeaKzeiNu728KKk2Lm4HPl2GKbp
 MUo=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:08:22 -0800
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
Subject: [RFC PATCH 15/37] drdb: use bio_init_fields in receiver
Date:   Mon, 18 Jan 2021 21:06:09 -0800
Message-Id: <20210119050631.57073-16-chaitanya.kulkarni@wdc.com>
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
 drivers/block/drbd/drbd_receiver.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 09c86ef3f0fd..2715081a4603 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1296,9 +1296,7 @@ static void submit_one_flush(struct drbd_device *device, struct issue_flush_cont
 
 	octx->device = device;
 	octx->ctx = ctx;
-	bio_set_dev(bio, device->ldev->backing_bdev);
-	bio->bi_private = octx;
-	bio->bi_end_io = one_flush_endio;
+	bio_init_fields(bio, device->ldev->backing_bdev, 0, octx, one_flush_endio, 0, 0);
 	bio->bi_opf = REQ_OP_FLUSH | REQ_PREFLUSH;
 
 	device->flush_jif = jiffies;
@@ -1693,12 +1691,9 @@ int drbd_submit_peer_request(struct drbd_device *device,
 		goto fail;
 	}
 	/* > peer_req->i.sector, unless this is the first bio */
-	bio->bi_iter.bi_sector = sector;
-	bio_set_dev(bio, device->ldev->backing_bdev);
+	bio_init_fields(bio, device->ldev->backing_bdev, sector, peer_req,
+			drbd_peer_request_endio, 0, 0);
 	bio_set_op_attrs(bio, op, op_flags);
-	bio->bi_private = peer_req;
-	bio->bi_end_io = drbd_peer_request_endio;
-
 	bio->bi_next = bios;
 	bios = bio;
 	++n_bios;
-- 
2.22.1

