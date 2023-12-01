Return-Path: <linux-fsdevel+bounces-4644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB658016A7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66BDF1F210BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4904619D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="oJhpZ1cd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6A510D
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:25 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5cce5075bd6so22787837b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468745; x=1702073545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVMEIuPyFk0UJVVDGNAANRB18O7eDV0fbcVAkCK7tns=;
        b=oJhpZ1cdahfk4PB2leOlA3UBPvzrUhWRpVmKMphmXY909mnvdWhZhltXykJEpu7lgk
         R1lB+vo+4zpO6/9uD4qaLtAI1HE76207LB2YWr5JYBUgH8bwClJ9jijC/bsNyAsfxUXa
         +Hc5603CzDd+KFgm3wobKClMePrxoa0PHY55Lb2tgH3oA9e39o/Mnn8SFQ3E5WvD5qO3
         QTn6Te2Xff6KUEmfCo28Zx7cVnh4FlCFav8o8Fw+TC2dADsbs8S/B2+RRNFnP5yLFj1K
         VxXsz+8P5D9MFx1xo4YGfl7Z7o+LFjv9bw1Yc8jb+CdXJDV1WUiCCt8YoM1njeZDt6mV
         crsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468745; x=1702073545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVMEIuPyFk0UJVVDGNAANRB18O7eDV0fbcVAkCK7tns=;
        b=FSMObGyHu3hOJtzVt2pD528nw+g+GUn8W2dwU7CZFxE3tETYMmPtpFGWuirCElAtj0
         6lds23XDdYzlHFN31cCAK3ayoNPIlhsecFOeeq2+PND/gy0H1dLx8kVEgCQRfR7C/UWl
         blQXGZe54GelVVKjbm5FR78+Osxr6LT9q1CxhCtOAvkWHqGC/uqc7KqFpu8T4YMvk5ZM
         a5o/5UkJILSQSY1Zr1aM/81b9CxYG2nAShW8lCfZyG+3eSGD/ql/nIMj2GMMcx5UFONw
         gsoxGA9orkaIcp33rqDvm+HIOesvKablJ98YvrVex8LNM8ojG6xtZzMUJzoWdpQsT3I5
         YLmg==
X-Gm-Message-State: AOJu0Yw5+fy7UUJS1rio+Gxun3bYiU/5wtpjVZkGoXAZGG7s+O5LGl5n
	Hq/WJzdt4nEWei67m6PXcYrxo/OLiFAakbGiaj0uaQ==
X-Google-Smtp-Source: AGHT+IGL+TuLPtA3yVi7sUzk54735kxowGtQwrFaP3ucpcX739HW39tw7HQhc25cSM22SGGoQ6bbzA==
X-Received: by 2002:a05:690c:368d:b0:5d7:1940:3efb with SMTP id fu13-20020a05690c368d00b005d719403efbmr153365ywb.44.1701468744993;
        Fri, 01 Dec 2023 14:12:24 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m20-20020a819c14000000b005a4da74b869sm695899ywa.139.2023.12.01.14.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:24 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 24/46] btrfs: plumb the fscrypt extent context through create_io_em
Date: Fri,  1 Dec 2023 17:11:21 -0500
Message-ID: <f953f352d53ebe19368ec43f1e7ba46fffd8d320.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For prealloc extents we create an em, since we already have the context
loaded from the original prealloc extent creation we need to
pre-populate the extent map fscrypt info so it can be read properly
later if the pages are evicted.  Add the argument for create_io_em and
set it to NULL until we're ready to populate it properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 83d653376deb..837d7a3969d1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -140,11 +140,12 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
 				     struct page *locked_page, u64 start,
 				     u64 end, struct writeback_control *wbc,
 				     bool pages_dirty);
-static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
-				       u64 len, u64 orig_start, u64 block_start,
-				       u64 block_len, u64 orig_block_len,
-				       u64 ram_bytes, int compress_type,
-				       int type);
+static struct extent_map *create_io_em(struct btrfs_inode *inode,
+				       struct fscrypt_extent_info *fscrypt_info,
+				       u64 start, u64 len, u64 orig_start,
+				       u64 block_start, u64 block_len,
+				       u64 orig_block_len, u64 ram_bytes,
+				       int compress_type, int type);
 
 static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 					  u64 root, void *warn_ctx)
@@ -1156,7 +1157,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	}
 
 	/* Here we're doing allocation and writeback of the compressed pages */
-	em = create_io_em(inode, start,
+	em = create_io_em(inode, NULL, start,
 			  async_extent->ram_size,	/* len */
 			  start,			/* orig_start */
 			  ins.objectid,			/* block_start */
@@ -1421,7 +1422,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		extent_reserved = true;
 
 		ram_size = ins.offset;
-		em = create_io_em(inode, start, ins.offset, /* len */
+		em = create_io_em(inode, NULL, start, ins.offset, /* len */
 				  start, /* orig_start */
 				  ins.objectid, /* block_start */
 				  ins.offset, /* block_len */
@@ -2154,7 +2155,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			u64 orig_start = found_key.offset - nocow_args.extent_offset;
 			struct extent_map *em;
 
-			em = create_io_em(inode, cur_offset, nocow_args.num_bytes,
+			em = create_io_em(inode, NULL, cur_offset,
+					  nocow_args.num_bytes,
 					  orig_start,
 					  nocow_args.disk_bytenr, /* block_start */
 					  nocow_args.num_bytes, /* block_len */
@@ -7053,8 +7055,9 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 	struct btrfs_ordered_extent *ordered;
 
 	if (type != BTRFS_ORDERED_NOCOW) {
-		em = create_io_em(inode, start, len, orig_start, block_start,
-				  block_len, orig_block_len, ram_bytes,
+		em = create_io_em(inode, NULL, start, len, orig_start,
+				  block_start, block_len, orig_block_len,
+				  ram_bytes,
 				  BTRFS_COMPRESS_NONE, /* compress_type */
 				  type);
 		if (IS_ERR(em))
@@ -7342,11 +7345,12 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 }
 
 /* The callers of this must take lock_extent() */
-static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
-				       u64 len, u64 orig_start, u64 block_start,
-				       u64 block_len, u64 orig_block_len,
-				       u64 ram_bytes, int compress_type,
-				       int type)
+static struct extent_map *create_io_em(struct btrfs_inode *inode,
+				       struct fscrypt_extent_info *fscrypt_info,
+				       u64 start, u64 len, u64 orig_start,
+				       u64 block_start, u64 block_len,
+				       u64 orig_block_len, u64 ram_bytes,
+				       int compress_type, int type)
 {
 	struct extent_map *em;
 	int ret;
@@ -10535,7 +10539,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 		goto out_delalloc_release;
 	extent_reserved = true;
 
-	em = create_io_em(inode, start, num_bytes,
+	em = create_io_em(inode, NULL, start, num_bytes,
 			  start - encoded->unencoded_offset, ins.objectid,
 			  ins.offset, ins.offset, ram_bytes, compression,
 			  BTRFS_ORDERED_COMPRESSED);
-- 
2.41.0


