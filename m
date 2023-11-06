Return-Path: <linux-fsdevel+bounces-2171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0351F7E2F82
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 23:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C781B20BE1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 22:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB412FE0E;
	Mon,  6 Nov 2023 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="MW+Mb155"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0672EB1E
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 22:08:45 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBAD183
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:08:43 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77891f362cfso410092585a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 14:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308522; x=1699913322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYeMWvEhu1+Bmp78UF8eSUChUBLQrH7aUCmO3SKML2c=;
        b=MW+Mb155zOw+0cfixLVspOpoaLIb4UbRBHkPs+0z5hRPKlkqe2efirqaYvt5lFNGs+
         vHj2+XM//Gzy9CvXSGH7l2W5X9PDNojWn6LB4LauJVRWsaUXLVJEqwrwLr+kUAa1MN3t
         +U0czTlKqwK1GSULRt4a+a1R1XjgY5H3auZZZQusIGToATaY9tnGnL+aIBJWlkB1XmxQ
         4pn0YDmzvtEFWkJMr+KCMjDogJSZURP9NvubIdHCw/eDxzYM6NaU7u6nLdGDQJnkp4qA
         jamd+lePZ3/5Yg//8fQopQd/sjAJ6hHItnXtqJlpLRWbCu7IrsNOcIz28bgVITppL5QE
         i4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308522; x=1699913322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYeMWvEhu1+Bmp78UF8eSUChUBLQrH7aUCmO3SKML2c=;
        b=BQnIRFV/tmmYyXAtDI2qOEq6EFJ7jcpXFV4TOTh0LLTsxi6Te5AgIHld03rYiWdmoX
         GMj8Wp/tkGKpufDyZn7K5OJivZbdtbNUipp1yMtSp2CEF+Epq+He5zaMcH1L/b5pzWv2
         dN23mIj/5yK0WEyjSXt7lYL16qre7wRZHPzoSZkjclJp7GpZbBNMfwrtRyHgBdzuT4TX
         8WGOAQtL4Z4s1W6BfzoizXCHwBFdzbCCEsE7kwOtl+WII0EsyNrLK9QlAyoR/dtgl80v
         M1TfIJB0J9lNHsK8oaF7IwcOhQDs+dGYit/kjoWcMWBTrd77jC3zEFnlRFw9rpx2mNfc
         GCMQ==
X-Gm-Message-State: AOJu0YySI6hsSBp1NXmvX10+vZeYxuoL4aDMRZZgBZ4D2ITDiq5X/u5b
	zPQtev+M/Emmkcw48XQYSAl2Vg==
X-Google-Smtp-Source: AGHT+IGgX0TZ/9pOIeWUrKZ9XwtYnPoo5FhIp7tFj2JSSmR6IMbGf4K1sZ1sW1noBTkEpzBa0Vk3Sw==
X-Received: by 2002:a05:620a:bd6:b0:76f:5b9:3f29 with SMTP id s22-20020a05620a0bd600b0076f05b93f29mr1397960qki.2.1699308522116;
        Mon, 06 Nov 2023 14:08:42 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g11-20020ae9e10b000000b0077a7d02cffbsm2365510qkm.24.2023.11.06.14.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:41 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH 06/18] btrfs: split out ro->rw and rw->ro helpers into their own functions
Date: Mon,  6 Nov 2023 17:08:14 -0500
Message-ID: <bb944da42fc7d01832f72495ec07f9a82a133376.1699308010.git.josef@toxicpanda.com>
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

When we remount ro->rw or rw->ro we have some cleanup tasks that have to
be managed.  Split these out into their own function to make
btrfs_remount smaller.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 233 ++++++++++++++++++++++++-----------------------
 1 file changed, 120 insertions(+), 113 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index aef7e67538a3..d7070269e3ea 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1659,6 +1659,119 @@ static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
 		btrfs_set_free_space_cache_v1_active(fs_info, cache_opt);
 }
 
