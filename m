Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79EC2FB056
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 06:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389370AbhASFYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:24:30 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51835 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbhASFJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611032947; x=1642568947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D5cmtnOCFRgYuXCr3qAROSsFWDMPsd6wC55oJ+RtqCY=;
  b=gXS6aGeW69xGTbejTXr3A+VDyGmVf954sHJsGF181bpFFi9v0CieF00e
   5f/i8wMYuwWM6RibSot34dkAM5U44W8FnzPeaCkbhRNVXzPyVbbIznW0h
   rGhZuLopb+njfB+DHqqIzOF3pZHCOyMxPchTFF9yzMRLfkg3YQX63U2yE
   o7xHEOdgeHTyJw3IP/c1hx13jQTWkT4Cw7cpTNVsObnZXOUG2nML5RzW4
   Q28nagAFpc29CgfQy5opBPiGK2pVlgFdN/u2/tRsFXMxVhWhkfTUQI3Nf
   A+dbwgIEaXtTyHDiTEu7zL2AnnoKRPFn2NLUgYeI/+JVZhDmRkDK/PmRg
   Q==;
IronPort-SDR: Jtn7QNW3HC3OVWnWuFnEorU+MICXHjTwrEczhQ/zlPGXOIyJB9gB4eV/6n4UsrLh+JlbAPOjUS
 9XWMhH+AwZ6t/LsS+0Ojyh0pGlCp1A4yVWHAZ3DjybRf3HPiYG9eDb+kbc3f+WZmSKOj9i0Exp
 v+OhMZCyxB042RY/Km2wdv0hcfzuCtRmIOEnxuxVQ1gghss/8yCe4OaOucfo9f0DVGbaXhzTlG
 3dt2ZSMHqH7JDKTWLc3EI6KkhMGhmU0/oJWhBpbEm8FuMU0Qh6STqjriCpDjwjhNIsWpTgYHAx
 WFo=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="157763776"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:07:04 +0800
IronPort-SDR: 3KOifggCECjDw7+BF1aqp+vcmn045Y0f5Vs++y+7O6FUUUXsH3IJRpcT7tuvunjoc1uoLl7vWm
 suUyM5CRB0LjMRqVTFwTlLcnkOUPnLavqVQ9SvmsNPcjsdLrmUNGlOdh071Fi6THVn2+NdFSiA
 YRxoQeP9WUi7VDxiPFBoEQebhd2n3YAWH0TG9H6C6u0XGGZZQg6kamaaO42lqVEcCKd1mWk8oA
 hZlcrrf8AJxyWyD2FzKfQjUqY21ZodhHwQupxUC4bg1nNGyna+/8bpka79dj3OZ9R6vZlbXfs9
 uzHrxrYFi+fTQYdkvBMniNhv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:51:42 -0800
IronPort-SDR: pxAqff3CzY6SNypEdU8pcyRF7Ycp2XDG/dFXp67ii/ClPi77Zq14dTS0/Abfh56tMQEJCZUgEv
 hp/pu5jYnyf4G6Ftz6560hm1xTauIc3+qd7iUoR92HKspQ4jIbCxp/rRkQaHksEACl6G/0Nxwk
 QZZl1HrIzXwoiE65870EG7Al72AiwGtlVjZjJc6GYoY+JOC16HDs1pPQioV4bpbAPsiE8/On0q
 zAsBgNZtal+/XzWJ5D9TE5/A5r3kkpStmQ4w13z8jL1gTn8oG9nSDXfj42gpMTqu+V2gtyTMTx
 oyE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:07:04 -0800
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
Subject: [RFC PATCH 04/37] btrfs: use bio_init_fields in volumes
Date:   Mon, 18 Jan 2021 21:05:58 -0800
Message-Id: <20210119050631.57073-5-chaitanya.kulkarni@wdc.com>
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
 fs/btrfs/volumes.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ee086fc56c30..836167212252 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6371,14 +6371,12 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
 
 	bio->bi_private = bbio;
 	btrfs_io_bio(bio)->device = dev;
-	bio->bi_end_io = btrfs_end_bio;
-	bio->bi_iter.bi_sector = physical >> 9;
+	bio_init_fields(bio, dev->bdev, physical >> 9, bbio, btrfs_end_bio, 0, 0);
 	btrfs_debug_in_rcu(fs_info,
 	"btrfs_map_bio: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
 		bio_op(bio), bio->bi_opf, bio->bi_iter.bi_sector,
 		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
 		dev->devid, bio->bi_iter.bi_size);
-	bio_set_dev(bio, dev->bdev);
 
 	btrfs_bio_counter_inc_noblocked(fs_info);
 
-- 
2.22.1

