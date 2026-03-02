Return-Path: <linux-fsdevel+bounces-78897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DUxCSiRpWmoDgYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:31:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 934241D9CB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9D6F3061BDE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 13:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BE432D0EE;
	Mon,  2 Mar 2026 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="C3w8X+KC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD21536C9D0;
	Mon,  2 Mar 2026 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458128; cv=none; b=eVfaPez3X0nsWx26xXwsEIXqVTEBM/g8u0hn4wGLxcdHCOUqUVdGRFJZ4PpdH0oJi2kGyK1Hm9q4emsBai2RcCK65PYOoaBBllF4lQHlorfrSYLSSKez958dIjrhvXMSHk8U6PfZi3w6aYoiOX88dLlty7Rezev+nH6fiA1wlZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458128; c=relaxed/simple;
	bh=W6qmQbOUEvCz4cAy/edHoPzKepofa/JIaVO2fGniCcs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OAz0TjbfB99Idj5VISoU37PvALOUIcONJvGPLVk4PsTuLSRcvLRjiU9r9imrNOkSxTdasYf5m8rcdZ4hva2k9lFirlRSVAjWwKe5TOUDwxGmi/QoMgwjFVhYGU72w/J2SS5+cY1iRo3s/fCjSPsXa8ZEwnfK8KY6fJNS8KNtwGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=C3w8X+KC; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vx3Jw-003bl4-7x; Mon, 02 Mar 2026 14:28:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:To:From;
	bh=DqGOd6ipwPciYOEGbBHYVc1F4qmoJna8wv2iZM4469g=; b=C3w8X+KCNPwwUnlCUtq46S90t1
	DaIzVd1U67pGzKoSNwRgDY0CkJR1WNOs2reVFFLbpCZJ5PTfZVq5TZTYpBtxMw2AfBFKsnU8eNfzL
	UyKZj1Ao3zw24M6GhXmw4q7AcjpvZz9fajrVInZguhOGa8NYPBkUrjhNlngU3Mr5PEAWm9Jc6JFne
	y3SR7NYQbKrUQi7nwwLTjarrREdk17HVYnhrX+G5V/PSUpfdGc3Axbaqn/zyoRSLpoMrqqb5dL7RX
	smVDc6yiyZoQchORsC5WgAugpAW3KLRRAwN3ak0bumYpByVPz6HVuheyobbQNDuH27z7AyGB9th3/
	IYE9RgWA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vx3Ju-0001hC-Np; Mon, 02 Mar 2026 14:28:22 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vx3Jl-008UTR-0w; Mon, 02 Mar 2026 14:28:13 +0100
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
Subject: [PATCH v2 next 5/5] signal: Use scoped_user_access() instead of __put/get_user()
Date: Mon,  2 Mar 2026 13:27:55 +0000
Message-Id: <20260302132755.1475451-6-david.laight.linux@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78897-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[runbox.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 934241D9CB4
X-Rspamd-Action: no action

From: David Laight <david.laight.linux@gmail.com>

Mechanically change the access_ok() and __get/put_user() to use
scoped_user_read/write_access() and unsafe_get/put_user().

This generates better code with fewer STAC/CLAC pairs.

It also ensures that access_ok() is called near the user accesses.
I failed to find the one for __save_altstack().

Looking at the change, perhaps there should be aliases:
#define scoped_put_user unsafe_put_user
#define scoped_get_user unsafe_get_user

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 kernel/signal.c | 72 ++++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index d65d0fe24bfb..fca257398cbc 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4469,10 +4469,16 @@ int restore_altstack(const stack_t __user *uss)
 int __save_altstack(stack_t __user *uss, unsigned long sp)
 {
 	struct task_struct *t = current;
-	int err = __put_user((void __user *)t->sas_ss_sp, &uss->ss_sp) |
-		__put_user(t->sas_ss_flags, &uss->ss_flags) |
-		__put_user(t->sas_ss_size, &uss->ss_size);
-	return err;
+
+	scoped_user_write_access(uss, Efault) {
+		unsafe_put_user((void __user *)t->sas_ss_sp, &uss->ss_sp, Efault);
+		unsafe_put_user(t->sas_ss_flags, &uss->ss_flags, Efault);
+		unsafe_put_user(t->sas_ss_size, &uss->ss_size, Efault);
+	}
+	return 0;
+
+Efault:
+	return -EFAULT;
 }
 
 #ifdef CONFIG_COMPAT
@@ -4705,12 +4711,12 @@ SYSCALL_DEFINE3(sigaction, int, sig,
 
 	if (act) {
 		old_sigset_t mask;
-		if (!access_ok(act, sizeof(*act)) ||
-		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
-		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer) ||
-		    __get_user(new_ka.sa.sa_flags, &act->sa_flags) ||
-		    __get_user(mask, &act->sa_mask))
-			return -EFAULT;
+		scoped_user_read_access(act, Efault) {
+		    unsafe_get_user(new_ka.sa.sa_handler, &act->sa_handler, Efault);
+		    unsafe_get_user(new_ka.sa.sa_restorer, &act->sa_restorer, Efault);
+		    unsafe_get_user(new_ka.sa.sa_flags, &act->sa_flags, Efault);
+		    unsafe_get_user(mask, &act->sa_mask, Efault);
+		}
 #ifdef __ARCH_HAS_KA_RESTORER
 		new_ka.ka_restorer = NULL;
 #endif
@@ -4720,15 +4726,18 @@ SYSCALL_DEFINE3(sigaction, int, sig,
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 
 	if (!ret && oact) {
-		if (!access_ok(oact, sizeof(*oact)) ||
-		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
-		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer) ||
-		    __put_user(old_ka.sa.sa_flags, &oact->sa_flags) ||
-		    __put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask))
-			return -EFAULT;
+		scoped_user_write_access(oact, Efault) {
+		    unsafe_put_user(old_ka.sa.sa_handler, &oact->sa_handler, Efault);
+		    unsafe_put_user(old_ka.sa.sa_restorer, &oact->sa_restorer, Efault);
+		    unsafe_put_user(old_ka.sa.sa_flags, &oact->sa_flags, Efault);
+		    unsafe_put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask, Efault);
+		}
 	}
 
 	return ret;
