Return-Path: <linux-fsdevel+bounces-20692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9778D6DD5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 05:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ECB7B23DBB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 03:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFA9762C9;
	Sat,  1 Jun 2024 03:42:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE651B812;
	Sat,  1 Jun 2024 03:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717213328; cv=none; b=l2vRsRJlQGharc4fcTaQca78wHQTmTIH9qNBpbvQStyG1z2Eo08ScldKV4Y8Q7/6owR+B8Fnh55fxcnMdZe8TuhKl4y9lppQh6MzRUMafs6Zsxw1RGqWa3rUh2EKzyuknTvH4QYGVEsCFtiUdo7fsCsZNEL/7xEm+/9d4fx+55o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717213328; c=relaxed/simple;
	bh=ha3SETPGsayKRKJq4d1o9KDqgbPX0AlFjErn2744iq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uDqQDKXVxAi27id1INVgiVgTJ5EasR83mhFj6WfNbL57vVchAjfIxrja5jUTVbvSJhJL3ljQM1unXbplcIcY+7sQnrf7ZiJu3IEjCCc/ZwElNlEfiAeELWo1ROWfP8/d7KWEbpoc3EVWig36guAHiaGWwhj/6RKFL1xMqsiC3Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vrm4p0wQSz4f3mHb;
	Sat,  1 Jun 2024 11:41:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0D5B21A016E;
	Sat,  1 Jun 2024 11:41:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFumFpmHN_4OA--.4543S14;
	Sat, 01 Jun 2024 11:41:56 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH 10/10] ext4: drop all delonly descriptions
Date: Sat,  1 Jun 2024 11:41:49 +0800
Message-Id: <20240601034149.2169771-11-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240601034149.2169771-1-yi.zhang@huaweicloud.com>
References: <20240601034149.2169771-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RFumFpmHN_4OA--.4543S14
X-Coremail-Antispam: 1UD129KBjvJXoW3WFWUGw1DZF47Cr47Wr47XFb_yoWDXr1Upr
	W5KF13t3s8Xryv9r4Sywn7Xr1fWa4vvFWUt34fJFyFkFn5Jr1S9F1qkryFvFy8GrWxAw1q
	qF15u34Uua1qgFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUA
	rcfUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Drop all delonly descriptions in parameters and comments.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c | 92 ++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 47 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index db3fe3ada2e5..0af14b7d5005 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -142,8 +142,8 @@
  */
 
 struct rsvd_info {
-	int delonly_cluster;	/* reserved clusters for delalloc es entry */
-	int delonly_block;	/* reserved blocks for delalloc es entry */
+	int delayed_cluster;	/* reserved clusters for delalloc es entry */
+	int delayed_block;	/* reserved blocks for delalloc es entry */
 };
 
 static struct kmem_cache *ext4_es_cachep;
@@ -943,10 +943,10 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	 * so release the quota reservations made for any previously delayed
 	 * allocated clusters.
 	 */
-	resv_used = rinfo.delonly_cluster + pending;
+	resv_used = rinfo.delayed_cluster + pending;
 	if (resv_used)
 		ext4_da_update_reserve_space(inode, resv_used,
-					     rinfo.delonly_block);
+					     rinfo.delayed_block);
 	if (err1 || err2 || err3 < 0)
 		goto retry;
 
