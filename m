Return-Path: <linux-fsdevel+bounces-58388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3FEB2DDF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 15:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82E2B4E34F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 13:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B773277AF;
	Wed, 20 Aug 2025 13:35:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EC22D3231;
	Wed, 20 Aug 2025 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696922; cv=none; b=HQZYeZR5cTGpUqIKiaS5P0oIEpRgfQkbjzh7V/9gcQ1/mkZRjSTICOrkT6Y9V1eIw8QbnR1hehOqm7WSt+GD2UlANBgtWG43oc9OoaW96lIKT7ZzKMU02UrTMejw6FYOFdq19/msdh5bxIEzdE/j89kSQNHw840mu4HrS/JLvAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696922; c=relaxed/simple;
	bh=YRYktNFFgTk/blFCWFAsBlNr++wW/px3N+hR3EFl8+M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ejNQt9uaQQ0Gh5VA/0edBSD5YyNvx8kqwy0NSXJYTTi/E0p17wIC2u5PIKC58nlEjClY6mZo8oqDncgKnUhmV6tpSpCgjym3vGaFmD3XcCwhAMZIdFeEZ8+MJoeRRW+ebkUqyV0Sq1O8po7EOmWKoIi0A1XS6pkhbJ8j9EJQFiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 789171f47dca11f0b29709d653e92f7d-20250820
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_UNTRUSTED
	SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:eb32aa9a-7641-4351-973f-f00cae767eed,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:13
X-CID-INFO: VERSION:1.1.45,REQID:eb32aa9a-7641-4351-973f-f00cae767eed,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_HamU,ACTION
	:release,TS:13
X-CID-META: VersionHash:6493067,CLOUDID:9ad44a6ea3e5f4a61a3174d9144e2e8a,BulkI
	D:250820213504ZXR79S3G,BulkQuantity:0,Recheck:0,SF:16|19|24|38|44|66|78|10
	2,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 789171f47dca11f0b29709d653e92f7d-20250820
X-User: zhangguopeng@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1597698993; Wed, 20 Aug 2025 21:35:00 +0800
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
To: viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org
Cc: brauner@kernel.org,
	festevam@denx.de,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH] fs: fix indentation style
Date: Wed, 20 Aug 2025 21:34:24 +0800
Message-Id: <20250820133424.1667467-1-zhangguopeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace 8 leading spaces with a tab to follow kernel coding style.

Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ef9521e06cae..7673e52f437a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2455,7 +2455,7 @@ struct vfsmount *clone_private_mount(const struct path *path)
 			return ERR_PTR(-EINVAL);
 	}
 
-        if (!ns_capable(old_mnt->mnt_ns->user_ns, CAP_SYS_ADMIN))
+	if (!ns_capable(old_mnt->mnt_ns->user_ns, CAP_SYS_ADMIN))
 		return ERR_PTR(-EPERM);
 
 	if (__has_locked_children(old_mnt, path->dentry))
-- 
2.25.1


