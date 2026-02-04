Return-Path: <linux-fsdevel+bounces-76289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO0UMTgKg2k+hAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 09:58:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E97E3682
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 09:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DEDB30E43A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 08:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A9F39C636;
	Wed,  4 Feb 2026 08:54:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9EF368290
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770195294; cv=none; b=dX+63xd3ypogRl0rTfvyCMaTWsqe6Emd3Ksct2F3GSyj5L8uV/OptTTSBG0edqxetFWxZpj8QoKpPQoojpg670NSJQZZH+hpLE5PZnYSLU32uAbgVCvQky9b4euvQFmtSB5ZPYJZ1iwLOf4zRZpnsUDzP1XYQpPuFAexaXDVtqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770195294; c=relaxed/simple;
	bh=qIsACIMhslriEhiQTa5CM6EP3aeLfHepgJwOdBT3nEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hj2+6epLZyrSUe2kONKfV3WExrUBK34CE/W66MBzNkYUZ6KE9ex9gBCgO/ZuWjSgNLLCbAvBkuUw5I100PkjbSrtnVecYhQS9v/wwMqQIZj0lxmSBIY/r7o8RzBgMOjAOIUy3V1LrKayenfD/HSGtAfIIoD0igs/NpvLTEMDujY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a7b47a5460so3457825ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Feb 2026 00:54:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770195293; x=1770800093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C24sTJzvWiJfSjj9cTXtwuMyinaZ+9glC5BRRHwlXDY=;
        b=E+L/itZrxGmFlDSbiwjy5VAZjwBzMKVz47KSrHANCnPG7SQ24RePmdg8yVogMdF2lj
         /tyqhZWnwf8B78AyVwydwq6aeaSAVKV+ZV6OzUSr6cymLYOhEpJDOgNgAyCp3jVJciEp
         7mC90GudzIwYnMP0ywB970MkBUIhNUwru5lzJwn6ELsKn3DXHkHc1cw7wj/k+EkREH54
         CghIkVWuwR9jOp80AwuJVhhL3LrzTZ/d58bk98nNUY4awpoQcqm3j8y9MkPj71Y0piqV
         O108rFT2DJyTK051XM2Gp0XAe10fjFp2mgMPUI2SYMClmw53gk/Ckg9zIPgvMCmTKG5I
         Qc9A==
X-Gm-Message-State: AOJu0Yzq0F5iWm5ZI4GK5H0j5aJFGsX8blXkzAdIrLsSPu+6PUBSSPOg
	PXWu544txcWLeakszDHAVW9j2Z+fgnywQmo6S4A4x98nxh8gA7PdX0CF
X-Gm-Gg: AZuq6aJImf5syYXQ2LhA0S+3CZZmm/fUOK4+qF0q73R/cymB+i/kqCq9qZ8IyyFou3r
	C3eTbOmvxHaeanqFgttExJRYg4uorInVBhC6cjL2tpik0BhCoQ1YArbZxssQ62W8QyJadx5fj1z
	MSTga+4WSkvl6pGdwEbD0/EXnt/m3DLSyJ+JoUS56e5G+mQPtnwhmQWveVzSSfIeffl1H3PFMN3
	dhvjoFg9R2ZmJI36FSv0jPhZ1KFJgImXR2dKmA6nyFbK8rGc4ecS+jPiZsSJTsZS6fazMLBfT84
	e9yVEWxM3tm0LweckLa1MO6jo5lOLbpEjVbbIUGY+WFRrB13MmTcObtdmxMSsecu7tsik+m5F6e
	l1D/PGbSa0RO0+uDfPbSfOlqypIzcSLgdULun1RFMXMJCISikF0jPiJ9KjOyyTJH+bgTuZpebL7
	EuJQE9a1HSBhn+VevqXvWXtpujKw==
X-Received: by 2002:a17:903:1107:b0:295:592f:9496 with SMTP id d9443c01a7336-2a933977a88mr20336165ad.20.1770195293160;
        Wed, 04 Feb 2026 00:54:53 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933851270sm16847735ad.2.2026.02.04.00.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 00:54:52 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Anton Altaparmakov <anton@tuxera.com>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH RESEND v7 17/17] MAINTAINERS: update ntfs filesystem entry
Date: Wed,  4 Feb 2026 17:29:31 +0900
Message-Id: <20260204082931.13915-18-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260204082931.13915-1-linkinjeon@kernel.org>
References: <20260204082931.13915-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,tuxera.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-76289-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxera.com:url,tuxera.com:email,cantab.net:email,cam.ac.uk:url,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33E97E3682
X-Rspamd-Action: no action

Add myself and Hyunchul Lee as ntfs maintainer.
Since Anton is already listed in CREDITS, only his outdated information
is updated here. the web address in the W: field in his entry is no longer
accessible. Update his CREDITS with the web and email address found in
the ntfs filesystem entry.

Cc: Anton Altaparmakov <anton@tuxera.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 CREDITS     |  4 ++--
 MAINTAINERS | 11 +++++------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/CREDITS b/CREDITS
index 52f4df2cbdd1..4cf780e71775 100644
--- a/CREDITS
+++ b/CREDITS
@@ -80,8 +80,8 @@ S: B-2610 Wilrijk-Antwerpen
 S: Belgium
 
 N: Anton Altaparmakov
-E: aia21@cantab.net
-W: http://www-stu.christs.cam.ac.uk/~aia21/
+E: anton@tuxera.com
+W: http://www.tuxera.com/
 D: Author of new NTFS driver, various other kernel hacks.
 S: Christ's College
 S: Cambridge CB2 3BU
diff --git a/MAINTAINERS b/MAINTAINERS
index a8af534cdfd4..adf80c8207f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18647,12 +18647,11 @@ T:	git https://github.com/davejiang/linux.git
 F:	drivers/ntb/hw/intel/
 
 NTFS FILESYSTEM
-M:	Anton Altaparmakov <anton@tuxera.com>
-R:	Namjae Jeon <linkinjeon@kernel.org>
-L:	linux-ntfs-dev@lists.sourceforge.net
-S:	Supported
-W:	http://www.tuxera.com/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs.git
+M:	Namjae Jeon <linkinjeon@kernel.org>
+M:	Hyunchul Lee <hyc.lee@gmail.com>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git
 F:	Documentation/filesystems/ntfs.rst
 F:	fs/ntfs/
 
-- 
2.25.1


