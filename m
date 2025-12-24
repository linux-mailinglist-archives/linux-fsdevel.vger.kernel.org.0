Return-Path: <linux-fsdevel+bounces-72068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CBACDCA2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 16:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44D71301D5BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 15:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47494346FB5;
	Wed, 24 Dec 2025 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="P+KWVcQ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0D230F540;
	Wed, 24 Dec 2025 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766589257; cv=pass; b=Q4iLiSpktBsX4kLHwr8rIou9OFL3fv5AHPVDwnexkqaORFahBuAqm27M719xorpymM9KREeIQ8X5/5RFFhqi8VQD5biwgs6xNe2ZEunS9S5tIKQJ/toXRiltu2voEkmAoojbEJLSOdSDXmhKVNd5LsnXT5EwHwqa2U0HkLTdVEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766589257; c=relaxed/simple;
	bh=rbqc3UCFBSrz08h4aUFgyc8suMzsG2WeJiXabhgDrVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h3xG3441qZfs4Sb4tcfjs/PHPEVvJVuBTou4zpuBAnrJVoFvMCmZH43GAzL7A0WO1Xc5vp6mgXXtUO00U5cA/v7Q937snBNFxlX/hf0vbDg+z51l/yBgxw+Tjdl78lFgNDx8AGJrPQ0QMr5JnQn39JNPsY3Fkq9wlrpyVTMqy7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=P+KWVcQ1; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1766589238; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QFM6xA69fBlLK8q0d0afGufRoW3kM+ZRRwyL62hgY21pXNFiD3gVn2x1uca7cVUe8FI0QDUdUy82RsgApw1ivJ/fvmqmTNhOyxxpfAUSbbTcqNeN0ZI9hvcTEJxI8c4I0PsNVcVokTmf/VXdAozknTT4uwZcoNQBpgiyu9Aq+oA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766589238; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AyGDzezrDL1P/4MnEhokCLVuv3bZMX9RfvNUzF4CL3I=; 
	b=jr5LDs1/1rWiP7hBskGE2UFUBXvn2onODYVsxzhE93qHnJLju0m3ESdVyBM+sfmzij829jsRroXHQ0Lbg/mo642V11aWe8QQz6C+kDMMFkpJV/KH0/6zjpmwcXeNosOoVieJmJ3FAZy8szOs4uEhVNETFbw79de7/WvIZSRIhp0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766589238;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=AyGDzezrDL1P/4MnEhokCLVuv3bZMX9RfvNUzF4CL3I=;
	b=P+KWVcQ1KDB0SvODC/Yd4imdnPKLf2BRFWi5T/1t3zx75Ct9ImZiqmCXPs1uFYRr
	cAm3COA6/ZTtw170LOECzlDHXknE22LYubxcCa9UvCfs5lSvWfk0clxQacOy7sG+OZJ
	Mwr6epYEkcJFDUTKVx92RkTZF6PZymyBLjdlFq/4=
Received: by mx.zohomail.com with SMTPS id 1766589236772610.7105812564735;
	Wed, 24 Dec 2025 07:13:56 -0800 (PST)
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
Subject: [PATCH v2 0/2] hfsplus: avoid re-allocating header node 0 and stop on already-hashed nodes
Date: Wed, 24 Dec 2025 20:43:45 +0530
Message-Id: <20251224151347.1861896-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

syzbot reported a warning and crash when mounting a corrupted HFS+ image where
the on-disk B-tree bitmap has node 0 (header node) marked free. In that case
hfs_bmap_alloc() can try to allocate node 0 and reach hfs_bnode_create() with
an already-hashed node number.

Patch 1 prevents allocating the reserved header node (node 0) even if the bitmap
is corrupted.

Patch 2 follows Slava's review suggestion and changes the "already hashed" path
in hfs_bnode_create() to return ERR_PTR(-EEXIST) instead of returning the existing
node pointer, so we don't continue in a non-"business as usual" situation.

v2 changes:
  - Implement Slava's suggestion: return ERR_PTR(-EEXIST) for already-hashed nodes.
  - Keep the node-0 allocation guard as a minimal, targeted hardening measure.

Reported-by: syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=1c8ff72d0cd8a50dfeaa
Link: https://lore.kernel.org/all/20251213233215.368558-1-shardul.b@mpiricsoftware.com/

Shardul Bankar (2):
  hfsplus: skip node 0 in hfs_bmap_alloc
  hfsplus: return error when node already exists in hfs_bnode_create

 fs/hfsplus/bnode.c | 2 +-
 fs/hfsplus/btree.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.34.1


