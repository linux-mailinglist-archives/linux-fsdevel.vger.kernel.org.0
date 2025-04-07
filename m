Return-Path: <linux-fsdevel+bounces-45863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE14A7DCEB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 13:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597EE1694EA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 11:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E438F22A811;
	Mon,  7 Apr 2025 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dkDo2ljr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AE42500DE;
	Mon,  7 Apr 2025 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744026683; cv=none; b=X375KtUo7aOgOE6hkKCSn5jkAo67oYlQvEVhL0PIM8wIamBl4ym/r2wbNdnM1jvr3GFrrpiuNaRu+9IuIGkkIE13PTZc2XRpZiEs6mHYyU0lCcZEyhoV5hA17+LEL4W36p9GCcrcQXUaedIy9PWTu3uZwXsDoeGZ8bFK3gkJvkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744026683; c=relaxed/simple;
	bh=xgUKmB5vq2YP9FDOVVqsqudMWRIqV09YtHQN0uX6tfI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y2CEUlbvjr07kQX2Pu/sSD+3J8KSCuSEkyJH9e4P1YlRMtzO153F0qExvEPtkDWd9UCTbga5SX8qWXVH1yxNUu+9knTRWjb0v0Sdgg4w2goup6v8InQg5chWHpcTiIKmAFwrNBD87YicMQ3pUDyqE6Sn+n2aMYdgL3UdsClcYt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dkDo2ljr; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9ba92ac613a611f0aae1fd9735fae912-20250407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=tkF2DYghDX+VQfWwEAkZ56brYwDEfPo9ZbyXaVQNw8w=;
	b=dkDo2ljr/sjlsjNlGfkK7xnllS11m7EAELVbxF48MOdpRgeY5+FB9Tr3LWl50hEl09m6Tpr1kBlybpkQskkhlue4E/XCDUnM6izu49IRQx4vahYZxZwz3ZYBm8eTN782/aTlXF8IRD5Msts73jgYOYZpiRWWWPrEz2rXGy7xFcc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:ff118d3f-26b2-4ad9-b2dd-4d96e9e9d256,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:fff2c6a5-c619-47e3-a41b-90eedbf5b947,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9ba92ac613a611f0aae1fd9735fae912-20250407
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <xiangsheng.hou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2082688227; Mon, 07 Apr 2025 19:51:14 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 7 Apr 2025 19:51:13 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 7 Apr 2025 19:51:13 +0800
From: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
To: Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>, <eperezma@redhat.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <virtualization@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <benliang.zhao@mediatek.com>,
	<bin.zhang@mediatek.com>, Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: [RESEND] virtiofs: add filesystem context source name check
Date: Mon, 7 Apr 2025 19:50:49 +0800
Message-ID: <20250407115111.25535-1-xiangsheng.hou@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

In certain scenarios, for example, during fuzz testing, the source
name may be NULL, which could lead to a kernel panic. Therefore, an
extra check for the source name should be added.

Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
---
 fs/fuse/virtio_fs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 2c7b24cb67ad..53c2626e90e7 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1669,6 +1669,9 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	unsigned int virtqueue_size;
 	int err = -EIO;
 
+	if (!fsc->source)
+		return invalf(fsc, "No source specified");
+
 	/* This gets a reference on virtio_fs object. This ptr gets installed
 	 * in fc->iq->priv. Once fuse_conn is going away, it calls ->put()
 	 * to drop the reference to this object.
-- 
2.46.0


