Return-Path: <linux-fsdevel+bounces-24871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD64945D90
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 13:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A28284ACF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 11:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D371EA0C0;
	Fri,  2 Aug 2024 11:55:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169E91E4865;
	Fri,  2 Aug 2024 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599712; cv=none; b=JBR1qntY/gwYelFeJGlkZqdeokRFsqagmpD1aWL2BJWRTDAFzDVXKMA1mvK5/ONjD2uT8eyg5fEz+pw/7dOD6sydzT9PCbJm4uh+3ckmK4M5aesKmvoyfBdMIvPmBfKBNU/gXGP2q552YsK/OhYmLaWOxHU4uqVyBP/jFlVkLGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599712; c=relaxed/simple;
	bh=+OI/J6BGrGdke+LydxA16Y3pVsD76XGURwLpNIyKCjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QxTFKgJno2EgR2dupL35yquoZ3qpvyyS+fjJ1Osy2/xz+b2kaO4dSGXeKlEmamFNCBg+69sIfUhARilLXkTxNkz340w9Gv+1Qlf9OqTPdt5+yRQV8FP+He5YDTf9mEg7EuAuSH501IQ5/omLU4CdPOKkISpLSZXz/+ghZy0kO6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wb45G1lkyz4f3k6L;
	Fri,  2 Aug 2024 19:54:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 04FAC1A018D;
	Fri,  2 Aug 2024 19:55:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4UJyaxmamI8Ag--.7970S14;
	Fri, 02 Aug 2024 19:55:06 +0800 (CST)
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
Subject: [PATCH v2 10/10] ext4: drop all delonly descriptions
Date: Fri,  2 Aug 2024 19:51:20 +0800
Message-Id: <20240802115120.362902-11-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
References: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3n4UJyaxmamI8Ag--.7970S14
X-Coremail-Antispam: 1UD129KBjvJXoW3WFWUCFWxAF4DKrWxJFWxtFb_yoWDXr1Upr
	WYgF15twn8Xryv9r4ftwn7Xr1Sga4vqayUt34fJFyF9Fn5Jr1S9F1qkryFvFy8GrWxAw1q
	qF15u34Uua1qgFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUWMKtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Drop all delonly descriptions in parameters and comments.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c | 92 ++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 47 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 5fb0a02405ba..54ef599869f7 100644
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
@@ -945,10 +945,10 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
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
 
@@ -1069,8 +1069,8 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 }
 
 struct rsvd_count {
-	int ndelonly_cluster;
-	int ndelonly_block;
+	int ndelayed_cluster;
+	int ndelayed_block;
 	bool first_do_lblk_found;
 	ext4_lblk_t first_do_lblk;
 	ext4_lblk_t last_do_lblk;
@@ -1096,11 +1096,11 @@ static void init_rsvd(struct inode *inode, ext4_lblk_t lblk,
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
@@ -1120,9 +1120,8 @@ static void init_rsvd(struct inode *inode, ext4_lblk_t lblk,
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
@@ -1145,19 +1144,19 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
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
@@ -1171,7 +1170,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 	 * doesn't start with it, count it and stop tracking
 	 */
 	if (rc->partial && (rc->lclu != EXT4_B2C(sbi, i))) {
-		rc->ndelonly_cluster++;
+		rc->ndelayed_cluster++;
 		rc->partial = false;
 	}
 
@@ -1181,7 +1180,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 	 */
 	if (EXT4_LBLK_COFF(sbi, i) != 0) {
 		if (end >= EXT4_LBLK_CFILL(sbi, i)) {
-			rc->ndelonly_cluster++;
+			rc->ndelayed_cluster++;
 			rc->partial = false;
 			i = EXT4_LBLK_CFILL(sbi, i) + 1;
 		}
@@ -1189,11 +1188,11 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 
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
 
@@ -1253,10 +1252,9 @@ static struct pending_reservation *__pr_tree_search(struct rb_root *root,
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
@@ -1267,33 +1265,33 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
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
@@ -1301,7 +1299,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 				break;
 			es = rb_entry(node, struct extent_status, rb_node);
 		}
-		if (right_es && (!left_delonly || first_lclu != last_lclu)) {
+		if (right_es && (!left_delayed || first_lclu != last_lclu)) {
 			if (end < ext4_es_end(right_es)) {
 				es = right_es;
 			} else {
@@ -1312,8 +1310,8 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
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
@@ -1327,21 +1325,21 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
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
@@ -1352,13 +1350,13 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
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
@@ -1369,7 +1367,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 			}
 		}
 	}
-	return rc->ndelonly_cluster;
+	return rc->ndelayed_cluster;
 }
 
 
@@ -1403,8 +1401,8 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	struct rsvd_count rc;
 
 	if (rinfo) {
-		rinfo->delonly_cluster = 0;
-		rinfo->delonly_block = 0;
+		rinfo->delayed_cluster = 0;
+		rinfo->delayed_block = 0;
 		if (test_opt(inode->i_sb, DELALLOC))
 			count_reserved = true;
 	}
@@ -1506,8 +1504,8 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 
 out_get_reserved:
 	if (count_reserved) {
-		rinfo->delonly_cluster = get_rsvd(inode, end, es, &rc);
-		rinfo->delonly_block = rc.ndelonly_block;
+		rinfo->delayed_cluster = get_rsvd(inode, end, es, &rc);
+		rinfo->delayed_block = rc.ndelayed_block;
 	}
 out:
 	return err;
@@ -1565,7 +1563,7 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 		goto retry;
 
 	ext4_es_print_tree(inode);
-	ext4_da_release_space(inode, rinfo.delonly_cluster);
+	ext4_da_release_space(inode, rinfo.delayed_cluster);
 	return;
 }
 
-- 
2.39.2


