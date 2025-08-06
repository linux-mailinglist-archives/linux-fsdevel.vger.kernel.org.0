Return-Path: <linux-fsdevel+bounces-56819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D77B1C046
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 08:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C73A3ABB0D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 06:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FDB217704;
	Wed,  6 Aug 2025 06:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="ADXrF2mq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E273213254;
	Wed,  6 Aug 2025 06:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754460447; cv=none; b=R4HRaHJnKQOIntS3En2pIyl05k9g7tI1e5q0XBj6IE9+x2D99PXqUXzVtuJDRaXGvnnoMu7n4uJrcrFCOhMLDVtkzzcfjWM/LB88SZUe7NjMZNOaOZPs/KbxLGFwxPZ4LPMOi5qKEGQECdWdWgD9lWLKsIV2eaXPEAKuLlEmabg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754460447; c=relaxed/simple;
	bh=4s8Gi1EenOHJaLb55g1juwsl7ZsPZjgWY4gDBSu2WAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KtFFDCDu1QUdvtPA0x+Ncn2C0365UJCgV/ixOzNRNw4idv1sbLu796OMgh3dI7LDtbiMdDpvksJFsOFsVlDUe+wQFEcLREZNIm17hcAK80CRxtnlLtK3BpO7a+bJnUb0eRhBtM8Iywact+0ZwTSXR1zPVefRroFv8WqaiHkbxLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=ADXrF2mq; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bxfvr4j5mz9tcl;
	Wed,  6 Aug 2025 08:07:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754460440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yOE9waL0ew+X+ln2ytNi3KfwfeUFVHt9mFZ0tGiHb8c=;
	b=ADXrF2mqGhopMlhIOanMGYzWUQ1wtbPzl+gFMMbNzVNI5ezmijF7kTcBmi2kjSYv4CPvLO
	nVbZ1+AcM+xdMpICf2FmZAYqUIZ2OTMHAqG5LdF5forSKUgp9NusF6iq3Zpt4WoEYunu6A
	83cLg3BVixa8LrEzac59d/0DquXiQGlhRkrtDd0xKHMtN7jhCnp88eKj/BgyU/WEJES9fm
	6uXCFBY8kEEm/bKuECvcfUDb+KbZd7liSEhyiRgYTRdUJASlhu3+KI189cwNEewdyDXHPg
	rc6+j8X13ssp0c/ALLlCkvJzb4qiLzcIpmDf0AgHIp373KKnv6ffW1NiMc9LHQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Wed, 06 Aug 2025 16:07:05 +1000
Subject: [PATCH v2 1/2] fscontext: add custom-prefix log helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-errorfc-mount-too-revealing-v2-1-534b9b4d45bb@cyphar.com>
References: <20250806-errorfc-mount-too-revealing-v2-0-534b9b4d45bb@cyphar.com>
In-Reply-To: <20250806-errorfc-mount-too-revealing-v2-0-534b9b4d45bb@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3383; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=4s8Gi1EenOHJaLb55g1juwsl7ZsPZjgWY4gDBSu2WAI=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRM+shv+dtntTbHe0WzBS52LzZk63wXurN6zQLJpY7+G
 4X0pQ8JdJSyMIhxMciKKbJs8/MM3TR/8ZXkTyvZYOawMoEMYeDiFICJXMll+Ge1sefMKe6QYwF/
 RLaJ+Et46kqvmp4Yxpv7bJL5vj+XZvox/GL2Wrm855Rf+qxtnq5TeU44JBXXOG+qaxFattkhclo
 XKx8A
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4bxfvr4j5mz9tcl

Sometimes, errors associated with an fscontext come from the VFS or
otherwise outside of the filesystem driver itself. However, the default
logging of errorfc will always prefix the message with the filesystem
name.

So, add some *fcp() wrappers that allow for custom prefixes to be used
when emitting information to the fscontext log.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 include/linux/fs_context.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 7773eb870039..671f031be173 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -186,10 +186,12 @@ struct fc_log {
 extern __attribute__((format(printf, 4, 5)))
 void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt, ...);
 
-#define __logfc(fc, l, fmt, ...) logfc((fc)->log.log, NULL, \
-					l, fmt, ## __VA_ARGS__)
-#define __plog(p, l, fmt, ...) logfc((p)->log, (p)->prefix, \
-					l, fmt, ## __VA_ARGS__)
+#define __logfc(fc, l, fmt, ...) \
+	logfc((fc)->log.log, NULL, (l), (fmt), ## __VA_ARGS__)
+#define __plogp(p, prefix, l, fmt, ...) \
+	logfc((p)->log, (prefix), (l), (fmt), ## __VA_ARGS__)
+#define __plog(p, l, fmt, ...) __plogp(p, (p)->prefix, l, fmt, ## __VA_ARGS__)
+
 /**
  * infof - Store supplementary informational message
  * @fc: The context in which to log the informational message
@@ -201,6 +203,8 @@ void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt,
 #define infof(fc, fmt, ...) __logfc(fc, 'i', fmt, ## __VA_ARGS__)
 #define info_plog(p, fmt, ...) __plog(p, 'i', fmt, ## __VA_ARGS__)
 #define infofc(fc, fmt, ...) __plog((&(fc)->log), 'i', fmt, ## __VA_ARGS__)
+#define infofcp(fc, prefix, fmt, ...) \
+	__plogp((&(fc)->log), prefix, 'i', fmt, ## __VA_ARGS__)
 
 /**
  * warnf - Store supplementary warning message
@@ -213,6 +217,8 @@ void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt,
 #define warnf(fc, fmt, ...) __logfc(fc, 'w', fmt, ## __VA_ARGS__)
 #define warn_plog(p, fmt, ...) __plog(p, 'w', fmt, ## __VA_ARGS__)
 #define warnfc(fc, fmt, ...) __plog((&(fc)->log), 'w', fmt, ## __VA_ARGS__)
+#define warnfcp(fc, prefix, fmt, ...) \
+	__plogp((&(fc)->log), prefix, 'w', fmt, ## __VA_ARGS__)
 
 /**
  * errorf - Store supplementary error message
@@ -225,6 +231,8 @@ void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt,
 #define errorf(fc, fmt, ...) __logfc(fc, 'e', fmt, ## __VA_ARGS__)
 #define error_plog(p, fmt, ...) __plog(p, 'e', fmt, ## __VA_ARGS__)
 #define errorfc(fc, fmt, ...) __plog((&(fc)->log), 'e', fmt, ## __VA_ARGS__)
+#define errorfcp(fc, prefix, fmt, ...) \
+	__plogp((&(fc)->log), prefix, 'e', fmt, ## __VA_ARGS__)
 
 /**
  * invalf - Store supplementary invalid argument error message
@@ -237,5 +245,7 @@ void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt,
 #define invalf(fc, fmt, ...) (errorf(fc, fmt, ## __VA_ARGS__), -EINVAL)
 #define inval_plog(p, fmt, ...) (error_plog(p, fmt, ## __VA_ARGS__), -EINVAL)
 #define invalfc(fc, fmt, ...) (errorfc(fc, fmt, ## __VA_ARGS__), -EINVAL)
+#define invalfcp(fc, prefix, fmt, ...) \
+	(errorfcp(fc, prefix, fmt, ## __VA_ARGS__), -EINVAL)
 
 #endif /* _LINUX_FS_CONTEXT_H */

-- 
2.50.1


