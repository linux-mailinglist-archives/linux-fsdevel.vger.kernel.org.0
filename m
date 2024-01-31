Return-Path: <linux-fsdevel+bounces-9719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82759844933
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 21:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6EBD1C21A28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 20:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C590E39875;
	Wed, 31 Jan 2024 20:53:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B032B38FBC
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706734395; cv=none; b=A/JlkDZt+thK37rimkO/36XSGNIvm5Lw4uR90QvP3nIhwg8Mf9Pbf3oneBRII0ecifQrHbYwrL9qyVfZU8AXcrKe5pdrqiKvWfApWIGJ7i0q9H5ziQkOhDsT4SMXlH49zErTgWo/ZA9uPWoIeC9r6L5XioPTPYkcT9aKhO9jc+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706734395; c=relaxed/simple;
	bh=a+okDlWx9/qPLdBcy7htYvkIivsaWX4NYZq96zRjvIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDKKw4Ymhrl4soNz9CST7c3h2inYCeTUr5Vf0Qa1jcqg8CRepC7wr3FuBXHwR6I/pZN5wJ1Jzfv4RcxKHu0ywF4hlz/NuZPAOHceYh9bySBWYfLc/ALBh0EtjzQ4kG0S8ySIG4yw7iwYxWc5b0Qbce13EGx8M/o+fipDQuAAP4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-295f95ac74aso118776a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 12:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706734393; x=1707339193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQtRy8aH4+NZcdv1DbXtSr6CX/Icu9Trjb7pmXD4VBs=;
        b=rci9jp/YTqYPtrB8gCr0j6umeUMvQ3S4mGhdgzeqTxkUxf6EGXXwmxE9xmQPel/16e
         kctwg1yHDWQkuRLBxJ008b7fiJKsJd7jxzpdB1ry6xSBE/8np8o2SYlyOuzvMAK7/tLo
         /Rnyo8Ivhpt6Abk5BithfWrU9Q/3zbWfJQ2DBzplO8G+YHnLbzWkWqWHmmDa0FOLBc7k
         fDfDMCo9kPXa9HHZ3J2aqRqXKjoCTg/ziRbP2Ner49k6qxXwPRpHfn1/IL4vCVDMFqyK
         6EW/Rhbt5oSEGcu3crnW84qiAna8/1JKU1BDu/IEicb3NW6dreEYLaWSxa8Bs546zG9C
         dM2g==
X-Gm-Message-State: AOJu0YyeRjYIgj0KYdttQiSYwy5X+UMqv/AbjePbffPiqeVA/tJi9XR1
	GH02ihja4GfdoUzZjxp+ff7RBvvNVexs9Xen6d+YnwcVVtdn1hr7
X-Google-Smtp-Source: AGHT+IFRBdJ3Qo7SWYftLxaNase8/u8qHhrlRksrACE/t4Kaedxp1+yLQaTYcLVKecLVDmKFlPoGug==
X-Received: by 2002:a17:90a:ce97:b0:295:aa97:d6ad with SMTP id g23-20020a17090ace9700b00295aa97d6admr2828956pju.39.1706734392847;
        Wed, 31 Jan 2024 12:53:12 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:1d95:ca94:1cbe:1409])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090ace8300b00295fb7e7b87sm855977pju.27.2024.01.31.12.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 12:53:12 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 6/6] block, fs: Restore the per-bio/request data lifetime fields
