Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EF52FB074
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 06:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbhASF1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:27:12 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:40916 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388447AbhASFKo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033043; x=1642569043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w8Mrhn53C/xIBUdIFO7UKVArjHLD+jnktLncJKflGH0=;
  b=A6shQQssXe5lCJyYySIWAaXX3f9xVuUkiwPju1rU3Hw1HkuQnsjqFF3a
   y0imaY05Doo0tUDv+9EbctpkF9SsJNkoofLIL0Su6suKjCIRtEe0CKzI9
   t67HeHbUMYv9mfNZRDrn5lO869a/r8tKc0RWNQ36HbPNFveqvqWhmGhZU
   6AUjPfekUVNgY/YVj+cJ/Sa3DY225gqyaUiC2HwMD0cgxhT0XhatmNVcP
   tAiS2kSE25l8zrJRMB0gfjuUL+2ET+YpL5vPo81zkLL/ZNs5H3eYkctuq
   adga7qFMo2lsuAum+UqyPpKQUjmbg1kBCyzxUuCk65F68EsGXbWec/rJw
   w==;
IronPort-SDR: w9sGdC8A1/2YAZm1cF3Zkx0CIHGMOdZ2yNGawzpWIafsKVHKOMwMByTYvZqt2Zs/x7Dlk7PUPZ
 PxcK+SPLugFkyxg5wxI3Wme/2LUW5FhNK9FAr1dHc8rJxld14vRXZCH2tj1+XCzqCGuDuaRruq
 XM4De1q+2j/LMkX4eQMKnhi8Yruj8EFULYWbo6P6Ctmikc6zf+c7xNDQpcrxBduT89An69AOHP
 G8IFqE1ssb35mYs8qMHRawqRz9HtLEJrPvcMNGTY1CQ2Gy4xIA4mlQeyCNmd2rHbcqk4Qj6XNu
 uDw=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="157758656"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:08:44 +0800
IronPort-SDR: /4rknuhBgDt675asJXfOJT26NRbCq/B9PRx3/J8J6q0CouuDDLww71phCdwW4tmclxneBFI+0T
 ayjDOD3yQIDTLMAvYW50nqtkkhFRW1XCfUBESumEK7E7j8UCBbHZhNHItdwsO/9VHzReTuxV1r
 rfZrlzNGZ+XEE14l0430IfGsqKnfXTX7jeajLHv1MP3445CLcNMxfJkESLLRjDBtNNGRnes2lO
 gOLvtuiTlu0PsGwJWnMwDSoTAGfFyxyvDz09WaPK+5R6iwpdcEL6kuSkw/mbAu4uKwDC9mnPDJ
 P4eVH92RIt1EAfIKyStvw8Qe
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:51:20 -0800
IronPort-SDR: xHO7HSedCSnJKcraGlp7cKbNn6U0vc/h0J7EqOAnrofU3EEgY4EwjLXGgaVPQ5fUfdFd219vRC
 LbXct13YZVVN6KiDu7+byPcBbjh+W64o6mdrAGqpUIdo+laa5H7zxxeLGqJmYjiZ2ypNwYS6EG
 9RidoyBhQkvm19kb9tceoxELnw81qM1BKYuv80rD63H6aZrLZIzawrq4dPgHk7mfEo+EtG3r5z
 NCmJQgYY2IUYeXtIflYFA9t16yIX5Qq8Uqp9iDzkQXKkZabUiMynH1bRZzCY09gOJtgWn+rlXY
 Wrs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:08:44 -0800
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
Subject: [RFC PATCH 18/37] bcache: use bio_init_fields in journal
Date:   Mon, 18 Jan 2021 21:06:12 -0800
Message-Id: <20210119050631.57073-19-chaitanya.kulkarni@wdc.com>
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
 drivers/md/bcache/journal.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index aefbdb7e003b..0aabcb5cf2ad 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -54,12 +54,10 @@ reread:		left = ca->sb.bucket_size - offset;
 		len = min_t(unsigned int, left, PAGE_SECTORS << JSET_BITS);
 
 		bio_reset(bio);
-		bio->bi_iter.bi_sector	= bucket + offset;
-		bio_set_dev(bio, ca->bdev);
+		bio_init_fields(bio, ca->bdev, bucket + offset,
+				&cl, journal_read_endio, 0, 0);
 		bio->bi_iter.bi_size	= len << 9;
 
-		bio->bi_end_io	= journal_read_endio;
-		bio->bi_private = &cl;
 		bio_set_op_attrs(bio, REQ_OP_READ, 0);
 		bch_bio_map(bio, data);
 
@@ -588,6 +586,7 @@ static void do_journal_discard(struct cache *ca)
 {
 	struct journal_device *ja = &ca->journal;
 	struct bio *bio = &ja->discard_bio;
+	sector_t sect;
 
 	if (!ca->discard) {
 		ja->discard_idx = ja->last_idx;
@@ -613,12 +612,10 @@ static void do_journal_discard(struct cache *ca)
 
 		bio_init(bio, bio->bi_inline_vecs, 1);
 		bio_set_op_attrs(bio, REQ_OP_DISCARD, 0);
-		bio->bi_iter.bi_sector	= bucket_to_sector(ca->set,
-						ca->sb.d[ja->discard_idx]);
-		bio_set_dev(bio, ca->bdev);
 		bio->bi_iter.bi_size	= bucket_bytes(ca);
-		bio->bi_end_io		= journal_discard_endio;
-
+		sect = bucket_to_sector(ca->set, ca->sb.d[ja->discard_idx]);
+		bio_init_fields(bio, ca->bdev, sect, NULL,
+				journal_discard_endio, 0, 0);
 		closure_get(&ca->set->cl);
 		INIT_WORK(&ja->discard_work, journal_discard_work);
 		queue_work(bch_journal_wq, &ja->discard_work);
@@ -774,12 +771,10 @@ static void journal_write_unlocked(struct closure *cl)
 		atomic_long_add(sectors, &ca->meta_sectors_written);
 
 		bio_reset(bio);
-		bio->bi_iter.bi_sector	= PTR_OFFSET(k, i);
-		bio_set_dev(bio, ca->bdev);
 		bio->bi_iter.bi_size = sectors << 9;
 
-		bio->bi_end_io	= journal_write_endio;
-		bio->bi_private = w;
+		bio_init_fields(bio, ca->bdev, PTR_OFFSET(k, i), w,
+				journal_write_endio, 0, 0);
 		bio_set_op_attrs(bio, REQ_OP_WRITE,
 				 REQ_SYNC|REQ_META|REQ_PREFLUSH|REQ_FUA);
 		bch_bio_map(bio, w->data);
-- 
2.22.1

