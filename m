Return-Path: <linux-fsdevel+bounces-65095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE17DBFBF0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B56C4ECEB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 12:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF4F348452;
	Wed, 22 Oct 2025 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kSNLvhZH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jBvd0+8w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEACD34405D;
	Wed, 22 Oct 2025 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137365; cv=none; b=J2Ae/if4iDshzkVWvPVpifFoMQyba1tTpF4VGUjRCI0onW9CivF91zs4jOLpzjikCXl4ryEvohio5ohnxsOfP8cLsB2zU6F3bYKPtUGhWaAuTrihvAgIRas78m9l7Lk1sfrDFdj2+uHx/sK/DKUzw48LUMcwHm8yQCrWj9sAfQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137365; c=relaxed/simple;
	bh=wJm5UMrmpvAcM99cTkidm5TaAvUNVlh+zG+6Y25egfQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=U9yvKmSJmCVoinT4BVRBbR8AJ71A0AbRXj9e5iQ2ffBQmPt9uO41tw/ERHZh/WmlWE7TIyUrlNMh9DtQglBYPzpfG0GKTbke7lkH6D9NmZ3y0HrRWTCr87sFVy5cIW5yWs9CNBOIwSmdw37GAOsX6QRX16fkSX7pTNK5qRCVq+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kSNLvhZH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jBvd0+8w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022103112.419590507@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lccNRRk780OLOrvRTmsIIfoLd+zwTDZxXhd+4kcSfCA=;
	b=kSNLvhZHcJTcvSj8XCd+k+HYD9K4T7yCINmy83VEZBK84m3WfK/bM45mfZ5F0pkI6uuJu0
	oytRSuCMIOKuePJ3eBS98GD4Y8yR0+mSEW1CFZInDFQFQGtQ6aybIQf+lGATl+mCkVjvAS
	Bv9uqeqEjKipDkPqb8YRk0E0bTCt4ULyXEgYj11AP66+iaO0pej0K5kqDozoGdnp3g6kIE
	QADjIdbC4Rb2fXcGo7OGvJ4afzmSSZCRuG2WSJvRB6gDLxIxDlS+byoXg3jYsPtCPt3tXy
	mz5W6+lpGnVsjOfQuAHbg7HE8LLFTei08BImHMANYVlHxFwey+pKUDBBTnKG3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lccNRRk780OLOrvRTmsIIfoLd+zwTDZxXhd+4kcSfCA=;
	b=jBvd0+8wGhqi9YLp+G44n5XgyHsh8eF5MQnWzMNg30j3PgApN0ylxUrS8tq8eAgva7Gr6V
	RLwP5H6AG5silIDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 x86@kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 David Laight <david.laight.linux@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: [patch V4 09/12] [RFC] coccinelle: misc: Add scoped_$MODE_access()
 checker script
References: <20251022102427.400699796@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:49:13 +0200 (CEST)

A common mistake in user access code is that the wrong access mode is
selected for starting the user access section. As most architectures map
Read and Write modes to ReadWrite this goes often unnoticed for quite some
time.

Aside of that the scoped user access mechanism requires that the same
pointer is used for the actual accessor macros that was handed in to start
the scope because the pointer can be modified by the scope begin mechanism
if the architecture supports masking.

Add a basic (and incomplete) coccinelle script to check for the common
issues. The error output is:

kernel/futex/futex.h:303:2-17: ERROR: Invalid pointer for unsafe_put_user(p) in scoped_user_write_access(to)
kernel/futex/futex.h:292:2-17: ERROR: Invalid access mode unsafe_get_user() in scoped_user_write_access()

Not-Yet-Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
---
 scripts/coccinelle/misc/scoped_uaccess.cocci |  108 +++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

--- /dev/null
+++ b/scripts/coccinelle/misc/scoped_uaccess.cocci
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Validate scoped_masked_user*access() scopes
+///
+// Confidence: Zero
+// Options: --no-includes --include-headers
+
+virtual context
+virtual report
+virtual org
+
+@initialize:python@
+@@
+
+scopemap = {
+  'scoped_user_read_access_size'  : 'scoped_user_read_access',
+  'scoped_user_write_access_size' : 'scoped_user_write_access',
+  'scoped_user_rw_access_size'    : 'scoped_user_rw_access',
+}
+
+# Most common accessors. Incomplete list
+noaccessmap = {
+  'scoped_user_read_access'       : ('unsafe_put_user', 'unsafe_copy_to_user'),
+  'scoped_user_write_access'      : ('unsafe_get_user', 'unsafe_copy_from_user'),
+}
+
+# Most common accessors. Incomplete list
+ptrmap = {
+  'unsafe_put_user'			 : 1,
+  'unsafe_get_user'			 : 1,
+  'unsafe_copy_to_user'		 	 : 0,
+  'unsafe_copy_from_user'		 : 0,
+}
+
+print_mode = None
+
+def pr_err(pos, msg):
+   if print_mode == 'R':
+      coccilib.report.print_report(pos[0], msg)
+   elif print_mode == 'O':
+      cocci.print_main(msg, pos)
+
+@r0 depends on report || org@
+iterator name scoped_user_read_access,
+	      scoped_user_read_access_size,
+	      scoped_user_write_access,
+	      scoped_user_write_access_size,
+	      scoped_user_rw_access,
+	      scoped_user_rw_access_size;
+iterator scope;
+statement S;
+@@
+
+(
+(
+scoped_user_read_access(...) S
+|
+scoped_user_read_access_size(...) S
+|
+scoped_user_write_access(...) S
+|
+scoped_user_write_access_size(...) S
+|
+scoped_user_rw_access(...) S
+|
+scoped_user_rw_access_size(...) S
+)
+&
+scope(...) S
+)
+
+@script:python depends on r0 && report@
+@@
+print_mode = 'R'
+
+@script:python depends on r0 && org@
+@@
+print_mode = 'O'
+
+@r1@
+expression sp, a0, a1;
+iterator r0.scope;
+identifier ac;
+position p;
+@@
+
+  scope(sp,...) {
+    <...
+    ac@p(a0, a1, ...);
+    ...>
+  }
+
+@script:python@
+pos << r1.p;
+scope << r0.scope;
+ac << r1.ac;
+sp << r1.sp;
+a0 << r1.a0;
+a1 << r1.a1;
+@@
+
+scope = scopemap.get(scope, scope)
+if ac in noaccessmap.get(scope, []):
+   pr_err(pos, 'ERROR: Invalid access mode %s() in %s()' %(ac, scope))
+
+if ac in ptrmap:
+   ap = (a0, a1)[ptrmap[ac]]
+   if sp != ap.lstrip('&').split('->')[0].strip():
+      pr_err(pos, 'ERROR: Invalid pointer for %s(%s) in %s(%s)' %(ac, ap, scope, sp))


