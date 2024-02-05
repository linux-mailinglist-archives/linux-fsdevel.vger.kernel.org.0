Return-Path: <linux-fsdevel+bounces-10245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0428184951E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 09:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975631F248BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 08:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4596F111A4;
	Mon,  5 Feb 2024 08:10:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751F811184;
	Mon,  5 Feb 2024 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707120636; cv=none; b=ZnsWOHe32bSq3YcbRiEasmnAgO2KWuOWwyLuBVZcmRB2RZrWjPKXEM1ujh9aDh2rNYYEgeu/yZ9MFn+EN1OvagDIC2i79hWNZszlmlEULRiY+OrGbtRIasb9HI+8yhh8F99i3e5AudWBojmuprmuN/T5C+CFyjUnGg8CMvcQWVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707120636; c=relaxed/simple;
	bh=lJfLls5gfxNink17J4VWmEfa8CGJgcmPdq9FvLEAIgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EY1e67ffKQn5ZFR5wJc1R/LmZwyMIWd/YDiMCjoA65P1fQEjdQt2YjNKBuGzX0kIL2rdqGtBgYKJFpU8OqsjeInVRYJq/+7hbgDFf8rMQ62tQ+db+5ejdU8aCUns3GXb/81DUaydEayZbiFfBFv2rzhhhR74lQH+qHUYuTF5oZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1d47c6aa2b3747909181acbb0103231e-20240205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:e90204c5-e0b1-407d-855a-d1d3f5b1baaf,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:1
X-CID-INFO: VERSION:1.1.35,REQID:e90204c5-e0b1-407d-855a-d1d3f5b1baaf,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:5d391d7,CLOUDID:23702180-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240205161028035G384B,BulkQuantity:0,Recheck:0,SF:17|19|42|74|66|38|2
	4|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 1d47c6aa2b3747909181acbb0103231e-20240205
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 968780155; Mon, 05 Feb 2024 16:10:25 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 1BE1FE000EBC;
	Mon,  5 Feb 2024 16:10:25 +0800 (CST)
X-ns-mid: postfix-65C097F0-91013334
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 539BFE000EBC;
	Mon,  5 Feb 2024 16:10:24 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: dlemoal@kernel.org,
	naohiro.aota@wdc.com,
	jth@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] zonefs: Simplify the allocation of slab caches in zonefs_init_inodecache
Date: Mon,  5 Feb 2024 16:10:22 +0800
Message-Id: <20240205081022.433945-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 fs/zonefs/super.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 93971742613a..9b578e7007e9 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1387,10 +1387,8 @@ static struct file_system_type zonefs_type =3D {
=20
 static int __init zonefs_init_inodecache(void)
 {
-	zonefs_inode_cachep =3D kmem_cache_create("zonefs_inode_cache",
-			sizeof(struct zonefs_inode_info), 0,
-			(SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT),
-			NULL);
+	zonefs_inode_cachep =3D KMEM_CACHE(zonefs_inode_info,
+			SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT);
 	if (zonefs_inode_cachep =3D=3D NULL)
 		return -ENOMEM;
 	return 0;
--=20
2.39.2


