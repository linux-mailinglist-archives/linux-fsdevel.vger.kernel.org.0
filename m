Return-Path: <linux-fsdevel+bounces-71256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41150CBB4E7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 00:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29076300EE4A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 23:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242982F83A2;
	Sat, 13 Dec 2025 23:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="h4bFIDde"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A101DF736;
	Sat, 13 Dec 2025 23:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765668768; cv=pass; b=d1pclLgwLuUJ+Q2eRA/y6URz1C7GlaUJaxGw3awpxQoyjAVoZNZwOlGQvs/YaVIqXbULgU7t8jVZ4z+UPAYEWYUwbWOBc3ZKegMErfHHCxr6oO3CvAD2pdpP9Z76xLwlqYgEUe79aasuaCmQzF/GV1GSFXATaKycBAJFVasSh34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765668768; c=relaxed/simple;
	bh=yda15wAybjMbzW36uS1GA74uu0UbQewQEPd0DVUBDKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R6QcV70eYGDMb4a0EfmC5GbZ9nNHq3Cr7Vt5qxsopfK8p1KEp+DhxRsPy8ikxo6ZQf7fUQPJZSiBB6hroVfcNmAMHdB/ou4PI/PbQZ4iqFW2wLwqwceInGObWHQX4wrFTFcgZ3c7sPCgOd/yG76+NgueVH3e2igIEkGDdnyQNFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=h4bFIDde; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1765668746; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O51OYnIpIsEoq4zbKeTZ8utrHB79jLRT5abLCcmGH8fD0mtgoBIMsgWChpZxj6huo7XpsjJ+4hWQV4b+HZiYp7MSBCRhvBC1COrXYs27hm/6/EtSKzyQZzd9kaJoN1mKfqUndEqx6CSVrUsYUDdgZwJRfrDAAJqiX/2ApjoS2lQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765668746; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7QLqhYCU7tOHd2rPWf8OqePTT79VhENalhjDKdmnmpU=; 
	b=PyYQJatwHWsmayBuaUPXQ2owURATEk8zoChcYHKp/VWzD0kM2ZgU9WRUdfJ3PKzC2zXzaHxzZt5H6RawlH89A4LSosagoNmgySN8qFKllG6EwxU/wkZjcgFu+X24blJS94U/gs09P8ncdY8TuMRLDlFO7SgIili8i1ozZ0lZ6/8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765668746;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=7QLqhYCU7tOHd2rPWf8OqePTT79VhENalhjDKdmnmpU=;
	b=h4bFIDden9Y00uw/Ml+8FBS2xqlBzb7pUhBeILKDzqikY4DzHvLI3nOP6Faw/WKR
	QmxyfZLxNBaGxrpnt8GK8W+kjdJfOvRyRCBHFMStUofMozw42pI0WbBD6iBPYPk1wEp
	iNWI3VmNyvNur8rdxguoX4qpqyHxcylrz4JlvFTA=
Received: by mx.zohomail.com with SMTPS id 176566874356911.581348542616524;
	Sat, 13 Dec 2025 15:32:23 -0800 (PST)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: zippel@linux-m68k.org,
	linux-fsdevel@vger.kernel.org,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: akpm@osdl.org,
	linux-kernel@vger.kernel.org,
	janak@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH] hfsplus: fix missing hfs_bnode_get() in hfs_bnode_create()
Date: Sun, 14 Dec 2025 05:02:15 +0530
Message-Id: <20251213233215.368558-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When hfs_bnode_create() finds an existing node in the hash table, it
returns the node without incrementing its reference count. This causes
the reference count to become inconsistent, leading to a kernel panic
when hfs_bnode_put() is later called with refcnt=0:

    BUG_ON(!atomic_read(&node->refcnt))

This occurs because hfs_bmap_alloc() calls hfs_bnode_create() expecting
to receive a node with a proper reference count, but if the node is
already in the hash table, it is returned without the required refcnt
increment.

Fix this by calling hfs_bnode_get() when returning an existing node,
ensuring the reference count is properly incremented. This follows the
same pattern as the fix in __hfs_bnode_create() (commit 152af1142878
 ("hfsplus: fix missing hfs_bnode_get() in __hfs_bnode_create")).

Note: While finding an existing node in hfs_bnode_create() is unexpected
(indicated by the pr_crit warning), we still need proper refcnt management
to prevent crashes. The warning will still fire to alert about the
underlying issue (e.g., bitmap corruption or logic error causing an
existing node to be requested for allocation).

Link: https://syzkaller.appspot.com/bug?extid=1c8ff72d0cd8a50dfeaa
Fixes: 634725a92938 ("[PATCH] hfs: cleanup HFS+ prints")
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 fs/hfsplus/bnode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 191661af9677..e098e05add43 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -629,6 +629,7 @@ struct hfs_bnode *hfs_bnode_create(struct hfs_btree *tree, u32 num)
 	if (node) {
 		pr_crit("new node %u already hashed?\n", num);
 		WARN_ON(1);
+		hfs_bnode_get(node);
 		return node;
 	}
 	node = __hfs_bnode_create(tree, num);
-- 
2.34.1


