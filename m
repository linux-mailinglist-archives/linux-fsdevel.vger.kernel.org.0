Return-Path: <linux-fsdevel+bounces-2179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7A17E2F90
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 23:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80A6280F16
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 22:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6453030CE8;
	Mon,  6 Nov 2023 22:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="CRGWLn5M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8212FE33
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 22:08:54 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52C6D77
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:08:52 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-778927f2dd3so258866585a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 14:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308532; x=1699913332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=reEakIOm3rrykETmz3iMDC9rTy9UEkj05xNfQfA4/Qo=;
        b=CRGWLn5MbEeaHXzo4e+YS0XQhWRmuGRtuzzxc/at5RwjNSz8aEvYN7RpjxZ6MBL6k8
         4K/pbPTxNrJ++Tz7NgN9VCtxNzH3v3JflbikWSNi4oy7aa5hSNhx0fTzcSyKbUdARZhT
         0cQ9Sb4H/ohGIpFDomFEWhvGgWw4o1d7bS3lpzUlHV7geXTJny0AzwaDAzZuYwO17mlt
         dWd47aVTEHuxobJa5c3QfuNGjuSTBOxLl92bL10ZykQmHk8Rg3niQyPGwmYcc5EJS6+u
         b7H+4ScNGTWnQwsXTIVsOVv5I3oYfXc9tvpqG2mJ+ASWoLaxAnPl1E10TmokUdf3DBNi
         dUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308532; x=1699913332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reEakIOm3rrykETmz3iMDC9rTy9UEkj05xNfQfA4/Qo=;
        b=ZMHx1vvm6di4mmAcw+Ase/BugENAPx3stZ62yiaWToi96T9+gmlymq7yh7VGvNSTnj
         +EHKFL3G8BH7kZpGnuPny62pH0UHm6Fulqd4pSgkxYOQzSoQosAo1DIzbyH6UEeFAKKf
         Xm77ciPt4ixVXf8fP144Bw4jpdEQmIk56USCrpotsN0cGLsFoZKXfG9lq2Ftosfq8K+V
         +YD80Sm/4T1+Cv4fnun8rJ8sL/Hnmcai18YwLt6f6INGJlZ/agmiBM2/SQQy+Lm9ccUx
         +mUET1l6Fg8qwOcfX0cGXKI9kdZ9dnCvMV6273LV9kGneRsLEgVt8uZ4KDX8lZIpR4Vp
         65Ng==
X-Gm-Message-State: AOJu0YxCuHMbPDZhLFHJfM0htIpEQeo7qTuX/B2g1R20pu3vNFeUKHIj
	/yL+CwwdZqqIWnLSOwhXsqd64A==
X-Google-Smtp-Source: AGHT+IFYfPGuFoc9TZeLp+hR3yvZR4SS9i76z2acWjsVd3QfptcaKByxxEZPVsJmqAjdUV1XgESIsg==
X-Received: by 2002:a05:620a:44d2:b0:775:9c22:e901 with SMTP id y18-20020a05620a44d200b007759c22e901mr31734685qkp.15.1699308531791;
        Mon, 06 Nov 2023 14:08:51 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y13-20020a37e30d000000b007759e9b0eb8sm3660393qki.99.2023.11.06.14.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:51 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH 15/18] btrfs: move the device specific mount options to super.c
Date: Mon,  6 Nov 2023 17:08:23 -0500
Message-ID: <691405bb49db78cc585dab67111835ddde69b2e7.1699308010.git.josef@toxicpanda.com>
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

We add these mount options based on the fs_devices settings, which can
be set once we've opened the fs_devices.  Move these into their own
helper and call it from get_tree_super.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 23 -----------------------
 fs/btrfs/super.c   | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ce861f4baf47..50ed7ece0840 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3483,29 +3483,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_cleaner;
 	}
 
-	if (!btrfs_test_opt(fs_info, NOSSD) &&
-	    !fs_info->fs_devices->rotating) {
-		btrfs_set_and_info(fs_info, SSD, "enabling ssd optimizations");
-	}
-
-	/*
-	 * For devices supporting discard turn on discard=async automatically,
-	 * unless it's already set or disabled. This could be turned off by
-	 * nodiscard for the same mount.
-	 *
-	 * The zoned mode piggy backs on the discard functionality for
-	 * resetting a zone. There is no reason to delay the zone reset as it is
-	 * fast enough. So, do not enable async discard for zoned mode.
-	 */
-	if (!(btrfs_test_opt(fs_info, DISCARD_SYNC) ||
-	      btrfs_test_opt(fs_info, DISCARD_ASYNC) ||
-	      btrfs_test_opt(fs_info, NODISCARD)) &&
-	    fs_info->fs_devices->discardable &&
-	    !btrfs_is_zoned(fs_info)) {
-		btrfs_set_and_info(fs_info, DISCARD_ASYNC,
-				   "auto enabling async discard");
-	}
-
 	ret = btrfs_read_qgroup_config(fs_info);
 	if (ret)
 		goto fail_trans_kthread;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a99af94a7409..e67578dc48de 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -823,6 +823,29 @@ void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
 		btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
 }
 
+static void set_device_specific_options(struct btrfs_fs_info *fs_info)
+{
+	if (!btrfs_test_opt(fs_info, NOSSD) &&
+	    !fs_info->fs_devices->rotating)
+		btrfs_set_opt(fs_info->mount_opt, SSD);
+
+	/*
+	 * For devices supporting discard turn on discard=async automatically,
+	 * unless it's already set or disabled. This could be turned off by
+	 * nodiscard for the same mount.
+	 *
+	 * The zoned mode piggy backs on the discard functionality for
+	 * resetting a zone. There is no reason to delay the zone reset as it is
+	 * fast enough. So, do not enable async discard for zoned mode.
+	 */
+	if (!(btrfs_test_opt(fs_info, DISCARD_SYNC) ||
+	      btrfs_test_opt(fs_info, DISCARD_ASYNC) ||
+	      btrfs_test_opt(fs_info, NODISCARD)) &&
+	    fs_info->fs_devices->discardable &&
+	    !btrfs_is_zoned(fs_info))
+		btrfs_set_opt(fs_info->mount_opt, DISCARD_ASYNC);
+}
+
 static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 {
 	char *opts;
@@ -2913,6 +2936,8 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		goto error;
 	}
 
+	set_device_specific_options(fs_info);
+
 	if (s->s_root) {
 		btrfs_close_devices(fs_devices);
 		if ((fc->sb_flags ^ s->s_flags) & SB_RDONLY)
-- 
2.41.0


