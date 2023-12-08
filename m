Return-Path: <linux-fsdevel+bounces-5311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E37C80A34E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 13:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74C21F21455
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209E712B7D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Ww3Z6KM+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349C310CA
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 03:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1702034501;
	bh=+QeCqnUl3Zvl3kLwf+D8OZ4mle50KHBxwSgY62XS3SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ww3Z6KM+SsWFBYP1LwGDyNDt2p8bI68l3DGgGAcaytspA2A8pycdVRnyN3GQv6Iii
	 PR1ZTlN1EeH1aryEQbMiVO9zmmlYoeRP3QrlDWfh1wcVd7IW51naHT5R6lyUk0Claq
	 FrIkkgW/V+vMsR0ILwZB2AAsOftBzgipk5NwVsV8=
Received: from localhost.localdomain ([180.164.182.58])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 530B9A94; Fri, 08 Dec 2023 19:20:48 +0800
X-QQ-mid: xmsmtpt1702034499t1z09xkmu
Message-ID: <tencent_117C2E61A9EA7E17E94AE221027D1A2DA708@qq.com>
X-QQ-XMAILINFO: Nfm/+M6ONQ57SBF37mfK0SmLAsrop4F25W7X6rEQSu1Vo1CcOFSZDeQ++P/MWm
	 lOABzWg6ytfWOYkRPo+va8JiGP1Fmcrp+RWo5er5nXTYvqt/o/JXUmeJXlgiXHu5wbVDXz1C7OIb
	 dEKjBbY51MJ/t/L5uUKZXzw84ZoQiZo5dq66CB1QroybbdClDH7M36HnTqB6MkuoL4079zi3eeNY
	 g9mqr3+S/TTOgITHd4/H1W2pwrSLCQzzwX2JHuld+/odG91vkY0MQ7fOcQuR5SL3sGpQTOwSVnu2
	 y6DlmG96TJnbxzcMSvXJpkILuEXfeakf5dJPB3S21uQmlNJPfAi7xX4oNlokIJd/RKYr2cBRs9zA
	 M6q3x19tYoTzjM4otTtYLDAU6+ng9sHM9G9ZWPtKzrGMa/BAUBizQ2tG29whZ0GqP2dRinH78Ljh
	 9AciO9y8xRzZkfr8LoRluNLICI0YqIpPoWrEC0V4Ax/0RJoeRJLXgxTjxlVKSL/2YwfuETHG0Yrd
	 ptZiF0b2UyyNLv7x6LXtCenyFHmoZmghtEqYC6iRv5SnU68zZQF9SGrgxTnniEsRPPdsOKc1qT/F
	 ZfPVhmjxorbRimCBhH6ykZwWE0XY4RCyPKxYcknJtGAxCmnYoR4/VDUlkPVPcNrWPSdWbl7ZSTXF
	 6tyrMQT+63AgJtHOC5rxuyJlDItiZP2JIk+9nEr+KkSbM9/c8qWVfE84QDwRkvQ6kl+1pwXC3aVd
	 jYN1ZgYYMq12ct0l4fSOPe1LwD/gtNr4rFCzVUAs2LCSb3NX/37G5wS/7gp8ZatHnEcEGrnM6YDA
	 p/ax8yggnakfHWuhrkOhmHysgvCelMR7fd2MYyi5iDXzozDqN8i2JBF5MLbL8xu8mkwBSwdAlIfu
	 b+9EQEhHwij9+8/Vfu85fJZhje6QZmnDIix92iNgjJBIEJwi2CVTODwk1o3p/mlm5KwegwMkDaSi
	 LOGdHNnoFvuP66f54G7EXBbTZ23zIa0B9/YoeNgvUrUtW6MYZhVYkK3tLTmhPD
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: yuezhang.mo@foxmail.com
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: linux-fsdevel@vger.kernel.org,
	Andy.Wu@sony.com,
	wataru.aoyama@sony.com,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v1 07/11] exfat: covert exfat_init_ext_entry() to use dentry cache
Date: Fri,  8 Dec 2023 19:23:16 +0800
X-OQ-MSGID: <20231208112318.1135649-8-yuezhang.mo@foxmail.com>
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

Before this conversion, in exfat_init_ext_entry(), to init
the dentries in a dentry set, the sync times is equals the
dentry number if 'dirsync' or 'sync' is enabled.
That affects not only performance but also device life.