+
+Efault:
+	return -EFAULT;
 }
 #endif
 #ifdef CONFIG_COMPAT_OLD_SIGACTION
@@ -4742,12 +4751,12 @@ COMPAT_SYSCALL_DEFINE3(sigaction, int, sig,
 	compat_uptr_t handler, restorer;
 
 	if (act) {
-		if (!access_ok(act, sizeof(*act)) ||
-		    __get_user(handler, &act->sa_handler) ||
-		    __get_user(restorer, &act->sa_restorer) ||
-		    __get_user(new_ka.sa.sa_flags, &act->sa_flags) ||
-		    __get_user(mask, &act->sa_mask))
-			return -EFAULT;
+		scoped_user_read_access(act, Efault) {
+		    unsafe_get_user(handler, &act->sa_handler, Efault);
+		    unsafe_get_user(restorer, &act->sa_restorer, Efault);
+		    unsafe_get_user(new_ka.sa.sa_flags, &act->sa_flags, Efault);
+		    unsafe_get_user(mask, &act->sa_mask, Efault);
+		}
 
 #ifdef __ARCH_HAS_KA_RESTORER
 		new_ka.ka_restorer = NULL;
@@ -4760,16 +4769,19 @@ COMPAT_SYSCALL_DEFINE3(sigaction, int, sig,
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 
 	if (!ret && oact) {
-		if (!access_ok(oact, sizeof(*oact)) ||
-		    __put_user(ptr_to_compat(old_ka.sa.sa_handler),
-			       &oact->sa_handler) ||
-		    __put_user(ptr_to_compat(old_ka.sa.sa_restorer),
-			       &oact->sa_restorer) ||
-		    __put_user(old_ka.sa.sa_flags, &oact->sa_flags) ||
-		    __put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask))
-			return -EFAULT;
+		scoped_user_write_access(oact, Efault) {
+		    unsafe_put_user(ptr_to_compat(old_ka.sa.sa_handler),
+			       &oact->sa_handler, Efault);
+		    unsafe_put_user(ptr_to_compat(old_ka.sa.sa_restorer),
+			       &oact->sa_restorer, Efault);
+		    unsafe_put_user(old_ka.sa.sa_flags, &oact->sa_flags, Efault);
+		    unsafe_put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask, Efault);
+		}
 	}
 	return ret;
+
+Efault:
+	return -EFAULT;
 }
 #endif
 
-- 
2.39.5


