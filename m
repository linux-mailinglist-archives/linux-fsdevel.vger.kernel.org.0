Return-Path: <linux-fsdevel+bounces-72100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBF8CDE8D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 10:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C09E33019B76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 09:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB73730C374;
	Fri, 26 Dec 2025 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nSDOlbKe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0CA800;
	Fri, 26 Dec 2025 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766742338; cv=none; b=DvTTM46mf5zobHaDlcdK+WFTZQnzYjd6FkcJnCSJypD1NUyPthl8o2SMjq/cdtLaG0i4LqJ/XgNH31AnxUslxNE9Mfg5bw3HMr8X5C7hPBss9rGaoFHoMdH+x+fq6adJ/ZD1joDha/qQ1NAzOUrqSLPJFwT9jQOLaMBWV9vIL0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766742338; c=relaxed/simple;
	bh=7XQnh/VA/KqJu+7+aA4dxxn6OFQ3awzG6+iIQKJDZXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAqFqE9VT+N3VGjBYpFFp/0ZoY8ZQLjPsyLhsqFm3vt7U4+jkllNRFPmMEMnwKyvFMH4ymkAIDQ7pAa0Squ9ikHejNfFH2M+GRRqFx2xRDLrdmo6JuPm/+jSPKBpiKIk3V5yno5mZ5ycJGL+e4epqFYSeAGXvLG9bl2/hRUiOn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nSDOlbKe; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Hw
	hjI8LrnsS3V0SFfDxImoH+MP8b9nINkDRWIGH0XPQ=; b=nSDOlbKeebsa/WSXv3
	XOpkJZiPaDaYaXhY9wyhP7lOK2wAxqtsKshSdDu2EM/ikuVrkD/5XTG+JFpwl8Wa
	/xZsJmWEza68+9vwAISZm5CxYDr95EqUPrNDR3aWqaeD/nWVr8sCjanrMFbeqoXd
	LwufFWphAXWElOY3Mxr9d5hSI=
Received: from chi-Redmi-Book.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCnlXIPWU5p9JFCJA--.53S8;
	Fri, 26 Dec 2025 17:44:52 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 6/9] exfat: remove unused parameters from exfat_get_cluster
Date: Fri, 26 Dec 2025 17:44:37 +0800
Message-ID: <20251226094440.455563-7-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251226094440.455563-1-chizhiling@163.com>
References: <20251226094440.455563-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCnlXIPWU5p9JFCJA--.53S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr18try7XF4rKF4kXF1fWFg_yoWruw47pr
	ZrKa4rt3y3Xayv9w48tFs5Za4fK3Z7GFWUJw43AryYkr90yr1F9FnFkr9Iya48Gw4kuayj
	9F15Kw1j9rnxGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnCzZUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+BRJ5mlOWRSBVAAA38

From: Chi Zhiling <chizhiling@kylinos.cn>

Remove the unused fclus and allow_eof parameters from exfat_get_cluster.
The fclus parameter is changed to a local variable as it is not needed
to be returned. The allow_eof parameter was always 1, so remove it and
the associated error handling.

This simplifies the function and its callers, no logical changes.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/cache.c    | 31 +++++++++++--------------------
 fs/exfat/exfat_fs.h |  3 +--
 fs/exfat/inode.c    | 12 +++++-------
 3 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