After this conversion, only needs to be synchronized once if
'dirsync' or 'sync' is enabled.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Andy Wu <Andy.Wu@sony.com>
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
---
 fs/exfat/dir.c      | 33 +++++---------------
 fs/exfat/exfat_fs.h |  4 +--
 fs/exfat/namei.c    | 73 +++++++++++++++------------------------------
 3 files changed, 33 insertions(+), 77 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 8965bb2c99ae..94cedc145291 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -532,46 +532,27 @@ static void exfat_free_benign_secondary_clusters(struct inode *inode,
 	exfat_free_cluster(inode, &dir);
 }
 
-int exfat_init_ext_entry(struct inode *inode, struct exfat_chain *p_dir,
-		int entry, int num_entries, struct exfat_uni_name *p_uniname)
+void exfat_init_ext_entry(struct exfat_entry_set_cache *es, int num_entries,
+		struct exfat_uni_name *p_uniname)
 {
-	struct super_block *sb = inode->i_sb;
 	int i;
 	unsigned short *uniname = p_uniname->name;
 	struct exfat_dentry *ep;
-	struct buffer_head *bh;
-	int sync = IS_DIRSYNC(inode);
-
-	ep = exfat_get_dentry(sb, p_dir, entry, &bh);
-	if (!ep)
-		return -EIO;
 
+	ep = exfat_get_dentry_cached(es, ES_IDX_FILE);
 	ep->dentry.file.num_ext = (unsigned char)(num_entries - 1);
-	exfat_update_bh(bh, sync);
-	brelse(bh);
-
-	ep = exfat_get_dentry(sb, p_dir, entry + 1, &bh);
-	if (!ep)
-		return -EIO;
 
+	ep = exfat_get_dentry_cached(es, ES_IDX_STREAM);
 	ep->dentry.stream.name_len = p_uniname->name_len;
 	ep->dentry.stream.name_hash = cpu_to_le16(p_uniname->name_hash);
-	exfat_update_bh(bh, sync);
-	brelse(bh);
-
-	for (i = EXFAT_FIRST_CLUSTER; i < num_entries; i++) {
-		ep = exfat_get_dentry(sb, p_dir, entry + i, &bh);
-		if (!ep)
-			return -EIO;
 
+	for (i = ES_IDX_FIRST_FILENAME; i < num_entries; i++) {
+		ep = exfat_get_dentry_cached(es, i);
 		exfat_init_name_entry(ep, uniname);
-		exfat_update_bh(bh, sync);
-		brelse(bh);
 		uniname += EXFAT_FILE_NAME_LEN;
 	}
 
-	exfat_update_dir_chksum(inode, p_dir, entry);
-	return 0;
+	exfat_update_dir_chksum_with_entry_set(es);
 }
 
 void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 46031e77f58b..0280a975586c 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -483,8 +483,8 @@ unsigned int exfat_get_entry_type(struct exfat_dentry *p_entry);
 void exfat_init_dir_entry(struct exfat_entry_set_cache *es,
 		unsigned int type, unsigned int start_clu,
 		unsigned long long size, struct timespec64 *ts);
-int exfat_init_ext_entry(struct inode *inode, struct exfat_chain *p_dir,
-		int entry, int num_entries, struct exfat_uni_name *p_uniname);
+void exfat_init_ext_entry(struct exfat_entry_set_cache *es, int num_entries,
+		struct exfat_uni_name *p_uniname);
 void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
 		int order);
 int exfat_update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 9a0d8f2deea6..ee7d5fd0b16f 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -522,15 +522,12 @@ static int exfat_add_entry(struct inode *inode, const char *path,
 		goto out;
 
 	exfat_init_dir_entry(&es, type, start_clu, clu_size, &ts);
+	exfat_init_ext_entry(&es, num_entries, &uniname);
 
 	ret = exfat_put_dentry_set(&es, IS_DIRSYNC(inode));
 	if (ret)
 		goto out;
 
-	ret = exfat_init_ext_entry(inode, p_dir, dentry, num_entries, &uniname);
-	if (ret)
-		goto out;
-
 	info->dir = *p_dir;
 	info->entry = dentry;
 	info->flags = ALLOC_NO_FAT_CHAIN;
@@ -1001,8 +998,7 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 	int ret, num_new_entries;
 	struct exfat_dentry *epold, *epnew;
 	struct super_block *sb = inode->i_sb;
-	struct buffer_head *new_bh;
-	struct exfat_entry_set_cache old_es;
+	struct exfat_entry_set_cache old_es, new_es;
 	int sync = IS_DIRSYNC(inode);
 
 	num_new_entries = exfat_calc_num_entries(p_uniname);
@@ -1027,33 +1023,25 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 			goto put_old_es;
 		}
 
-		epnew = exfat_get_dentry(sb, p_dir, newentry, &new_bh);
-		if (!epnew) {
-			ret = -EIO;
+		ret = exfat_get_empty_dentry_set(&new_es, sb, p_dir, newentry,
+				num_new_entries);
+		if (ret)
 			goto put_old_es;
-		}
 
