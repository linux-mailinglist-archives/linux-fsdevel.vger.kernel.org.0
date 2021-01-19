Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923D52FB3D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 09:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389635AbhASFZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:25:51 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34702 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731930AbhASFJn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611032983; x=1642568983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7b7Ba/mkSpgZ58joyvKPrAaGG8qz0lkQcstbC0iRpPI=;
  b=hoCPR6+JPwXb4NUidO7PPWk6+QxAL1MfjG31vE0x/o2DtQQXtFLjxavg
   JXYklM0do/i5rnr42DwRO0LJZh7j9s5QtXDNdkTQ0emYyx6n/Vv2hV98u
   xZGz1W1S+Psydrb+82nhBTe6iyPEtJbFjaXItDiQpp4WBnW8n9n8WHycs
   ysd+uazr8/pR/nKtHF+qsZg6yHIrCQ1MpayDWC3HQQ2gZgwF9wsAQCwi3
   kqoHGMXNejyNklDwAm79q3aFi9cWuVfpYB76me4nBcksW/+3Kondk0ne2
   zzAXddAS1ysJIcdx1t9LyQPrITia+P1UsUJckefqF+nmrIoSJ8RCh4u3C
   w==;
IronPort-SDR: eZ9GzOW6ryJEvDPSNJqna3IvNIoXm61TE9qccZ3A3l0qmG08arebgpnGe4kLVuQsBPR7ZlrD8u
 UvchH8taBhvY5zEWi9e4IOEJD9hG7i4I3ZG8QB7h43S84atVVxLtmmgfRPpCaZuM3fsjvdA7EA
 gUIUzcrJeTnsLFD2RCMV0RXt1xXmVUQI6p3ZMiO8atB9eEcRFUcylw81NPqZYNdKwga+KFG9Tp
 eJcnf4Quruy1olcCSupPGVivQvP6/IfTZwpMs1okEl9+IDIdyEDbx59Evu416ZMKXGG4B+fTgV
 XLU=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="268081044"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:08:30 +0800
IronPort-SDR: ZMezbSDwWuYFWdC7DWvizZCfAHGg6wc/P1xL8z2y/3gZ2MDS36R+ED/AN2d7MSfFTGU+KGsiJL
 +uJi0muOvTBGiCF9Wy+AJTqelwkp5kX4JQMwxwztJ2uwunGJesMrzeuUkNUfD1SklAw6GlsZZN
 vT5Xxu2TQheAm8IQIuqHGtM2AIbLzWY9/jqw9FSj8aVW7fwS2iL56l8SlIwznFL5rLPVA4BlHM
 37iXVQRXW/cdlYLd59mZfeRYpY8NO4JpvGekPR+HYFfy6DHlZ5Y9oKvTjCuf+qcbcHTniJk/zD
 gbRMPSotBf3S4fA2IxleOW+p
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:53:07 -0800
IronPort-SDR: P5c68+r5a8DOSQsRGC/PLvFBWof3CYBSZ78/AjZxxbqEhqAxt84O9ZWicHnuz+rOOqV7roKTgj
 twniYUPk2fiAD8Xe2xt0+bCng/kmhe4tRAPsXmMChVmLYeVESDqX1Ch12ppq+swuJrohwMf670
 nW4oFOXw5mZvfoBvM6DRJldmElTkBvSEiHsn4Z6Lj6HNC6nwKfOy7ls60P38dBSPu32aUdCyrJ
 9Xni8CwHGVPZR+TCQgcaFbT87hN7DOlLc38PrOokHP4ypmvZX5OCF+2Q9DRTOOHIgCBKFlVNcC
 QQI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:08:30 -0800
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
Subject: [RFC PATCH 16/37] floppy: use bio_init_fields
Date:   Mon, 18 Jan 2021 21:06:10 -0800
Message-Id: <20210119050631.57073-17-chaitanya.kulkarni@wdc.com>
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
 drivers/block/floppy.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index dfe1dfc901cc..1237b64bb37b 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4219,13 +4219,10 @@ static int __floppy_read_block_0(struct block_device *bdev, int drive)
 	cbdata.drive = drive;
 
 	bio_init(&bio, &bio_vec, 1);
-	bio_set_dev(&bio, bdev);
+	bio_init_fields(&bio, bdev, 0, &cbdata, floppy_rb0_cb, 0, 0);
 	bio_add_page(&bio, page, block_size(bdev), 0);
 
-	bio.bi_iter.bi_sector = 0;
 	bio.bi_flags |= (1 << BIO_QUIET);
-	bio.bi_private = &cbdata;
-	bio.bi_end_io = floppy_rb0_cb;
 	bio_set_op_attrs(&bio, REQ_OP_READ, 0);
 
 	init_completion(&cbdata.complete);
-- 
2.22.1

