Return-Path: <linux-fsdevel+bounces-4661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A556A801667
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A53EB209EA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7183F8CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Flj7Hs77"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4023CD63
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:47 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5d3644ca426so24384917b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468766; x=1702073566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orFc9ft3N/UoPwsjthsVKSwuN6/TtsfGvyUWZy1WZBs=;
        b=Flj7Hs77LD2rT4kfqxsPY0crWkFboQ4aWQfViy/PqG6Ha1BzjD/hfeiSZsXNLni2B/
         4ZDNnBHlPBODBRHJ6DcKAvOFOzj5r4SNHsvAc0fPORmRiC5wYBPCld1X10fA98ca3Al6
         8vov20qgTN/70LShg9bCTfRbEx8dQ3o77LG0M04Pr4tQjkk08i0MBL2u6e5eARaYN26S
         8Ic1PJrjO0/9FG+g4pD+WLi1FFkWrXp3/c7KTBgn5uGNB2p2xnWt1Q0Pu3MedNW1UdrH
         oSvogocXCXcXPFZbYpfdYc6wRE0uDeVn1Ou/ZTft4GSvqvEG2Hxl8zMHyVkuLObMF9jO
         CKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468766; x=1702073566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orFc9ft3N/UoPwsjthsVKSwuN6/TtsfGvyUWZy1WZBs=;
        b=iY9EeOBSN9ViaESXwiCmtQTcJ7c0fEzgsFyy8e3p7QwM3xZVF11ULmuPanjo0HVxTb
         2/M3J0K1NEWoIAWPctfxK3IwiIWzbVs1mG/ej3MzUwdEiXaGTgH4VMAagotPXVPdOzYq
         /CXCNm2VLNSJcpCqFe/qb0pJzh+XFMW/lujieAH0BwXjgqt3aNkH7tKxlH2bPd4XuVtk
         rdOO1hCVEO9LjSHwgsS57ZDvvP+4JKuSkF2QfxORF9/l5zFVGwIagEOLUmn7M6K3S580
         BaFV2eIKRuXjW2q3Q5i8iVcOlnm/E/6nx7MSCmg++ec1vPfF2j8Co3id9AN8ShC++Dzz
         q0BQ==
X-Gm-Message-State: AOJu0Yytf+69Qd3P+3ucMtsQnJpm8oLftXmRHU7i4vgFaYAOO5DPuxcx
	IeErNrnwI53zbnLHmb+AxwWmwg==
X-Google-Smtp-Source: AGHT+IFuUAzLwk16Snq+KtsWjvULMLCdbsTWTAPfoHJhjL6e4RFJJa1D8aicRDwIsxQRCQnLxBqJ4Q==
X-Received: by 2002:a05:690c:708:b0:5d3:55ae:90db with SMTP id bs8-20020a05690c070800b005d355ae90dbmr6409047ywb.20.1701468766288;
        Fri, 01 Dec 2023 14:12:46 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q128-20020a819986000000b005ce93212c47sm1388975ywg.134.2023.12.01.14.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:45 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 39/46] btrfs: add test_dummy_encryption support
Date: Fri,  1 Dec 2023 17:11:36 -0500
Message-ID: <b50d128bfbae6011473f2eec74fdf7c7e68ea6b7.1701468306.git.josef@toxicpanda.com>
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

In order to enable more thorough testing of fscrypt enable the
test_dummy_encryption mount option.  This is used by fscrypt users to
easily enable fscrypt on the file system for testing without needing to
do the key setup and everything.

The only deviation from other file systems we make is we only support
the fsparam_flag version of this mount option, as it defaults to v2.  We
don't want to have to bother with rejecting v1 related mount options.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c |  1 +
 fs/btrfs/fs.h      |  3 +++
 fs/btrfs/fscrypt.c |  6 +++++
 fs/btrfs/super.c   | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 719245d73b99..aedd8a0e4962 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1272,6 +1272,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	kfree(fs_info->super_copy);
 	kfree(fs_info->super_for_commit);
 	kfree(fs_info->subpage_info);
+	fscrypt_free_dummy_policy(&fs_info->dummy_enc_policy);
 	kvfree(fs_info);
 }
 
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 1340e71d026c..74752204f3ab 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -7,6 +7,7 @@
 #include <linux/fs.h>
 #include <linux/btrfs_tree.h>
 #include <linux/sizes.h>
