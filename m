Return-Path: <linux-fsdevel+bounces-74908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DBaNPRAcWn2fgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:11:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A235DD8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 077FF7A8930
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 19:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37FA35F8BD;
	Wed, 21 Jan 2026 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="tXPRry4m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1531D3D5228;
	Wed, 21 Jan 2026 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024506; cv=none; b=i7glcch+CpZ8x0HhqAtCyZuZZhv2tGYmYxpbp5iw0ssJDyDeFU62ZlVQA7bHgU2nvU/2PY+7ji/sLUo8UQfZtbr2aH+UH+KTcfdbTrskgMqbv4Igd3ugmSPT3950lL7ay1Ps5XhTEQqNta9nHj/BucyzWfzhrD/aGBVz5IbZL70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024506; c=relaxed/simple;
	bh=XOgwSnZJeK713yQMdMbALyRA+5GyjqZpxbGj3e6XiUk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=axHhu2ssRteqwdD8dI45GFHaLLKRy38vKEZaonGWZIigc+avkeHMQ5SN4dJuXEPsNNclSvAuExOfboqHZX+tUN0ouVdiWyb6mdVAh1LzVSwUh2d27EqITebQgS+damb1g70fh6UyhyeDTv5GhXO7eKA021q8aMLxUIx9shEYCm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=tXPRry4m; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769024504; x=1800560504;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NVBmq2PvfFfaooqrHPovx1jJmYeoNrtc1bzeNX7e6Oc=;
  b=tXPRry4mwFq4f9VWXssuvGxzNyrYn5nkaq1tjOhzLVkZoUnS4R63NW4s
   AS6g8C3QRbrzN05xtfC5V0vXBY2+bWnWQu6yiY3J0hzLg6956pqa9ftyB
   P9acg1seNmAHXgP2U2a5+i59mCZABA4gsbw3wA6389OF+h+GApYCQQZRV
   X4+ZFFV1sc9IifZs7hLSYric1eAecQeHhVCfiZpZDUtFXt/ZBoaQDBu6s
   mkPSXhEqW1eI0+CNZ/teUcgSBhedVk1w1T6deK93jsZL9TR1csr63ohgP
   gbiug442nZDWlCW/82AucmQvkMC0gVIGn803DyfYkozCjU2QNtBtKml9Y
   Q==;
X-CSE-ConnectionGUID: WBmheypdQQOFbFS4+nMGzA==
X-CSE-MsgGUID: zPStVyfpS5C3NZDr0NnFgA==
X-IronPort-AV: E=Sophos;i="6.21,244,1763424000"; 
   d="scan'208";a="11114008"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 19:41:40 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:8153]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.244:2525] with esmtp (Farcaster)
 id 2ef3123d-e002-4fe5-95cb-5ef8607876b8; Wed, 21 Jan 2026 19:41:40 +0000 (UTC)
X-Farcaster-Flow-ID: 2ef3123d-e002-4fe5-95cb-5ef8607876b8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 21 Jan 2026 19:41:40 +0000
Received: from c889f3b07a0a.amazon.com (10.106.83.29) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 21 Jan 2026 19:41:39 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: <linux-fsdevel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Yuto Ohnuki <ytohnuki@amazon.com>
Subject: [PATCH] ufs: use fs_umode_to_dtype() for d_type table lookup
Date: Wed, 21 Jan 2026 19:41:28 +0000
Message-ID: <20260121194128.61320-1-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-7.96 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74908-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[amazon.com,quarantine];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ytohnuki@amazon.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 87A235DD8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the switch statement in ufs_set_de_type() with
fs_umode_to_dtype() as suggested by the TODO comment.

This improves maintainability by using the helper function. No
functional change intended.

Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
---
 fs/ufs/util.h | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 391bb4f11d74..e03d768b982d 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -9,6 +9,7 @@
 
 #include <linux/buffer_head.h>
 #include <linux/fs.h>
+#include <linux/fs_dirent.h>
 #include "swab.h"
 
 /*
@@ -152,34 +153,7 @@ ufs_set_de_type(struct super_block *sb, struct ufs_dir_entry *de, int mode)
 	if ((UFS_SB(sb)->s_flags & UFS_DE_MASK) != UFS_DE_44BSD)
 		return;
 
-	/*
-	 * TODO turn this into a table lookup
-	 */
-	switch (mode & S_IFMT) {
-	case S_IFSOCK:
-		de->d_u.d_44.d_type = DT_SOCK;
-		break;
-	case S_IFLNK:
-		de->d_u.d_44.d_type = DT_LNK;
-		break;
-	case S_IFREG:
-		de->d_u.d_44.d_type = DT_REG;
-		break;
-	case S_IFBLK:
-		de->d_u.d_44.d_type = DT_BLK;
-		break;
-	case S_IFDIR:
-		de->d_u.d_44.d_type = DT_DIR;
-		break;
-	case S_IFCHR:
-		de->d_u.d_44.d_type = DT_CHR;
-		break;
-	case S_IFIFO:
-		de->d_u.d_44.d_type = DT_FIFO;
-		break;
-	default:
-		de->d_u.d_44.d_type = DT_UNKNOWN;
-	}
+	de->d_u.d_44.d_type = fs_umode_to_dtype(mode);
 }
 
 static inline u32
-- 
2.50.1




Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705




