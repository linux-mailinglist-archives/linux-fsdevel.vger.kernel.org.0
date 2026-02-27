Return-Path: <linux-fsdevel+bounces-78692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OqgOEFToWkfsAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 09:18:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D6C1B4609
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 09:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2E1E30668F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 08:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6052394497;
	Fri, 27 Feb 2026 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="fjI1FOId"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e3i670.smtp2go.com (e3i670.smtp2go.com [158.120.86.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226B630FC2E
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.86.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180172; cv=none; b=WxQlH8BHxfkX9SMoE85qPjkAXclSIUHH9N8Fv6uJkB4G3IOrGIdsLUgHzcu7PeLyWukvDIyr5YlzxUq3oJ+b9sXVBVTPa+S3PLrHz+nKf8UpOJXnZVzjIirMbLdauFbcU9en4n7V8TSYg5s58I3xl2knf2DBVwREVzoWSyhT+Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180172; c=relaxed/simple;
	bh=H9jWy2UoCy52M+2klxirjo2B6xc5s5xL6iuP+p5vM3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyKZR2kyz4L04HT0bVHjPTVP10zQa06dqAvb6jvbTJQDN1UkbzrLY0pNf/Y42rr0RUe6ouPKWx16la3fNqQQKdf6Nu9l2e0wQshMXUXv/vaBj7j9kWKsyPzpdhujWWPrm35mqBQv2A7CM2ST4xUOk4+t5G1N1cbjeREGxM7OF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=fjI1FOId; arc=none smtp.client-ip=158.120.86.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1772180165; h=from : subject
 : to : message-id : date;
 bh=in1ruy0aNQuVl5px1Sa8iq4z9THvURtLD4XCmSiWq0s=;
 b=fjI1FOIdQRad9tZD3zxhGo30Fd4WGM3ChRtLZlFW0rddPD5Q0nEKi6Hj/HiMRnPEZvsc4
 27xyszvtDulPwyKlHrvFJceCV4C6BP3q8Ipe9SBdFAdzAbhOtRHzgDsL6GVVvsl0+VhmCpE
 0aduuqSKXOJRHPW5FNNUGgDb048rRSLh95oGsX9oDf6sK3YtVAJ6xRZN5HGKE7K6Db1R3Dc
 dylm4zYKcfGlENqbaJj/fOSR6RJpiN9WrMHItktB4/MLXGMFrsTly9+0/FJsWN0nFG0HzGO
 937PGqroGUzG4PtFHh/npMbfl/wOsUogNUny84wThsnt71CaNpimbaL54+zA==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1vvt0x-4o5NDgro4p9-pNDb;
	Fri, 27 Feb 2026 08:15:59 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v3 3/4] 9p: Set default negative dentry retention time for cache=loose
Date: Fri, 27 Feb 2026 08:56:54 +0100
Message-ID: <59d4509e1015eb664bc2b5e59e1d5cf11ab95656.1772178819.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1772178819.git.repk@triplefau.lt>
References: <cover.1772178819.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sBtzXdwV7-
X-smtpcorp-track: e-fDM4CfrzN0.0Gal5pryUSGp.qQmbYg8VZre
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[triplefau.lt,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[triplefau.lt:s=s510616];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78692-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[triplefau.lt:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[repk@triplefau.lt,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D0D6C1B4609
X-Rspamd-Action: no action

For cache=loose mounts, set the default negative dentry cache retention
time to 24 hours.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 fs/9p/v9fs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index a26bd9070786..d14f6eda94d6 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -24,6 +24,9 @@
 #include "v9fs_vfs.h"
 #include "cache.h"
 
+/* cache=loose default negative dentry retention time is 24hours */
+#define CACHE_LOOSE_NDENTRY_TMOUT_DEFAULT (24 * 60 * 60 * 1000)
+
 static DEFINE_SPINLOCK(v9fs_sessionlist_lock);
 static LIST_HEAD(v9fs_sessionlist);
 struct kmem_cache *v9fs_inode_cache;
@@ -440,6 +443,13 @@ static void v9fs_apply_options(struct v9fs_session_info *v9ses,
 	v9ses->uid = ctx->session_opts.uid;
 	v9ses->session_lock_timeout = ctx->session_opts.session_lock_timeout;
 	v9ses->ndentry_timeout_ms = ctx->session_opts.ndentry_timeout_ms;
+
+	/* If negative dentry timeout has not been overriden set default for
+	 * cache=loose
+	 */
+	if (!(v9ses->flags & V9FS_NDENTRY_TMOUT_SET) &&
+	    (v9ses->cache & CACHE_LOOSE))
+		v9ses->ndentry_timeout_ms = CACHE_LOOSE_NDENTRY_TMOUT_DEFAULT;
 }
 
 /**
-- 
2.52.0


