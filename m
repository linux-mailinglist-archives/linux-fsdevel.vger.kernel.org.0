Return-Path: <linux-fsdevel+bounces-78898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDN1CgCRpWmoDgYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:30:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FAD1D9C95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F176301CC79
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 13:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13663F0744;
	Mon,  2 Mar 2026 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="WNKhqMbv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3362C9D
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458130; cv=none; b=RNX9bSSREdC920GcvObR7MVIdUn3n0KFY/+t7qzPCvSG3ULqLLRRlg0mW5xJLJK4RgJJxVUxh8rRHiqaZANLjLSIptEryahoJ/JU37ZjE+Bgv50MP3qS9ra/mnhGp+aifH3Tl4fD7SWMqYNJbTxhj9lhxx1QhdUqO434sS+yGwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458130; c=relaxed/simple;
	bh=+8jUA1pIhBmowlO1jxzQc7kmakXtjz0IlbAyic50DRM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XAf50qp3txCUIQY2PNzy8QgI0FrMuxFSn3+d/E3cJAD3lztoeLzTh8adJ2T/gj3HdoLfa0X8/e6QQBNVhTeEbuAfGXNmWwLY5QPaeXTb0HcEwCOG9xRTUWRT07RKNz2PU7Ix03IXFXcwMnxcc/OotL5E33PjpsqWRCSMQVZqHmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=WNKhqMbv; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vx3Jw-003bl2-4q; Mon, 02 Mar 2026 14:28:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:To:From;
	bh=gjy8VzZho98qn7gDgAP8doLSL96/gQyRo0dz/GrFn7E=; b=WNKhqMbveWP+K3PmL7U2N/ZjgC
	CRkQIzZeOHgk5k2HnpMOotG24V0hTJvr6OyT7PqOl2Dm4nA4urOR3OWpHobtPgDSlAr7nWHDbEPwt
	tSQA2Q7DOv2iXbAH5WTGLe+U0ioyZh17n7ApFQAc/XkWeA54mqXch5dDYlog2nx7U8hngM1sDJ11s
	tNRhThx7ejIxz+T6UR24ZnQQNxcdrxg2eAm04+CH6ikcFduLKZhvpfDwjgDgloDXZCXGRn/V4LJTr
	wYXmGMM3HPxkLojYe9Z7XsbLpV20rgoagwKiSMoPtipXBJZirNaVllMP0+p8CbfIcQhj00YQaveaN
	J3vQaaWw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vx3Ju-0003tB-95; Mon, 02 Mar 2026 14:28:22 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vx3Jg-008UTR-FQ; Mon, 02 Mar 2026 14:28:08 +0100
From: david.laight.linux@gmail.com
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Andre Almeida <andrealmeid@igalia.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Darren Hart <dvhart@infradead.org>,
	David Laight <david.laight.linux@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Heiko Carstens <hca@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	Kees Cook <kees@kernel.org>,
	akpm@linux-foundation.org
Subject: [PATCH v2 1/5] uaccess: Fix scoped_user_read_access() for 'pointer to const'
Date: Mon,  2 Mar 2026 13:27:51 +0000
Message-Id: <20260302132755.1475451-2-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302132755.1475451-1-david.laight.linux@gmail.com>
References: <20260302132755.1475451-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[runbox.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78898-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,igalia.com,citrix.com,linux.ibm.com,kernel.org,csgroup.eu,infradead.org,gmail.com,stgolabs.net,suse.cz,inria.fr,linux-foundation.org,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,efficios.com,ellerman.id.au,imag.fr,dabbelt.com,armlinux.org.uk,linutronix.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	DKIM_TRACE(0.00)[runbox.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,runbox.com:dkim]
X-Rspamd-Queue-Id: 63FAD1D9C95
X-Rspamd-Action: no action

From: David Laight <david.laight.linux@gmail.com>

If a 'const struct foo __user *ptr' is used for the address passed
to scoped_user_read_access() then you get a warning/error
uaccess.h:691:1: error: initialization discards 'const' qualifier
    from pointer target type [-Werror=discarded-qualifiers]
for the
    void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl)
assignment.

Fix by using 'auto' for both _tmpptr and the redeclaration of uptr.
Replace the CLASS() with explicit __cleanup() functions on uptr.

Fixes: e497310b4ffb "(uaccess: Provide scoped user access regions)"
Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/uaccess.h | 54 +++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 1f3804245c06..809e4f7dfdbd 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -647,36 +647,22 @@ static inline void user_access_restore(unsigned long flags) { }
 /* Define RW variant so the below _mode macro expansion works */
 #define masked_user_rw_access_begin(u)	masked_user_access_begin(u)
 #define user_rw_access_begin(u, s)	user_access_begin(u, s)
-#define user_rw_access_end()		user_access_end()
 
 /* Scoped user access */
-#define USER_ACCESS_GUARD(_mode)				\
-static __always_inline void __user *				\
-class_user_##_mode##_begin(void __user *ptr)			\
-{								\
-	return ptr;						\
-}								\
-								\
-static __always_inline void					\
-class_user_##_mode##_end(void __user *ptr)			\
-{								\
-	user_##_mode##_access_end();				\
-}								\
-								\
-DEFINE_CLASS(user_ ##_mode## _access, void __user *,		\
-	     class_user_##_mode##_end(_T),			\
-	     class_user_##_mode##_begin(ptr), void __user *ptr)	\
-								\
-static __always_inline class_user_##_mode##_access_t		\
-class_user_##_mode##_access_ptr(void __user *scope)		\
-{								\
-	return scope;						\
-}
 
-USER_ACCESS_GUARD(read)
-USER_ACCESS_GUARD(write)
-USER_ACCESS_GUARD(rw)
-#undef USER_ACCESS_GUARD
+/* Cleanup wrapper functions */
+static __always_inline void __scoped_user_read_access_end(const void *p)
+{
+	user_read_access_end();
+};
+static __always_inline void __scoped_user_write_access_end(const void *p)
+{
+	user_write_access_end();
+};
+static __always_inline void __scoped_user_rw_access_end(const void *p)
+{
+	user_access_end();
+};
 
 /**
  * __scoped_user_access_begin - Start a scoped user access
@@ -750,13 +736,13 @@ USER_ACCESS_GUARD(rw)
  *
  * Don't use directly. Use scoped_masked_user_$MODE_access() instead.
  */
-#define __scoped_user_access(mode, uptr, size, elbl)					\
-for (bool done = false; !done; done = true)						\
-	for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
-	     !done; done = true)							\
-		for (CLASS(user_##mode##_access, scope)(_tmpptr); !done; done = true)	\
-			/* Force modified pointer usage within the scope */		\
-			for (const typeof(uptr) uptr = _tmpptr; !done; done = true)
+#define __scoped_user_access(mode, uptr, size, elbl)				\
+for (bool done = false; !done; done = true)					\
+	for (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl);	\
+	     !done; done = true)						\
+		/* Force modified pointer usage within the scope */		\
+		for (const auto uptr  __cleanup(__scoped_user_##mode##_access_end) = \
+		     _tmpptr; !done; done = true)
 
 /**
  * scoped_user_read_access_size - Start a scoped user read access with given size
-- 
2.39.5


