Return-Path: <linux-fsdevel+bounces-5310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E8E80A34C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 13:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02181C20916
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A441C6A7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="pPxkeGcj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4599910CF
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 03:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1702034493;
	bh=FbtnXJicbS+oXRm4DcyjEtI+97mlthN7LzlIHvYY+hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pPxkeGcjq3akbSuSGvP/tzQCHZD3aPhvB/gZPMmzgFIn5Ez1bhoTrYDUu2PlxIBLb
	 xSt1Rt4tzaLq/O2oIcvzqPxs/Wf5Mn/tt0NpX9RCOOES6Oap867xSSNkg3TnVNZ5pG
	 nZyEJlodqlrHMMoR8JgjcytIZ6YevhqmUj7f2UnI=
Received: from localhost.localdomain ([180.164.182.58])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 530B9A94; Fri, 08 Dec 2023 19:20:48 +0800
X-QQ-mid: xmsmtpt1702034490t1n49dn22
Message-ID: <tencent_D92E716001318DB6D30497F5D434BF8C7407@qq.com>
X-QQ-XMAILINFO: MW5hkHoBpWXydSCNNW9tJ3OH4KBnjaSG7SiQBr9BEDJ/XLaeo0+vMPDYMAaeLT
	 HuAc8ktumaW4qPBVumzMQr073Xsx8QHLHK25B+k3xCz5um3LDEztfenuZkE5FvR6/2KCd5z65nde
	 atF+/9PQ8zkPq5wxvbJcrQBxZNJQaTtUJ6kdohO+Z3ifGq07CIETv7R/13+xicbzqdnfllHLFUIB
	 ZKKpM+4ltc5qDyAowN3lBsnft6UorYA8cznjJxR9QwPgU7GoY2byi+Og9CArVaqrmWo7HIyugrJA
	 JPfgUSSvUFYKmRq91k94OCPSRmcIxSjsYAJjUh624ONmMxRIlWf2olPHWKUrKPBsEKX6HkXEdrf1
	 t7kCVk54qqSOKWZ9kh6zJEsTlrbNBosYESWy2FLIkmnjtqKyNyRxFVdHDlBWR8RnDavUq2Px73JZ
	 NOX22cStQmYgwFcnOxLno1nIE5l9a5zFn2qxfPanOwcv+CsX22VNtLkJvgmlU8h3hq/m+hsDnK0Z
	 uogmtH/nfXELhHrZTBpvCqhj0IL24FJUne3j59HJNqSRLPPxXvozTBokcfyq9KqoQoka+7/MR2sx
	 xrtuDPo1eZjmbh8W3xpE1CpMAUKMBmCwkmO/9xWQBdRwy0g0IfwIIJIvwxdzH02P3+P40revydgc
	 cFLsVYKG8baZ0u362WroSUVZ7knlhhblzv0c+xPDjBuYnuXPFKYUHfaBkwb/FDWahT+ujvCrnoLS
	 XJpOiKHirHwkwlztC1PKrJoXA0fINat/3pb9e4XQHC93m0cY62ATeffW/m4/ZwxqvwkO4h7xmnk8
	 IBHXgU8pY/tukzPc2fkEVjbudpiUFQWUT0T6IVHY2rbY6esNM9DaR0t4TBisZ+pWOTFYB6oYn5Pm
	 HeYdii4DxUt1SW8r2VpUIEZYjPmna1SAwqHPHBgOjE09Ha8Z4Kmp0z2tCRCQXdW6PTrfK4283DRv
	 V9d8Pr6ntes0kp2nxWCtqHYzzEFF9yx36YAK4Rcq11jj30d5eC2wjZioYdur0Z
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: yuezhang.mo@foxmail.com
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: linux-fsdevel@vger.kernel.org,
	Andy.Wu@sony.com,
	wataru.aoyama@sony.com,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v1 03/11] exfat: covert exfat_find_empty_entry() to use dentry cache
Date: Fri,  8 Dec 2023 19:23:12 +0800
X-OQ-MSGID: <20231208112318.1135649-4-yuezhang.mo@foxmail.com>
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

Before this conversion, each dentry traversed needs to be read
from the storage device or page cache. There are at least 16
dentries in a sector. This will result in frequent page cache
searches.

After this conversion, if all directory entries in a sector are
used, the sector only needs to be read once.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Andy Wu <Andy.Wu@sony.com>
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
---
 fs/exfat/namei.c | 111 ++++++++++++++++++++---------------------------
 1 file changed, 47 insertions(+), 64 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 9c549fd11fc8..1f662296f2fa 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -204,21 +204,16 @@ const struct dentry_operations exfat_utf8_dentry_ops = {
 	.d_compare	= exfat_utf8_d_cmp,
 };
 
