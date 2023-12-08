Return-Path: <linux-fsdevel+bounces-5316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E10480A35A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 13:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2B3281721
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEE71C68A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="wgrry+vw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD442172C
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 03:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1702034872;
	bh=efnKlWPIgV+aCUly4gyc3WFDYD3OwkbfwJMA+1xkW9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wgrry+vwcH/0BZ+daEKla63IRw39ZONldl/dGQN07HJclwPnGm9ct3/3n9Zp1xu4S
	 KYu2QOG9jnKlNA5fVOEF2SIaQAecZscp9gcglsTk/I6d2mrL/AQ8lfIicpVBAgy/WI
	 Qt7QYL+BgTno+lHGaPAB1pZITm1k095iSFTpdqKY=
Received: from localhost.localdomain ([180.164.182.58])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 530B9A94; Fri, 08 Dec 2023 19:20:48 +0800
X-QQ-mid: xmsmtpt1702034501tv5pwhro8
Message-ID: <tencent_FB9B093068189C7EB944A7EEFB35A46F8B0A@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntuj0JKncji42R9whlDJAn9T6+OtACvN2IBltKvBdkwsNa1R7DyE5f
	 regx2+CRiIMH9mdl7v3AHbdwOXDai/j5N8PYJe2U+CmUoYPyhdF2EC3jFxB11EpdXa3ZpLvwMUWF
	 b5haSHGo3ljAXKUJps2ZlAwpHr6nj5I8rU4GGeRYN/5bBPiL414GBBCkj2imjAGspCXytFLb7ed0
	 g/XTymvhEkSpNpcBW2TkpgahhHaqkDzo7KLDwVzuZOk/Otp1O+Vgt97wqpN9q881xtvajVhLafjT
	 lHak0fclrNBLoKyq/tHuOevr5xDSK5fz2jKKItaCY5J1nc7o5qtNDrn+zTUUvnsBHsAJtqHsyHa0
	 rBSV7yIvOMhnoE0maL4UCQTV699LZ9mpkdqGyCqxWZUQb8kzALTq2hRHJTouIPfALdSobdDiwtoQ
	 i8OIPatUrj1OBFNzeWm+yFiksnPLBzVM/m3wdaMuYKJNk564Big7vMAYs7XNxaiPrsL/JUmBhtbi
	 Bpm5BtQ10C/HxDM1HaW5qvXerQI3DbQO2NZ8zY0VNp73Lr0bgY0KDdP0X465Irr7zhdIJh8As83s
	 1Ouap90egB9OUuyE+lLLgAMxjjDC02arfpudtDcKO8MrGMo11Lfl4a31mU4j87oS5IraOQPCtXR8
	 JenHFv1bq4cYIWTR9gBsQJgvrRWHsqQ8vokHSEZlvEohRjI5TBACi7uJZcCV/An+gaMlmt/zSLWe
	 gUUGfRi2v6YDCco+5ixVkn1cDFvWrJf7s4edZCRb6XrvvUPqHGmlAtuMa41UgTIdAv9LAa3Ih48C
	 EI6Z2iyNFSvoyOUmc3lrLCpRpWTmGsEoIeQYqWC6PsVMulj/SidAdVdBNAw0UoYy/8nVMJaDATbu
	 mYigR4xrdNVxD+fCEHfJeKcBgbjKuo1K4x8qn4fXQOUvK8pUa/leVKmK7OMx+sXn2vCiATq+2CFQ
	 peLJS4HxQt38aEdJjxJqXj5W3ZvqhBt6Z9Fp5vQwo=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: yuezhang.mo@foxmail.com
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: linux-fsdevel@vger.kernel.org,
	Andy.Wu@sony.com,
	wataru.aoyama@sony.com,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v1 08/11] exfat: remove __exfat_find_empty_entry()
Date: Fri,  8 Dec 2023 19:23:17 +0800
X-OQ-MSGID: <20231208112318.1135649-9-yuezhang.mo@foxmail.com>
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

This commit removes exfat_find_empty_entry() and renames
__exfat_find_empty_entry() to exfat_find_empty_entry().

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Andy Wu <Andy.Wu@sony.com>
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
---
 fs/exfat/namei.c | 49 ++++++++++++------------------------------------
 1 file changed, 12 insertions(+), 37 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index ee7d5fd0b16f..79e3fc9d6e19 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -291,7 +291,7 @@ static int exfat_check_max_dentries(struct inode *inode)
 /* find empty directory entry.
  * if there isn't any empty slot, expand cluster chain.
  */
