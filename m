Return-Path: <linux-fsdevel+bounces-78351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAyKMlfcnmkTXgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:26:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A809196706
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08AFC30138FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 11:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FDC394476;
	Wed, 25 Feb 2026 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="W5yfc0cY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075593939CE;
	Wed, 25 Feb 2026 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018720; cv=none; b=HbjG6saOy693KCpsgmqxx9pJ4Rzl4b2Yn9GFIfDLwXRUsWowMSyeIM/G24hAv3NBlKi8tGJWNoS+4p2V5HoVn/y5hBXeTJixByEI+05GoRRqxPw8mCant/tJQcPWlO9Zl87jO5HlBRJJqErXUPc8obCWPJ6YQGJstJ22UV/OZHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018720; c=relaxed/simple;
	bh=f6lcVUK6pgrWtIVFsTWEzx5AVlThjPuX4q1NOOOOg4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITnqsDINGdQy+bcTUZ8XhtkFV97vJhRPhWw4GSmYjtNcqbjR4ozNl5JbmEtUoq62ZZTPDDCfGqUh2PCTp+NASEUmgRgRTJppZEGjN/5G1uYEtmd4Bw7IVkOlBBcgsTsclsagftoGdya/SrlBLm/lWsjgYfiuoAFsOql3OrT9wWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=W5yfc0cY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UKvw97aLLhmYWeg2HbSDZr64p/f1GKlxJKIAPRD8xWg=; b=W5yfc0cYXoqCoYjR52vwRHGVja
	1sBSAfc4HhOmYQ17Q/FqAhszuyzXV6p7J9qbUwDEsZTVPCQOjz3YVeYKM/HTvtYrEA8pWMR0pJ5Il
	no9uLcQAnK86aqz/zePcMgIV9MWuBJSDpdBUc5WdixhS2rTLXGhoPe1uihhMEXvMy/W7B7AlrSKUQ
	nIRukiiVGaqbok0XjaD15JNxFsKOCxMq9gxFM5/dpo6dhVzh6VA9af01Wr+R5pF4noY5iAslDSZQK
	ccNFNzeBqw2UZzojzOxe6L+SZpPCmHQ7mDfysICMeCS25RxkFvhNAVrhE9eVecKiwsPrE+Coi9eyG
	fG0OW6gw==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vvD0n-005CmH-D6; Wed, 25 Feb 2026 12:25:01 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Kevin Chen <kchen@ddn.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Harvey <mharvey@jumptrading.com>,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH v3 2/8] fuse: export extend_arg() and factor out fuse_ext_size()
Date: Wed, 25 Feb 2026 11:24:33 +0000
Message-ID: <20260225112439.27276-3-luis@igalia.com>
In-Reply-To: <20260225112439.27276-1-luis@igalia.com>
References: <20260225112439.27276-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78351-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[szeredi.hu,gmail.com,ddn.com,bsbernd.com,kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,igalia.com:mid,igalia.com:email]
X-Rspamd-Queue-Id: 0A809196706
X-Rspamd-Action: no action

Export (and rename) extend_arg() and fuse_ext_size() as these functions
are useful for using extension headers in other places.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/dir.c    | 9 ++-------
 fs/fuse/fuse_i.h | 7 +++++++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index e3000affff88..f5eacea44896 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -713,7 +713,7 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 	return err;
 }
 
-static void *extend_arg(struct fuse_in_arg *buf, u32 bytes)
+void *fuse_extend_arg(struct fuse_in_arg *buf, u32 bytes)
 {
 	void *p;
 	u32 newlen = buf->size + bytes;
@@ -733,11 +733,6 @@ static void *extend_arg(struct fuse_in_arg *buf, u32 bytes)
 	return p + newlen - bytes;
 }
 
-static u32 fuse_ext_size(size_t size)
-{
-	return FUSE_REC_ALIGN(sizeof(struct fuse_ext_header) + size);
-}
-
 /*
  * This adds just a single supplementary group that matches the parent's group.
  */
@@ -758,7 +753,7 @@ static int get_create_supp_group(struct mnt_idmap *idmap,
 	    !vfsgid_in_group_p(vfsgid))
 		return 0;
 
-	xh = extend_arg(ext, sg_len);
+	xh = fuse_extend_arg(ext, sg_len);
 	if (!xh)
 		return -ENOMEM;
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 6178a012f36c..135027efec7a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1410,6 +1410,13 @@ int fuse_valid_type(int m);
 
 bool fuse_invalid_attr(struct fuse_attr *attr);
 
+void *fuse_extend_arg(struct fuse_in_arg *buf, u32 bytes);
+
+static inline u32 fuse_ext_size(size_t size)
+{
+	return FUSE_REC_ALIGN(sizeof(struct fuse_ext_header) + size);
+}
+
 /**
  * Is current process allowed to perform filesystem operation?
  */

