Return-Path: <linux-fsdevel+bounces-72070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC20CDCA38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 16:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F25E0300CCFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 15:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04981346A11;
	Wed, 24 Dec 2025 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="uPUEXpZI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470F3346AD5;
	Wed, 24 Dec 2025 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766589300; cv=pass; b=YF0D8022UGUa/RiqYIHmMZv4rTMjuHCwrbAVyDaWRmM10i6DpNtV86bp1tVQ0dZzubsWavuhxo7OOTV8B1E+U09/0GOIN/HWf7KnuvXmtJ/5bHQ/vRgthxzV9gRAuau9AekpjVCuPhe0fa6NlbaTGwZYzY/mzvx4EJIUej5OHy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766589300; c=relaxed/simple;
	bh=VcIpv93cs+iZCQNZMb5+B7ptBS8sL8Okxk8HsgsphSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JrbHw81PpPrVFRK5ddP2XIYdXxSvhoDfk3NNNV+Etr435SfxayC2JARLDoNZWwIqw7KiH7N+/xTTEk5sZnPLQKT+/XPHu1t3PIZOiotENLRvV19QB3NPVXOi6JetLvwfNahmQqPQsbU3C3jqLi48fok7XX+HSEJ9GDr5A9k8efE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=uPUEXpZI; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1766589258; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G/DeQEYHrOMAYl/3ZEvGu+utIxKVXG+UCn0eXBMwXBU95Zlf5AC0mcAZuRQmkXAlT4WvilWegF4uQoY8+QxBg5M0Ond8UgbKt0PIRLhWEuWtdwilkmUlCwg0DE6+lX59P6q9qCE2O3IpR9BMHhyApbkVb2/kZujz1PBhwhJdGvA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766589258; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9UERILc8qj7pv/Dyd3F97ap3cBIOjg4t7GFeSU5EK6I=; 
	b=duOh47NQ90lEnezBrpHFfEtnPdLBzIdRYOicLsDnw5J1ydXSdudgld9N2F5+RZslBHaKFz8GofBQnBcAbpwNV4kGpT+zplOOOo1LNORxORMf6Nr6ZzRGSbOWwODs2IH0X4ms/DZuOIQN24E2XStkeEUxdOdEd2h4brXlMuR4uXs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766589258;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=9UERILc8qj7pv/Dyd3F97ap3cBIOjg4t7GFeSU5EK6I=;
	b=uPUEXpZI+MWj6t06z7EvFwOlSmKs8btpE5o2Q5u0CExK6Is1/LkoovzUusDn+Xcv
	+AkKsBoX0e31f12kz6jACuSZqzzum2oO044oY5Zj7LhG1iJuGpVn/fxyvulC0mF2n2/
	7ZfWRzr/vzOwxaZxHUQZPapGc9JCl9gSCTHNPZsw=
Received: by mx.zohomail.com with SMTPS id 1766589255667993.4447172420538;
	Wed, 24 Dec 2025 07:14:15 -0800 (PST)
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
Subject: [PATCH v2 2/2] hfsplus: return error when node already exists in hfs_bnode_create
Date: Wed, 24 Dec 2025 20:43:47 +0530
Message-Id: <20251224151347.1861896-3-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251224151347.1861896-1-shardul.b@mpiricsoftware.com>
References: <20251224151347.1861896-1-shardul.b@mpiricsoftware.com>
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
Fixes: 634725a92938 ("[PATCH] hfs: cleanup HFS+ prints")
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 v2:
 - Return ERR_PTR(-EEXIST) for already-hashed nodes, per Slava's suggestion.
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