Date: Wed, 31 Jan 2024 12:52:37 -0800
Message-ID: <20240131205237.3540210-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240131205237.3540210-1-bvanassche@acm.org>
References: <20240131205237.3540210-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Restore support for passing data lifetime information from filesystems to
block drivers. This patch reverts commit b179c98f7697 ("block: Remove
request.write_hint") and commit c75e707fe1aa ("block: remove the
per-bio/request write hint").

This patch does not modify the size of struct bio because the new
bi_write_hint member fills a hole in struct bio. pahole reports the
following for struct bio on an x86_64 system with this patch applied:

        /* size: 112, cachelines: 2, members: 20 */
        /* sum members: 110, holes: 1, sum holes: 2 */
        /* last cacheline: 48 bytes */

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bio.c                 |  2 ++
 block/blk-crypto-fallback.c |  1 +
 block/blk-merge.c           |  8 ++++++++
 block/blk-mq.c              |  2 ++
 block/bounce.c              |  1 +
 block/fops.c                |  3 +++
 fs/buffer.c                 | 12 ++++++++----
 fs/direct-io.c              |  2 ++
 fs/iomap/buffered-io.c      |  2 ++
 fs/iomap/direct-io.c        |  1 +
 fs/mpage.c                  |  1 +
 include/linux/blk-mq.h      |  2 ++
 include/linux/blk_types.h   |  2 ++
 13 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b9642a41f286..c9223e9d31da 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -251,6 +251,7 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 	bio->bi_opf = opf;
 	bio->bi_flags = 0;
 	bio->bi_ioprio = 0;
+	bio->bi_write_hint = 0;
 	bio->bi_status = 0;
 	bio->bi_iter.bi_sector = 0;
 	bio->bi_iter.bi_size = 0;
@@ -813,6 +814,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 {
 	bio_set_flag(bio, BIO_CLONED);
 	bio->bi_ioprio = bio_src->bi_ioprio;
+	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_iter = bio_src->bi_iter;
 
 	if (bio->bi_bdev) {
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index e6468eab2681..b1e7415f8439 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -172,6 +172,7 @@ static struct bio *blk_crypto_fallback_clone_bio(struct bio *bio_src)
 	if (bio_flagged(bio_src, BIO_REMAPPED))
 		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_ioprio		= bio_src->bi_ioprio;
+	bio->bi_write_hint	= bio_src->bi_write_hint;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 2d470cf2173e..2a06fd33039d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -810,6 +810,10 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (rq_data_dir(req) != rq_data_dir(next))
 		return NULL;
 
+	/* Don't merge requests with different write hints. */
+	if (req->write_hint != next->write_hint)
+		return NULL;
+
 	if (req->ioprio != next->ioprio)
 		return NULL;
 
@@ -937,6 +941,10 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (!bio_crypt_rq_ctx_compatible(rq, bio))
 		return false;
 
+	/* Don't merge requests with different write hints. */
+	if (rq->write_hint != bio->bi_write_hint)
+		return false;
+
 	if (rq->ioprio != bio_prio(bio))
 		return false;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index aa87fcfda1ec..34ceb15d2ea4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2585,6 +2585,7 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
 		rq->cmd_flags |= REQ_FAILFAST_MASK;
 
 	rq->__sector = bio->bi_iter.bi_sector;
+	rq->write_hint = bio->bi_write_hint;
 	blk_rq_bio_prep(rq, bio, nr_segs);
 
 	/* This can't fail, since GFP_NOIO includes __GFP_DIRECT_RECLAIM. */
@@ -3185,6 +3186,7 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 	}
 	rq->nr_phys_segments = rq_src->nr_phys_segments;
 	rq->ioprio = rq_src->ioprio;
+	rq->write_hint = rq_src->write_hint;
 
 	if (rq->bio && blk_crypto_rq_bio_prep(rq, rq->bio, gfp_mask) < 0)
 		goto free_and_out;
diff --git a/block/bounce.c b/block/bounce.c
index 7cfcb242f9a1..d6a5219f29dd 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -169,6 +169,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src)
 	if (bio_flagged(bio_src, BIO_REMAPPED))
 		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_ioprio		= bio_src->bi_ioprio;
+	bio->bi_write_hint	= bio_src->bi_write_hint;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
 
diff --git a/block/fops.c b/block/fops.c
index 0cf8cf72cdfa..ab0e37d1dc48 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -73,6 +73,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 		bio_init(&bio, bdev, vecs, nr_pages, dio_bio_write_op(iocb));
 	}
 	bio.bi_iter.bi_sector = pos >> SECTOR_SHIFT;
+	bio.bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
 	bio.bi_ioprio = iocb->ki_ioprio;
 
 	ret = bio_iov_iter_get_pages(&bio, iter);
@@ -203,6 +204,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 
 	for (;;) {
 		bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
+		bio->bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
 		bio->bi_private = dio;
 		bio->bi_end_io = blkdev_bio_end_io;
 		bio->bi_ioprio = iocb->ki_ioprio;
@@ -321,6 +323,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	dio->flags = 0;
 	dio->iocb = iocb;
 	bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
+	bio->bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
 	bio->bi_end_io = blkdev_bio_end_io_async;
 	bio->bi_ioprio = iocb->ki_ioprio;
 
diff --git a/fs/buffer.c b/fs/buffer.c
index b55dea034a5d..d6b64124977a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -55,7 +55,7 @@
 
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
-			  struct writeback_control *wbc);
+			  enum rw_hint hint, struct writeback_control *wbc);
 
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
 