index 4161b983b6af..43a6aa87c55d 100644
--- a/fs/exfat/cache.c
+++ b/fs/exfat/cache.c
@@ -234,8 +234,7 @@ static inline void cache_init(struct exfat_cache_id *cid,
 }
 
 int exfat_get_cluster(struct inode *inode, unsigned int cluster,
-		unsigned int *fclus, unsigned int *dclus,
-		unsigned int *last_dclus, int allow_eof)
+		unsigned int *dclus, unsigned int *last_dclus)
 {
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -243,7 +242,7 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	struct buffer_head *bh = NULL;
 	struct exfat_cache_id cid;
-	unsigned int content;
+	unsigned int content, fclus;
 
 	if (ei->start_clu == EXFAT_FREE_CLUSTER) {
 		exfat_fs_error(sb,
@@ -252,7 +251,7 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 		return -EIO;
 	}
 
-	*fclus = 0;
+	fclus = 0;
 	*dclus = ei->start_clu;
 	*last_dclus = *dclus;
 
@@ -264,7 +263,7 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 
 	cache_init(&cid, EXFAT_EOF_CLUSTER, EXFAT_EOF_CLUSTER);
 
-	if (exfat_cache_lookup(inode, cluster, &cid, fclus, dclus) ==
+	if (exfat_cache_lookup(inode, cluster, &cid, &fclus, dclus) ==
 			EXFAT_EOF_CLUSTER) {
 		/*
 		 * dummy, always not contiguous
@@ -276,15 +275,15 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 			cid.nr_contig != 0);
 	}
 
-	if (*fclus == cluster)
+	if (fclus == cluster)
 		return 0;
 
-	while (*fclus < cluster) {
+	while (fclus < cluster) {
 		/* prevent the infinite loop of cluster chain */
-		if (*fclus > limit) {
+		if (fclus > limit) {
 			exfat_fs_error(sb,
 				"detected the cluster chain loop (i_pos %u)",
-				(*fclus));
+				fclus);
 			goto err;
 		}
 
@@ -293,21 +292,13 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 
 		*last_dclus = *dclus;
 		*dclus = content;
-		(*fclus)++;
-
-		if (content == EXFAT_EOF_CLUSTER) {
-			if (!allow_eof) {
-				exfat_fs_error(sb,
-				       "invalid cluster chain (i_pos %u, last_clus 0x%08x is EOF)",
-				       *fclus, (*last_dclus));
-				goto err;
-			}
+		fclus++;
 
+		if (content == EXFAT_EOF_CLUSTER)
 			break;
-		}
 
 		if (!cache_contiguous(&cid, *dclus))
-			cache_init(&cid, *fclus, *dclus);
+			cache_init(&cid, fclus, *dclus);
 	}
 
 	brelse(bh);
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index f7f25e0600c7..e58d8eed5495 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -486,8 +486,7 @@ int exfat_cache_init(void);
 void exfat_cache_shutdown(void);
 void exfat_cache_inval_inode(struct inode *inode);
 int exfat_get_cluster(struct inode *inode, unsigned int cluster,
-		unsigned int *fclus, unsigned int *dclus,
-		unsigned int *last_dclus, int allow_eof);
+		unsigned int *dclus, unsigned int *last_dclus);
 
 /* dir.c */
 extern const struct inode_operations exfat_dir_inode_operations;
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index f9501c3a3666..1062ce470cb1 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -157,28 +157,26 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 				*clu += clu_offset;
 		}
 	} else if (ei->type == TYPE_FILE) {
-		unsigned int fclus = 0;
 		int err = exfat_get_cluster(inode, clu_offset,
-				&fclus, clu, &last_clu, 1);
+				clu, &last_clu);
 		if (err)
 			return -EIO;
-
-		clu_offset -= fclus;
 	} else {
+		unsigned int fclus = 0;
 		/* hint information */
 		if (clu_offset > 0 && ei->hint_bmap.off != EXFAT_EOF_CLUSTER &&
 		    ei->hint_bmap.off > 0 && clu_offset >= ei->hint_bmap.off) {
-			clu_offset -= ei->hint_bmap.off;
 			/* hint_bmap.clu should be valid */
 			WARN_ON(ei->hint_bmap.clu < 2);
+			fclus = ei->hint_bmap.off;
 			*clu = ei->hint_bmap.clu;
 		}
 
-		while (clu_offset > 0 && *clu != EXFAT_EOF_CLUSTER) {
+		while (fclus < clu_offset && *clu != EXFAT_EOF_CLUSTER) {
 			last_clu = *clu;
 			if (exfat_get_next_cluster(sb, clu))
 				return -EIO;
-			clu_offset--;
+			fclus++;
 		}
 	}
 
-- 
2.43.0


