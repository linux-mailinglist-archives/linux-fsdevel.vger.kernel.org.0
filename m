Return-Path: <linux-fsdevel+bounces-65100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81662BFBF6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4476188284E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 12:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3F03491EA;
	Wed, 22 Oct 2025 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YCUM+m2I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IZpjJMDC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD796346E72;
	Wed, 22 Oct 2025 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137370; cv=none; b=CHSwDeQ+84EbMiRZzpiccLFvE6fdiTA21zLvWHzFou6lumQSon0oalk3xd23I4udpFCJMTPSLg3IP6WQnTVRE7Goazk8+a2ijZn2Ssw9ZBDJ/uYmIIDDBSAAqVQnOxVuzr2Yrucgn4/Vy2HJfzSCyeIVCXTaGDS5bRl5k55J2OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137370; c=relaxed/simple;
	bh=7r3/a/NFbc1wdYwqjmEXZSkW3O7gggboTKfkaRskPyY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=cwW0T3tuijcjZAnX2Ag4GghZgDf/2baVPEoP8rl04ORIsuROhd+3AzouCx+0+oTrB27CYlgr7HUTUaOHiC3/JPLF4x+/9+35ZvZmmHCIQbIomeOfTlU1JuFNoQJN1Y7DzOHI14QVg0gCRn6SgHKQ1DTQgN6ZcCBf0xu4aZuVrOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YCUM+m2I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IZpjJMDC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022103112.478876605@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=CaAPbzoialu5mXFNLErT5ZTF4fpG+LkmcGL7QamE02U=;
	b=YCUM+m2IJhIlYNc3cw3Ka+JSw1r0rxQfagyYMBCbI5G0Wlrimf1GqVMRdPE4fE3q4DTDLL
	I3sZqCcSstmzPTAmKHsfJLX2C34OtucmDjHa59k+mhfvh5+9VviczJU5Sds0cipnh9SwfO
	oWZS+Qqu+HQ4gtdRXc2up+rIBxMO9BqQkbGhl/pgs0VaF5lnHLpP1SJqiRYu7DsIVtGwog
	iJzQBkR3BVxzibX9Vi4X6eSTOXUzrvM9S2tLua3pO5DkDcic3JptOzX0xEuxlfeEOEsy1h
	aSrVdebfZCKdTbD1hru16EJ14VbE11jH6OE5kYTFRDrxovf+JUjMjnVnSMwjFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=CaAPbzoialu5mXFNLErT5ZTF4fpG+LkmcGL7QamE02U=;
	b=IZpjJMDCZvmWlpmGgE3lhdOQmOPckYbthUby0iY/Im/yxFE9DkRTg5O+cgCbWyzDN24LUx
	wOuZ0lgHzEUESmCA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
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
 Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: [patch V4 10/12] futex: Convert to scoped user access
References: <20251022102427.400699796@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:49:14 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Replace the open coded implementation with the new get/put_user_scoped()
helpers.

No functional change intended

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "André Almeida" <andrealmeid@igalia.com>
---
V4: Rename once moar
V3: Adapt to scope changes
V2: Convert to scoped variant
---
 kernel/futex/futex.h |   37 ++-----------------------------------
 1 file changed, 2 insertions(+), 35 deletions(-)
---
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -285,48 +285,15 @@ static inline int futex_cmpxchg_value_lo
  * This does a plain atomic user space read, and the user pointer has
  * already been verified earlier by get_futex_key() to be both aligned
  * and actually in user space, just like futex_atomic_cmpxchg_inatomic().
- *
- * We still want to avoid any speculation, and while __get_user() is
- * the traditional model for this, it's actually slower than doing
- * this manually these days.
- *
- * We could just have a per-architecture special function for it,
- * the same way we do futex_atomic_cmpxchg_inatomic(), but rather
- * than force everybody to do that, write it out long-hand using
- * the low-level user-access infrastructure.
- *
- * This looks a bit overkill, but generally just results in a couple
- * of instructions.
  */
 static __always_inline int futex_get_value(u32 *dest, u32 __user *from)
 {
-	u32 val;
-
-	if (can_do_masked_user_access())
-		from = masked_user_access_begin(from);
-	else if (!user_read_access_begin(from, sizeof(*from)))
-		return -EFAULT;
-	unsafe_get_user(val, from, Efault);
-	user_read_access_end();
-	*dest = val;
-	return 0;
-Efault:
-	user_read_access_end();
-	return -EFAULT;
+	return get_user_scoped(*dest, from) ? 0 : -EFAULT;
 }
 
 static __always_inline int futex_put_value(u32 val, u32 __user *to)
 {
-	if (can_do_masked_user_access())
-		to = masked_user_access_begin(to);
-	else if (!user_write_access_begin(to, sizeof(*to)))
-		return -EFAULT;
-	unsafe_put_user(val, to, Efault);
-	user_write_access_end();
-	return 0;
-Efault:
-	user_write_access_end();
-	return -EFAULT;
+	return put_user_scoped(val, to) ? 0 : -EFAULT;
 }
 
 static inline int futex_get_value_locked(u32 *dest, u32 __user *from)