@@ -1889,7 +1889,8 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 	do {
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
-			submit_bh_wbc(REQ_OP_WRITE | write_flags, bh, wbc);
+			submit_bh_wbc(REQ_OP_WRITE | write_flags, bh,
+				      inode->i_write_hint, wbc);
 			nr_underway++;
 		}
 		bh = next;
@@ -1944,7 +1945,8 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
 			clear_buffer_dirty(bh);
-			submit_bh_wbc(REQ_OP_WRITE | write_flags, bh, wbc);
+			submit_bh_wbc(REQ_OP_WRITE | write_flags, bh,
+				      inode->i_write_hint, wbc);
 			nr_underway++;
 		}
 		bh = next;
@@ -2756,6 +2758,7 @@ static void end_bio_bh_io_sync(struct bio *bio)
 }
 
 static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
+			  enum rw_hint write_hint,
 			  struct writeback_control *wbc)
 {
 	const enum req_op op = opf & REQ_OP_MASK;
@@ -2783,6 +2786,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
+	bio->bi_write_hint = write_hint;
 
 	__bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
 
@@ -2802,7 +2806,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 
 void submit_bh(blk_opf_t opf, struct buffer_head *bh)
 {
-	submit_bh_wbc(opf, bh, NULL);
+	submit_bh_wbc(opf, bh, WRITE_LIFE_NOT_SET, NULL);
 }
 EXPORT_SYMBOL(submit_bh);
 
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 60456263a338..62c97ff9e852 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -410,6 +410,8 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 		bio->bi_end_io = dio_bio_end_io;
 	if (dio->is_pinned)
 		bio_set_flag(bio, BIO_PAGE_PINNED);
+	bio->bi_write_hint = file_inode(dio->iocb->ki_filp)->i_write_hint;
+
 	sdio->bio = bio;
 	sdio->logical_offset_in_bio = sdio->cur_page_fs_offset;
 }
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 093c4515b22a..c961511bece1 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1667,6 +1667,7 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
 			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
 			       GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = sector;
+	bio->bi_write_hint = inode->i_write_hint;
 	wbc_init_bio(wbc, bio);
 
 	ioend = container_of(bio, struct iomap_ioend, io_inline_bio);
@@ -1697,6 +1698,7 @@ iomap_chain_bio(struct bio *prev)
 	new = bio_alloc(prev->bi_bdev, BIO_MAX_VECS, prev->bi_opf, GFP_NOFS);
 	bio_clone_blkg_association(new, prev);
 	new->bi_iter.bi_sector = bio_end_sector(prev);
+	new->bi_write_hint = prev->bi_write_hint;
 
 	bio_chain(prev, new);
 	bio_get(prev);		/* for iomap_finish_ioend */
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index bcd3f8cf5ea4..f3b43d223a46 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -380,6 +380,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 					  GFP_KERNEL);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
+		bio->bi_write_hint = inode->i_write_hint;
 		bio->bi_ioprio = dio->iocb->ki_ioprio;
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
diff --git a/fs/mpage.c b/fs/mpage.c
index 738882e0766d..fa8b99a199fa 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -605,6 +605,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 				GFP_NOFS);
 		bio->bi_iter.bi_sector = first_block << (blkbits - 9);
 		wbc_init_bio(wbc, bio);
+		bio->bi_write_hint = inode->i_write_hint;
 	}
 
 	/*
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 7a8150a5f051..492b0128b5d9 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -8,6 +8,7 @@
 #include <linux/scatterlist.h>
 #include <linux/prefetch.h>
 #include <linux/srcu.h>
+#include <linux/rw_hint.h>
 
 struct blk_mq_tags;
 struct blk_flush_queue;
@@ -135,6 +136,7 @@ struct request {
 	struct blk_crypto_keyslot *crypt_keyslot;
 #endif
 
+	enum rw_hint write_hint;
 	unsigned short ioprio;
 
 	enum mq_rq_state state;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index f288c94374b3..12d87cef2c03 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -10,6 +10,7 @@
 #include <linux/bvec.h>
 #include <linux/device.h>
 #include <linux/ktime.h>
+#include <linux/rw_hint.h>
 
 struct bio_set;
 struct bio;
@@ -269,6 +270,7 @@ struct bio {
 						 */
 	unsigned short		bi_flags;	/* BIO_* below */
 	unsigned short		bi_ioprio;
+	enum rw_hint		bi_write_hint;
 	blk_status_t		bi_status;
 	atomic_t		__bi_remaining;
 

