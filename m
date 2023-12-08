Return-Path: <linux-fsdevel+bounces-5318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCC080A35D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 13:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62AF5B20AE3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C861F1A73B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="yDem2e7h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF1A171F
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 03:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1702035001;
	bh=+/pN+pgmxf4tGRuEeHxpF9JmqCk/0LPE9fuycvif25I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yDem2e7hVO5E5R83H3cRaY42FPE5oo6axyHFPGLFwWfeDfQkZo5IFY5oWqLEJa8+z
	 PXqJTfHnAlI+vCLhAg5yYloV71II7f9m8RsBsKDPO1o8beexQyFtLrVbUPa3IccONt
	 bxmtqfIxdfjYOFiYSss/MNSvRkY6B5CysHLQcaJ0=
Received: from localhost.localdomain ([180.164.182.58])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 530B9A94; Fri, 08 Dec 2023 19:20:48 +0800
X-QQ-mid: xmsmtpt1702034495tjj64rn0g
Message-ID: <tencent_444D2AB5DF5F3AA5389300B986E7A99CCB06@qq.com>
X-QQ-XMAILINFO: NnA3IMNPwBd+ji1cITXbS2GOU1gnuGjHkwF3/LYL+DNhgfwKY74vj7Wmt3PUqM
	 LHFhosfchvve5FjFvmfIJqAV9tZzr0NsSlFphvX6eHuHYy0t4yNQMmA4TurIyYExBIV5APN5xkYs
	 0nUKpfIHB485Syq1VgHYYCF3X6GlxmBkLYTLo9twLs6tPzlue/IQyDeNzp9errU3B5dsmNfmFyPo
	 rZH3You5JtkGFJbTWj2VxcWRlP0mGfApZ1B3etL7Fqdz05vpiUIS07MSHRxpSmsObd1gzFRVrOsd
	 vD8y8q2nbrpeyBoIpRyDpyMVuVlw5YLGk4lv2NZHGJ3H2rYE7KXjxfx/GWypFgr2xPQJuuLIa1Ah
	 UquUYsxYvNaUg6DCOPtPmmk9QQ53Jw2OSLdaBg2sbkyqCLyMEaJlAEgJX6OfBOZ5m9Kr9sIvJE0v
	 0BNFwxdeuqMsSsY6GiVC6xXe+ZJummAvagcdj956T1L77Wr+BwqlzKaZ0Nr21HrhczM9S9u21sL1
	 vK2HpAHOLWSgFsY6cBzEZhluOQdLe+2A4ZGXCmIBJc0hZufE5fv38kF1ULzAn6vlUjfsHXftmsuO
	 c4XTsoiBc8MUH0U/FIzs/lb8WkwB9nE2qY7n78RnUGIeWH4LjMoa+lW8RJLWvZwcG7uDmQPeGdqA
	 48qQpTCOAcckPBssIAi1vG5mnjfx2tWvr6nmDuRf3eb7KirVoDC3qkjUY76CVKKsHSyvJ8Z5pTFA
	 utoTGV+XxCJu5teSMnKpNU3XkmOtkYBauEyseZGI/GouldMhawwfrGVXXmh7gpyhhSM08YZjc92Q
	 dD3hIOGxBSpgAQhreJfMgO7KLMaNnP/j3dcsQFB8U0IJoSm9Rx5qF7HKNJLl3AR2p+BKNa1Qptkn
	 TfK7JQ61w/KADTieITZdp1Jq458/QyBVrDGAx5MG20IQlH2oGHXr8+PKEH3FwOgM9ulJRZltO28R
	 6Y8mRjdXyikwSkVnrtwEbY6cUpsPC5hnGHwW+9pHksq52nIS/c/3v7PrIq1jiKqPlASkMNbDGk8P
	 8Q3dAlAw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: yuezhang.mo@foxmail.com
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: linux-fsdevel@vger.kernel.org,
	Andy.Wu@sony.com,
	wataru.aoyama@sony.com,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v1 05/11] exfat: covert exfat_remove_entries() to use dentry cache