+static int btrfs_remount_rw(struct btrfs_fs_info *fs_info)
+{
+	int ret;
+
+	if (BTRFS_FS_ERROR(fs_info)) {
+		btrfs_err(fs_info,
+			  "Remounting read-write after error is not allowed");
+		return -EINVAL;
+	}
+
+	if (fs_info->fs_devices->rw_devices == 0)
+		return -EACCES;
+
+	if (!btrfs_check_rw_degradable(fs_info, NULL)) {
+		btrfs_warn(fs_info,
+			   "too many missing devices, writable remount is not allowed");
+		return -EACCES;
+	}
+
+	if (btrfs_super_log_root(fs_info->super_copy) != 0) {
+		btrfs_warn(fs_info,
+			   "mount required to replay tree-log, cannot remount read-write");
+		return -EINVAL;
+	}
+
+	/*
+	 * NOTE: when remounting with a change that does writes, don't put it
+	 * anywhere above this point, as we are not sure to be safe to write
+	 * until we pass the above checks.
+	 */
+	ret = btrfs_start_pre_rw_mount(fs_info);
+	if (ret)
+		return ret;
+
+	btrfs_clear_sb_rdonly(fs_info->sb);
+
+	set_bit(BTRFS_FS_OPEN, &fs_info->flags);
+
+	/*
+	 * If we've gone from readonly -> read/write, we need to get our
+	 * sync/async discard lists in the right state.
+	 */
+	btrfs_discard_resume(fs_info);
+
+	return 0;
+}
+
+static int btrfs_remount_ro(struct btrfs_fs_info *fs_info)
+{
+	/*
+	 * this also happens on 'umount -rf' or on shutdown, when
+	 * the filesystem is busy.
+	 */
+	cancel_work_sync(&fs_info->async_reclaim_work);
+	cancel_work_sync(&fs_info->async_data_reclaim_work);
+
+	btrfs_discard_cleanup(fs_info);
+
+	/* wait for the uuid_scan task to finish */
+	down(&fs_info->uuid_tree_rescan_sem);
+	/* avoid complains from lockdep et al. */
+	up(&fs_info->uuid_tree_rescan_sem);
+
+	btrfs_set_sb_rdonly(fs_info->sb);
+
+	/*
+	 * Setting SB_RDONLY will put the cleaner thread to
+	 * sleep at the next loop if it's already active.
+	 * If it's already asleep, we'll leave unused block
+	 * groups on disk until we're mounted read-write again
+	 * unless we clean them up here.
+	 */
+	btrfs_delete_unused_bgs(fs_info);
+
+	/*
+	 * The cleaner task could be already running before we set the
+	 * flag BTRFS_FS_STATE_RO (and SB_RDONLY in the superblock).
+	 * We must make sure that after we finish the remount, i.e. after
+	 * we call btrfs_commit_super(), the cleaner can no longer start
+	 * a transaction - either because it was dropping a dead root,
+	 * running delayed iputs or deleting an unused block group (the
+	 * cleaner picked a block group from the list of unused block
+	 * groups before we were able to in the previous call to
+	 * btrfs_delete_unused_bgs()).
+	 */
+	wait_on_bit(&fs_info->flags, BTRFS_FS_CLEANER_RUNNING,
+		    TASK_UNINTERRUPTIBLE);
+
+	/*
+	 * We've set the superblock to RO mode, so we might have made
+	 * the cleaner task sleep without running all pending delayed
+	 * iputs. Go through all the delayed iputs here, so that if an
+	 * unmount happens without remounting RW we don't end up at
+	 * finishing close_ctree() with a non-empty list of delayed
+	 * iputs.
+	 */
+	btrfs_run_delayed_iputs(fs_info);
+
+	btrfs_dev_replace_suspend_for_unmount(fs_info);
+	btrfs_scrub_cancel(fs_info);
+	btrfs_pause_balance(fs_info);
+
+	/*
+	 * Pause the qgroup rescan worker if it is running. We don't want
+	 * it to be still running after we are in RO mode, as after that,
+	 * by the time we unmount, it might have left a transaction open,
+	 * so we would leak the transaction and/or crash.
+	 */
+	btrfs_qgroup_wait_for_completion(fs_info, false);
+
+	return btrfs_commit_super(fs_info);
+}
+
 static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
@@ -1712,120 +1825,14 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		}
 	}
 
-	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
-		goto out;
+	ret = 0;
+	if (!sb_rdonly(sb) && (*flags & SB_RDONLY))
+		ret = btrfs_remount_ro(fs_info);
+	else if (sb_rdonly(sb) && !(*flags & SB_RDONLY))
+		ret = btrfs_remount_rw(fs_info);
+	if (ret)
+		goto restore;
 
