Return-Path: <linux-fsdevel+bounces-23271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAED929D03
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 09:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63021F216C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 07:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE641D556;
	Mon,  8 Jul 2024 07:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ldOEqU0z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D81AEDF;
	Mon,  8 Jul 2024 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720423391; cv=none; b=U7mFcUbYoYKif77pMB5X4KDYkC+d6KdQeSe816ALg06tviUdN35twA2SnXSl8gC884HT/zdvlxDDveLoRK3iwoiNMGlHCOxm9a5ZBmVFVHTkhAd/T/w1NJRbMRYzzFi1AtLHGLCyhHbdZ9U8Oxutpc/FOfImhWacmkZKxFbZOBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720423391; c=relaxed/simple;
	bh=STaX1vcUu7uY/uYmJmwcUdFRYIW7vppHsn7l8Uq2u60=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AWbXLX3kaWOKZPqXOZdiP1M4m7Smrpx0juCgj9MtLOSQCLJ+Iwmk3dlZm0qIHzuEH+4mtjoC1B5ciG7agDtE87uJrzTuDRXVM2ELtpFIhsHbRWruTdCkmZaNimq3Vy+KuAVWIoT3XY87gi8oHYRyesVwfVKzfA7QE2qHCpX3A8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ldOEqU0z; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eb0381623cfa11ef8b8f29950b90a568-20240708
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=vJkwzRahuAD6qT9OiVCPZe9NczY4Z6Ju4rXLGq9EF/Y=;
	b=ldOEqU0z8WEFhFr6Kx78onUFlezztM/ASaiXmGGEEeGLTeqlNQncwoP5AlYJQR4jUvu9gLjwFF+sJ0ItH5RNpj/E6R2Ky7z+QzSv42ZTpDcb38nuDD2V5on2vrFGAER5NNKWKUVgSOgblk8NZ/VGF+HpNg8wwxPGyk6habUZkSI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:a7aced1f-0d47-4d79-9ec8-29dc833e9e67,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:e9910845-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eb0381623cfa11ef8b8f29950b90a568-20240708
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ed.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 849706814; Mon, 08 Jul 2024 15:23:05 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 8 Jul 2024 00:23:04 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 8 Jul 2024 15:23:04 +0800
From: <ed.tsai@mediatek.com>
To: Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino
 Del Regno <angelogioacchino.delregno@collabora.com>
CC: <chun-hung.wu@mediatek.com>, Ed Tsai <ed.tsai@mediatek.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-unionfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/1] backing-file: convert to using fops->splice_write
Date: Mon, 8 Jul 2024 15:22:06 +0800
Message-ID: <20240708072208.25244-1-ed.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Ed Tsai <ed.tsai@mediatek.com>

Filesystems may define their own splice write. Therefore, use the file
fops instead of invoking iter_file_splice_write() directly.

Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
---
 fs/backing-file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index afb557446c27..8860dac58c37 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -303,13 +303,16 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 	if (WARN_ON_ONCE(!(out->f_mode & FMODE_BACKING)))
 		return -EIO;
 
+	if (!out->f_op->splice_write)
+		return -EINVAL;
+
 	ret = file_remove_privs(ctx->user_file);
 	if (ret)
 		return ret;
 
 	old_cred = override_creds(ctx->cred);
 	file_start_write(out);
-	ret = iter_file_splice_write(pipe, out, ppos, len, flags);
+	ret = out->f_op->splice_write(pipe, out, ppos, len, flags);
 	file_end_write(out);
 	revert_creds(old_cred);
 
-- 
2.18.0


