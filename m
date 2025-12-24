Return-Path: <linux-fsdevel+bounces-72069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00920CDCA35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 16:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 747A0300D30D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 15:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13981346FC3;
	Wed, 24 Dec 2025 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="Nlxx43tU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEAE30F540;
	Wed, 24 Dec 2025 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766589281; cv=pass; b=ZHiNX7tIrvv4myL7QbsJv3lsan4FKykImQtXmm3gjivOZMu/QKjof5I6VKvQ6Usa34AB1ew9vbHjeTJV+fUV1aJmkshnZsdY4dB03QBb5qeAf+7lIQCsECzDZRjpe78rEqftaCqtXkHHExcMryXJ+JDskOHCde7w71blb6upkRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766589281; c=relaxed/simple;
	bh=WPGWhm3kolC3HIOnVmDBcTF/0kkr+8NEvNc5vqyq8tc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BySK1YSQjhVVkZfvDlGFaaXgl6k7ISTr4OOmrHJG54Egk8mFO3WbpG2n9SbKrl0dv7v2qwCcNf6wZVseNAfmVBna/uKcOLi7yqtalZREuuOLgBOPAmHUupVVYgi7luytLi8sCPWD+XkrpjhmnAK+jDNM0xi9hPW25MxbLCko7oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=Nlxx43tU; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1766589250; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jFcwyYS1SIvB06RAl4mUh7plXe9h1VVj3/Eq5nex/ehU9DVfB2eKhXo91mUfmUnCR4zD66Vul0Xq83OBK2R5iYWXjPcRx3tno1rthC4E711LkFSrUrBrbGC/Da35C4fpKOr6Y84Hh+J9qKakOAHKdrZ2Jdd9NGDlGN0E2pUSRVg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766589250; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=w9IsnJ/aVfBvOceN//c8GNS4LLhNppxpUDjXrHQw1rI=; 
	b=aLuyJ/o+NFkraLM+NE6zfGaMYEl2m/0JCSGkBlKls7i7oD6up0lzYqi3ug1r6xbc0ZfN2lGBJFGuON5IDg6xHGGGepyNISkkmrM9oM+bmALRKitdIXBDyW4izAmu463nuioYz6wPA7hs30VmUb5WkVmSptqZkC4gkELZZ06W2hg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766589250;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=w9IsnJ/aVfBvOceN//c8GNS4LLhNppxpUDjXrHQw1rI=;
	b=Nlxx43tUJGe/t719lYBTnFOLkJaMj0cFYQVoWYY/v37ZXE8nJgSkzGPl3TAesOfA
	vbwfxLQwR+JtKCbkRq610A9ZL+MtRCPd7Tzv80PQ8orP1tgLmbICoFhgEAZu/SIqg9N
	04eZlWvNEv1K73UaHtWweI5yTwmcBDlQydKyIapM=
Received: by mx.zohomail.com with SMTPS id 1766589247444212.342196029001;
	Wed, 24 Dec 2025 07:14:07 -0800 (PST)
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
Subject: [PATCH v2 1/2] hfsplus: skip node 0 in hfs_bmap_alloc
Date: Wed, 24 Dec 2025 20:43:46 +0530
Message-Id: <20251224151347.1861896-2-shardul.b@mpiricsoftware.com>
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

Node 0 is the header node in HFS+ B-trees and should always be allocated.
However, if a filesystem image has node 0's bitmap bit unset (e.g., due to
corruption or a buggy image generator), hfs_bmap_alloc() will find node 0
as free and attempt to allocate it. This causes a conflict because node 0
already exists as the header node, leading to a WARN_ON(1) in
hfs_bnode_create() when the node is found already hashed.

This issue can occur with syzkaller-generated HFS+ images or corrupted
real-world filesystems. Add a guard in hfs_bmap_alloc() to skip node 0
during allocation, providing defense-in-depth against such corruption.

Reported-by: syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=1c8ff72d0cd8a50dfeaa
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 v2:
 - Keep the node-0 allocation guard as targeted hardening for corrupted images.
 fs/hfsplus/btree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 229f25dc7c49..60985f449450 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -411,6 +411,9 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 			if (byte != 0xff) {
 				for (m = 0x80, i = 0; i < 8; m >>= 1, i++) {
 					if (!(byte & m)) {
+						/* Skip node 0 (header node, always allocated) */
+						if (idx == 0 && i == 0)
+							continue;
 						idx += i;
 						data[off] |= m;
 						set_page_dirty(*pagep);
-- 
2.34.1


