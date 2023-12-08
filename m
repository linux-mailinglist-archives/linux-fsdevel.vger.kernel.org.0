Return-Path: <linux-fsdevel+bounces-5319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C4180A35F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 13:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A302817EA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6701C694
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="LQb5RX09"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B3410F7
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 03:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1702035009;
	bh=cv3cK8vQYwCgVCck4+KMVVaFBdsPTiUNyCcJ325ZB/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LQb5RX09HfxZWireVsoQaeBY8Gyb+8+mCyL4WaUFpeGkye+Jx7FkePKPDWQBJn+6s
	 ONW2A0VWTtnRCD76W05U5zswyZMxtDCN1guDTKMtpFWkHScmPUttonq1bRlIrAMxiG
	 a60w84nLBwZN1Ns6u5O2Z3kDcin+MwmCWRY1L+LM=
Received: from localhost.localdomain ([180.164.182.58])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 530B9A94; Fri, 08 Dec 2023 19:20:48 +0800
X-QQ-mid: xmsmtpt1702034505t4l6op3qg
Message-ID: <tencent_C819A7DB899F09F0693C9C36BA8CA422FA0A@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9lBseoUVoM6+eakXSWLsAZ5Hil6AnwLXUjH5cYV7w9Xgsy8K098
	 TjZF+fon1dOUWNke0ZYhnvuaYtSnvNLDKYR464MW4LjEB57YagXAXUkTkkzIQp49vNOvOmQ5I0bK
	 VDheK3Lg8V2Kkmq1EXzUizMu+53HVze1G6/ojjSmdMD5COE20PhdBIRutYHXWeyiwsdDnd6fDFbE
	 CjEe2fFo189POK/8lQ3d/HjKPnQVYiPS7pKL+kClxpxvQtXW2sEOxBiAK0yvMq+Jdy41tqYZojtK
	 ew9jyG9fB7V4UZMds326+R7TZXqkk85DuXFLZUbyCv8dYqMWc9uSpee/mARs/6bJ/5PgbrsM43r3
	 H+1DmOHp4aH5MCdeXwTsNp5XZK4gcaeU/Rq0raJStdLnA5nbhR6YAzhEwyxfiHQaG9kBQBMV0QjA
	 3SpfVa6/xwhR4Jmx6L+wmyvro9K/Xj2eU8Nawp0vTiRXPwDbDZ1B6sk71v9XFBrPy83KPmAaQY4T
	 gZvDTevFnmpNkKfM1pUYpPy0MedaO8sVOskHuE0+AriVh+/wdoOC4+wCrn/sqbpl4H5HN9pXEOoy
	 igcx5b+om43vW9eFmRlSanJfOlmrfBCnrC3ExjB+ftJD/t73sNJMqtAL047mYGAoaDkRvAJvNgpj
	 7df/oiphqHosMuYSVRjN9WJvHQDL8NRBUAkzKDibfjhGOFmDrJCzWKRGKXIGx8gyxbnGS9yy95At
	 /5W2s76mhullqfhJT4NRHHb1iYcyn6xX8bhOaO+deza9vvaQ0UTedcEjIkly8HE3ny4aMtBJbsNQ
	 wGaVNWNoXkH3Jg3NViDXlmmuy9cn4M01QZlLwmYDCMPVCWaTLP5HOmcWwOguW+gjzmeKfZ3SHHJG
	 lp39MJoXUpiqIPhrMzh3j/YlIZnjnUzf8yXupYj//BgOPSAC9ItbtkSuGu9kqitr/1FukIsmEv0m
	 gcSDjjf/c21Ku/pEpQzhzDgW1zDBPVWguKKElpE4JaJ24hPDAbkQJoTbBWDT8M
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: yuezhang.mo@foxmail.com
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: linux-fsdevel@vger.kernel.org,
	Andy.Wu@sony.com,
	wataru.aoyama@sony.com,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v1 10/11] exfat: do not sync parent dir if just update timestamp
