Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B622FB28A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 08:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390120AbhASF1t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:27:49 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:40896 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388611AbhASFKv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033051; x=1642569051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kVFX0znrSc+8VbzsAzlWslK9G1sWqMMHsAPd6F9G8C0=;
  b=IkZFyKZwCI7Yfjl14pO41C+y1zWEP3fQqcBBiKj/KTAul0hnprjlT3/X
   nStH8IL31VZ8yUGm/2EgL/ykqqHCiQhO0QAZhDumNC75JZZB9FrkF+JuJ
   d4vs5Qh5/O9RqeAYulsAy/2uGR2L8oirUtnOKyVm4gvzQBFX6k2EmB6MZ
   J6Aq5u+5xrnm9amUsUoQoNR1vup4PjwrAJRFvgHEnRpyaPNnCfTkqYbZp
   kksQ/DCWKtsmkhoh97C9z3yCDm+MmSpo1NyEJXRHfUqMf3ip3qrJkovw6
   thXHHHW3q63BZXQ9VeeLJyld+xkT4UbvRZv7NxmH1M/RmBi+/GJy2w5MQ
   w==;
IronPort-SDR: MNtTyBlPmS+fM8ep6TEqeCcTMyBsH2MQvxPr27G6O4PxcDOfCqHrpAdLkGZjLFxwZbKeljeiHB
 b4GAgTIvrEl3iPonREGNBOH+7xx0mcKGnjsLWl/sR7v88RmQiZiCj7UCb1nTJfNeWyH1YpeQvj
 gwaEG32eQeUKDB2Gu7QHJxSqgPqHmEOQA+0/av2uuZapQD4kN/OcQbFyKuRuT9exHtmns0n9cw
 uusghcxIf76jYI0hqFTOw234HtwFVWwYmx74ma1pwt+gdJmXaED0rdUJKHJnbzthszvmwWv0C5
 4lM=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="157758682"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:08:58 +0800
IronPort-SDR: lQYuyzy0Q+rJ69szOgo8kE0MVKTVokudmggg0LeWPU6qFR26VXUThAbaE0wMuginq+5vgTd2KI
 OWcfER/kQhN8qa8NQFPoaRWw6izanbZfLa7XBmzNLR9CbgX6myj6VNfoLAvyokY2wtV1ZcGcx6
 gs1lmeDl8dx6kSa7GPKGCONTpKKazcZ+GPsrh7v08RsM8z30vaUDZ42SugJvs1ELWIYxv9nt4d
 IMmBnM9vq0F/HDJ3CqPznPMhN6d6RMZc5LvH2gwOkx2ClVjJ0JhC46AKW9R/w7dKlxon9l3AWZ
 98Jz+pujCcKpI6/Ytf8CXNJ8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:53:36 -0800
IronPort-SDR: jlVjSrblz306Hto1pLF+Ht0EEquCddwQbUHFuCddrqoN07zLTxnOBCPrasx6QzbFI3wH8LUOM6
 f1riISJo1ZfVD8XFhKudLwqjNPGTk45UkBknW/fvY8/YSLAFyl7p/oEVvVwMk/Qs1/83QCrF4q
 ATtQzOiVpqAKtEILRicfThLBsahVfoN7j2kdMa4Kjuo9XbLFp402k/0XWqZ4GyoE/rJecEZ36T
 8WqaSeI83mvc1WGr9SQTI7cT3Gl1099yvZzXS5oMJnA3jan5x1SLdjiEGtr/xqjinEgosWxBG6
 /Qk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:08:58 -0800
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
Subject: [RFC PATCH 20/37] bcache: use bio_init_fields in writeback
Date:   Mon, 18 Jan 2021 21:06:14 -0800
Message-Id: <20210119050631.57073-21-chaitanya.kulkarni@wdc.com>
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
 drivers/md/bcache/writeback.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index a129e4d2707c..e2b769bbdb14 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -358,10 +358,8 @@ static void write_dirty(struct closure *cl)
 	if (KEY_DIRTY(&w->key)) {
 		dirty_init(w);
 		bio_set_op_attrs(&io->bio, REQ_OP_WRITE, 0);
-		io->bio.bi_iter.bi_sector = KEY_START(&w->key);
-		bio_set_dev(&io->bio, io->dc->bdev);
-		io->bio.bi_end_io	= dirty_endio;
-
+		bio_init_fields(&io->bio, io->dc->bdev, KEY_START(&w->key), NULL,
+				dirty_endio, 0, 0);
 		/* I/O request sent to backing device */
 		closure_bio_submit(io->dc->disk.c, &io->bio, cl);
 	}
@@ -471,10 +469,10 @@ static void read_dirty(struct cached_dev *dc)
 
 			dirty_init(w);
 			bio_set_op_attrs(&io->bio, REQ_OP_READ, 0);
-			io->bio.bi_iter.bi_sector = PTR_OFFSET(&w->key, 0);
-			bio_set_dev(&io->bio,
-				    PTR_CACHE(dc->disk.c, &w->key, 0)->bdev);
-			io->bio.bi_end_io	= read_dirty_endio;
+			bio_init_fields(&io->bio,
+				PTR_CACHE(dc->disk.c, &w->key, 0)->bdev,
+				PTR_OFFSET(&w->key, 0), NULL,
+				read_dirty_endio, 0, 0);
 
 			if (bch_bio_alloc_pages(&io->bio, GFP_KERNEL))
 				goto err_free;
-- 
2.22.1

