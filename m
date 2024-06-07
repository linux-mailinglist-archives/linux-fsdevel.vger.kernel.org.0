Return-Path: <linux-fsdevel+bounces-21187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694DA900345
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE42AB2617B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BC5199258;
	Fri,  7 Jun 2024 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="CqPDluEv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA07B1990A5;
	Fri,  7 Jun 2024 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762590; cv=none; b=IB/v3bGB6lMNsqdMk2YKUCky7SX8ywHze4JCnlams4BOtElU+7Q8oRKPjSobQ5Vy93L4eTmxsgmuboR4J7nvrdQoDy3wRg5i6eq2PKXUBnqKuW/C44MF9t7/FcWeqfU2EPM+iu0DEHNouiy1NwnqxzYE8E6LRb2XJqpNid2wNA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762590; c=relaxed/simple;
	bh=Yacxdvk9agwC7dm+tRdWYE6QBG5sEvZ2POWkQC00ekM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7jAzH+08Lbtny1i+3wBVFzSTGIapVyIIAq6YU0quonOYZWubObYvawk6aNi69IrZIoXgROFGb27MAY9fTepQURxPxPCOhPUIOhUhmNHT7fD/+L8e61d6CnUIOmu8TXJKdreOYkhEXL6FEAHqbnbCoydoOE40REAjnrTbKpiDUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=CqPDluEv; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 0C4642111;
	Fri,  7 Jun 2024 12:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762113;
	bh=6qiKymjDgGJvobrjtMHFM+VNPPdAqGv/F7p+4NzzYnc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=CqPDluEv97gyHQjiNU40B2RXjnBcpIgbqd32An5eDDDzb0PzIbMNNYKdXgQFN9D3b
	 8c1AJjlIQY+f5xlqJ9ci/ooLnFiy/aJxAIlGag9/DComDOzkQbf7b+UqS2XTJj3+E+
	 SbYSwrRKT/XrB1iwP9o+xaZNYjxFYRzCzLu/nAOs=
Received: from ntfs3vm.paragon-software.com (192.168.211.95) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 7 Jun 2024 15:16:26 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 18/18] fs/ntfs3: Add some comments
Date: Fri, 7 Jun 2024 15:15:48 +0300
Message-ID: <20240607121548.18818-19-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
References: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/fslog.c | 14 ++++++--------
 fs/ntfs3/inode.c |  4 ++--
 fs/ntfs3/super.c |  5 ++---
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 389fce092d6d..21c23f6bd7f6 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -4107,7 +4107,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 
 	/* Allocate and Read the Transaction Table. */
 	if (!rst->transact_table_len)
-		goto check_dirty_page_table;
+		goto check_dirty_page_table; /* reduce tab pressure. */
 
 	t64 = le64_to_cpu(rst->transact_table_lsn);
 	err = read_log_rec_lcb(log, t64, lcb_ctx_prev, &lcb);
@@ -4147,7 +4147,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 check_dirty_page_table:
 	/* The next record back should be the Dirty Pages Table. */
 	if (!rst->dirty_pages_len)
-		goto check_attribute_names;
+		goto check_attribute_names; /* reduce tab pressure. */
 
 	t64 = le64_to_cpu(rst->dirty_pages_table_lsn);
 	err = read_log_rec_lcb(log, t64, lcb_ctx_prev, &lcb);
@@ -4183,7 +4183,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 
 	/* Convert Ra version '0' into version '1'. */
 	if (rst->major_ver)
-		goto end_conv_1;
+		goto end_conv_1; /* reduce tab pressure. */
 
 	dp = NULL;
 	while ((dp = enum_rstbl(dptbl, dp))) {
@@ -4203,8 +4203,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	 * remembering the oldest lsn values.
 	 */
 	if (sbi->cluster_size <= log->page_size)
-		goto trace_dp_table;
-
+		goto trace_dp_table; /* reduce tab pressure. */
 	dp = NULL;
 	while ((dp = enum_rstbl(dptbl, dp))) {
 		struct DIR_PAGE_ENTRY *next = dp;
@@ -4225,7 +4224,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 check_attribute_names:
 	/* The next record should be the Attribute Names. */
 	if (!rst->attr_names_len)
-		goto check_attr_table;
+		goto check_attr_table; /* reduce tab pressure. */
 
 	t64 = le64_to_cpu(rst->attr_names_lsn);
 	err = read_log_rec_lcb(log, t64, lcb_ctx_prev, &lcb);
@@ -4257,7 +4256,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 check_attr_table:
 	/* The next record should be the attribute Table. */
 	if (!rst->open_attr_len)
-		goto check_attribute_names2;
+		goto check_attribute_names2; /* reduce tab pressure. */
 
 	t64 = le64_to_cpu(rst->open_attr_table_lsn);
 	err = read_log_rec_lcb(log, t64, lcb_ctx_prev, &lcb);
@@ -4546,7 +4545,6 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 			}
 		}
 		goto next_log_record_analyze;
-		;
 	}
 
 	case OpenNonresidentAttribute:
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 46130cbd08d4..374b10e5a6b7 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -18,7 +18,7 @@
 #include "ntfs_fs.h"
 
 /*
- * ntfs_read_mft - Read record and parses MFT.
+ * ntfs_read_mft - Read record and parse MFT.
  */
 static struct inode *ntfs_read_mft(struct inode *inode,
 				   const struct cpu_str *name,
@@ -1557,7 +1557,7 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 
 		/*
 		 * Below function 'ntfs_save_wsl_perm' requires 0x78 bytes.
-		 * It is good idea to keep extened attributes resident.
+		 * It is good idea to keep extended attributes resident.
 		 */
 		if (asize + t16 + 0x78 + 8 > sbi->record_size) {
 			CLST alen;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 6c9e5fe8ce81..e70ba2370c6e 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1205,7 +1205,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	/*
 	 * Load $Volume. This should be done before $LogFile
-	 * 'cause 'sbi->volume.ni' is used 'ntfs_set_state'.
+	 * 'cause 'sbi->volume.ni' is used in 'ntfs_set_state'.
 	 */
 	ref.low = cpu_to_le32(MFT_REC_VOL);
 	ref.seq = cpu_to_le16(MFT_REC_VOL);
@@ -1866,8 +1866,7 @@ static int __init init_ntfs_fs(void)
 
 	ntfs_inode_cachep = kmem_cache_create(
 		"ntfs_inode_cache", sizeof(struct ntfs_inode), 0,
-		(SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT),
-		init_once);
+		(SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT), init_once);
 	if (!ntfs_inode_cachep) {
 		err = -ENOMEM;
 		goto out1;
-- 
2.34.1


