Return-Path: <linux-fsdevel+bounces-5314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7359380A356
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 13:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C3B280CA3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C82F1C696
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="whoMz1rb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2DB10F8
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 03:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1702034869;
	bh=iHqxm6/z8eZr9tI87TDYsEEgs6+ViMDs61QFgckO3tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=whoMz1rbflCPAEbFUH5YwlXHGzgzBj2xy+sUO1ebZILGyAWhS86hETzn3wVokqMCN
	 /ny6FOPC+GhkEXX8cFS0IwcpfCMuoiC135KBLy/actzDdQvUk8uFsyoF8yVG2sdesK
	 zdOFy1WEMgCEszhNY8Psb54rhQdp0JW0g9dPqu3c=
Received: from localhost.localdomain ([180.164.182.58])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 530B9A94; Fri, 08 Dec 2023 19:20:48 +0800
X-QQ-mid: xmsmtpt1702034492tk11qvic2
Message-ID: <tencent_F1AF0B696AA71F537A8038A60088C6D8E906@qq.com>
X-QQ-XMAILINFO: NJ/+omVLhVgaUsRybtwRP+OXwlr1Nf8n9XgwU4fjsBubRxuKAnX//en4D40LJ6
	 lNKWSMKXa3P8L6F1sK2uNy/CgPw/P3uTyIeK9GgwkCCFHs+aHf5zt6NApm42eu83IPhyBMCkF0fu
	 tZGFuELY4IWI19iIjRK57c2emPevTc65XidG4Xkp/J3TTP+SbYXm1cI3VUtB1joCz82IwncgUjIj
	 Oup5RuTKJc3kU3M0i83pjz+rnPi0cuq7rxVoRX2GymGnqgAqKuQLkLK9pxPCe98sQB+LoRe5PP0Y
	 UpLv2fzUT7QnYmd/sYOJjNQSm1LbdG1sNYz9aZe4+Y+BLwLQWqRTcC1Z+ZLveVNg0I4kqxSFBkrT
	 soVHxF312gu3/OFP3ZD/VtXAyF74V7C/aV8TYalqZru66scRoz2sfOV6j+2ks/AwU96ngwRkzYKX
	 qXfpBMALUl8ml32kTV8QkAeIKjMqlIJyGvBKmV+z8ogqc/UXiFIjp+aax6t10nHxNN9c1JADFQ+E
	 S71aDsAxY+oG5PCpojTw34jX6ACD3a+wtnuUxwqi2VPR47F/GmIfNV6956ThBAGvCDDRGAVEISSk
	 8669WRRkOt20T5t1/GNyPySPfX8DV5LfzZQi1tXGeo0yLm8ZbEmw43Sq3YAi6hZmFM/fukgyAOzU
	 1kD7CALtl+nozhTEWCI3IdG7MfyXMGjd/Q0BN8ri+eXEPgVsGo4mTas1vA27H+kOFe3SubpCIAcL
	 oGRcshaIxo+S7O2wPUVOIAv+U8AZtdIT8RXFYaP2r1BeOsy256iELcvxsBHemMdrz5kFoRZkD1nJ
	 OalG4jQMOSP3WsKvz36q5JA0qv/9I/LyftwTVTn9cuiYXIYJuIZlayLkyivVbKaAJgvf0goeekRz
	 Gqpj1IIjGYhbTmX2SEXHQ89HeltdyYT36HhYHeGz0m6yrgJml4SYFPqJGjN46h5Rzv92dVIsZYr8
	 wtWHCJn3DoNmR8b+HR2a2jLYg4Lu0lACaiefTkM65jtbrqlLtSn+qcy5Zm8591
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: yuezhang.mo@foxmail.com
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: linux-fsdevel@vger.kernel.org,
	Andy.Wu@sony.com,
	wataru.aoyama@sony.com,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v1 04/11] exfat: covert exfat_add_entry() to use dentry cache
Date: Fri,  8 Dec 2023 19:23:13 +0800
X-OQ-MSGID: <20231208112318.1135649-5-yuezhang.mo@foxmail.com>
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

After this conversion, if "dirsync" or "sync" is enabled, the
number of synchronized dentries in exfat_add_entry() will change
from 2 to 1.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Andy Wu <Andy.Wu@sony.com>
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
---
 fs/exfat/dir.c      | 37 +++++++++----------------------------
 fs/exfat/exfat_fs.h |  6 +++---
 fs/exfat/namei.c    | 12 ++++++++++--
 3 files changed, 22 insertions(+), 33 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index bb23585c6e7c..a7eda14a57ac 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -448,53 +448,34 @@ static void exfat_init_name_entry(struct exfat_dentry *ep,
 	}
 }
 