-/* used only in search empty_slot() */
-#define CNT_UNUSED_NOHIT        (-1)
-#define CNT_UNUSED_HIT          (-2)
 /* search EMPTY CONTINUOUS "num_entries" entries */
 static int exfat_search_empty_slot(struct super_block *sb,
 		struct exfat_hint_femp *hint_femp, struct exfat_chain *p_dir,
-		int num_entries)
+		int num_entries, struct exfat_entry_set_cache *es)
 {
-	int i, dentry, num_empty = 0;
+	int i, dentry, ret;
 	int dentries_per_clu;
-	unsigned int type;
 	struct exfat_chain clu;
-	struct exfat_dentry *ep;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	struct buffer_head *bh;
+	int total_entries = EXFAT_CLU_TO_DEN(p_dir->size, sbi);
 
 	dentries_per_clu = sbi->dentries_per_clu;
 
@@ -231,7 +226,7 @@ static int exfat_search_empty_slot(struct super_block *sb,
 		 * Otherwise, and if "dentry + hint_famp->count" is also equal
 		 * to "p_dir->size * dentries_per_clu", it means ENOSPC.
 		 */
-		if (dentry + hint_femp->count == p_dir->size * dentries_per_clu &&
+		if (dentry + hint_femp->count == total_entries &&
 		    num_entries > hint_femp->count)
 			return -ENOSPC;
 
@@ -242,69 +237,41 @@ static int exfat_search_empty_slot(struct super_block *sb,
 		dentry = 0;
 	}
 
-	while (clu.dir != EXFAT_EOF_CLUSTER) {
+	while (dentry + num_entries < total_entries &&
+	       clu.dir != EXFAT_EOF_CLUSTER) {
 		i = dentry & (dentries_per_clu - 1);
 
-		for (; i < dentries_per_clu; i++, dentry++) {
-			ep = exfat_get_dentry(sb, &clu, i, &bh);
-			if (!ep)
-				return -EIO;
-			type = exfat_get_entry_type(ep);
-			brelse(bh);
-
-			if (type == TYPE_UNUSED || type == TYPE_DELETED) {
-				num_empty++;
-				if (hint_femp->eidx == EXFAT_HINT_NONE) {
-					hint_femp->eidx = dentry;
-					hint_femp->count = CNT_UNUSED_NOHIT;
-					exfat_chain_set(&hint_femp->cur,
-						clu.dir, clu.size, clu.flags);
-				}
-
-				if (type == TYPE_UNUSED &&
-				    hint_femp->count != CNT_UNUSED_HIT)
-					hint_femp->count = CNT_UNUSED_HIT;
+		ret = exfat_get_empty_dentry_set(es, sb, &clu, i, num_entries);
+		if (ret < 0)
+			return ret;
+		else if (ret == 0)
+			return dentry;
+
+		dentry += ret;
+		i += ret;
+
+		while (i >= dentries_per_clu) {
+			if (clu.flags == ALLOC_NO_FAT_CHAIN) {
+				if (--clu.size > 0)
+					clu.dir++;
+				else
+					clu.dir = EXFAT_EOF_CLUSTER;
 			} else {
-				if (hint_femp->eidx != EXFAT_HINT_NONE &&
-				    hint_femp->count == CNT_UNUSED_HIT) {
-					/* unused empty group means
-					 * an empty group which includes
-					 * unused dentry
-					 */
-					exfat_fs_error(sb,
-						"found bogus dentry(%d) beyond unused empty group(%d) (start_clu : %u, cur_clu : %u)",
-						dentry, hint_femp->eidx,
-						p_dir->dir, clu.dir);
+				if (exfat_get_next_cluster(sb, &clu.dir))
 					return -EIO;
-				}
-
-				num_empty = 0;
-				hint_femp->eidx = EXFAT_HINT_NONE;
 			}
 
-			if (num_empty >= num_entries) {
-				/* found and invalidate hint_femp */
-				hint_femp->eidx = EXFAT_HINT_NONE;
-				return (dentry - (num_entries - 1));
-			}
-		}
-
-		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
-			if (--clu.size > 0)
-				clu.dir++;
-			else
-				clu.dir = EXFAT_EOF_CLUSTER;
-		} else {
-			if (exfat_get_next_cluster(sb, &clu.dir))
-				return -EIO;
+			i -= dentries_per_clu;
 		}
 	}
 
-	hint_femp->eidx = p_dir->size * dentries_per_clu - num_empty;
-	hint_femp->count = num_empty;
-	if (num_empty == 0)
+	hint_femp->eidx = dentry;
+	hint_femp->count = 0;
+	if (dentry == total_entries || clu.dir == EXFAT_EOF_CLUSTER)
 		exfat_chain_set(&hint_femp->cur, EXFAT_EOF_CLUSTER, 0,
 				clu.flags);
+	else
+		hint_femp->cur = clu;
 
 	return -ENOSPC;
 }
@@ -324,8 +291,9 @@ static int exfat_check_max_dentries(struct inode *inode)
 /* find empty directory entry.
  * if there isn't any empty slot, expand cluster chain.
  */
-static int exfat_find_empty_entry(struct inode *inode,
-		struct exfat_chain *p_dir, int num_entries)
+static int __exfat_find_empty_entry(struct inode *inode,
+		struct exfat_chain *p_dir, int num_entries,
+		struct exfat_entry_set_cache *es)
 {
 	int dentry;
 	unsigned int ret, last_clu;
@@ -344,7 +312,7 @@ static int exfat_find_empty_entry(struct inode *inode,
 	}
 
 	while ((dentry = exfat_search_empty_slot(sb, &hint_femp, p_dir,
-					num_entries)) < 0) {
+					num_entries, es)) < 0) {
 		if (dentry == -EIO)
 			break;
 
@@ -414,6 +382,21 @@ static int exfat_find_empty_entry(struct inode *inode,
 	return dentry;
 }
 
+static int exfat_find_empty_entry(struct inode *inode,
+		struct exfat_chain *p_dir, int num_entries)
+{
+	int entry;
+	struct exfat_entry_set_cache es;
+
+	entry = __exfat_find_empty_entry(inode, p_dir, num_entries, &es);
+	if (entry < 0)
+		return entry;
+
+	exfat_put_dentry_set(&es, false);
+
+	return entry;
+}
+
 /*
  * Name Resolution Functions :
  * Zero if it was successful; otherwise nonzero.
-- 
2.25.1


