Return-Path: <linux-fsdevel+bounces-4650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E706380165F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804881F21043
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E2B3F8CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="BcK3cMsI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1BE10F1
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:35 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5d3d5b10197so17597537b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468755; x=1702073555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LKWiCClPYuTfIaoXpNks8/BOy6SWwggGf9EcawY+RrU=;
        b=BcK3cMsIkHgjOv7nlVw8i3YO3ellxNcfuTeGWIv38NKDqjD0uzpt0XkLolvAXScHNR
         Ta6/AzXljNSdV9L1qManzmDCpU9eASvsbqt+84lb4y90gqK8c0RMPKbJPWMX1kp/KcQt
         RI7W96m62H4rA+Gee2vzaaqbXQ+IHOdXLrFM+Xs9WLjWrUsRZLcJ3fRSE+6cD8X5/v+w
         U3F8xj37ol5G6TuCe+ujH/ooC3xcLMRKTn48XlcD23EXRsythHLP3pK1p2nE/dVXWByx
         cwo8HCYgkmhqxDaIIjv8Avsi8RTibWHYtRydPluDxloM8gsKJTT+fcl0+r3+vLuvt/jR
         7CHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468755; x=1702073555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKWiCClPYuTfIaoXpNks8/BOy6SWwggGf9EcawY+RrU=;
        b=xJSTquAp8y/mOpjK1hW1+XB3pJByBKzBRFq4Ke2+sz3zDTClWVOIc2R0WPXiqcqVe9
         SV79qxkPoZRytpJCkT17Z+BY97oNWLlMlObAgLgyfPpZ8iJTGGLhQJZdw6Wy0bord4Hn
         XNf7QcK5W40wQPld67j/56ve9q4cW4LY2O4xCjXoLj8RFwvDDciteQWP7uMw12+TMY92
         tY6Wnpizo2lMB/HpXHg3O8J8VCSM2ZVB3iYd1WyEbxja2UNbwluDHFGv85/DnklMdKa3
         +un2fJvMlvlpOl0Mr2ArGu2a3sfyqVnMhRKkfkhrXS3ju7ze1ZNuTZQtVIXz7MmAeQbe
         VCwg==
X-Gm-Message-State: AOJu0YwiIc4lxFtfAZkpyiFIbBZum3ZlbL6mYlnJBaU0pnBUgFjZBWfX
	FoGrsiVnnMgDiS9NXkNFL6zMcg==
X-Google-Smtp-Source: AGHT+IHgBGXs1lk7pQ/qnyaYCRqlIauDPMPv8C9tRRr6Oak6txsoTbpXMLAMZ1O04gknJYr6sj4v2w==
X-Received: by 2002:a05:690c:fd1:b0:5d7:1941:ab5 with SMTP id dg17-20020a05690c0fd100b005d719410ab5mr271323ywb.80.1701468754716;
        Fri, 01 Dec 2023 14:12:34 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id r65-20020a819a44000000b005d3fecea56csm818014ywg.61.2023.12.01.14.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:34 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 29/46] btrfs: pass through fscrypt_extent_info to the file extent helpers
Date: Fri,  1 Dec 2023 17:11:26 -0500
Message-ID: <921ee1a1728be513293488859d0060aca592e5be.1701468306.git.josef@toxicpanda.com>
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

Now that we have the fscrypt_extnet_info in all of the supporting
structures, pass this through and set the file extent encryption bit
accordingly from the supporting structures.  In subsequent patches code
will be added to populate these appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c    | 18 +++++++++++-------
 fs/btrfs/tree-log.c |  2 +-
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 150ec68783c3..8bd5c7488055 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2897,7 +2897,9 @@ int btrfs_writepage_cow_fixup(struct page *page)
 }
 
 static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
-				       struct btrfs_inode *inode, u64 file_pos,
+				       struct btrfs_inode *inode,
+				       struct fscrypt_extent_info *fscrypt_info,
+				       u64 file_pos,
 				       struct btrfs_file_extent_item *stack_fi,
 				       const bool update_inode_bytes,
 				       u64 qgroup_reserved)
@@ -3029,8 +3031,7 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_num_bytes(&stack_fi, num_bytes);
 	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, ram_bytes);
 	btrfs_set_stack_file_extent_compression(&stack_fi, oe->compress_type);
-	btrfs_set_stack_file_extent_encryption(&stack_fi,
-					       BTRFS_ENCRYPTION_NONE);
+	btrfs_set_stack_file_extent_encryption(&stack_fi, oe->encryption_type);
 	/* Other encoding is reserved and always 0 */
 
 	/*
@@ -3044,8 +3045,9 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 			     test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags);
 
 	return insert_reserved_file_extent(trans, BTRFS_I(oe->inode),
-					   oe->file_offset, &stack_fi,
-					   update_inode_bytes, oe->qgroup_rsv);
+					   oe->fscrypt_info, oe->file_offset,
+					   &stack_fi, update_inode_bytes,
+					   oe->qgroup_rsv);
 }
 
 /*
@@ -9708,6 +9710,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 				       struct btrfs_trans_handle *trans_in,
 				       struct btrfs_inode *inode,
 				       struct btrfs_key *ins,
+				       struct fscrypt_extent_info *fscrypt_info,
 				       u64 file_offset)
 {
 	struct btrfs_file_extent_item stack_fi;
@@ -9729,6 +9732,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, len);
 	btrfs_set_stack_file_extent_compression(&stack_fi, BTRFS_COMPRESS_NONE);
 	btrfs_set_stack_file_extent_encryption(&stack_fi,
+					       fscrypt_info ? BTRFS_ENCRYPTION_FSCRYPT :
 					       BTRFS_ENCRYPTION_NONE);
 	/* Other encoding is reserved and always 0 */
 
@@ -9737,7 +9741,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 		return ERR_PTR(qgroup_released);
 
 	if (trans) {
-		ret = insert_reserved_file_extent(trans, inode,
+		ret = insert_reserved_file_extent(trans, inode, fscrypt_info,
 						  file_offset, &stack_fi,
 						  true, qgroup_released);
 		if (ret)
@@ -9831,7 +9835,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 
 		last_alloc = ins.offset;
 		trans = insert_prealloc_file_extent(trans, BTRFS_I(inode),
-						    &ins, cur_offset);
+						    &ins, NULL, cur_offset);
 		/*
 		 * Now that we inserted the prealloc extent we can finally
 		 * decrement the number of reservations in the block group.
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 580974153649..36cbc4d176c5 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4628,7 +4628,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	u64 block_len;
 	int ret;
 	size_t fscrypt_context_size = 0;
-	u8 encryption = BTRFS_ENCRYPTION_NONE;
+	u8 encryption = em->encryption_type;
 
 	btrfs_set_stack_file_extent_generation(&fi, trans->transid);
 	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
-- 
2.41.0