-int exfat_init_dir_entry(struct inode *inode, struct exfat_chain *p_dir,
-		int entry, unsigned int type, unsigned int start_clu,
-		unsigned long long size)
+void exfat_init_dir_entry(struct exfat_entry_set_cache *es,
+		unsigned int type, unsigned int start_clu,
+		unsigned long long size, struct timespec64 *ts)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = es->sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	struct timespec64 ts = current_time(inode);
 	struct exfat_dentry *ep;
-	struct buffer_head *bh;
-
-	/*
-	 * We cannot use exfat_get_dentry_set here because file ep is not
-	 * initialized yet.
-	 */
-	ep = exfat_get_dentry(sb, p_dir, entry, &bh);
-	if (!ep)
-		return -EIO;
 
+	ep = exfat_get_dentry_cached(es, ES_IDX_FILE);
 	exfat_set_entry_type(ep, type);
-	exfat_set_entry_time(sbi, &ts,
+	exfat_set_entry_time(sbi, ts,
 			&ep->dentry.file.create_tz,
 			&ep->dentry.file.create_time,
 			&ep->dentry.file.create_date,
 			&ep->dentry.file.create_time_cs);
-	exfat_set_entry_time(sbi, &ts,
+	exfat_set_entry_time(sbi, ts,
 			&ep->dentry.file.modify_tz,
 			&ep->dentry.file.modify_time,
 			&ep->dentry.file.modify_date,
 			&ep->dentry.file.modify_time_cs);
-	exfat_set_entry_time(sbi, &ts,
+	exfat_set_entry_time(sbi, ts,
 			&ep->dentry.file.access_tz,
 			&ep->dentry.file.access_time,
 			&ep->dentry.file.access_date,
 			NULL);
 
-	exfat_update_bh(bh, IS_DIRSYNC(inode));
-	brelse(bh);
-
-	ep = exfat_get_dentry(sb, p_dir, entry + 1, &bh);
-	if (!ep)
-		return -EIO;
-
+	ep = exfat_get_dentry_cached(es, ES_IDX_STREAM);
 	exfat_init_stream_entry(ep, start_clu, size);
-	exfat_update_bh(bh, IS_DIRSYNC(inode));
-	brelse(bh);
-
-	return 0;
 }
 
 int exfat_update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 6dc76b3f4945..0897584d1473 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -480,9 +480,9 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 extern const struct inode_operations exfat_dir_inode_operations;
 extern const struct file_operations exfat_dir_operations;
 unsigned int exfat_get_entry_type(struct exfat_dentry *p_entry);
-int exfat_init_dir_entry(struct inode *inode, struct exfat_chain *p_dir,
-		int entry, unsigned int type, unsigned int start_clu,
-		unsigned long long size);
+void exfat_init_dir_entry(struct exfat_entry_set_cache *es,
+		unsigned int type, unsigned int start_clu,
+		unsigned long long size, struct timespec64 *ts);
 int exfat_init_ext_entry(struct inode *inode, struct exfat_chain *p_dir,
 		int entry, int num_entries, struct exfat_uni_name *p_uniname);
 int exfat_remove_entries(struct inode *inode, struct exfat_chain *p_dir,
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 1f662296f2fa..423cd6d505ab 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -482,6 +482,8 @@ static int exfat_add_entry(struct inode *inode, const char *path,
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_uni_name uniname;
 	struct exfat_chain clu;
+	struct timespec64 ts = current_time(inode);
+	struct exfat_entry_set_cache es;
 	int clu_size = 0;
 	unsigned int start_clu = EXFAT_FREE_CLUSTER;
 
@@ -514,8 +516,14 @@ static int exfat_add_entry(struct inode *inode, const char *path,
 	/* fill the dos name directory entry information of the created file.
 	 * the first cluster is not determined yet. (0)
 	 */
-	ret = exfat_init_dir_entry(inode, p_dir, dentry, type,
-		start_clu, clu_size);
+
+	ret = exfat_get_empty_dentry_set(&es, sb, p_dir, dentry, num_entries);
+	if (ret)
+		goto out;
+
+	exfat_init_dir_entry(&es, type, start_clu, clu_size, &ts);
+
+	ret = exfat_put_dentry_set(&es, IS_DIRSYNC(inode));
 	if (ret)
 		goto out;
 
-- 
2.25.1


