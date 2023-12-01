Return-Path: <linux-fsdevel+bounces-4646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F27B80165C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3A41F21039
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A26619C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="FdEtEq/f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C4210D0
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:27 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-db632fef2dcso894849276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468746; x=1702073546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ek5VDxe4u6nMgsTGQg53bhX64gutAEVKYEBo1llkfyg=;
        b=FdEtEq/f/xAsuYy9NEFOX7JFkTwW4/PDUx9tNQtPhCLLV8vBv56KKN1sMN6ygVz8H+
         CBJp4zLnT8lEaDJRBsd4cx/CEvn39JBARKTARE4kmDVj+uGjSZ/N0hAAdpDyv7jWJkJg
         XB2WWJx3DXsphBmhWvQGjbW+UmX+2pWaqJMY1XgJcf0TP13fgjZ2treUOG2ycQcfqzSA
         /GLoqrkj2Nj96idYrYVDj3lbDy+WO+GVhKz4wDO1DwNUiiTQKoTjPedVZ5mLx7UdaYqC
         swFuf1QtpB2nPDgCMzNG9/Y+wFQZ72JOS/NqnznskPjqqUWwQQ/eKr/LcO0uq8Bj1hkP
         5Xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468746; x=1702073546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ek5VDxe4u6nMgsTGQg53bhX64gutAEVKYEBo1llkfyg=;
        b=RCl78q0IRf11x9BeeoO16Tp9zblZqnOlAYHeyODz+oVBcoJr9v+ECbgK8cNAhXI/8Y
         P7hUySIpIbJyYziWngV4xLzBtcWLMhzufHQsJoYB4aRxwmDoONGu11MYcN+Qhx7yJ8pz
         QLz9piL7N+MwxBIk8c41GVD0QY25ZNcWEW1Kc2yevDdOItmjj2tdtyzSmA8jPM842FJn
         MLgFfizRnPKyjvPj/Fa60Vy3fMTjsDCMY3yG2Fle/qkRB7hX5NalhBZtUHdhHq4YZ9Iq
         Bzn12Tz2p4O76AMg+rCtJAU/zcUVFLX+pvN10OkgmgOnABGAgXih8KCVUikqMdapex3K
         YG7A==
X-Gm-Message-State: AOJu0YzblQDXIylpLDRz0lMuT2322G5uSz6jbahS9xTSzRzURgHwEsv9
	bYRAW0ZjiiF2DuQx0QfGJbSFxOSIx/98WYyAw2VbNg==
X-Google-Smtp-Source: AGHT+IFU62CwfBowml7OMWcFxDo2470t9e0vP430EQGlaT5wyCBNIv9Bm+1IRruiXnSoIb32Me7FDA==
X-Received: by 2002:a0d:d40c:0:b0:5d7:1940:b38e with SMTP id w12-20020a0dd40c000000b005d71940b38emr167008ywd.90.1701468746222;
        Fri, 01 Dec 2023 14:12:26 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x67-20020a817c46000000b0057a8de72338sm1375955ywc.68.2023.12.01.14.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:25 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 25/46] btrfs: populate the ordered_extent with the fscrypt context
Date: Fri,  1 Dec 2023 17:11:22 -0500
Message-ID: <6ef7620cd1bfaf1592549de0898c81c9b953b395.1701468306.git.josef@toxicpanda.com>
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

The fscrypt_extent_info will be tied to the extent_map lifetime, so it
will be created when we create the IO em, or it'll already exist in the
NOCOW case.  Use this fscrypt_info when creating the ordered extent to
make sure everything is passed through properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 77 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 837d7a3969d1..9c704b1cfe05 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1170,9 +1170,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 		ret = PTR_ERR(em);
 		goto out_free_reserve;
 	}
-	free_extent_map(em);
 