-static int __exfat_find_empty_entry(struct inode *inode,
+static int exfat_find_empty_entry(struct inode *inode,
 		struct exfat_chain *p_dir, int num_entries,
 		struct exfat_entry_set_cache *es)
 {
@@ -382,21 +382,6 @@ static int __exfat_find_empty_entry(struct inode *inode,
 	return dentry;
 }
 
-static int exfat_find_empty_entry(struct inode *inode,
-		struct exfat_chain *p_dir, int num_entries)
-{
-	int entry;
-	struct exfat_entry_set_cache es;
-
-	entry = __exfat_find_empty_entry(inode, p_dir, num_entries, &es);
-	if (entry < 0)
-		return entry;
-
-	exfat_put_dentry_set(&es, false);
-
-	return entry;
-}
-
 /*
  * Name Resolution Functions :
  * Zero if it was successful; otherwise nonzero.
@@ -498,7 +483,7 @@ static int exfat_add_entry(struct inode *inode, const char *path,
 	}
 
 	/* exfat_find_empty_entry must be called before alloc_cluster() */
-	dentry = exfat_find_empty_entry(inode, p_dir, num_entries);
+	dentry = exfat_find_empty_entry(inode, p_dir, num_entries, &es);
 	if (dentry < 0) {
 		ret = dentry; /* -EIO or -ENOSPC */
 		goto out;
@@ -506,8 +491,10 @@ static int exfat_add_entry(struct inode *inode, const char *path,
 
 	if (type == TYPE_DIR && !sbi->options.zero_size_dir) {
 		ret = exfat_alloc_new_dir(inode, &clu);
-		if (ret)
+		if (ret) {
+			exfat_put_dentry_set(&es, false);
 			goto out;
+		}
 		start_clu = clu.dir;
 		clu_size = sbi->cluster_size;
 	}
@@ -516,11 +503,6 @@ static int exfat_add_entry(struct inode *inode, const char *path,
 	/* fill the dos name directory entry information of the created file.
 	 * the first cluster is not determined yet. (0)
 	 */
-
-	ret = exfat_get_empty_dentry_set(&es, sb, p_dir, dentry, num_entries);
-	if (ret)
-		goto out;
-
 	exfat_init_dir_entry(&es, type, start_clu, clu_size, &ts);
 	exfat_init_ext_entry(&es, num_entries, &uniname);
 
@@ -1016,18 +998,13 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 	if (old_es.num_entries < num_new_entries) {
 		int newentry;
 
-		newentry =
-			exfat_find_empty_entry(inode, p_dir, num_new_entries);
+		newentry = exfat_find_empty_entry(inode, p_dir, num_new_entries,
+				&new_es);
 		if (newentry < 0) {
 			ret = newentry; /* -EIO or -ENOSPC */
 			goto put_old_es;
 		}
 
-		ret = exfat_get_empty_dentry_set(&new_es, sb, p_dir, newentry,
-				num_new_entries);
-		if (ret)
-			goto put_old_es;
-
 		epnew = exfat_get_dentry_cached(&new_es, ES_IDX_FILE);
 		*epnew = *epold;
 		if (exfat_get_entry_type(epnew) == TYPE_FILE) {
@@ -1077,19 +1054,17 @@ static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
 	if (num_new_entries < 0)
 		return num_new_entries;
 
-	newentry = exfat_find_empty_entry(inode, p_newdir, num_new_entries);
-	if (newentry < 0)
-		return newentry; /* -EIO or -ENOSPC */
-
 	ret = exfat_get_dentry_set(&mov_es, sb, p_olddir, oldentry,
 			ES_ALL_ENTRIES);
 	if (ret)
 		return -EIO;
 
-	ret = exfat_get_empty_dentry_set(&new_es, sb, p_newdir, newentry,
-			num_new_entries);
-	if (ret)
+	newentry = exfat_find_empty_entry(inode, p_newdir, num_new_entries,
+			&new_es);
+	if (newentry < 0) {
+		ret = newentry; /* -EIO or -ENOSPC */
 		goto put_mov_es;
+	}
 
 	epmov = exfat_get_dentry_cached(&mov_es, ES_IDX_FILE);
 	epnew = exfat_get_dentry_cached(&new_es, ES_IDX_FILE);
-- 
2.25.1


