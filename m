Return-Path: <linux-fsdevel+bounces-72083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8823DCDD57F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 06:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35C64301EC46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 05:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6804C2D543E;
	Thu, 25 Dec 2025 05:51:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6358E1E5205;
	Thu, 25 Dec 2025 05:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766641865; cv=none; b=cSNHPj/hse3qTThtsWZ7rtgGPReQQUQdxj6o1Bap10tHJ9yYD44+93xKRfXy2BC6kzu614ewLVasDu6uhL+PWNP5P5Ivl5Nq1q7IeOEJEWt83IEuwuyQ5C7qNg23JD/Cs/eNtMlH2G/45nMwCEA4iaWMw3wX7AgXwcLzmuTIr2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766641865; c=relaxed/simple;
	bh=ZcO+zvxMg403xGFUBbYz9SogBrfkBYIBuoA0ig53fqs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rCynr3s32oepiMGSJGmZgYz8bAmuZXDXZWYi5p7EFfO6hKE1FhHMkCM+oGJuX0y0HEZNfn0zwGvTTXZe3zHOcW+3QVWm51d/Baps9fOGK7lHbdMIZe/Z/DNpaBtIvzoht3GFGOv3bLAr04XkgzdFTX3arkoERKlUhWvOrc9Mgyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a88e5f7ce15511f0a38c85956e01ac42-20251225
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR, SN_UNTRUSTED
	SN_LOWREP, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:67db0299-961e-41ab-a8a0-eb04931a4222,IP:15,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:20
X-CID-INFO: VERSION:1.3.6,REQID:67db0299-961e-41ab-a8a0-eb04931a4222,IP:15,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
	lease,TS:20
X-CID-META: VersionHash:a9d874c,CLOUDID:322bc6c406895948a369d2fccc14273b,BulkI
	D:251225134931A62SLXE9,BulkQuantity:1,Recheck:0,SF:19|66|72|78|102|127|850
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a88e5f7ce15511f0a38c85956e01ac42-20251225
X-User: kuangkai@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <kuangkai@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 287335933; Thu, 25 Dec 2025 13:50:46 +0800
From: Kuang Kai <kuangkai@kylinos.cn>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuangkai@kylinos.cn,
	kk47yx@gmail.com
Subject: [PATCH] fuse: show the io_uring mount option
Date: Thu, 25 Dec 2025 13:50:21 +0800
Message-Id: <20251225055021.42491-1-kuangkai@kylinos.cn>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: kuangkai <kuangkai@kylinos.cn>

mount with io_uring options will not work if the kernel parameter of /sys/module/fuse/parameters/enable_uring has not been set,
displaying this option can help confirm whether the fuse over io_uring function is enabled.

Signed-off-by: kuangkai <kuangkai@kylinos.cn>
---
 fs/fuse/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 21e04c394a80..190de3f29552 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -937,6 +937,11 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",dax=inode");
 #endif
 
+#ifdef CONFIG_FUSE_IO_URING
+	if (fc->io_uring)
+		seq_puts(m, ",io_uring");
+#endif
+
 	return 0;
 }
 
-- 
2.39.2 (Apple Git-143)