-	ordered = btrfs_alloc_ordered_extent(inode, NULL,
+	ordered = btrfs_alloc_ordered_extent(inode, em->fscrypt_info,
 				       start,			/* file_offset */
 				       async_extent->ram_size,	/* num_bytes */
 				       async_extent->ram_size,	/* ram_bytes */
@@ -1181,6 +1180,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 				       0,			/* offset */
 				       1 << BTRFS_ORDERED_COMPRESSED,
 				       async_extent->compress_type);
+	free_extent_map(em);
 	if (IS_ERR(ordered)) {
 		btrfs_drop_extent_map_range(inode, start, end, false);
 		ret = PTR_ERR(ordered);
@@ -1434,13 +1434,13 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			ret = PTR_ERR(em);
 			goto out_reserve;
 		}
-		free_extent_map(em);
 
-		ordered = btrfs_alloc_ordered_extent(inode, NULL,
+		ordered = btrfs_alloc_ordered_extent(inode, em->fscrypt_info,
 					start, ram_size, ram_size, ins.objectid,
 					cur_alloc_size, 0,
 					1 << BTRFS_ORDERED_REGULAR,
 					BTRFS_COMPRESS_NONE);
+		free_extent_map(em);
 		if (IS_ERR(ordered)) {
 			ret = PTR_ERR(ordered);
 			goto out_drop_extent_cache;
@@ -2013,6 +2013,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		struct btrfs_key found_key;
 		struct btrfs_file_extent_item *fi;
 		struct extent_buffer *leaf;
+		struct extent_map *em = NULL;
+		struct fscrypt_extent_info *fscrypt_info = NULL;
 		u64 extent_end;
 		u64 ram_bytes;
 		u64 nocow_end;
@@ -2149,13 +2151,29 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			}
 		}
 
+		/*
+		 * We only want to do this lookup if we're encrypted, otherwise
+		 * fsrypt_info will be null and we can avoid this lookup.
+		 */
+		if (IS_ENCRYPTED(&inode->vfs_inode)) {
+			em = btrfs_get_extent(inode, NULL, 0, cur_offset,
+					      nocow_args.num_bytes);
+			if (IS_ERR(em)) {
+				btrfs_dec_nocow_writers(nocow_bg);
+				ret = PTR_ERR(em);
+				goto error;
+			}
+			fscrypt_info = fscrypt_get_extent_info(em->fscrypt_info);
+			free_extent_map(em);
+			em = NULL;
+		}
+
 		nocow_end = cur_offset + nocow_args.num_bytes - 1;
 		is_prealloc = extent_type == BTRFS_FILE_EXTENT_PREALLOC;
 		if (is_prealloc) {
 			u64 orig_start = found_key.offset - nocow_args.extent_offset;
-			struct extent_map *em;
 
-			em = create_io_em(inode, NULL, cur_offset,
+			em = create_io_em(inode, fscrypt_info, cur_offset,
 					  nocow_args.num_bytes,
 					  orig_start,
 					  nocow_args.disk_bytenr, /* block_start */
@@ -2164,6 +2182,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					  ram_bytes, BTRFS_COMPRESS_NONE,
 					  BTRFS_ORDERED_PREALLOC);
 			if (IS_ERR(em)) {
+				fscrypt_put_extent_info(fscrypt_info);
 				btrfs_dec_nocow_writers(nocow_bg);
 				ret = PTR_ERR(em);
 				goto error;
@@ -2171,13 +2190,15 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			free_extent_map(em);
 		}
 
-		ordered = btrfs_alloc_ordered_extent(inode, NULL, cur_offset,
-				nocow_args.num_bytes, nocow_args.num_bytes,
-				nocow_args.disk_bytenr, nocow_args.num_bytes, 0,
+		ordered = btrfs_alloc_ordered_extent(inode, fscrypt_info,
+				cur_offset, nocow_args.num_bytes,
+				nocow_args.num_bytes, nocow_args.disk_bytenr,
+				nocow_args.num_bytes, 0,
 				is_prealloc
 				? (1 << BTRFS_ORDERED_PREALLOC)
 				: (1 << BTRFS_ORDERED_NOCOW),
 				BTRFS_COMPRESS_NONE);
+		fscrypt_put_extent_info(fscrypt_info);
 		btrfs_dec_nocow_writers(nocow_bg);
 		if (IS_ERR(ordered)) {
 			if (is_prealloc) {
@@ -7042,6 +7063,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 
 static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 						  struct btrfs_dio_data *dio_data,
+						  struct extent_map *orig_em,
 						  const u64 start,
 						  const u64 len,
 						  const u64 orig_start,
@@ -7053,18 +7075,24 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 {
 	struct extent_map *em = NULL;
 	struct btrfs_ordered_extent *ordered;
+	struct fscrypt_extent_info *fscrypt_info = NULL;
+
+	if (orig_em)
+		fscrypt_info = orig_em->fscrypt_info;
 
 	if (type != BTRFS_ORDERED_NOCOW) {
-		em = create_io_em(inode, NULL, start, len, orig_start,
+		em = create_io_em(inode, fscrypt_info, start, len, orig_start,
 				  block_start, block_len, orig_block_len,
 				  ram_bytes,
 				  BTRFS_COMPRESS_NONE, /* compress_type */
 				  type);
 		if (IS_ERR(em))
 			goto out;
+		fscrypt_info = em->fscrypt_info;
 	}
-	ordered = btrfs_alloc_ordered_extent(inode, NULL, start, len, len,
-					     block_start, block_len, 0,
+
+	ordered = btrfs_alloc_ordered_extent(inode, fscrypt_info, start, len,
+					     len, block_start, block_len, 0,
 					     (1 << type) |
 					     (1 << BTRFS_ORDERED_DIRECT),
 					     BTRFS_COMPRESS_NONE);
@@ -7108,9 +7136,10 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 	if (ret)
 		return ERR_PTR(ret);
 
-	em = btrfs_create_dio_extent(inode, dio_data, start, ins.offset, start,
-				     ins.objectid, ins.offset, ins.offset,
-				     ins.offset, BTRFS_ORDERED_REGULAR);
+	em = btrfs_create_dio_extent(inode, dio_data, NULL, start, ins.offset,
+				     start, ins.objectid, ins.offset,
+				     ins.offset, ins.offset,
+				     BTRFS_ORDERED_REGULAR);
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	if (IS_ERR(em))
 		btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset,
@@ -7379,7 +7408,13 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode,
 		set_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
 		em->compress_type = compress_type;
 	}
-	em->encryption_type = BTRFS_ENCRYPTION_NONE;
+
+	if (fscrypt_info) {
+		em->encryption_type = BTRFS_ENCRYPTION_FSCRYPT;
+		em->fscrypt_info = fscrypt_get_extent_info(fscrypt_info);
+	} else {
+		em->encryption_type = BTRFS_ENCRYPTION_NONE;
+	}
 
 	ret = btrfs_replace_extent_map_range(inode, em, true);
 	if (ret) {
@@ -7455,9 +7490,9 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		}
 		space_reserved = true;
 
-		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start, len,
-					      orig_start, block_start,
-					      len, orig_block_len,
+		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, em,
+					      start, len, orig_start,
+					      block_start, len, orig_block_len,
 					      ram_bytes, type);
 		btrfs_dec_nocow_writers(bg);
 		if (type == BTRFS_ORDERED_PREALLOC) {
@@ -10547,14 +10582,14 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 		ret = PTR_ERR(em);
 		goto out_free_reserved;
 	}
-	free_extent_map(em);
 
-	ordered = btrfs_alloc_ordered_extent(inode, NULL, start,
+	ordered = btrfs_alloc_ordered_extent(inode, em->fscrypt_info, start,
 				       num_bytes, ram_bytes, ins.objectid,
 				       ins.offset, encoded->unencoded_offset,
 				       (1 << BTRFS_ORDERED_ENCODED) |
 				       (1 << BTRFS_ORDERED_COMPRESSED),
 				       compression);
+	free_extent_map(em);
 	if (IS_ERR(ordered)) {
 		btrfs_drop_extent_map_range(inode, start, end, false);
 		ret = PTR_ERR(ordered);
-- 
2.41.0


