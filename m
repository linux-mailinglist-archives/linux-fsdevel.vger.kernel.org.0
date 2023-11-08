Return-Path: <linux-fsdevel+bounces-2429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A597E5E56
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 20:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12243B216BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 19:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBA039863;
	Wed,  8 Nov 2023 19:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="2VEtU/jj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13523984C
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 19:09:38 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0502119
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 11:09:37 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-66d093265dfso429096d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Nov 2023 11:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699470577; x=1700075377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2b6stU5Dn37TYle1ZNPCWeZzeNevf1ImD39GCencX20=;
        b=2VEtU/jjhYdiF1l+A0m9pLu9rkn3bdRgLG5djSU50YtNonEatS3smZALg/+cQSBV20
         Bx0TkwJsc26aKfpyv+myO/CF+z0zKq8o/AglbMK2UEofHjwVN/SxJkrxPjXt/FoGRvjy
         j0MmxIfAx80izRGIWqi68XaXt8WmZG4E/Nu4u9P+w12ks7jww0/PXNVQcVnvf2588stR
         iI9Ch1Fb1JhCsa+OgN2zSgRKfdaIWKlmMuRQ2T20r8AR/xzqy82ZLq3utq9bzijHaD1e
         Wm27RX2bqVybAlOG1y4FRs/9Edee8K8kHSKkTfTNW6o1L/k+K5JP0gRH/ZwFDKJb4Svn
         c8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470577; x=1700075377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2b6stU5Dn37TYle1ZNPCWeZzeNevf1ImD39GCencX20=;
        b=con/eM4IQAFaHLezrp+P5fmkEOuR42wIhgQUzBJ2ap5Anf9rexSGhx6eWpioR66y0R
         4oPuPvB3DMLtc7Ecy+AXWSXyWpk9u5pU195QWNvnDOQl6B48wOWcOqEcBnXkdNCKeU+P
         1+itTACx0WMN88xt2t0I5X2pwYGXka2L7r4McKggb88AZdWVqOZ/0rUK3wwT3k9gGm0K
         uY807d4okT5iyyewPd4KkuQPIvg/zyWBl//7i5oyeKCOCywmMJPB+rG/T2Bg87kWaS0K
         A04WWEDS+wzboFwmMRISlBjyADWbGOjYghNagpHWT88VVVy/B1Y19GdsTQbXlGbbPH8E
         UU7g==
X-Gm-Message-State: AOJu0Yx+99z7R6fXro6abW1TbCHP4C4gOtAGdcmNyiz+QZd07Sc1F/zg
	A3OK8xJJZWF2D5PN4dDtEAZNhd5G/Hz7cb7omk5vmw==
X-Google-Smtp-Source: AGHT+IHu2mCN647pwQ4DXOeAd0GM+Qw5uEDGAtHj6Gbxow4drHl9/RM9vFEIYmCnZV/cbZK2XyOb4g==
X-Received: by 2002:a05:6214:2401:b0:66d:2064:c7ee with SMTP id fv1-20020a056214240100b0066d2064c7eemr3294396qvb.20.1699470577088;
        Wed, 08 Nov 2023 11:09:37 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m13-20020ad44b6d000000b0064f53943626sm1363094qvx.89.2023.11.08.11.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:09:36 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH v2 17/18] btrfs: move one shot mount option clearing to super.c
Date: Wed,  8 Nov 2023 14:08:52 -0500
Message-ID: <922162872adc0c434bdfade4dbb2b560b09c5a98.1699470345.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699470345.git.josef@toxicpanda.com>
References: <cover.1699470345.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no reason this has to happen in open_ctree, and in fact in the
old mount API we had to call this from remount.  Move this to super.c,
unexport it, and call it from both mount and reconfigure.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 16 +---------------
 fs/btrfs/disk-io.h |  1 -
 fs/btrfs/super.c   | 15 +++++++++++++++
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 50ed7ece0840..8f04d2d5f530 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2929,18 +2929,6 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 	return err;
 }
 
-/*
- * Some options only have meaning at mount time and shouldn't persist across
- * remounts, or be displayed. Clear these at the end of mount and remount
- * code paths.
- */
-void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info)
-{
-	btrfs_clear_opt(fs_info->mount_opt, USEBACKUPROOT);
-	btrfs_clear_opt(fs_info->mount_opt, CLEAR_CACHE);
-	btrfs_clear_opt(fs_info->mount_opt, NOSPACECACHE);
-}
-
 /*
  * Mounting logic specific to read-write file systems. Shared by open_ctree
  * and btrfs_remount when remounting from read-only to read-write.
@@ -3508,7 +3496,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	}
 
 	if (sb_rdonly(sb))
-		goto clear_oneshot;
+		return 0;
 
 	ret = btrfs_start_pre_rw_mount(fs_info);
 	if (ret) {
@@ -3536,8 +3524,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (test_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags))
 		wake_up_process(fs_info->cleaner_kthread);
 
-clear_oneshot:
-	btrfs_clear_oneshot_options(fs_info);
 	return 0;
 
 fail_qgroup:
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index e589359e6a68..9413726b329b 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -37,7 +37,6 @@ struct extent_buffer *btrfs_find_create_tree_block(
 						struct btrfs_fs_info *fs_info,
 						u64 bytenr, u64 owner_root,
 						int level);
-void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info);
 int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info);
 int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 			   const struct btrfs_super_block *disk_sb);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d99da8107677..f45de65c3c0b 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -640,6 +640,19 @@ static int btrfs_parse_param(struct fs_context *fc,
 	return 0;
 }
 
+/*
+ * Some options only have meaning at mount time and shouldn't persist across
+ * remounts, or be displayed. Clear these at the end of mount and remount
+ * code paths.
+ */
+static void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info)
+{
+	btrfs_clear_opt(fs_info->mount_opt, USEBACKUPROOT);
+	btrfs_clear_opt(fs_info->mount_opt, CLEAR_CACHE);
+	btrfs_clear_opt(fs_info->mount_opt, NOSPACECACHE);
+}
+
+
 static bool check_ro_option(struct btrfs_fs_info *fs_info,
 			    unsigned long mount_opt, unsigned long opt,
 			    const char *opt_name)
@@ -1902,6 +1915,8 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		return ret;
 	}
 
+	btrfs_clear_oneshot_options(fs_info);
+
 	fc->root = dget(s->s_root);
 	return 0;
 
-- 
2.41.0


