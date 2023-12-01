Return-Path: <linux-fsdevel+bounces-4652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A5D801660
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0AB1F21043
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7DC3F8C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zfUamOBk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF3910EA
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:39 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5b383b4184fso29888747b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468758; x=1702073558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/gVzeoeMQURNmpVvwynwfw94EyTjX18z8l6sVFepenU=;
        b=zfUamOBk1mZF62Y8pJofbqt6NsxqKT6LTQrnyfryWYlkHt4b1K8UVQH+aFV63uI8Pw
         bn11dFDN2FaGhb8xV8IBNoAm/QJs08+pqc7AodzvIyllyFGRu6fpY8EE34aDjywXreZl
         nZ8tPsougPMKYFAxVylIN6oNP6ScyR5Jl15MKd+yCs10ZS6MQH0KbL2/i8r5hwhk2VkU
         2+x2O33dla8huYwszfQkjiNj3s6bYEyVGf2GcxL0sahbFXwEe49bm7QwV9bNyHmWrOFJ
         Ou5J4HU3/62Z20TQSSqt2KtF5KijdR5NAmcWMIWrriyFHsLkg2Go/XEgioOnHAizxuGV
         opMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468758; x=1702073558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gVzeoeMQURNmpVvwynwfw94EyTjX18z8l6sVFepenU=;
        b=JFWNq2W7mIr0uk22q0WC6OH1DFQggaGnh+qlh9sbbKVMu/wQ2QHIAdaRKE1pAysjoM
         CW4y3ZXozBYKhNYuFGKP9TfMHQdKwhvmwQtXVia4Jn88p9WCvkTCQwJKUFHY6GQfTOg5
         glNn3/uy9/8LmIVDg2CeEpHuIveJdQgFuKx2kBeptHdz1V4bsbc2BYwL1IwRR4rV7oHM
         30AG0eelyjRavM5x+bvrvIvgZjNT+yKPFN3s2cfSSKaN/BdR5LsynU2JGtPojE48o/b8
         0N6Ig1KcJkuHTHnnHlnWB5R91QkLgtkC7+oHzVDE3NH2NdGZqsxW8Kcu2Jc69n5KcYVC
         x1Jw==
X-Gm-Message-State: AOJu0YwW+7ywSfNoTpaghyK29CNatLZgNs9kxS+/B1zp8m0Wy9aPlvsk
	qk0NgieRdw14ubmUh9nOFtMtgw==
X-Google-Smtp-Source: AGHT+IH89hNyf6GR833XcK9wzFi9Ci0Mxcbcl+L3FWkFizNpJnJbUry42lg3AZACHMlWrF3lwLX8xQ==
X-Received: by 2002:a05:690c:f85:b0:5d7:2c6b:625 with SMTP id df5-20020a05690c0f8500b005d72c6b0625mr45864ywb.34.1701468758582;
        Fri, 01 Dec 2023 14:12:38 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z143-20020a0dd795000000b005af5bb5e840sm226ywd.34.2023.12.01.14.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:38 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 32/46] btrfs: setup fscrypt_extent_info for new extents
Date: Fri,  1 Dec 2023 17:11:29 -0500
Message-ID: <506c404aac10482cf64b0fb5e34310a41316f637.1701468306.git.josef@toxicpanda.com>
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

New extents for encrypted inodes must have a fscrypt_extent_info, which
has the necessary keys and does all the registration at the block layer
for them.  This is passed through all of the infrastructure we've
previously added to make sure the context gets saved properly with the
file extents.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index dc24f11016d9..60d016da1fce 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7434,6 +7434,16 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode,
 	if (fscrypt_info) {
 		em->encryption_type = BTRFS_ENCRYPTION_FSCRYPT;
 		em->fscrypt_info = fscrypt_get_extent_info(fscrypt_info);
+	} else if (IS_ENCRYPTED(&inode->vfs_inode)) {
+		struct fscrypt_extent_info *fscrypt_info;
+
+		em->encryption_type = BTRFS_ENCRYPTION_FSCRYPT;
+		fscrypt_info = fscrypt_prepare_new_extent(&inode->vfs_inode);
+		if (IS_ERR(fscrypt_info)) {
+			free_extent_map(em);
+			return ERR_CAST(fscrypt_info);
+		}
+		em->fscrypt_info = fscrypt_info;
 	} else {
 		em->encryption_type = BTRFS_ENCRYPTION_NONE;
 	}
@@ -9831,6 +9841,9 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 	if (trans)
 		own_trans = false;
 	while (num_bytes > 0) {
+		struct fscrypt_extent_info *fscrypt_info = NULL;
+		int encryption_type = BTRFS_ENCRYPTION_NONE;
+
 		cur_bytes = min_t(u64, num_bytes, SZ_256M);
 		cur_bytes = max(cur_bytes, min_size);
 		/*
@@ -9845,6 +9858,20 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		if (ret)
 			break;
 
+		if (IS_ENCRYPTED(inode)) {
+			fscrypt_info = fscrypt_prepare_new_extent(inode);
+			if (IS_ERR(fscrypt_info)) {
+				btrfs_dec_block_group_reservations(fs_info,
+								   ins.objectid);
+				btrfs_free_reserved_extent(fs_info,
+							   ins.objectid,
+							   ins.offset, 0);
+				ret = PTR_ERR(fscrypt_info);
+				break;
+			}
+			encryption_type = BTRFS_ENCRYPTION_FSCRYPT;
+		}
+
 		/*
 		 * We've reserved this space, and thus converted it from
 		 * ->bytes_may_use to ->bytes_reserved.  Any error that happens
@@ -9856,7 +9883,8 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 
 		last_alloc = ins.offset;
 		trans = insert_prealloc_file_extent(trans, BTRFS_I(inode),
-						    &ins, NULL, cur_offset);
+						    &ins, fscrypt_info,
+						    cur_offset);
 		/*
 		 * Now that we inserted the prealloc extent we can finally
 		 * decrement the number of reservations in the block group.
@@ -9866,6 +9894,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
+			fscrypt_put_extent_info(fscrypt_info);
 			btrfs_free_reserved_extent(fs_info, ins.objectid,
 						   ins.offset, 0);
 			break;
@@ -9873,6 +9902,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 
 		em = alloc_extent_map();
 		if (!em) {
+			fscrypt_put_extent_info(fscrypt_info);
 			btrfs_drop_extent_map_range(BTRFS_I(inode), cur_offset,
 					    cur_offset + ins.offset - 1, false);
 			btrfs_set_inode_full_sync(BTRFS_I(inode));
@@ -9888,6 +9918,8 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		em->ram_bytes = ins.offset;
 		set_bit(EXTENT_FLAG_PREALLOC, &em->flags);
 		em->generation = trans->transid;
+		em->fscrypt_info = fscrypt_info;
+		em->encryption_type = encryption_type;
 
 		ret = btrfs_replace_extent_map_range(BTRFS_I(inode), em, true);
 		free_extent_map(em);
-- 
2.41.0


