Return-Path: <linux-fsdevel+bounces-1165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B7B7D6DA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 15:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9EEDB210A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 13:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC83228DBE;
	Wed, 25 Oct 2023 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1Mgad7q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6161D28DAC
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 13:51:04 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DA9199;
	Wed, 25 Oct 2023 06:50:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32d80ae19f8so3937283f8f.2;
        Wed, 25 Oct 2023 06:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698241855; x=1698846655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSgXeEd7ULlQwvOdUJlS0OAnMD4LNWicUe5LQunKIfI=;
        b=c1Mgad7qoQF5XmxFTt1dymhti+oKhs5LPbIoB7iqzWLQdxTa/0vvuntX9JDDgi3EM4
         RJPZ5LFjL06wLjhScm6uOSC4FL9o6ZjE5c/JntnS83FQTa9YYiyz1Te1N/TMji7CtMy/
         8EWWZKNqgA3RjAOwAYILIKXQdmXFXB6B+7TvWZ+m+/T3TNMp37CvZmFdzA7/FH1ulvOH
         luDucRtoqCs+gCsVy+d3nd/lP45477WmyUnT+S50RvX6xr7MKWzenWUBfZWArR7yfDfj
         fVzBPjr3t6cq0HIa0S7YuuDysAj1+zqbE55xug7B4t12cwSZW07r9wAGmnjt/KvMiscn
         wa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698241855; x=1698846655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSgXeEd7ULlQwvOdUJlS0OAnMD4LNWicUe5LQunKIfI=;
        b=YAsEJzBFl+EP3INwWJN0kkcSdR58ebt0W4nzctd9aWlmYyFDn58HFGQo6QmlF/Fwoi
         lP1+kYcQJTmPkk073y9G9zgvbZHng8OUjen4BJQ8oRmayIOy39VLmGn6aAPmEfZF9k6x
         B+upFRE/iEYXIBivLieVZQt6GpSsCEr+CERBRKweNpM9XO3JoOv7FNV6S+oKbenudwnD
         f13xy4jM/USmnjwtFtQ+mVgjZN6N1S7dYtKYYsNLoziUH6e6p1ytCwr2LwD5r71r5xYC
         /CuEz8ZGk4XAP0y1P7WtFvQp2NakeKAMT44NqIRkyn8ERPEcXTD7og3OknREIpEcLsbd
         SUEQ==
X-Gm-Message-State: AOJu0YxVN4KBgDM0UeUx0jEBALmD3vOEqOm51WbkVJj31tQOAYwI3eY0
	aZOEs+3vmQWWTe6I5lAsxzzQXRfsgGw=
X-Google-Smtp-Source: AGHT+IFFzIlXwxvcIgap54Fb94ldQ034AJ3oWh5Ftg+yG5ur8gVuFiH7cjvCbbF/naVjYX5QuK4AgA==
X-Received: by 2002:adf:fe48:0:b0:32d:9fc9:d14c with SMTP id m8-20020adffe48000000b0032d9fc9d14cmr11863736wrs.47.1698241854748;
        Wed, 25 Oct 2023 06:50:54 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id t8-20020adff048000000b0032dc2110d01sm12143673wro.61.2023.10.25.06.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 06:50:54 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] btrfs: implement super operation to get fsid
Date: Wed, 25 Oct 2023 16:50:47 +0300
Message-Id: <20231025135048.36153-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025135048.36153-1-amir73il@gmail.com>
References: <20231025135048.36153-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs statfs can report a different fsid for different inodes.

Implement btrfs_get_fsid() that can be used as a cheaper way of getting
the f_fsid memeber of kstatfs, for callers that only care about fsid.

fanotify is going to make use of that to get btrfs fsid from inode on
every event.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/btrfs/super.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1a093ec0f7e3..fd08f7e81f72 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2016,6 +2016,26 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+static int btrfs_get_fsid(struct inode *inode, __kernel_fsid_t *fsid)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	__be32 *__fsid = (__be32 *)fs_info->fs_devices->fsid;
+
+	/*
+	 * We treat it as constant endianness (it doesn't matter _which_)
+	 * because we want the fsid to come out the same whether mounted
+	 * on a big-endian or little-endian host
+	 */
+	fsid->val[0] = be32_to_cpu(__fsid[0]) ^ be32_to_cpu(__fsid[2]);
+	fsid->val[1] = be32_to_cpu(__fsid[1]) ^ be32_to_cpu(__fsid[3]);
+
+	/* Mask in the root object ID too, to disambiguate subvols */
+	fsid->val[0] ^= BTRFS_I(inode)->root->root_key.objectid >> 32;
+	fsid->val[1] ^= BTRFS_I(inode)->root->root_key.objectid;
+
+	return 0;
+}
+
 /*
  * Calculate numbers for 'df', pessimistic in case of mixed raid profiles.
  *
@@ -2038,7 +2058,6 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	u64 total_free_data = 0;
 	u64 total_free_meta = 0;
 	u32 bits = fs_info->sectorsize_bits;
-	__be32 *fsid = (__be32 *)fs_info->fs_devices->fsid;
 	unsigned factor = 1;
 	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
 	int ret;
@@ -2124,16 +2143,7 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_bsize = dentry->d_sb->s_blocksize;
 	buf->f_namelen = BTRFS_NAME_LEN;
 
-	/* We treat it as constant endianness (it doesn't matter _which_)
-	   because we want the fsid to come out the same whether mounted
-	   on a big-endian or little-endian host */
-	buf->f_fsid.val[0] = be32_to_cpu(fsid[0]) ^ be32_to_cpu(fsid[2]);
-	buf->f_fsid.val[1] = be32_to_cpu(fsid[1]) ^ be32_to_cpu(fsid[3]);
-	/* Mask in the root object ID too, to disambiguate subvols */
-	buf->f_fsid.val[0] ^=
-		BTRFS_I(d_inode(dentry))->root->root_key.objectid >> 32;
-	buf->f_fsid.val[1] ^=
-		BTRFS_I(d_inode(dentry))->root->root_key.objectid;
+	btrfs_get_fsid(d_inode(dentry), &buf->f_fsid);
 
 	return 0;
 }
@@ -2362,6 +2372,7 @@ static const struct super_operations btrfs_super_ops = {
 	.alloc_inode	= btrfs_alloc_inode,
 	.destroy_inode	= btrfs_destroy_inode,
 	.free_inode	= btrfs_free_inode,
+	.get_fsid	= btrfs_get_fsid,
 	.statfs		= btrfs_statfs,
 	.remount_fs	= btrfs_remount,
 	.freeze_fs	= btrfs_freeze,
-- 
2.34.1


