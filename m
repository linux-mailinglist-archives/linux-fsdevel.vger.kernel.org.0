Return-Path: <linux-fsdevel+bounces-71230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE33CBA2FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 03:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EF0A3002B92
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 02:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5419248F69;
	Sat, 13 Dec 2025 02:22:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC7D242D6A;
	Sat, 13 Dec 2025 02:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765592554; cv=none; b=FjlbOWh++T9+h7T19zxST1pi8vmkOvN5LZqaf1tHouNTUpXbcbaK5b6Iz9M1EJ7dS7KQGnYyFlOxoOdlFvtbRwdsxRFnkdFlRZ4pWwTz75+ke9dkZzqkCDySMhLSgr5LCnPTq1iArmylT/G07HCvzlnBMSVa7ToNp0VEaYexwas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765592554; c=relaxed/simple;
	bh=7Cs1pr7wAo/xMoCnHKq12fNe9CDnAQGWhwmIwaIGDq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwInMMdo2oQ9OWS+Ud5lK1t5OS0LfUanePqhE2fzOOt7Ocr8WiCCXzhepwsUHwB4IQPqTTCgpDkwWcl2oYmKX1Ve59WRbupKmhHcC3Yrk0qixuPcGgcfBU8WyepGsxmINRQmgDnA5lLewtD8W4dJCnrt0Z0ZoqfUGHpSZrU76Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dSqpT5pzBzYQtvd;
	Sat, 13 Dec 2025 10:22:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3D40C1A0A29;
	Sat, 13 Dec 2025 10:22:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgA3F1HTzTxpFXQ7Bg--.63968S11;
	Sat, 13 Dec 2025 10:22:29 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com,
	yukuai@fnnas.com
Subject: [PATCH -next 7/7] ext4: remove EXT4_GET_BLOCKS_IO_CREATE_EXT
Date: Sat, 13 Dec 2025 10:20:08 +0800
Message-ID: <20251213022008.1766912-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251213022008.1766912-1-yi.zhang@huaweicloud.com>
References: <20251213022008.1766912-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA3F1HTzTxpFXQ7Bg--.63968S11
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWUGw1UGF1xAryfXr1UJrb_yoWrGrW5p3
	sxAF1xGr4jq34j93yxCa1UXr12k3W8KF47ur4rJrWF9a43Ar1fKF10ya4FyFWFgFW8Za1Y
	qFWrK34UJa93GrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUQFxUUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

We do not use EXT4_GET_BLOCKS_IO_CREATE_EXT or split extents before
submitting I/O; therefore, remove the related code.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    |  9 ---------
 fs/ext4/extents.c | 29 -----------------------------
 fs/ext4/inode.c   | 11 -----------
 3 files changed, 49 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9a71357f192d..174c51402864 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -707,15 +707,6 @@ enum {
 	 * found an unwritten extent, we need to split it.
 	 */
 #define EXT4_GET_BLOCKS_SPLIT_NOMERGE		0x0008
-	/*
-	 * Caller is from the dio or dioread_nolock buffered IO, reqest to
-	 * create an unwritten extent if it does not exist or split the
-	 * found unwritten extent. Also do not merge the newly created
-	 * unwritten extent, io end will convert unwritten to written,
-	 * and try to merge the written extent.
-	 */
-#define EXT4_GET_BLOCKS_IO_CREATE_EXT		(EXT4_GET_BLOCKS_SPLIT_NOMERGE|\
-					 EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT)
 	/* Convert unwritten extent to initialized. */
 #define EXT4_GET_BLOCKS_CONVERT			0x0010
 	/* Eventual metadata allocation (due to growing extent tree)
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c98f7c5482b4..c7c66ab825e7 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3925,34 +3925,6 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	trace_ext4_ext_handle_unwritten_extents(inode, map, flags,
 						*allocated, newblock);
 
-	/* get_block() before submitting IO, split the extent */
-	if (flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE) {
-		int depth;
-
-		path = ext4_split_convert_extents(handle, inode, map, path,
-						  flags, allocated);
-		if (IS_ERR(path))
-			return path;
-		/*
-		 * shouldn't get a 0 allocated when splitting an extent unless
-		 * m_len is 0 (bug) or extent has been corrupted
-		 */
-		if (unlikely(*allocated == 0)) {
-			EXT4_ERROR_INODE(inode,
-					 "unexpected allocated == 0, m_len = %u",
-					 map->m_len);
-			err = -EFSCORRUPTED;
-			goto errout;
-		}
-		/* Don't mark unwritten if the extent has been zeroed out. */
-		path = ext4_find_extent(inode, map->m_lblk, path, flags);
-		if (IS_ERR(path))
-			return path;
-		depth = ext_depth(inode);
-		if (ext4_ext_is_unwritten(path[depth].p_ext))
-			map->m_flags |= EXT4_MAP_UNWRITTEN;
-		goto out;
-	}
 	/* IO end_io complete, convert the filled extent to written */
 	if (flags & EXT4_GET_BLOCKS_CONVERT) {
 		path = ext4_convert_unwritten_extents_endio(handle, inode,
@@ -4006,7 +3978,6 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 		goto errout;
 	}
 
-out:
 	map->m_flags |= EXT4_MAP_NEW;
 map_out:
 	map->m_flags |= EXT4_MAP_MAPPED;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 39348ee46e5c..fa579e857baf 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -588,7 +588,6 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
 static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
 				  struct ext4_map_blocks *map, int flags)
 {
-	struct extent_status es;
 	unsigned int status;
 	int err, retval = 0;
 
@@ -649,16 +648,6 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
 			return err;
 	}
 
-	/*
-	 * If the extent has been zeroed out, we don't need to update
-	 * extent status tree.
-	 */
-	if (flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE &&
-	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, &map->m_seq)) {
-		if (ext4_es_is_written(&es))
-			return retval;
-	}
-
 	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
 			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
 	ext4_es_insert_extent(inode, map->m_lblk, map->m_len, map->m_pblk,
-- 
2.46.1


