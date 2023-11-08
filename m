Return-Path: <linux-fsdevel+bounces-2426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594C97E5E4F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 20:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A90B7B211E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 19:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C54138FA2;
	Wed,  8 Nov 2023 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="UWDlZNoG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D992138DEE
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 19:09:32 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F382115
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 11:09:32 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b2b1af09c5so28922b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Nov 2023 11:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699470571; x=1700075371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u077NpaoSpIkuKKJ4fWP/spLQzbnOhK4NUit92ElAMg=;
        b=UWDlZNoGfCldyL8CCJVpkR79zDv48m/GUgKh4EXtQBdgr6I7pDI8Oe2qoM2charNoH
         An56uYEHdpPm2Zw5ar+f8DOPXVhQqzxPmnWvdGt/HGTTKUq8PTag4BUWUEyVbdGI6dEe
         IeT6gFJKlMTaW1k7OhGKLoenzwG3aXeF+1RhSc6+Ldh3nYpKqUMn8k2hvCKXQgblbSnf
         /WSvBAydbzDVufEde381Ky8gOJbVvZIcBf+6xBoaGI7ui4B7oWu9xZYrl6xRxBUCVydi
         AJRt2S8vOqvuPQI1OSNsDelXo+pxK1MiyGq0rsfulSjHl6Hl6WfQ9QJa0Zhukcq586y4
         Nkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470571; x=1700075371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u077NpaoSpIkuKKJ4fWP/spLQzbnOhK4NUit92ElAMg=;
        b=SMAP4xC/q4xF3+ouPGIqZ7rZq91UIPQ+C/llcKKeUsZkpu3F7jsHZq6lNREVVBEohY
         JnmMmm54XnKcR/tZe1z8oo94on/XNJJ+meGi8QwMcVbyONsJns9cfsPh2onJ/9EO57hi
         JBMZHMghSnAuE303sxCd7u9kM6aHuIWu2Au0x1ahFKUzKP4X0Z0HzoMkPLkqwVWoZznt
         knvq1l/ACC/5rx4msNMvYJInF/YvCTjbhhs5LJ3X0FDQjSguDBhykDbDf3B01oIng+sv
         JYP+nWzqZFk2wj6C4Su+I4kQdryoMgd7eFzuZ6eSoxG67EiN7kB4N7+selfq5sJ98zpq
         6Avg==
X-Gm-Message-State: AOJu0Yz8p4sMvHKH50N3Sj682T45EEVtZiNbKeMyssopxF0RdAqz9tvA
	uTIlwYJKbiYje32ZzanVFzawmA==
X-Google-Smtp-Source: AGHT+IFfFazP6h8qDsiKwTWZobPWRIuJz/CZ4ibPyfDYQjRVwVbMpKXWsbWiDffKI6CuZ9b1QacqSg==
X-Received: by 2002:a05:6808:158f:b0:3ae:5372:3790 with SMTP id t15-20020a056808158f00b003ae53723790mr3640129oiw.48.1699470571610;
        Wed, 08 Nov 2023 11:09:31 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id k23-20020a05620a143700b00774133fb9a3sm1338205qkj.114.2023.11.08.11.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:09:31 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH v2 13/18] btrfs: handle the ro->rw transition for mounting different subovls
Date: Wed,  8 Nov 2023 14:08:48 -0500
Message-ID: <7cecb77e26d58981202d0809df8ffc4d2f37bcb4.1699470345.git.josef@toxicpanda.com>
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

This is an oddity that we've carried around since 0723a0473fb4 ("btrfs:
allow mounting btrfs subvolumes with different ro/rw options") where
we'll under the covers flip the file system to RW if you're mixing and
matching ro/rw options with different subvol mounts.  The first mount is
what the super gets setup as, so we'd handle this by remount the super
as rw under the covers to facilitate this behavior.

With the new mount API we can't really allow this, because user space
has the ability to specify the super block settings, and the mount
settings.  So if the user explicitly set the super block as read only,
and then tried to mount a rw mount with the super block we'll reject
this.  However the old API was less descriptive and thus we allowed this
kind of behavior.

This patch preserves this behavior for the old api calls.  This is
inspired by Christians work, and includes one of his comments, and thus
is included in the link below.

Link: https://lore.kernel.org/all/20230626-fs-btrfs-mount-api-v1-2-045e9735a00b@kernel.org/
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4ace42e08bff..7a49a61fc50a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2513,13 +2513,15 @@ static int btrfs_reconfigure(struct fs_context *fc)
 	struct btrfs_fs_context *ctx = fc->fs_private;
 	struct btrfs_fs_context old_ctx;
 	int ret = 0;
+	bool mount_reconfigure = (fc->s_fs_info != NULL);
 
 	btrfs_info_to_ctx(fs_info, &old_ctx);
 
 	sync_filesystem(sb);
 	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
 
-	if (!check_options(fs_info, &ctx->mount_opt, fc->sb_flags))
+	if (!mount_reconfigure &&
+	    !check_options(fs_info, &ctx->mount_opt, fc->sb_flags))
 		return -EINVAL;
 
 	ret = btrfs_check_features(fs_info, !(fc->sb_flags & SB_RDONLY));
@@ -2922,6 +2924,133 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	return ret;
 }
 
