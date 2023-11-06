Return-Path: <linux-fsdevel+bounces-2177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2A07E2F8F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 23:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F3F1B20E84
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 22:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EACD2FE3A;
	Mon,  6 Nov 2023 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="IyTh9e7H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5111D2FE15
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 22:08:52 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67B41BC
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:08:50 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7789a4c01ddso330455085a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 14:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308530; x=1699913330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8j2QVOSc+1ODIU13iTqNOKn0/FDevbwNBM/VRc23N+w=;
        b=IyTh9e7HrIwWNcZZ97pFellsHOtyW+2/ZwPvhT5LIaVH83NtTGEQVrX8DHvKeWX9+a
         gSyGhU2CVgyJIhDHt5fkfD1Bew46IflxmoJr/2j8c4ZQz2An4y54pBOyzhWa3QrjB6rm
         FIM95hCG4WgXNMcPArv0I3C63CcNXE4NwIul6BPl6vr2bOkevmwFCe1XWMcBFN39IqJS
         sOhPbLt8+/ajDfu5OoK4rAAzPUyWSR6lv6AHH6o+8vHSe6ExO9du7Ka1Cn2kpOhQLJap
         NPWwpsQeqP97869pjtlGhUibgw8CXCFCrREqYZr894phwZXoCeb6Meo4Ze4DoWJTNtdT
         4CPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308530; x=1699913330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8j2QVOSc+1ODIU13iTqNOKn0/FDevbwNBM/VRc23N+w=;
        b=shLNgVO52tzx8AfrgJdX+pOgi5BkgmiUaNT7xysIjZpIUNiBXX6iUs1RRo8a0icQ8F
         ymtcOX6PadilHMnz/1Z6PZj6rXPai48vwgLG7HI153VgZdfPA1eViQuU6ueocMq0hhKg
         RAROsGbAEtqUg5KoK+VNiJneUdU7x5lneUsYg/p5ydDS9eDqD05Fc5FaLaXOis4S3rmk
         CrNIyqLZGnut/OQ/ka4/UJNpVt4WTX5pNW5da6G5NDL5cSKK347h5pnrAwImJ2h7EvYs
         ihVNcxtVo3ETnxY9Ik/VFzjUAhkhuDys1mytD/1QtzZWzPDTUvraNUi1U2BjObROcCsl
         bXlw==
X-Gm-Message-State: AOJu0Ywt0Nzsfs394+WuuSA489WsLaW0Zu7cW2W8Eh006Ejn+4siB25o
	myEaS+z1582t91T+p56Ykd5kVg==
X-Google-Smtp-Source: AGHT+IEEbklU1ZQ3qsHEK3r5Rhn95AvMaBeSzWOqoxhudvAt2H7ZkC05WSZGBm894QvVjqy/13nAmQ==
X-Received: by 2002:a05:620a:4113:b0:76c:e9e1:2b2 with SMTP id j19-20020a05620a411300b0076ce9e102b2mr22998208qko.13.1699308529769;
        Mon, 06 Nov 2023 14:08:49 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u21-20020ae9c015000000b00774652483b7sm3685338qkk.33.2023.11.06.14.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:49 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH 13/18] btrfs: handle the ro->rw transition for mounting different subovls
Date: Mon,  6 Nov 2023 17:08:21 -0500
Message-ID: <0a73915edbb8d05e30d167351ea8c709a9bfe447.1699308010.git.josef@toxicpanda.com>
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
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4ace42e08bff..e2ac0801211d 100644
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
+ * ever since commit 0723a0473fb4 ("btrfs: allow * mounting btrfs subvolumes
+ * with different ro/rw * options") the following works:
+ *
+ *        (i) mount /dev/sda3 -o subvol=foo,ro /mnt/foo
+ *       (ii) mount /dev/sda3 -o subvol=bar,rw /mnt/bar
+ *
+ * which looks nice and innocent but is actually pretty * intricate and
+ * deserves a long comment.
+ *
+ * on another filesystem a subvolume mount is close to * something like:
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
+ * of course, there's some special subvolume sauce and there's the fact that the
+ * sb->s_root dentry is really swapped after mount_subtree(). but conceptually
+ * it's very close and will help us understand the issue.
+ *
+ * the old mount api didn't cleanly distinguish between a mount being made ro
+ * and a superblock being made ro.  the only way to change the ro state of
+ * either object was by passing ms_rdonly. if a new mount was created via
+ * mount(2) such as:
+ *
+ *      mount("/dev/sdb", "/mnt", "xfs", ms_rdonly, null);
+ *
+ * the ms_rdonly flag being specified had two effects:
+ *
+ * (1) mnt_readonly was raised -> the resulting mount got
+ *     @mnt->mnt_flags |= mnt_readonly raised.
+ *
+ * (2) ms_rdonly was passed to the filesystem's mount method and the filesystems
+ *     made the superblock ro. note, how sb_rdonly has the same value as
+ *     ms_rdonly and is raised whenever ms_rdonly is passed through mount(2).
+ *
+ * creating a subtree mount via (iii) ends up leaving a rw superblock with a
+ * subtree mounted ro.
+ *
+ * but consider the effect on the old mount api on btrfs subvolume mounting
+ * which combines the distinct step in (iii) into a a single step.
+ *
+ * by issuing (i) both the mount and the superblock are turned ro. now when (ii)
+ * is issued the superblock is ro and thus even if the mount created for (ii) is
+ * rw it wouldn't help. hence, btrfs needed to transition the superblock from ro
+ * to rw for (ii) which it did using an internal remount call (a bold
+ * choice...).
+ *
+ * iow, subvolume mounting was inherently messy due to the ambiguity of
+ * ms_rdonly in mount(2). note, this ambiguity has mount(8) always translate
+ * "ro" to ms_rdonly. iow, in both (i) and (ii) "ro" becomes ms_rdonly when
+ * passed by mount(8) to mount(2).
+ *
+ * enter the new mount api. the new mount api disambiguates making a mount ro
+ * and making a superblock ro.
+ *
+ * (3) to turn a mount ro the mount_attr_rdonly flag can be used with either
+ *     fsmount() or mount_setattr() this is a pure vfs level change for a
+ *     specific mount or mount tree that is never seen by the filesystem itself.
+ *
+ * (4) to turn a superblock ro the "ro" flag must be used with
+ *     fsconfig(fsconfig_set_flag, "ro"). this option is seen by the filesytem
+ *     in fc->sb_flags.
+ *
+ * this disambiguation has rather positive consequences.  mounting a subvolume
+ * ro will not also turn the superblock ro. only the mount for the subvolume
+ * will become ro.
+ *
+ * so, if the superblock creation request comes from the new mount api the
+ * caller must've explicitly done:
+ *
+ *      fsconfig(fsconfig_set_flag, "ro")
+ *      fsmount/mount_setattr(mount_attr_rdonly)
+ *
+ * iow, at some point the caller must have explicitly turned the whole
+ * superblock ro and we shouldn't just undo it like we did for the old mount
+ * api. in any case, it lets us avoid this nasty hack in the new mount api.
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


