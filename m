Return-Path: <linux-fsdevel+bounces-78823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yM4UIrreomkV7gQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 13:25:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E13DC1C2EED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 13:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A66830A1544
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 12:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEDE43CED1;
	Sat, 28 Feb 2026 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="VVGWNGjT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9A6423141;
	Sat, 28 Feb 2026 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772281486; cv=pass; b=lZMId6c0yOsSKjdCOZH+J4V4BkiQ4rC+NfWCCny/Dr8vDmlXftWmrKfjfmvbsBjHcbCzR0pdS6iKhYcydB2GAkjcTsUE+1lWRiQz7A9oPd8qgXqjMHWo/lslfQc0OA/tt42VNaNL0TdpyW3LiY/T0nN8IuuFlxeJWvVhOuVrTqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772281486; c=relaxed/simple;
	bh=D8IQ/dSgkS8q4qDP/WHoXvMPzPsf0DvQXi4zEMgXOh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G6XEUqrjP8nTO/m8y8QVvps2JVgT7edLjGnrS4CsPRPVvQTB4zHpSduZu8Sz3l0PJz2ItggK08Ebo979dOzeenCq9Rp4pcl1rc+8gOw5XN6EWaiu2+p8IkWUtmD4H901epYQLb14bTxVladfqBaLNSmQvGtIhymOyCWlMGhywww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=VVGWNGjT; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1772281403; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EHKeQ/g28D3PcojRPEv626YXrTDhIbJ2/copoExbyLCwp9nF+dfbLVP4Ep2iGniW5ypV+uxd+pDhHePVIkYfpLklVAw4iNDKPx+KrYj1iDFo5GIx8wMHZkxsNuwKHnYXfb0cfRJRp31aLvQQXyvGnO5kFdcpviBTzCxwb/ZKeRo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772281403; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pn9CST5OW722hXNukxq5ItUixPhC81Qjbu1Drjb5oJY=; 
	b=DXPBHn9bM3n9njs53eyJNmIuLKDYCovgr+otc6ZVMO+fNa/+XhA9KHoOjlo4pj69rF0nwG3mYdrfntMZWEQBO9NzkIi3pjQyqyNzL97BWdfgqEwZ9jnKzAHn4JIowiGS4ylLSUHrfKQfJlXmW7qAs7w+sIp9nLVgk1TcZfj2aOU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772281403;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=pn9CST5OW722hXNukxq5ItUixPhC81Qjbu1Drjb5oJY=;
	b=VVGWNGjT1y/4T2VEg9vscuMT52Z+RRhT8UqZRZlqHlDfe+EfRgmkc03itd3/a8nG
	wWMhRQ37uJMZCtD1DPMz1+U8cU1EW1A1xhIN4OYrPCzBydrW1aQc6RLzRTGzKbw99M7
	xxcBGmRwSqKTLmaO/mWy1Cy88x6PDIWd8O4axB4I=
Received: by mx.zohomail.com with SMTPS id 1772281401429696.177219428546;
	Sat, 28 Feb 2026 04:23:21 -0800 (PST)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: janak@mpiricsoftware.com,
	janak@mpiric.us,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com
Subject: [PATCH v5 2/2] hfsplus: validate b-tree node 0 bitmap at mount time
Date: Sat, 28 Feb 2026 17:53:05 +0530
Message-Id: <20260228122305.1406308-3-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260228122305.1406308-1-shardul.b@mpiricsoftware.com>
References: <20260228122305.1406308-1-shardul.b@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mpiricsoftware.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mpiricsoftware.com:s=mpiric];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mpiricsoftware.com,mpiric.us,gmail.com,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78823-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardul.b@mpiricsoftware.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mpiricsoftware.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mpiricsoftware.com:mid,mpiricsoftware.com:dkim,mpiricsoftware.com:email]
X-Rspamd-Queue-Id: E13DC1C2EED
X-Rspamd-Action: no action

Syzkaller reported an issue with corrupted HFS+ images where the b-tree
allocation bitmap indicates that the header node (Node 0) is free. Node 0
must always be allocated as it contains the b-tree header record and the
allocation bitmap itself. Violating this invariant leads to allocator
corruption, which cascades into kernel panics or undefined behavior when
the filesystem attempts to allocate blocks.

Prevent trusting a corrupted allocator state by adding a validation check
during hfs_btree_open(). Using the newly introduced hfs_bmap_test_bit()
helper, verify that the MSB of the first bitmap byte (representing Node 0)
is marked as allocated.

If corruption is detected (either structurally invalid map records or an
illegally cleared bit), print a warning identifying the specific
corrupted tree and force the filesystem to mount read-only (SB_RDONLY).
This prevents kernel panics from corrupted images while enabling data
recovery.

Reported-by: syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=1c8ff72d0cd8a50dfeaa
Link: https://lore.kernel.org/all/54dc9336b514fb10547e27c7d6e1b8b967ee2eda.camel@ibm.com/
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 fs/hfsplus/btree.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 87650e23cd65..ee1edb03a38e 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -239,15 +239,31 @@ static int hfs_bmap_clear_bit(struct hfs_bnode *node, u32 bit_idx)
 	return 0;
 }
 
+static const char *hfs_btree_name(u32 cnid)
+{
+	static const char * const tree_names[] = {
+		[HFSPLUS_EXT_CNID] = "Extents",
+		[HFSPLUS_CAT_CNID] = "Catalog",
+		[HFSPLUS_ATTR_CNID] = "Attributes",
+	};
+
+	if (cnid < ARRAY_SIZE(tree_names) && tree_names[cnid])
+		return tree_names[cnid];
+
+	return "Unknown";
+}
+
 /* Get a reference to a B*Tree and do some initial checks */
 struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 {
 	struct hfs_btree *tree;
 	struct hfs_btree_header_rec *head;
 	struct address_space *mapping;
+	struct hfs_bnode *node;
 	struct inode *inode;
 	struct page *page;
 	unsigned int size;
+	int res;
 
 	tree = kzalloc_obj(*tree);
 	if (!tree)
@@ -352,6 +368,26 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 
 	kunmap_local(head);
 	put_page(page);
+
+	node = hfs_bnode_find(tree, HFSPLUS_TREE_HEAD);
+	if (IS_ERR(node))
+		goto free_inode;
+
+	res = hfs_bmap_test_bit(node, 0);
+	if (res < 0) {
+		pr_warn("(%s): %s Btree (cnid 0x%x) map record invalid/corrupted, forcing read-only.\n",
+				sb->s_id, hfs_btree_name(id), id);
+		pr_warn("Run fsck.hfsplus to repair.\n");
+		sb->s_flags |= SB_RDONLY;
+	} else if (res == 0) {
+		pr_warn("(%s): %s Btree (cnid 0x%x) bitmap corruption detected, forcing read-only.\n",
+				sb->s_id, hfs_btree_name(id), id);
+		pr_warn("Run fsck.hfsplus to repair.\n");
+		sb->s_flags |= SB_RDONLY;
+	}
+
+	hfs_bnode_put(node);
+
 	return tree;
 
  fail_page:
-- 
2.34.1