+		epnew = exfat_get_dentry_cached(&new_es, ES_IDX_FILE);
 		*epnew = *epold;
 		if (exfat_get_entry_type(epnew) == TYPE_FILE) {
 			epnew->dentry.file.attr |= cpu_to_le16(EXFAT_ATTR_ARCHIVE);
 			ei->attr |= EXFAT_ATTR_ARCHIVE;
 		}
-		exfat_update_bh(new_bh, sync);
-		brelse(new_bh);
 
 		epold = exfat_get_dentry_cached(&old_es, ES_IDX_STREAM);
-		epnew = exfat_get_dentry(sb, p_dir, newentry + 1, &new_bh);
-		if (!epnew) {
-			ret = -EIO;
-			goto put_old_es;
-		}
-
+		epnew = exfat_get_dentry_cached(&new_es, ES_IDX_STREAM);
 		*epnew = *epold;
-		exfat_update_bh(new_bh, sync);
-		brelse(new_bh);
 
-		ret = exfat_init_ext_entry(inode, p_dir, newentry,
-			num_new_entries, p_uniname);
+		exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);
+
+		ret = exfat_put_dentry_set(&new_es, sync);
 		if (ret)
 			goto put_old_es;
 
@@ -1067,11 +1055,7 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 		}
 
 		exfat_remove_entries(inode, &old_es, ES_IDX_FIRST_FILENAME + 1);
-
-		ret = exfat_init_ext_entry(inode, p_dir, oldentry,
-			num_new_entries, p_uniname);
-		if (ret)
-			goto put_old_es;
+		exfat_init_ext_entry(&old_es, num_new_entries, p_uniname);
 	}
 	return exfat_put_dentry_set(&old_es, sync);
 
@@ -1087,8 +1071,7 @@ static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
 	int ret, newentry, num_new_entries;
 	struct exfat_dentry *epmov, *epnew;
 	struct super_block *sb = inode->i_sb;
-	struct buffer_head *new_bh;
-	struct exfat_entry_set_cache mov_es;
+	struct exfat_entry_set_cache mov_es, new_es;
 
 	num_new_entries = exfat_calc_num_entries(p_uniname);
 	if (num_new_entries < 0)
@@ -1103,43 +1086,35 @@ static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
 	if (ret)
 		return -EIO;
 
-	epmov = exfat_get_dentry_cached(&mov_es, ES_IDX_FILE);
-	epnew = exfat_get_dentry(sb, p_newdir, newentry, &new_bh);
-	if (!epnew) {
-		ret = -EIO;
+	ret = exfat_get_empty_dentry_set(&new_es, sb, p_newdir, newentry,
+			num_new_entries);
+	if (ret)
 		goto put_mov_es;
-	}
 
+	epmov = exfat_get_dentry_cached(&mov_es, ES_IDX_FILE);
+	epnew = exfat_get_dentry_cached(&new_es, ES_IDX_FILE);
 	*epnew = *epmov;
 	if (exfat_get_entry_type(epnew) == TYPE_FILE) {
 		epnew->dentry.file.attr |= cpu_to_le16(EXFAT_ATTR_ARCHIVE);
 		ei->attr |= EXFAT_ATTR_ARCHIVE;
 	}
-	exfat_update_bh(new_bh, IS_DIRSYNC(inode));
-	brelse(new_bh);
 
 	epmov = exfat_get_dentry_cached(&mov_es, ES_IDX_STREAM);
-	epnew = exfat_get_dentry(sb, p_newdir, newentry + 1, &new_bh);
-	if (!epnew) {
-		ret = -EIO;
-		goto put_mov_es;
-	}
-
+	epnew = exfat_get_dentry_cached(&new_es, ES_IDX_STREAM);
 	*epnew = *epmov;
-	exfat_update_bh(new_bh, IS_DIRSYNC(inode));
-	brelse(new_bh);
-
-	ret = exfat_init_ext_entry(inode, p_newdir, newentry, num_new_entries,
-		p_uniname);
-	if (ret)
-		return ret;
 
+	exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);
 	exfat_remove_entries(inode, &mov_es, ES_IDX_FILE);
 
 	exfat_chain_set(&ei->dir, p_newdir->dir, p_newdir->size,
 		p_newdir->flags);
 
 	ei->entry = newentry;
+
+	ret = exfat_put_dentry_set(&new_es, IS_DIRSYNC(inode));
+	if (ret)
+		goto put_mov_es;
+
 	return exfat_put_dentry_set(&mov_es, IS_DIRSYNC(inode));
 
 put_mov_es:
-- 
2.25.1


