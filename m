Return-Path: <linux-fsdevel+bounces-72210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 170BACE82D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 21:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 114663018943
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 20:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAC22E6CAA;
	Mon, 29 Dec 2025 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="izfa6ADe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F3621A447;
	Mon, 29 Dec 2025 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767041414; cv=pass; b=S3SaDMMtse8s6MS/x+dDkiqSloRDaPLpFZ1qJi6Wjqk1Vr2whOyZ4kBFh9hEW7rRQztyWKAIum8S6YCUYCK83Cz0mHTJv15ShxYDyWKw7Drggsnld7lF9EpHxTiGMC1IXMRy8dzJTnwCgWBFxhPBtuie8w+ECVZsb5cw6w3Tqlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767041414; c=relaxed/simple;
	bh=Y3act2NuFjb8W1a4upCsma+y1jTtiUIJgtkptctT/0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hk9eEAuIZ3unjubGvwmyx9EQ/xbpSKs1211+cufd+cKMEGtFRKQY9mrGjfqIeH+G5ehEkFqmk7T3HWYnQVnhkVaAbMVarnJT2RcvrKgWveK/YiAfkp/NLtltNl/OW5GLS19Ds3l+jEq8HLT29ctiqDlqyMwA0/clpFUzxrawQwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=izfa6ADe; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1767041390; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Hv6CGLRDl+d2dSC6RZcX61Qo+/+lJSYru0ftv3FTJ/ItjQrPlsHeLbOxMa6geRc10UnjJFG2liq0xF7Qcgzkeh6kPsRTAu3YVMJvd+4KUEI8r0l8CHNnyagTT4jk0zSFANNBgGd1Rqd20GtOBpupex6R+cyg3kVDLDrSYtF0yUk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767041390; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fmghGag9NmzzfaBGoCxzAcUoBRUzA960YzhyQ/Qa3lE=; 
	b=VLqBGQ9PcBqDRI8p0ONb5N+Z9J6HJKkHua7nGClcRqKJ9TvzaDLBhO5yEENXyjZKfZ5JlMAHp70IQVKrGidVTW+i0mZsDJYtNxMZErFQHk2KESMoTyZyoX5dVnhzopxNQw/DZnev+7v0DlP6Mn8JLySOR3bOB/nUEJlP6z/rWvQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767041390;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=fmghGag9NmzzfaBGoCxzAcUoBRUzA960YzhyQ/Qa3lE=;
	b=izfa6ADefJSClyPNAjcCKLndoAO+aeLx+giWkwNIVpJkT9cyB+SvmQ32Ydk8YhXA
	lEQolIREeZxhh6I9MrZROLO4A6pgOhp69aq66/FG7H/NHAxPtjBzxcFesAZVi6btXCb
	ooiuzgguo83mzRpXMg3QrW10PAkNEy3Jdwn8RHXQ=
Received: by mx.zohomail.com with SMTPS id 1767041387182538.265209058355;
	Mon, 29 Dec 2025 12:49:47 -0800 (PST)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: slava@dubeyko.com,
	zippel@linux-m68k.org,
	linux-fsdevel@vger.kernel.org,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: akpm@osdl.org,
	linux-kernel@vger.kernel.org,
	janak@mpiricsoftware.com,
	shardulsb08@gmail.com,
	stable@vger.kernel.org,
	syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH v3] hfsplus: return error when node already exists in hfs_bnode_create
Date: Tue, 30 Dec 2025 02:19:38 +0530
Message-Id: <20251229204938.1907089-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When hfs_bnode_create() finds that a node is already hashed (which should
not happen in normal operation), it currently returns the existing node
without incrementing its reference count. This causes a reference count
inconsistency that leads to a kernel panic when the node is later freed
in hfs_bnode_put():

    kernel BUG at fs/hfsplus/bnode.c:676!
    BUG_ON(!atomic_read(&node->refcnt))

This scenario can occur when hfs_bmap_alloc() attempts to allocate a node
that is already in use (e.g., when node 0's bitmap bit is incorrectly
unset), or due to filesystem corruption.

Returning an existing node from a create path is not normal operation.

Fix this by returning ERR_PTR(-EEXIST) instead of the node when it's
already hashed. This properly signals the error condition to callers,
which already check for IS_ERR() return values.

Reported-by: syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=1c8ff72d0cd8a50dfeaa
Link: https://lore.kernel.org/all/784415834694f39902088fa8946850fc1779a318.camel@ibm.com/
Fixes: 634725a92938 ("[PATCH] hfs: cleanup HFS+ prints")
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
v3 changes:
  - This is posted standalone as discussed in the v2 thread.
v2 changes:
  - Implement Slava's suggestion: return ERR_PTR(-EEXIST) for already-hashed nodes.
  - Keep the node-0 allocation guard as a minimal, targeted hardening measure.

 fs/hfsplus/bnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 191661af9677..250a226336ea 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -629,7 +629,7 @@ struct hfs_bnode *hfs_bnode_create(struct hfs_btree *tree, u32 num)
 	if (node) {
 		pr_crit("new node %u already hashed?\n", num);
 		WARN_ON(1);
-		return node;
+		return ERR_PTR(-EEXIST);
 	}
 	node = __hfs_bnode_create(tree, num);
 	if (!node)
-- 
2.34.1


