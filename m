Return-Path: <linux-fsdevel+bounces-2166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1807E2F75
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 23:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75FF280DD2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 22:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9D42EB15;
	Mon,  6 Nov 2023 22:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="VuEPCyVm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C500F2EAFF
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 22:08:39 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FDD183
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:08:38 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66cfd874520so31638706d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 14:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308517; x=1699913317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wju2KDo89W0KqnbnN0qwqJupbKYYoKpOCJuF9HTEAq4=;
        b=VuEPCyVmiv47j8fjcgoD/1AfDaLySV+bMl1MCZY7D9nC/Z5dDqABGUw9pWSV0Qlfq5
         co/m7mQ6jpgwyp2TYP5NZg4/2eTdSpcw9UphCLPnt0kSWGBBjk5Utk5yMV2FOfOD8ywY
         DfqKPopxPBlIfTjs/xETE6dP4Iay+ZUlmVdjdLRiYBbEMZ4MydjRkN2cSR2Zd1SJjsE4
         S3f+B/dJNDu8j0SJDhF9OLHJZDb9WFkOA1EQKEXoR89b8Qreamv7vb2BwE4xJFlotRaz
         Z8krqKQm4JroWbmNV9/Xndac6bt1zjIidHkTVcBr98NC4Pq8mlUBKbTQjTF73AtlXM3K
         R7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308517; x=1699913317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wju2KDo89W0KqnbnN0qwqJupbKYYoKpOCJuF9HTEAq4=;
        b=jQsSclB8wDPXYYoA+1okvlWXehMnx2WO0zlELKhM0vRRsKJ3aiga/5ji6jQF6x/+eX
         8RwLIxLoPWmnVKBaPWP61lM4pGjVns9qrb0d2aiLt8qlTOkzRuUaMH6Uc1oBuc12nRXj
         D3OjH8A4HaoPQF2BV6L25NN6EzSH5Z5T+yq+8fUAjtiAjfoJLQAknzwru2nCxzP9y6Az
         wKavdTNoElohVMMfUl1apQDLdtqIP5B2VOlVv1F/0Z3QCUvYEMd9ZXvlgyzzAs19EEGv
         tRtBLxsN+z1p4rBHArtlALDM22n923Oh7LypqyFc6RCbShIQQpKEti8VuZYWp5Ujdx+9
         mqNA==
X-Gm-Message-State: AOJu0YxHSTm99n6wS2thBoVJ9lHUAovVOH4syvJTav++fqWqSA0WoTo0
	f6ayTLgN1tyOEa6ahfcJ4e5BbmIy81oUx/e/8OjwHA==
X-Google-Smtp-Source: AGHT+IHTYcyj/yGwLeP8RSSKs+dngQ5QGF5T5Msr4rMOHiK6M/weyhgIwMWFNBolNUanVCRgzi5vpQ==
X-Received: by 2002:ad4:4ea7:0:b0:66d:1215:6e3 with SMTP id ed7-20020ad44ea7000000b0066d121506e3mr36732241qvb.10.1699308517534;
        Mon, 06 Nov 2023 14:08:37 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id l8-20020a0ce848000000b0065d89f4d537sm3789905qvo.45.2023.11.06.14.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:37 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH 02/18] btrfs: split out the mount option validation code into its own helper
Date: Mon,  6 Nov 2023 17:08:10 -0500
Message-ID: <83e9157999dd0bc41ef1c267a6d6c0a83b36340d.1699308010.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699308010.git.josef@toxicpanda.com>
References: <cover.1699308010.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're going to need to validate mount options after they're all parsed
with the new mount api, split this code out into its own helper so we
can use it when we swap over to the new mount api.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 64 ++++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6ecf78d09694..639601d346d0 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -233,6 +233,39 @@ static bool check_ro_option(struct btrfs_fs_info *fs_info, unsigned long opt,
 	return false;
 }
 
+static bool check_options(struct btrfs_fs_info *info, unsigned long flags)
+{
+	if (!(flags & SB_RDONLY) &&
+	    (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
+	     check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots") ||
+	     check_ro_option(info, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums")))
+		return false;
+
+	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
+	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
+	    !btrfs_test_opt(info, CLEAR_CACHE)) {
+		btrfs_err(info, "cannot disable free space tree");
+		return false;
+	}
+	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
+	     !btrfs_test_opt(info, FREE_SPACE_TREE)) {
+		btrfs_err(info, "cannot disable free space tree with block-group-tree feature");
+		return false;
+	}
+
+	if (btrfs_check_mountopts_zoned(info))
+		return false;
+
+	if (!test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state)) {
+		if (btrfs_test_opt(info, SPACE_CACHE))
+			btrfs_info(info, "disk space caching is enabled");
+		if (btrfs_test_opt(info, FREE_SPACE_TREE))
+			btrfs_info(info, "using free space tree");
+	}
+
+	return true;
+}
+
 static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 {
 	char *opts;
@@ -311,7 +344,6 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	int saved_compress_level;
 	bool saved_compress_force;
 	int no_compress = 0;
-	const bool remounting = test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state);
 
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
 		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
@@ -330,7 +362,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	 * against new flags
 	 */
 	if (!options)
-		goto check;
+		goto out;
 
 	while ((p = strsep(&options, ",")) != NULL) {
 		int token;
@@ -774,35 +806,9 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			break;
 		}
 	}
-check:
-	/* We're read-only, don't have to check. */
-	if (new_flags & SB_RDONLY)
-		goto out;
-
-	if (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
-	    check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots") ||
-	    check_ro_option(info, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums"))
-		ret = -EINVAL;
 out:
-	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
-	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
-	    !btrfs_test_opt(info, CLEAR_CACHE)) {
-		btrfs_err(info, "cannot disable free space tree");
+	if (!ret && !check_options(info, new_flags))
 		ret = -EINVAL;
-	}
-	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
-	     !btrfs_test_opt(info, FREE_SPACE_TREE)) {
-		btrfs_err(info, "cannot disable free space tree with block-group-tree feature");
-		ret = -EINVAL;
-	}
-	if (!ret)
-		ret = btrfs_check_mountopts_zoned(info);
-	if (!ret && !remounting) {
-		if (btrfs_test_opt(info, SPACE_CACHE))
-			btrfs_info(info, "disk space caching is enabled");
-		if (btrfs_test_opt(info, FREE_SPACE_TREE))
-			btrfs_info(info, "using free space tree");
-	}
 	return ret;
 }
 
-- 
2.41.0


