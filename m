Return-Path: <linux-fsdevel+bounces-9627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 295ED843769
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 08:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBED81F25D56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 07:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C177A56B6C;
	Wed, 31 Jan 2024 07:09:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840C479943;
	Wed, 31 Jan 2024 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706684995; cv=none; b=NLdWNRs2NQS/z9MybNNcDow8Yfm3ItOkjBGGBhI+FcNgpi6jdCiFTJu7r5JpZjQWioooyyUNNiclQg4PtBxyTD2lc6g4OkePb47jqxltTO2xVcP4GjFCsks/VOYvoWvzjW/EIsojsaA7fdezrYzdaSG887LvzZuEE2EKqsSHiVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706684995; c=relaxed/simple;
	bh=jOy7A5WTQyGJIBvxH/FIa4h8gIfc5N0n93CcoCzbIgU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cr3jRm81rFoYkh7EWRwdV/c2KnotxuKk28/Rd47s6///1r+yh49loO0hDwmA7NMVD2sCpu6t0v1sCL6WyJ0BtCatyAyWFzj6R+LwSvUSyd6qKbynAufDrCYI3+/WcYr5t2zxXNwTSdT9/6ezvG+zsDoXYdRkvA4hxRk72JGxVkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 21a7510e3d8b4b8c8ce2d2d78c1109ea-20240131
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:b74068e4-0538-4de1-9c09-8250025e36a8,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-8,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:2
X-CID-INFO: VERSION:1.1.35,REQID:b74068e4-0538-4de1-9c09-8250025e36a8,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-8,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:2
X-CID-META: VersionHash:5d391d7,CLOUDID:ebad7383-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240131150947MB1NSQV2,BulkQuantity:0,Recheck:0,SF:100|17|19|44|101|66
	|38|24|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 21a7510e3d8b4b8c8ce2d2d78c1109ea-20240131
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 572861371; Wed, 31 Jan 2024 15:09:46 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 60886E000EBB;
	Wed, 31 Jan 2024 15:09:45 +0800 (CST)
X-ns-mid: postfix-65B9F239-184845410
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 3FCFAE000EB9;
	Wed, 31 Jan 2024 15:09:43 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: miklos@szeredi.hu,
	amir73il@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] fs: Use KMEM_CACHE instead of kmem_cache_create
Date: Wed, 31 Jan 2024 15:09:41 +0800
Message-Id: <20240131070941.135178-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
introduces a new macro.
Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 fs/backing-file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index a681f38d84d8..740185198db3 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -325,9 +325,7 @@ EXPORT_SYMBOL_GPL(backing_file_mmap);
=20
 static int __init backing_aio_init(void)
 {
-	backing_aio_cachep =3D kmem_cache_create("backing_aio",
-					       sizeof(struct backing_aio),
-					       0, SLAB_HWCACHE_ALIGN, NULL);
+	backing_aio_cachep =3D KMEM_CACHE(backing_aio, SLAB_HWCACHE_ALIGN);
 	if (!backing_aio_cachep)
 		return -ENOMEM;
=20
--=20
2.39.2