@@ -1067,8 +1067,8 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 }
 
 struct rsvd_count {
-	int ndelonly_cluster;
-	int ndelonly_block;
+	int ndelayed_cluster;
+	int ndelayed_block;
 	bool first_do_lblk_found;
 	ext4_lblk_t first_do_lblk;
 	ext4_lblk_t last_do_lblk;
@@ -1094,11 +1094,11 @@ static void init_rsvd(struct inode *inode, ext4_lblk_t lblk,
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct rb_node *node;
 
-	rc->ndelonly_cluster = 0;
-	rc->ndelonly_block = 0;
+	rc->ndelayed_cluster = 0;
+	rc->ndelayed_block = 0;
 
 	/*
-	 * for bigalloc, note the first delonly block in the range has not
+	 * for bigalloc, note the first delayed block in the range has not
 	 * been found, record the extent containing the block to the left of
 	 * the region to be removed, if any, and note that there's no partial
 	 * cluster to track
@@ -1118,9 +1118,8 @@ static void init_rsvd(struct inode *inode, ext4_lblk_t lblk,
 }
 
 /*
- * count_rsvd - count the clusters containing delayed and not unwritten
- *		(delonly) blocks in a range within an extent and add to
- *	        the running tally in rsvd_count
+ * count_rsvd - count the clusters containing delayed blocks in a range
+ *	        within an extent and add to the running tally in rsvd_count
  *
  * @inode - file containing extent
  * @lblk - first block in range
@@ -1143,19 +1142,19 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 	WARN_ON(len <= 0);
 
 	if (sbi->s_cluster_ratio == 1) {
-		rc->ndelonly_cluster += (int) len;
-		rc->ndelonly_block = rc->ndelonly_cluster;
+		rc->ndelayed_cluster += (int) len;
+		rc->ndelayed_block = rc->ndelayed_cluster;
 		return;
 	}
 
 	/* bigalloc */
-	rc->ndelonly_block += (int)len;
+	rc->ndelayed_block += (int)len;
 
 	i = (lblk < es->es_lblk) ? es->es_lblk : lblk;
 	end = lblk + (ext4_lblk_t) len - 1;
 	end = (end > ext4_es_end(es)) ? ext4_es_end(es) : end;
 
-	/* record the first block of the first delonly extent seen */
+	/* record the first block of the first delayed extent seen */
 	if (!rc->first_do_lblk_found) {
 		rc->first_do_lblk = i;
 		rc->first_do_lblk_found = true;
@@ -1169,7 +1168,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 	 * doesn't start with it, count it and stop tracking
 	 */
 	if (rc->partial && (rc->lclu != EXT4_B2C(sbi, i))) {
-		rc->ndelonly_cluster++;
+		rc->ndelayed_cluster++;
 		rc->partial = false;
 	}
 
@@ -1179,7 +1178,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 	 */
 	if (EXT4_LBLK_COFF(sbi, i) != 0) {
 		if (end >= EXT4_LBLK_CFILL(sbi, i)) {
-			rc->ndelonly_cluster++;
+			rc->ndelayed_cluster++;
 			rc->partial = false;
 			i = EXT4_LBLK_CFILL(sbi, i) + 1;
 		}
@@ -1187,11 +1186,11 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 
 	/*
 	 * if the current cluster starts on a cluster boundary, count the
-	 * number of whole delonly clusters in the extent
+	 * number of whole delayed clusters in the extent
 	 */
 	if ((i + sbi->s_cluster_ratio - 1) <= end) {
 		nclu = (end - i + 1) >> sbi->s_cluster_bits;
-		rc->ndelonly_cluster += nclu;
+		rc->ndelayed_cluster += nclu;
 		i += nclu << sbi->s_cluster_bits;
 	}
 
@@ -1251,10 +1250,9 @@ static struct pending_reservation *__pr_tree_search(struct rb_root *root,
  * @rc - pointer to reserved count data
  *
  * The number of reservations to be released is equal to the number of
- * clusters containing delayed and not unwritten (delonly) blocks within
- * the range, minus the number of clusters still containing delonly blocks
- * at the ends of the range, and minus the number of pending reservations
- * within the range.
+ * clusters containing delayed blocks within the range, minus the number of
+ * clusters still containing delayed blocks at the ends of the range, and
+ * minus the number of pending reservations within the range.
  */
 static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 			     struct extent_status *right_es,
@@ -1265,33 +1263,33 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 	struct ext4_pending_tree *tree = &EXT4_I(inode)->i_pending_tree;
 	struct rb_node *node;
 	ext4_lblk_t first_lclu, last_lclu;
-	bool left_delonly, right_delonly, count_pending;
+	bool left_delayed, right_delayed, count_pending;
 	struct extent_status *es;
 
 	if (sbi->s_cluster_ratio > 1) {
 		/* count any remaining partial cluster */
 		if (rc->partial)
-			rc->ndelonly_cluster++;
+			rc->ndelayed_cluster++;
 
-		if (rc->ndelonly_cluster == 0)
+		if (rc->ndelayed_cluster == 0)
 			return 0;
 
 		first_lclu = EXT4_B2C(sbi, rc->first_do_lblk);
 		last_lclu = EXT4_B2C(sbi, rc->last_do_lblk);
 
 		/*
-		 * decrease the delonly count by the number of clusters at the
-		 * ends of the range that still contain delonly blocks -
+		 * decrease the delayed count by the number of clusters at the
+		 * ends of the range that still contain delayed blocks -
 		 * these clusters still need to be reserved
 		 */
-		left_delonly = right_delonly = false;
+		left_delayed = right_delayed = false;
 
 		es = rc->left_es;
 		while (es && ext4_es_end(es) >=
 		       EXT4_LBLK_CMASK(sbi, rc->first_do_lblk)) {
 			if (ext4_es_is_delayed(es)) {
-				rc->ndelonly_cluster--;
-				left_delonly = true;
+				rc->ndelayed_cluster--;
+				left_delayed = true;
 				break;
 			}
 			node = rb_prev(&es->rb_node);
@@ -1299,7 +1297,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 				break;
 			es = rb_entry(node, struct extent_status, rb_node);
 		}
-		if (right_es && (!left_delonly || first_lclu != last_lclu)) {
+		if (right_es && (!left_delayed || first_lclu != last_lclu)) {
 			if (end < ext4_es_end(right_es)) {
 				es = right_es;
 			} else {
@@ -1310,8 +1308,8 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 			while (es && es->es_lblk <=
 			       EXT4_LBLK_CFILL(sbi, rc->last_do_lblk)) {
 				if (ext4_es_is_delayed(es)) {
-					rc->ndelonly_cluster--;
-					right_delonly = true;
+					rc->ndelayed_cluster--;
+					right_delayed = true;
 					break;
 				}
 				node = rb_next(&es->rb_node);
@@ -1325,21 +1323,21 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 		/*
 		 * Determine the block range that should be searched for
 		 * pending reservations, if any.  Clusters on the ends of the
-		 * original removed range containing delonly blocks are
+		 * original removed range containing delayed blocks are
 		 * excluded.  They've already been accounted for and it's not
 		 * possible to determine if an associated pending reservation
 		 * should be released with the information available in the
 		 * extents status tree.
 		 */
 		if (first_lclu == last_lclu) {
-			if (left_delonly | right_delonly)
+			if (left_delayed | right_delayed)
 				count_pending = false;
 			else
 				count_pending = true;
 		} else {
-			if (left_delonly)
+			if (left_delayed)
 				first_lclu++;
-			if (right_delonly)
+			if (right_delayed)
 				last_lclu--;
 			if (first_lclu <= last_lclu)
 				count_pending = true;
@@ -1350,13 +1348,13 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 		/*
 		 * a pending reservation found between first_lclu and last_lclu
 		 * represents an allocated cluster that contained at least one
-		 * delonly block, so the delonly total must be reduced by one
+		 * delayed block, so the delayed total must be reduced by one
 		 * for each pending reservation found and released
 		 */
 		if (count_pending) {
 			pr = __pr_tree_search(&tree->root, first_lclu);
 			while (pr && pr->lclu <= last_lclu) {
-				rc->ndelonly_cluster--;
+				rc->ndelayed_cluster--;
 				node = rb_next(&pr->rb_node);
 				rb_erase(&pr->rb_node, &tree->root);
 				__free_pending(pr);
@@ -1367,7 +1365,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 			}
 		}
 	}
-	return rc->ndelonly_cluster;
+	return rc->ndelayed_cluster;
 }
 
 
@@ -1401,8 +1399,8 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	struct rsvd_count rc;
 
 	if (rinfo) {
-		rinfo->delonly_cluster = 0;
-		rinfo->delonly_block = 0;
+		rinfo->delayed_cluster = 0;
+		rinfo->delayed_block = 0;
 		if (test_opt(inode->i_sb, DELALLOC))
 			count_reserved = true;
 	}
@@ -1504,8 +1502,8 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 
 out_get_reserved:
 	if (count_reserved) {
-		rinfo->delonly_cluster = get_rsvd(inode, end, es, &rc);
-		rinfo->delonly_block = rc.ndelonly_block;
+		rinfo->delayed_cluster = get_rsvd(inode, end, es, &rc);
+		rinfo->delayed_block = rc.ndelayed_block;
 	}
 out:
 	return err;
@@ -1563,7 +1561,7 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 		goto retry;
 
 	ext4_es_print_tree(inode);
-	ext4_da_release_space(inode, rinfo.delonly_cluster);
+	ext4_da_release_space(inode, rinfo.delayed_cluster);
 	return;
 }
 
-- 
2.31.1