+/*
+ * Christian wrote this long comment about what we're doing here, preserving it
+ * so the history of this change is preserved.
+ *
+ * Ever since commit 0723a0473fb4 ("btrfs: allow * mounting btrfs subvolumes
+ * with different ro/rw * options") the following works:
+ *
+ *        (i) mount /dev/sda3 -o subvol=foo,ro /mnt/foo
+ *       (ii) mount /dev/sda3 -o subvol=bar,rw /mnt/bar
+ *
+ * which looks nice and innocent but is actually pretty * intricate and
+ * deserves a long comment.
+ *
+ * On another filesystem a subvolume mount is close to * something like:
+ *
+ *	(iii) # create rw superblock + initial mount
+ *	      mount -t xfs /dev/sdb /opt/
+ *
+ *	      # create ro bind mount
+ *	      mount --bind -o ro /opt/foo /mnt/foo
+ *
+ *	      # unmount initial mount
+ *	      umount /opt
+ *
+ * Of course, there's some special subvolume sauce and there's the fact that the
+ * sb->s_root dentry is really swapped after mount_subtree(). But conceptually
+ * it's very close and will help us understand the issue.
+ *
+ * The old mount api didn't cleanly distinguish between a mount being made ro
+ * and a superblock being made ro.  The only way to change the ro state of
+ * either object was by passing ms_rdonly. If a new mount was created via
+ * mount(2) such as:
+ *
+ *      mount("/dev/sdb", "/mnt", "xfs", ms_rdonly, null);
+ *
+ * the MS_RDONLY flag being specified had two effects:
+ *
+ * (1) MNT_READONLY was raised -> the resulting mount got
+ *     @mnt->mnt_flags |= MNT_READONLY raised.
+ *
+ * (2) MS_RDONLY was passed to the filesystem's mount method and the filesystems
+ *     made the superblock ro. Note, how SB_RDONLY has the same value as
+ *     ms_rdonly and is raised whenever MS_RDONLY is passed through mount(2).
+ *
+ * Creating a subtree mount via (iii) ends up leaving a rw superblock with a
+ * subtree mounted ro.
+ *
+ * But consider the effect on the old mount api on btrfs subvolume mounting
+ * which combines the distinct step in (iii) into a a single step.
+ *
+ * By issuing (i) both the mount and the superblock are turned ro. Now when (ii)
+ * is issued the superblock is ro and thus even if the mount created for (ii) is
+ * rw it wouldn't help. Hence, btrfs needed to transition the superblock from ro
+ * to rw for (ii) which it did using an internal remount call (a bold
+ * choice...).
+ *
+ * IOW, subvolume mounting was inherently messy due to the ambiguity of
+ * MS_RDONLY in mount(2). Note, this ambiguity has mount(8) always translate
+ * "ro" to MS_RDONLY. IOW, in both (i) and (ii) "ro" becomes MS_RDONLY when
+ * passed by mount(8) to mount(2).
+ *
+ * Enter the new mount api. the new mount api disambiguates making a mount ro
+ * and making a superblock ro.
+ *
+ * (3) To turn a mount ro the MOUNT_ATTR_ONLY flag can be used with either
+ *     fsmount() or mount_setattr() this is a pure vfs level change for a
+ *     specific mount or mount tree that is never seen by the filesystem itself.
+ *
+ * (4) To turn a superblock ro the "ro" flag must be used with
+ *     fsconfig(FSCONFIG_SET_FLAG, "ro"). This option is seen by the filesytem
+ *     in fc->sb_flags.
+ *
+ * This disambiguation has rather positive consequences.  Mounting a subvolume
+ * ro will not also turn the superblock ro. Only the mount for the subvolume
+ * will become ro.
+ *
+ * So, if the superblock creation request comes from the new mount api the
+ * caller must've explicitly done:
+ *
+ *      fsconfig(FSCONFIG_SET_FLAG, "ro")
+ *      fsmount/mount_setattr(MOUNT_ATTR_RDONLY)
+ *
+ * IOW, at some point the caller must have explicitly turned the whole
+ * superblock ro and we shouldn't just undo it like we did for the old mount
+ * api. In any case, it lets us avoid this nasty hack in the new mount api.
+ *
+ * Consequently, the remounting hack must only be used for requests originating
+ * from the old mount api and should be marked for full deprecation so it can be
+ * turned off in a couple of years.
+ *
+ * The new mount api has no reason to support this hack.
+ */
+static struct vfsmount *btrfs_reconfigure_for_mount(struct fs_context *fc)
+{
+	struct vfsmount *mnt;
+	int ret;
+	bool ro2rw = !(fc->sb_flags & SB_RDONLY);
+
+	/*
+	 * We got an EBUSY because our SB_RDONLY flag didn't match the existing
+	 * super block, so invert our setting here and re-try the mount so we
+	 * can get our vfsmount.
+	 */
+	if (ro2rw)
+		fc->sb_flags |= SB_RDONLY;
+	else
+		fc->sb_flags &= ~SB_RDONLY;
+
+	mnt = fc_mount(fc);
+	if (IS_ERR(mnt))
+		return mnt;
+
+	if (!fc->oldapi || !ro2rw)
+		return mnt;
+
+	/* We need to convert to rw, call reconfigure */
+	fc->sb_flags &= ~SB_RDONLY;
+	down_write(&mnt->mnt_sb->s_umount);
+	ret = btrfs_reconfigure(fc);
+	up_write(&mnt->mnt_sb->s_umount);
+	if (ret) {
+		mntput(mnt);
+		return ERR_PTR(ret);
+	}
+	return mnt;
+}
+
 static int btrfs_get_tree_subvol(struct fs_context *fc)
 {
 	struct btrfs_fs_info *fs_info = NULL;
@@ -2971,6 +3100,8 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
 	fc->security = NULL;
 
 	mnt = fc_mount(dup_fc);
+	if (PTR_ERR_OR_ZERO(mnt) == -EBUSY)
+		mnt = btrfs_reconfigure_for_mount(dup_fc);
 	put_fs_context(dup_fc);
 	if (IS_ERR(mnt))
 		return PTR_ERR(mnt);
-- 
2.41.0