Date: Fri,  8 Dec 2023 19:23:19 +0800
X-OQ-MSGID: <20231208112318.1135649-11-yuezhang.mo@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231208112318.1135649-1-yuezhang.mo@foxmail.com>
References: <20231208112318.1135649-1-yuezhang.mo@foxmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuezhang Mo <Yuezhang.Mo@sony.com>

When sync or dir_sync is enabled, there is no need to sync the
parent directory's inode if only for updating its timestamp.

1. If an unexpected power failure occurs, the timestamp of the
   parent directory is not updated to the storage, which has no
   impact on the user.

2. The number of writes will be greatly reduced, which can not
   only improve performance, but also prolong device life.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Andy Wu <Andy.Wu@sony.com>
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
---
 fs/exfat/namei.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 79e3fc9d6e19..b33497845a06 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -547,6 +547,7 @@ static int exfat_create(struct mnt_idmap *idmap, struct inode *dir,
 	struct exfat_dir_entry info;
 	loff_t i_pos;
 	int err;
+	loff_t size = i_size_read(dir);
 
 	mutex_lock(&EXFAT_SB(sb)->s_lock);
 	exfat_set_volume_dirty(sb);
@@ -557,7 +558,7 @@ static int exfat_create(struct mnt_idmap *idmap, struct inode *dir,
 
 	inode_inc_iversion(dir);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
-	if (IS_DIRSYNC(dir))
+	if (IS_DIRSYNC(dir) && size != i_size_read(dir))
 		exfat_sync_inode(dir);
 	else
 		mark_inode_dirty(dir);
@@ -801,10 +802,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 	inode_inc_iversion(dir);
 	simple_inode_init_ts(dir);
 	exfat_truncate_inode_atime(dir);
-	if (IS_DIRSYNC(dir))
-		exfat_sync_inode(dir);
-	else
-		mark_inode_dirty(dir);
+	mark_inode_dirty(dir);
 
 	clear_nlink(inode);
 	simple_inode_init_ts(inode);
@@ -825,6 +823,7 @@ static int exfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	struct exfat_chain cdir;
 	loff_t i_pos;
 	int err;
+	loff_t size = i_size_read(dir);
 
 	mutex_lock(&EXFAT_SB(sb)->s_lock);
 	exfat_set_volume_dirty(sb);
@@ -835,7 +834,7 @@ static int exfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	inode_inc_iversion(dir);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
-	if (IS_DIRSYNC(dir))
+	if (IS_DIRSYNC(dir) && size != i_size_read(dir))
 		exfat_sync_inode(dir);
 	else
 		mark_inode_dirty(dir);
@@ -1239,6 +1238,7 @@ static int exfat_rename(struct mnt_idmap *idmap,
 	struct super_block *sb = old_dir->i_sb;
 	loff_t i_pos;
 	int err;
+	loff_t size = i_size_read(new_dir);
 
 	/*
 	 * The VFS already checks for existence, so for local filesystems
@@ -1260,7 +1260,7 @@ static int exfat_rename(struct mnt_idmap *idmap,
 	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
 	EXFAT_I(new_dir)->i_crtime = current_time(new_dir);
 	exfat_truncate_inode_atime(new_dir);
-	if (IS_DIRSYNC(new_dir))
+	if (IS_DIRSYNC(new_dir) && size != i_size_read(new_dir))
 		exfat_sync_inode(new_dir);
 	else
 		mark_inode_dirty(new_dir);
@@ -1281,10 +1281,7 @@ static int exfat_rename(struct mnt_idmap *idmap,
 	}
 
 	inode_inc_iversion(old_dir);
-	if (IS_DIRSYNC(old_dir))
-		exfat_sync_inode(old_dir);
-	else
-		mark_inode_dirty(old_dir);
+	mark_inode_dirty(old_dir);
 
 	if (new_inode) {
 		exfat_unhash_inode(new_inode);
-- 
2.25.1