Date: Fri,  8 Dec 2023 19:23:14 +0800
X-OQ-MSGID: <20231208112318.1135649-6-yuezhang.mo@foxmail.com>
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

Before this conversion, in exfat_remove_entries(), to mark the
dentries in a dentry set as deleted, the sync times is equals
the dentry numbers if 'dirsync' or 'sync' is enabled.
That affects not only performance but also device life.

After this conversion, only needs to be synchronized once if
'dirsync' or 'sync' is enabled.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Andy Wu <Andy.Wu@sony.com>
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
---
 fs/exfat/dir.c      |  17 ++--
 fs/exfat/exfat_fs.h |   4 +-
 fs/exfat/namei.c    | 184 ++++++++++++++++++++------------------------
 3 files changed, 90 insertions(+), 115 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index a7eda14a57ac..2a002b01f1dc 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -577,28 +577,23 @@ int exfat_init_ext_entry(struct inode *inode, struct exfat_chain *p_dir,
 	return 0;
 }
 
-int exfat_remove_entries(struct inode *inode, struct exfat_chain *p_dir,
-		int entry, int order, int num_entries)
+void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
+		int order)
 {
-	struct super_block *sb = inode->i_sb;
 	int i;
 	struct exfat_dentry *ep;
-	struct buffer_head *bh;
 
-	for (i = order; i < num_entries; i++) {
-		ep = exfat_get_dentry(sb, p_dir, entry + i, &bh);
-		if (!ep)
-			return -EIO;
+	for (i = order; i < es->num_entries; i++) {
+		ep = exfat_get_dentry_cached(es, i);
 
 		if (exfat_get_entry_type(ep) & TYPE_BENIGN_SEC)
 			exfat_free_benign_secondary_clusters(inode, ep);
 
 		exfat_set_entry_type(ep, TYPE_DELETED);
-		exfat_update_bh(bh, IS_DIRSYNC(inode));
-		brelse(bh);
 	}
 
-	return 0;
+	if (order < es->num_entries)
+		es->modified = true;
 }
 
 void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 0897584d1473..46031e77f58b 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -485,8 +485,8 @@ void exfat_init_dir_entry(struct exfat_entry_set_cache *es,
 		unsigned long long size, struct timespec64 *ts);
 int exfat_init_ext_entry(struct inode *inode, struct exfat_chain *p_dir,
 		int entry, int num_entries, struct exfat_uni_name *p_uniname);
-int exfat_remove_entries(struct inode *inode, struct exfat_chain *p_dir,
-		int entry, int order, int num_entries);
+void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
+		int order);
 int exfat_update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
 		int entry);
 void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es);
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 423cd6d505ab..6a85b6707a7e 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -786,12 +786,11 @@ static struct dentry *exfat_lookup(struct inode *dir, struct dentry *dentry,
 static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct exfat_chain cdir;
-	struct exfat_dentry *ep;
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = dentry->d_inode;
 	struct exfat_inode_info *ei = EXFAT_I(inode);
-	struct buffer_head *bh;
-	int num_entries, entry, err = 0;
+	struct exfat_entry_set_cache es;
+	int entry, err = 0;
 
 	mutex_lock(&EXFAT_SB(sb)->s_lock);
 	exfat_chain_dup(&cdir, &ei->dir);
@@ -802,26 +801,20 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 		goto unlock;
 	}
 