+#include <linux/fscrypt.h>
 #include "extent-io-tree.h"
 #include "extent_map.h"
 #include "async-thread.h"
@@ -189,6 +190,7 @@ enum {
 	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 28),
 	BTRFS_MOUNT_NODISCARD			= (1UL << 29),
 	BTRFS_MOUNT_NOSPACECACHE		= (1UL << 30),
+	BTRFS_MOUNT_TEST_DUMMY_ENCRYPTION	= (1UL << 31),
 };
 
 /*
@@ -828,6 +830,7 @@ struct btrfs_fs_info {
 	spinlock_t eb_leak_lock;
 	struct list_head allocated_ebs;
 #endif
+	struct fscrypt_dummy_policy dummy_enc_policy;
 };
 
 static inline u64 btrfs_get_fs_generation(const struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index 85b596711371..2fbceec62dc7 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -242,6 +242,11 @@ static blk_status_t btrfs_process_encrypted_bio(struct bio *orig_bio,
 	return btrfs_csum_one_bio(bbio, enc_bio);
 }
 
+static const union fscrypt_policy *btrfs_get_dummy_policy(struct super_block *sb)
+{
+	return btrfs_sb(sb)->dummy_enc_policy.policy;
+}
+
 int btrfs_fscrypt_load_extent_info(struct btrfs_inode *inode,
 				   struct extent_map *em,
 				   struct btrfs_fscrypt_ctx *ctx)
@@ -357,4 +362,5 @@ const struct fscrypt_operations btrfs_fscrypt_ops = {
 	.empty_dir = btrfs_fscrypt_empty_dir,
 	.get_devices = btrfs_fscrypt_get_devices,
 	.process_bio = btrfs_process_encrypted_bio,
+	.get_dummy_policy = btrfs_get_dummy_policy,
 };
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 462a23db26af..2a7789519a6c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -88,6 +88,7 @@ struct btrfs_fs_context {
 	unsigned long compress_type:4;
 	unsigned int compress_level;
 	refcount_t refs;
+	struct fscrypt_dummy_policy dummy_enc_policy;
 };
 
 enum {
@@ -122,6 +123,7 @@ enum {
 	Opt_thread_pool,
 	Opt_treelog,
 	Opt_user_subvol_rm_allowed,
+	Opt_test_dummy_encryption,
 
 	/* Rescue options */
 	Opt_rescue,
