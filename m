Return-Path: <linux-fsdevel+bounces-65681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD8EC0C6EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 09:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9D714F36AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 08:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38DB2FC017;
	Mon, 27 Oct 2025 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZVzA63Zc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wry6l0Yw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E3E2FC00E;
	Mon, 27 Oct 2025 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554643; cv=none; b=g7li9Ry0bDuu+INFjHs1eisSDwlDG/PzwBN0dQgn/ShOj3E1m0007DC45vZ9XCdlQQYorANRxXuK5GWUILG21k2XI/J/3peIRE4X7es2z7ITE4rPPwg36wsQyswxgZIEDqsfgAXvh12CNnJeo/fK3i2QyuJD3ZrPJ7QvGIsKqfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554643; c=relaxed/simple;
	bh=xYNHqlUV4558B3B1ToI0PaNV5yELgt5cMzX/MaR4N9Q=;
	h=Message-ID:From:To:Subject:References:MIME-Version:Content-Type:
	 cc:Date; b=bZ4nxa2z0y5Zz662fWQbFb5uXV4LJVSK/S9aN1MC22eonS/2ENObnx3CLLO8sbNqSYumwbzoKem/q/aDKnx+bfDou6YJyDLWbywHiTbxz21pfexGVarsyudQL8XTcjHsZdVs7mBc8Q3HS53aUVb6xtZgA+w6aX0XWbaMmTHYkqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZVzA63Zc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wry6l0Yw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027083745.609031602@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=as4pbOCxyeTzYGzifOoPeMiju/LrgMig7nFy3Mj05oM=;
	b=ZVzA63ZcU5mloVrwo8+Jfcyohj0YpcWp8iDv0uosSTIGcM45Tl8yQXKTF3WdtzlsM1z+mJ
	f8TA9NOrPnTyPyVmugWaX5MxqCnytrkuKrBuLV26iaNZqxMEtBr6xJ45WTbOR/vB+3gzzV
	0jNCxcRcapxFnr3bWoJY97mTfcv5YEKGvo7Tq4oSQsHCMrQ6FBCAcYDG+ifbE9gMHosLHb
	zkzf0SDgTCLBEJJbQ1BEUmbtn9GjOI9CG6cUmFHccokGfgEJjy/2JkinfGlDNP8ioNLaW0
	dnn85SIAnHnJayOM5hUUKyanxcds+OjyyMzirFKdQw9EW1wOg2U3qD+4JnQUmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=as4pbOCxyeTzYGzifOoPeMiju/LrgMig7nFy3Mj05oM=;
	b=wry6l0YwTe1mHwd3wZkgxRkSddPV4gTf1dO6fAnvsK4rZdyFD/mI82Mc3upvCPaozRA33y
	FSBO9vnYcONdE5Dw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V5 08/12] uaccess: Provide put/get_user_inline()
References: <20251027083700.573016505@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
cc: kernel test robot <lkp@intel.com>,
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
 Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Date: Mon, 27 Oct 2025 09:43:56 +0100 (CET)

Provide conveniance wrappers around scoped user access similiar to
put/get_user(), which reduce the usage sites to:

       if (!get_user_inline(val, ptr))
       		return -EFAULT;

Should only be used if there is a demonstrable performance benefit.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: Rename to inline
V4: Rename to scoped
---
 include/linux/uaccess.h |   50 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -825,6 +825,56 @@ for (bool done = false; !done; done = tr
 #define scoped_user_rw_access(uptr, elbl)				\
 	scoped_user_rw_access_size(uptr, sizeof(*(uptr)), elbl)
 
+/**
+ * get_user_inline - Read user data inlined
+ * @val:	The variable to store the value read from user memory
+ * @usrc:	Pointer to the user space memory to read from
+ *
+ * Return: 0 if successful, -EFAULT when faulted
+ *
+ * Inlined variant of get_user(). Only use when there is a demonstrable
+ * performance reason.
+ */
+#define get_user_inline(val, usrc)				\
+({								\
+	__label__ efault;					\
+	typeof(usrc) _tmpsrc = usrc;				\
+	int _ret = 0;						\
+								\
+	scoped_user_read_access(_tmpsrc, efault)		\
+		unsafe_get_user(val, _tmpsrc, efault);		\
+	if (0) {						\
+	efault:							\
+		_ret = -EFAULT;					\
+	}							\
+	_ret;							\
+})
+
+/**
+ * put_user_inline - Write to user memory inlined
+ * @val:	The value to write
+ * @udst:	Pointer to the user space memory to write to
+ *
+ * Return: 0 if successful, -EFAULT when faulted
+ *
+ * Inlined variant of put_user(). Only use when there is a demonstrable
+ * performance reason.
+ */
+#define put_user_inline(val, udst)				\
+({								\
+	__label__ efault;					\
+	typeof(udst) _tmpdst = udst;				\
+	int _ret = 0;						\
+								\
+	scoped_user_write_access(_tmpdst, efault)		\
+		unsafe_put_user(val, _tmpdst, efault);		\
+	if (0) {						\
+	efault:							\
+		_ret = -EFAULT;					\
+	}							\
+	_ret;							\
+})
+
 #ifdef CONFIG_HARDENED_USERCOPY
 void __noreturn usercopy_abort(const char *name, const char *detail,
 			       bool to_user, unsigned long offset,