-	if (*flags & SB_RDONLY) {
-		/*
-		 * this also happens on 'umount -rf' or on shutdown, when
-		 * the filesystem is busy.
-		 */
-		cancel_work_sync(&fs_info->async_reclaim_work);
-		cancel_work_sync(&fs_info->async_data_reclaim_work);
-
-		btrfs_discard_cleanup(fs_info);
-
-		/* wait for the uuid_scan task to finish */
-		down(&fs_info->uuid_tree_rescan_sem);
-		/* avoid complains from lockdep et al. */
-		up(&fs_info->uuid_tree_rescan_sem);
-
-		btrfs_set_sb_rdonly(sb);
-
-		/*
-		 * Setting SB_RDONLY will put the cleaner thread to
-		 * sleep at the next loop if it's already active.
-		 * If it's already asleep, we'll leave unused block
-		 * groups on disk until we're mounted read-write again
-		 * unless we clean them up here.
-		 */
-		btrfs_delete_unused_bgs(fs_info);
-
-		/*
-		 * The cleaner task could be already running before we set the
-		 * flag BTRFS_FS_STATE_RO (and SB_RDONLY in the superblock).
-		 * We must make sure that after we finish the remount, i.e. after
-		 * we call btrfs_commit_super(), the cleaner can no longer start
-		 * a transaction - either because it was dropping a dead root,
-		 * running delayed iputs or deleting an unused block group (the
-		 * cleaner picked a block group from the list of unused block
-		 * groups before we were able to in the previous call to
-		 * btrfs_delete_unused_bgs()).
-		 */
-		wait_on_bit(&fs_info->flags, BTRFS_FS_CLEANER_RUNNING,
-			    TASK_UNINTERRUPTIBLE);
-
-		/*
-		 * We've set the superblock to RO mode, so we might have made
-		 * the cleaner task sleep without running all pending delayed
-		 * iputs. Go through all the delayed iputs here, so that if an
-		 * unmount happens without remounting RW we don't end up at
-		 * finishing close_ctree() with a non-empty list of delayed
-		 * iputs.
-		 */
-		btrfs_run_delayed_iputs(fs_info);
-
-		btrfs_dev_replace_suspend_for_unmount(fs_info);
-		btrfs_scrub_cancel(fs_info);
-		btrfs_pause_balance(fs_info);
-
-		/*
-		 * Pause the qgroup rescan worker if it is running. We don't want
-		 * it to be still running after we are in RO mode, as after that,
-		 * by the time we unmount, it might have left a transaction open,
-		 * so we would leak the transaction and/or crash.
-		 */
-		btrfs_qgroup_wait_for_completion(fs_info, false);
-
-		ret = btrfs_commit_super(fs_info);
-		if (ret)
-			goto restore;
-	} else {
-		if (BTRFS_FS_ERROR(fs_info)) {
-			btrfs_err(fs_info,
-				"Remounting read-write after error is not allowed");
-			ret = -EINVAL;
-			goto restore;
-		}
-		if (fs_info->fs_devices->rw_devices == 0) {
-			ret = -EACCES;
-			goto restore;
-		}
-
-		if (!btrfs_check_rw_degradable(fs_info, NULL)) {
-			btrfs_warn(fs_info,
-		"too many missing devices, writable remount is not allowed");
-			ret = -EACCES;
-			goto restore;
-		}
-
-		if (btrfs_super_log_root(fs_info->super_copy) != 0) {
-			btrfs_warn(fs_info,
-		"mount required to replay tree-log, cannot remount read-write");
-			ret = -EINVAL;
-			goto restore;
-		}
-
-		/*
-		 * NOTE: when remounting with a change that does writes, don't
-		 * put it anywhere above this point, as we are not sure to be
-		 * safe to write until we pass the above checks.
-		 */
-		ret = btrfs_start_pre_rw_mount(fs_info);
-		if (ret)
-			goto restore;
-
-		btrfs_clear_sb_rdonly(sb);
-
-		set_bit(BTRFS_FS_OPEN, &fs_info->flags);
-
-		/*
-		 * If we've gone from readonly -> read/write, we need to get
-		 * our sync/async discard lists in the right state.
-		 */
-		btrfs_discard_resume(fs_info);
-	}
-out:
 	/*
 	 * We need to set SB_I_VERSION here otherwise it'll get cleared by VFS,
 	 * since the absence of the flag means it can be toggled off by remount.
-- 
2.41.0