@@ -255,6 +257,13 @@ static const struct fs_parameter_spec btrfs_fs_parameters[] = {
 	fsparam_flag_no("enospc_debug", Opt_enospc_debug),
 #ifdef CONFIG_BTRFS_DEBUG
 	fsparam_enum("fragment", Opt_fragment, btrfs_parameter_fragment),
+
+	/*
+	 * With -o test_dummy_encryption we default to v2, only allow the flag
+	 * version, since we don't support v1.
+	 */
+	fsparam_flag("test_dummy_encryption", Opt_test_dummy_encryption),
+
 #endif
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	fsparam_flag("ref_verify", Opt_ref_verify),
@@ -268,6 +277,7 @@ static int btrfs_parse_param(struct fs_context *fc,
 	struct btrfs_fs_context *ctx = fc->fs_private;
 	struct fs_parse_result result;
 	int opt;
+	int ret;
 
 	opt = fs_parse(fc, btrfs_fs_parameters, param, &result);
 	if (opt < 0)
@@ -598,6 +608,13 @@ static int btrfs_parse_param(struct fs_context *fc,
 			return -EINVAL;
 		}
 		break;
+	case Opt_test_dummy_encryption:
+		btrfs_set_opt(ctx->mount_opt, TEST_DUMMY_ENCRYPTION);
+		ret = fscrypt_parse_test_dummy_encryption(param,
+							  &ctx->dummy_enc_policy);
+		if (ret)
+			return ret;
+		break;
 #endif
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	case Opt_ref_verify:
@@ -946,6 +963,9 @@ static int btrfs_fill_super(struct super_block *sb,
 		return err;
 	}
 
+	if (fscrypt_is_dummy_policy_set(&fs_info->dummy_enc_policy))
+		btrfs_set_fs_incompat(fs_info, ENCRYPT);
+
 	if (btrfs_fs_incompat(fs_info, ENCRYPT)) {
 		if (IS_ENABLED(CONFIG_FS_ENCRYPTION_INLINE_CRYPT)) {
 			sb->s_flags |= SB_INLINECRYPT;
@@ -1112,6 +1132,9 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 #endif
 	if (btrfs_test_opt(info, REF_VERIFY))
 		seq_puts(seq, ",ref_verify");
+	if (btrfs_test_opt(info, TEST_DUMMY_ENCRYPTION))
+		fscrypt_show_test_dummy_encryption(seq, ',', dentry->d_sb);
+
 	seq_printf(seq, ",subvolid=%llu",
 		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
 	subvol_name = btrfs_get_subvol_name_from_objectid(info,
@@ -1384,6 +1407,18 @@ static void btrfs_ctx_to_info(struct btrfs_fs_info *fs_info,
 	fs_info->mount_opt = ctx->mount_opt;
 	fs_info->compress_type = ctx->compress_type;
 	fs_info->compress_level = ctx->compress_level;
+
+	/*
+	 * If there's nothing set, or if the fs_info already has one set, don't
+	 * do anything.  If the fs_info is set we'll free the dummy one when we
+	 * free the ctx.
+	 */
+	if (!fscrypt_is_dummy_policy_set(&ctx->dummy_enc_policy) ||
+	    fscrypt_is_dummy_policy_set(&fs_info->dummy_enc_policy))
+		return;
+
+	fs_info->dummy_enc_policy = ctx->dummy_enc_policy;
+	memset(&ctx->dummy_enc_policy, 0, sizeof(ctx->dummy_enc_policy));
 }
 
 static void btrfs_info_to_ctx(struct btrfs_fs_info *fs_info,
@@ -1436,6 +1471,7 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
 	btrfs_info_if_set(info, old, USEBACKUPROOT, "trying to use backup root at mount time");
 	btrfs_info_if_set(info, old, IGNOREBADROOTS, "ignoring bad roots");
 	btrfs_info_if_set(info, old, IGNOREDATACSUMS, "ignoring data csums");
+	btrfs_info_if_set(info, old, TEST_DUMMY_ENCRYPTION, "test dummy encryption mode enabled");
 
 	btrfs_info_if_unset(info, old, NODATACOW, "setting datacow");
 	btrfs_info_if_unset(info, old, SSD, "not using ssd optimizations");
@@ -1467,6 +1503,23 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
 			   info->max_inline);
 }
 
+static bool btrfs_check_test_dummy_encryption(struct fs_context *fc)
+{
+	struct btrfs_fs_context *ctx = fc->fs_private;
+	struct btrfs_fs_info *fs_info = btrfs_sb(fc->root->d_sb);
+
+	if (!fscrypt_is_dummy_policy_set(&ctx->dummy_enc_policy))
+		return true;
+
+	if (fscrypt_dummy_policies_equal(&fs_info->dummy_enc_policy,
+					 &ctx->dummy_enc_policy))
+		return true;
+
+	btrfs_warn(fs_info,
+		   "Can't set or change test_dummy_encryption on remount");
+	return false;
+}
+
 static int btrfs_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
@@ -1485,6 +1538,10 @@ static int btrfs_reconfigure(struct fs_context *fc)
 	    !btrfs_check_options(fs_info, &ctx->mount_opt, fc->sb_flags))
 		return -EINVAL;
 
+	if (!mount_reconfigure &&
+	    !btrfs_check_test_dummy_encryption(fc))
+		return -EINVAL;
+
 	ret = btrfs_check_features(fs_info, !(fc->sb_flags & SB_RDONLY));
 	if (ret < 0)
 		return ret;
@@ -2121,6 +2178,7 @@ static void btrfs_free_fs_context(struct fs_context *fc)
 		btrfs_free_fs_info(fs_info);
 
 	if (ctx && refcount_dec_and_test(&ctx->refs)) {
+		fscrypt_free_dummy_policy(&ctx->dummy_enc_policy);
 		kfree(ctx->subvol_name);
 		kfree(ctx);
 	}
-- 
2.41.0


