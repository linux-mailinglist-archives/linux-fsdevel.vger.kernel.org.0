Return-Path: <linux-fsdevel+bounces-25783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 407D2950553
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 14:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36701F256E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 12:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3B919FA68;
	Tue, 13 Aug 2024 12:39:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F5F199E9B;
	Tue, 13 Aug 2024 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552772; cv=none; b=CgkVuZfNOCwhg4YBwsNwq8NdtqJAqhsDlz3tgJAdoXBC6HnzIHKgrTSMjdrWrdEPj5voL6WQqDDfWZqvVocwnHeY15x/WvRIXHIuTWcYvOrD1+6FTJ0VTwuxP03BCh7XEEXR4YiA6dAh0RTwRwqecXD2HcWVccRykqVo7mn4AV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552772; c=relaxed/simple;
	bh=myNAaYvncLUJOSa4A+wCCsT7D2xZ2t6PEeXjJg2Opmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y4M6y6ZQIwiMRlWzEW0OUH1j8EorxUXQs34S+2PQXQ6OHb4TDDvBBEEMp2b6WC6EPLgHba+LLETKbgItoVANWUJa2RhtusuLkQWqf50GRubeflj/+Q2tgupLZDzfh4WfwRhlc0qF3SjMIv26a60UrPuPA6FAMzsKeD+1YznVwHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WjrYF06kdz4f3k6W;
	Tue, 13 Aug 2024 20:39:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4D3081A07B6;
	Tue, 13 Aug 2024 20:39:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBnj4XkU7tmejNSBg--.17625S16;
	Tue, 13 Aug 2024 20:39:22 +0800 (CST)
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
Subject: [PATCH v3 12/12] ext4: drop all delonly descriptions
Date: Tue, 13 Aug 2024 20:34:52 +0800
Message-Id: <20240813123452.2824659-13-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
References: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnj4XkU7tmejNSBg--.17625S16
X-Coremail-Antispam: 1UD129KBjvJXoWxKFyDKFW3GrWrXr1kCFW8tFb_yoW3Ar4xpF
	WYg3W5ta1DX3y09r4Svw48Zr1Sq34ktFWUt34fJa4Fyrn5tryFkFn2yry0vFy8GrWxA3Wj
	qF1j9ryUua12gFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUQFxUUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When counting reserved clusters, delayed type is always equal to delonly
type now, hence drop all delonly descriptions in parameters and
comments.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c | 66 +++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 68c47ecc01a5..c786691dabd3 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1067,7 +1067,7 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 }
 
 struct rsvd_count {
-	int ndelonly;
+	int ndelayed;
 	bool first_do_lblk_found;
 	ext4_lblk_t first_do_lblk;
 	ext4_lblk_t last_do_lblk;
@@ -1093,10 +1093,10 @@ static void init_rsvd(struct inode *inode, ext4_lblk_t lblk,
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct rb_node *node;
 
-	rc->ndelonly = 0;
+	rc->ndelayed = 0;
 
 	/*
-	 * for bigalloc, note the first delonly block in the range has not
+	 * for bigalloc, note the first delayed block in the range has not
 	 * been found, record the extent containing the block to the left of
 	 * the region to be removed, if any, and note that there's no partial
 	 * cluster to track
@@ -1116,9 +1116,8 @@ static void init_rsvd(struct inode *inode, ext4_lblk_t lblk,
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
@@ -1141,7 +1140,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 	WARN_ON(len <= 0);
 
 	if (sbi->s_cluster_ratio == 1) {
-		rc->ndelonly += (int) len;
+		rc->ndelayed += (int) len;
 		return;
 	}
 
@@ -1151,7 +1150,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 	end = lblk + (ext4_lblk_t) len - 1;
 	end = (end > ext4_es_end(es)) ? ext4_es_end(es) : end;
 
-	/* record the first block of the first delonly extent seen */
+	/* record the first block of the first delayed extent seen */
 	if (!rc->first_do_lblk_found) {
 		rc->first_do_lblk = i;
 		rc->first_do_lblk_found = true;
@@ -1165,7 +1164,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 	 * doesn't start with it, count it and stop tracking
 	 */
 	if (rc->partial && (rc->lclu != EXT4_B2C(sbi, i))) {
-		rc->ndelonly++;
+		rc->ndelayed++;
 		rc->partial = false;
 	}
 
@@ -1175,7 +1174,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 	 */
 	if (EXT4_LBLK_COFF(sbi, i) != 0) {
 		if (end >= EXT4_LBLK_CFILL(sbi, i)) {
-			rc->ndelonly++;
+			rc->ndelayed++;
 			rc->partial = false;
 			i = EXT4_LBLK_CFILL(sbi, i) + 1;
 		}
@@ -1183,11 +1182,11 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 
 	/*
 	 * if the current cluster starts on a cluster boundary, count the
-	 * number of whole delonly clusters in the extent
+	 * number of whole delayed clusters in the extent
 	 */
 	if ((i + sbi->s_cluster_ratio - 1) <= end) {
 		nclu = (end - i + 1) >> sbi->s_cluster_bits;
-		rc->ndelonly += nclu;
+		rc->ndelayed += nclu;
 		i += nclu << sbi->s_cluster_bits;
 	}
 
@@ -1247,10 +1246,9 @@ static struct pending_reservation *__pr_tree_search(struct rb_root *root,
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
@@ -1261,33 +1259,33 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 	struct ext4_pending_tree *tree = &EXT4_I(inode)->i_pending_tree;
 	struct rb_node *node;
 	ext4_lblk_t first_lclu, last_lclu;
-	bool left_delonly, right_delonly, count_pending;
+	bool left_delayed, right_delayed, count_pending;
 	struct extent_status *es;
 
 	if (sbi->s_cluster_ratio > 1) {
 		/* count any remaining partial cluster */
 		if (rc->partial)
-			rc->ndelonly++;
+			rc->ndelayed++;
 
-		if (rc->ndelonly == 0)
+		if (rc->ndelayed == 0)
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
-				rc->ndelonly--;
-				left_delonly = true;
+				rc->ndelayed--;
+				left_delayed = true;
 				break;
 			}
 			node = rb_prev(&es->rb_node);
@@ -1295,7 +1293,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 				break;
 			es = rb_entry(node, struct extent_status, rb_node);
 		}
-		if (right_es && (!left_delonly || first_lclu != last_lclu)) {
+		if (right_es && (!left_delayed || first_lclu != last_lclu)) {
 			if (end < ext4_es_end(right_es)) {
 				es = right_es;
 			} else {
@@ -1306,8 +1304,8 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 			while (es && es->es_lblk <=
 			       EXT4_LBLK_CFILL(sbi, rc->last_do_lblk)) {
 				if (ext4_es_is_delayed(es)) {
-					rc->ndelonly--;
-					right_delonly = true;
+					rc->ndelayed--;
+					right_delayed = true;
 					break;
 				}
 				node = rb_next(&es->rb_node);
@@ -1321,21 +1319,21 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
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
@@ -1346,13 +1344,13 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
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
-				rc->ndelonly--;
+				rc->ndelayed--;
 				node = rb_next(&pr->rb_node);
 				rb_erase(&pr->rb_node, &tree->root);
 				__free_pending(pr);
@@ -1363,7 +1361,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 			}
 		}
 	}
-	return rc->ndelonly;
+	return rc->ndelayed;
 }
 
 
-- 
2.39.2


