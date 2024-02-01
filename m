Return-Path: <linux-fsdevel+bounces-9831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B6584544B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056C41C25AC3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A15B4DA1E;
	Thu,  1 Feb 2024 09:40:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F54A4DA04;
	Thu,  1 Feb 2024 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780415; cv=none; b=linFo12jbl8LBejog3jMbxl/r9HzsmUXcdBWQGqyY3d8Ul7vb9Qbx2yzM8K8iy6r6NOda7Jn48GC/eLUzU8UeqHZDvzWMu+3ZsosXcuzaPTR9SJ9TlWHa/XHNmKuGqlbuFmQ43KWzVNAc8gi6nXd7yJIAzTfbhiQWi3oCEv6Z+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780415; c=relaxed/simple;
	bh=vc+Am/eF9iicnxtvW7Z4hjqUV+fLMgxqF8JECJDqaRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lOYM6MiOwdPoqpQmqT9TkW9rqM4YQm9lcYycwdYXaEVGFAu1I87hwmYwlPm/P99gRnR8zDZ3Gl2e3esXbxTvLocxhXpWvd21UbnRugdaK9npLidHG/rMYrkyOJB+JhDIk3jzn3Uvz17mjXjoCgriopNp4AvKMgWrHuSDKZe+lhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 070b2b4eba1f41a0bacbf62848b6ff79-20240201
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:2a9da3b9-c96f-457e-92b5-eba60a138977,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:2a9da3b9-c96f-457e-92b5-eba60a138977,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:38720180-4f93-4875-95e7-8c66ea833d57,B
	ulkID:2402011734352Y3RVKA1,BulkQuantity:0,Recheck:0,SF:24|17|19|44|66|38|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 070b2b4eba1f41a0bacbf62848b6ff79-20240201
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1510496774; Thu, 01 Feb 2024 17:34:31 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id A9E87E000EB9;
	Thu,  1 Feb 2024 17:34:31 +0800 (CST)
X-ns-mid: postfix-65BB65A7-4971281242
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id C7D7DE000EB9;
	Thu,  1 Feb 2024 17:34:28 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] mbcache: Simplify the allocation of slab caches
Date: Thu,  1 Feb 2024 17:34:26 +0800
Message-Id: <20240201093426.207932-1-chentao@kylinos.cn>
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
 fs/mbcache.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/mbcache.c b/fs/mbcache.c
index 82aa7a35db26..fe2624e17253 100644
--- a/fs/mbcache.c
+++ b/fs/mbcache.c
@@ -426,9 +426,8 @@ EXPORT_SYMBOL(mb_cache_destroy);
=20
 static int __init mbcache_init(void)
 {
-	mb_entry_cache =3D kmem_cache_create("mbcache",
-				sizeof(struct mb_cache_entry), 0,
-				SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD, NULL);
+	mb_entry_cache =3D KMEM_CACHE(mb_cache_entry,
+					 SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD);
 	if (!mb_entry_cache)
 		return -ENOMEM;
 	return 0;
--=20
2.39.2