-	ep = exfat_get_dentry(sb, &cdir, entry, &bh);
-	if (!ep) {
-		err = -EIO;
-		goto unlock;
-	}
-	num_entries = exfat_count_ext_entries(sb, &cdir, entry, ep);
-	if (num_entries < 0) {
+	err = exfat_get_dentry_set(&es, sb, &cdir, entry, ES_ALL_ENTRIES);
+	if (err) {
 		err = -EIO;
-		brelse(bh);
 		goto unlock;
 	}
-	num_entries++;
-	brelse(bh);
 
 	exfat_set_volume_dirty(sb);
+
 	/* update the directory entry */
-	if (exfat_remove_entries(dir, &cdir, entry, 0, num_entries)) {
-		err = -EIO;
+	exfat_remove_entries(inode, &es, ES_IDX_FILE);
+
+	err = exfat_put_dentry_set(&es, IS_DIRSYNC(inode));
+	if (err)
 		goto unlock;
-	}
 
 	/* This doesn't modify ei */
 	ei->dir.dir = DIR_DELETED;
@@ -937,13 +930,12 @@ static int exfat_check_dir_empty(struct super_block *sb,
 static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
-	struct exfat_dentry *ep;
 	struct exfat_chain cdir, clu_to_free;
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
-	struct buffer_head *bh;
-	int num_entries, entry, err;
+	struct exfat_entry_set_cache es;
+	int entry, err;
 
 	mutex_lock(&EXFAT_SB(inode->i_sb)->s_lock);
 
@@ -967,27 +959,20 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 		goto unlock;
 	}
 
-	ep = exfat_get_dentry(sb, &cdir, entry, &bh);
-	if (!ep) {
-		err = -EIO;
-		goto unlock;
-	}
-
-	num_entries = exfat_count_ext_entries(sb, &cdir, entry, ep);
-	if (num_entries < 0) {
+	err = exfat_get_dentry_set(&es, sb, &cdir, entry, ES_ALL_ENTRIES);
+	if (err) {
 		err = -EIO;
-		brelse(bh);
 		goto unlock;
 	}
-	num_entries++;
-	brelse(bh);
 
 	exfat_set_volume_dirty(sb);
-	err = exfat_remove_entries(dir, &cdir, entry, 0, num_entries);
-	if (err) {
-		exfat_err(sb, "failed to exfat_remove_entries : err(%d)", err);
+
+	exfat_remove_entries(inode, &es, ES_IDX_FILE);
+
+	err = exfat_put_dentry_set(&es, IS_DIRSYNC(dir));
+	if (err)
 		goto unlock;
-	}
+
 	ei->dir.dir = DIR_DELETED;
 
 	inode_inc_iversion(dir);
@@ -1013,36 +998,40 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 		int oldentry, struct exfat_uni_name *p_uniname,
 		struct exfat_inode_info *ei)
 {
-	int ret, num_old_entries, num_new_entries;
+	int ret, num_new_entries;
 	struct exfat_dentry *epold, *epnew;
 	struct super_block *sb = inode->i_sb;
-	struct buffer_head *new_bh, *old_bh;
+	struct buffer_head *new_bh;
+	struct exfat_entry_set_cache old_es;
 	int sync = IS_DIRSYNC(inode);
 
-	epold = exfat_get_dentry(sb, p_dir, oldentry, &old_bh);
-	if (!epold)
-		return -EIO;
-
-	num_old_entries = exfat_count_ext_entries(sb, p_dir, oldentry, epold);
-	if (num_old_entries < 0)
-		return -EIO;
-	num_old_entries++;
-
 	num_new_entries = exfat_calc_num_entries(p_uniname);
 	if (num_new_entries < 0)
 		return num_new_entries;
 
-	if (num_old_entries < num_new_entries) {
+	ret = exfat_get_dentry_set(&old_es, sb, p_dir, oldentry, ES_ALL_ENTRIES);
+	if (ret) {
+		ret = -EIO;
+		return ret;
+	}
+
+	epold = exfat_get_dentry_cached(&old_es, ES_IDX_FILE);
+
+	if (old_es.num_entries < num_new_entries) {
 		int newentry;
 
 		newentry =
 			exfat_find_empty_entry(inode, p_dir, num_new_entries);
-		if (newentry < 0)
-			return newentry; /* -EIO or -ENOSPC */
+		if (newentry < 0) {
+			ret = newentry; /* -EIO or -ENOSPC */
+			goto put_old_es;
+		}
 
 		epnew = exfat_get_dentry(sb, p_dir, newentry, &new_bh);
-		if (!epnew)
-			return -EIO;
+		if (!epnew) {
+			ret = -EIO;
+			goto put_old_es;
+		}
 
 		*epnew = *epold;
 		if (exfat_get_entry_type(epnew) == TYPE_FILE) {
@@ -1050,30 +1039,25 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 			ei->attr |= EXFAT_ATTR_ARCHIVE;
 		}
 		exfat_update_bh(new_bh, sync);
-		brelse(old_bh);
 		brelse(new_bh);
 
-		epold = exfat_get_dentry(sb, p_dir, oldentry + 1, &old_bh);
-		if (!epold)
-			return -EIO;
+		epold = exfat_get_dentry_cached(&old_es, ES_IDX_STREAM);
 		epnew = exfat_get_dentry(sb, p_dir, newentry + 1, &new_bh);
 		if (!epnew) {
-			brelse(old_bh);
-			return -EIO;
+			ret = -EIO;
+			goto put_old_es;
 		}
 
 		*epnew = *epold;
 		exfat_update_bh(new_bh, sync);
-		brelse(old_bh);
 		brelse(new_bh);
 
 		ret = exfat_init_ext_entry(inode, p_dir, newentry,
 			num_new_entries, p_uniname);
 		if (ret)
-			return ret;
+			goto put_old_es;
 
-		exfat_remove_entries(inode, p_dir, oldentry, 0,
-			num_old_entries);
+		exfat_remove_entries(inode, &old_es, ES_IDX_FILE);
 		ei->dir = *p_dir;
 		ei->entry = newentry;
 	} else {
@@ -1081,37 +1065,29 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 			epold->dentry.file.attr |= cpu_to_le16(EXFAT_ATTR_ARCHIVE);
 			ei->attr |= EXFAT_ATTR_ARCHIVE;
 		}
-		exfat_update_bh(old_bh, sync);
-		brelse(old_bh);
 		ret = exfat_init_ext_entry(inode, p_dir, oldentry,
 			num_new_entries, p_uniname);
 		if (ret)
-			return ret;
+			goto put_old_es;
 
-		exfat_remove_entries(inode, p_dir, oldentry, num_new_entries,
-			num_old_entries);
+		exfat_remove_entries(inode, &old_es, num_new_entries);
 	}
-	return 0;
+	return exfat_put_dentry_set(&old_es, sync);
+
+put_old_es:
+	exfat_put_dentry_set(&old_es, false);
+	return ret;
 }
 
 static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
 		int oldentry, struct exfat_chain *p_newdir,
 		struct exfat_uni_name *p_uniname, struct exfat_inode_info *ei)
 {
-	int ret, newentry, num_new_entries, num_old_entries;
+	int ret, newentry, num_new_entries;
 	struct exfat_dentry *epmov, *epnew;
 	struct super_block *sb = inode->i_sb;
-	struct buffer_head *mov_bh, *new_bh;
-
-	epmov = exfat_get_dentry(sb, p_olddir, oldentry, &mov_bh);
-	if (!epmov)
-		return -EIO;
-
-	num_old_entries = exfat_count_ext_entries(sb, p_olddir, oldentry,
-		epmov);
-	if (num_old_entries < 0)
-		return -EIO;
-	num_old_entries++;
+	struct buffer_head *new_bh;
+	struct exfat_entry_set_cache mov_es;
 
 	num_new_entries = exfat_calc_num_entries(p_uniname);
 	if (num_new_entries < 0)
@@ -1121,31 +1097,35 @@ static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
 	if (newentry < 0)
 		return newentry; /* -EIO or -ENOSPC */
 
-	epnew = exfat_get_dentry(sb, p_newdir, newentry, &new_bh);
-	if (!epnew)
+	ret = exfat_get_dentry_set(&mov_es, sb, p_olddir, oldentry,
+			ES_ALL_ENTRIES);
+	if (ret)
 		return -EIO;
 
+	epmov = exfat_get_dentry_cached(&mov_es, ES_IDX_FILE);
+	epnew = exfat_get_dentry(sb, p_newdir, newentry, &new_bh);
+	if (!epnew) {
+		ret = -EIO;
+		goto put_mov_es;
+	}
+
 	*epnew = *epmov;
 	if (exfat_get_entry_type(epnew) == TYPE_FILE) {
 		epnew->dentry.file.attr |= cpu_to_le16(EXFAT_ATTR_ARCHIVE);
 		ei->attr |= EXFAT_ATTR_ARCHIVE;
 	}
 	exfat_update_bh(new_bh, IS_DIRSYNC(inode));
-	brelse(mov_bh);
 	brelse(new_bh);
 
-	epmov = exfat_get_dentry(sb, p_olddir, oldentry + 1, &mov_bh);
-	if (!epmov)
-		return -EIO;
+	epmov = exfat_get_dentry_cached(&mov_es, ES_IDX_STREAM);
 	epnew = exfat_get_dentry(sb, p_newdir, newentry + 1, &new_bh);
 	if (!epnew) {
-		brelse(mov_bh);
-		return -EIO;
+		ret = -EIO;
+		goto put_mov_es;
 	}
 
 	*epnew = *epmov;
 	exfat_update_bh(new_bh, IS_DIRSYNC(inode));
-	brelse(mov_bh);
 	brelse(new_bh);
 
 	ret = exfat_init_ext_entry(inode, p_newdir, newentry, num_new_entries,
@@ -1153,13 +1133,18 @@ static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
 	if (ret)
 		return ret;
 
-	exfat_remove_entries(inode, p_olddir, oldentry, 0, num_old_entries);
+	exfat_remove_entries(inode, &mov_es, ES_IDX_FILE);
 
 	exfat_chain_set(&ei->dir, p_newdir->dir, p_newdir->size,
 		p_newdir->flags);
 
 	ei->entry = newentry;
-	return 0;
+	return exfat_put_dentry_set(&mov_es, IS_DIRSYNC(inode));
+
+put_mov_es:
+	exfat_put_dentry_set(&mov_es, false);
+
+	return ret;
 }
 
 /* rename or move a old file into a new file */
@@ -1177,7 +1162,6 @@ static int __exfat_rename(struct inode *old_parent_inode,
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	const unsigned char *new_path = new_dentry->d_name.name;
 	struct inode *new_inode = new_dentry->d_inode;
-	int num_entries;
 	struct exfat_inode_info *new_ei = NULL;
 	unsigned int new_entry_type = TYPE_UNUSED;
 	int new_entry = 0;
@@ -1248,25 +1232,21 @@ static int __exfat_rename(struct inode *old_parent_inode,
 				&newdir, &uni_name, ei);
 
 	if (!ret && new_inode) {
+		struct exfat_entry_set_cache es;
+
 		/* delete entries of new_dir */
-		ep = exfat_get_dentry(sb, p_dir, new_entry, &new_bh);
-		if (!ep) {
+		ret = exfat_get_dentry_set(&es, sb, p_dir, new_entry,
+				ES_ALL_ENTRIES);
+		if (ret) {
 			ret = -EIO;
 			goto del_out;
 		}
 
-		num_entries = exfat_count_ext_entries(sb, p_dir, new_entry, ep);
-		if (num_entries < 0) {
-			ret = -EIO;
-			goto del_out;
-		}
-		brelse(new_bh);
+		exfat_remove_entries(new_inode, &es, ES_IDX_FILE);
 
-		if (exfat_remove_entries(new_inode, p_dir, new_entry, 0,
-				num_entries + 1)) {
-			ret = -EIO;
+		ret = exfat_put_dentry_set(&es, IS_DIRSYNC(new_inode));
+		if (ret)
 			goto del_out;
-		}
 
 		/* Free the clusters if new_inode is a dir(as if exfat_rmdir) */
 		if (new_entry_type == TYPE_DIR &&
-- 
2.25.1


