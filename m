Return-Path: <linux-fsdevel+bounces-61785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7128BB59DC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 18:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90A2F7B7D37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFB1393DF4;
	Tue, 16 Sep 2025 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L0Z/lwtG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f1EJzrU9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D923469F6;
	Tue, 16 Sep 2025 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040397; cv=none; b=tDkK+CPvyMMgOPpSc7qiq2MyVMg+ugVNB0H34Um+hLDRTEHNopQIzaBSXben6haPguXD/WW388pZCLjAS+uJrVY2ddVPW5iPtolg8/FqlV9xI1WN3SdBzcpnj677UFPx+KAiawQQNj1DBTL3XRtgbLolvp4c33r7A6F9iRJ2EJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040397; c=relaxed/simple;
	bh=/wayF/ykjt3o2/TfwFdRNrfa6lQV/ms4kUq0GZMusQo=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=mk+Os+eF7TsTognwp/gpAFrBBlQIUSijPidzCr4XRVJEQW8GPFvvJW/6S3AwO0q/b9iGcKhn3gLJx/lw5hapCAJ7KXFvImI9XjQmvVYT9Zs7IftA3+0a06hx/mzBgu8qDgSt9HeV/2efTOsoKsMQJtrXVa8DhtFLlQg7LouSyts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L0Z/lwtG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f1EJzrU9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250916163252.164475057@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758040393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ib+tYvB6+raN75IBUSlEV2Q6chmKOOXAleDMdfewJ7k=;
	b=L0Z/lwtGPk9Sgdt1ZYlxMINPo7dV83sl/4KOmCNUKFnOp8/6rpB/AF2j6b3HxDvIZ/drww
	pZn3nnBgf0AJwf2Bx/4rkB3T+ramZxTEO+ybShnv9ruhIOlaD+GDCpEmVZwLF84QG087vw
	1gvdVKAZRqf+Mu1XVEw275JvQewA3ldn/uBitiVMO1FpjY0eEr05vanETrpGJ5008wifTh
	3Chl3wMmSbFbCwHkbeRqrdu0tRAV80NW6bHlkwhJiKPj1EK5nUB490aeksetB2s1OTIkeQ
	lIwSFGzHnXv8x0FAPzcF+zrecYNa0vLk+i4/LhPOjhfojTl3iBKUfTqlR3XT/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758040393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ib+tYvB6+raN75IBUSlEV2Q6chmKOOXAleDMdfewJ7k=;
	b=f1EJzrU944K2BVtYrVkMXmBt5BXNx/99RSi+rW/mpOel4RkYY/i6thuBmiuuuf+Gsor2CC
	CoY9EhUuPQA7pxBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Nathan Chancellor <nathan@kernel.org>,
 Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 x86@kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: [patch V2 3/6] uaccess: Provide scoped masked user access regions
References: <20250916163004.674341701@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Sep 2025 18:33:13 +0200 (CEST)

User space access regions are tedious and require similar code patterns all
over the place:

     	if (!user_read_access_begin(from, sizeof(*from)))
		return -EFAULT;
	unsafe_get_user(val, from, Efault);
	user_read_access_end();
	return 0;
Efault:
	user_read_access_end();
	return -EFAULT;

This got worse with the recend addition of masked user access, which
optimizes the speculation prevention:

	if (can_do_masked_user_access())
		from = masked_user_read_access_begin((from));
	else if (!user_read_access_begin(from, sizeof(*from)))
		return -EFAULT;
	unsafe_get_user(val, from, Efault);
	user_read_access_end();
	return 0;
Efault:
	user_read_access_end();
	return -EFAULT;

There have been issues with using the wrong user_*_access_end() variant in
the error path and other typical Copy&Pasta problems, e.g. using the wrong
fault label in the user accessor which ends up using the wrong accesss end
variant. 

These patterns beg for scopes with automatic cleanup. The resulting outcome
is:
    	scoped_masked_user_read_access(from, return -EFAULT,
		scoped_get_user(val, from); );
	return 0;

The scope guarantees the proper cleanup for the access mode is invoked both
in the success and the failure (fault) path

The fault label is scope local and always 'scope_fault:', which prevents
mixing up fault labels between scopes. It is marked __maybe_unused so that
user access, which does not use a fault label and modifies a result
variable in the exception handler, does not cause a defined but unused
warning.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
---
V2: Remove the shady wrappers around the opening and use scopes with automatic cleanup
---
 include/linux/uaccess.h |  151 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_UACCESS_H__
 #define __LINUX_UACCESS_H__
 
+#include <linux/cleanup.h>
 #include <linux/fault-inject-usercopy.h>
 #include <linux/instrumented.h>
 #include <linux/minmax.h>
@@ -35,9 +36,17 @@
 
 #ifdef masked_user_access_begin
  #define can_do_masked_user_access() 1
+# ifndef masked_user_write_access_begin
+#  define masked_user_write_access_begin masked_user_access_begin
+# endif
+# ifndef masked_user_read_access_begin
+#  define masked_user_read_access_begin masked_user_access_begin
+#endif
 #else
  #define can_do_masked_user_access() 0
  #define masked_user_access_begin(src) NULL
+ #define masked_user_read_access_begin(src) NULL
+ #define masked_user_write_access_begin(src) NULL
  #define mask_user_address(src) (src)
 #endif
 
@@ -569,6 +578,148 @@ static inline void user_access_restore(u
 #define user_read_access_end user_access_end
 #endif
 
+/* Define RW variant so the below _mode macro expansion works */
+#define masked_user_rw_access_begin(u)	masked_user_access_begin(u)
+#define user_rw_access_begin(u, s)	user_access_begin(u, s)
+#define user_rw_access_end()		user_access_end()
+
+/* Scoped user access */
+#define USER_ACCESS_GUARD(_mode)					\
+static __always_inline void __user *					\
+class_masked_user_##_mode##_begin(void __user *ptr)			\
+{									\
+	return ptr;							\
+}									\
+									\
+static __always_inline void						\
+class_masked_user_##_mode##_end(void __user *ptr)			\
+{									\
+	user_##_mode##_access_end();					\
+}									\
+									\
+DEFINE_CLASS(masked_user_ ##_mode## _access, void __user *,		\
+	     class_masked_user_##_mode##_end(_T),			\
+	     class_masked_user_##_mode##_begin(ptr), void __user *ptr)	\
+									\
+static __always_inline class_masked_user_##_mode##_access_t		\
+class_masked_user_##_mode##_access_ptr(void __user *scope)		\
+{									\
+	return scope;							\
+}									\
+
+USER_ACCESS_GUARD(read)
+USER_ACCESS_GUARD(write)
+USER_ACCESS_GUARD(rw)
+#undef USER_ACCESS_GUARD
+
+/**
+ * __scoped_masked_user_access - Open a scope for masked user access
+ * @_mode:	The mode of the access class (read, write, rw)
+ * @_uptr:	The pointer to access user space memory
+ * @_ecode:	Code to inject for the failure case
+ * @_code:	The code to inject inside the scope
+ *
+ * When the scope is left user_##@_mode##_access_end() is invoked, if the
+ * corresponding user_##@_mode##_masked_begin() succeeded.
+ *
+ * The user access function inside the scope must use a fault label, which
+ * is inside the scope. __scoped_masked_user_access() provides a default
+ * label @scope_label, which is placed right before @_ecode. This label is
+ * scope local, so multiple masked user scopes can be in one function.
+ *
+ * The user access helpers scoped_put_user() and scoped_get_user() use
+ * @scope_label automatically.
+ *
+ *  A single line statement in the scope::
+ *
+ *	scoped_masked_user_read_access(ptr, return false,
+ *		scoped_get_user(val, ptr););
+ *
+ *  Multi-line statement::
+ *
+ *	scoped_masked_user_rw_access(ptr, return false, {
+ *		scoped_get_user(rval, &ptr->rval);
+ *		scoped_put_user(wval, &ptr->wval);
+ *	});
+ */
+#define __scoped_masked_user_access(_mode, _uptr, _ecode, _code)	\
+do {									\
+	unsigned long size = sizeof(*(_uptr));				\
+	typeof((_uptr)) _tmpptr = (_uptr);				\
+	bool proceed = true;						\
+									\
+	/*								\
+	 * Must be outside the CLASS scope below to handle the fail	\
+	 * of the non-masked access_begin() case correctly.		\
+	 */								\
+	if (can_do_masked_user_access())				\
+		_tmpptr = masked_user_##_mode##_access_begin((_uptr));	\
+	else								\
+		proceed = user_##_mode##_access_begin((_uptr), size);	\
+									\
+	if (!proceed) {							\
+		_ecode;							\
+	} else {							\
+		__label__ scope_fault;					\
+		CLASS(masked_user_##_mode##_access, scope) (_tmpptr);	\
+		/* Force modified pointer usage in @_code */		\
+		const typeof((_uptr)) _uptr = _tmpptr;			\
+									\
+		_code;							\
+		if (0) {						\
+		scope_fault:						\
+			__maybe_unused;					\
+			_ecode;						\
+		}							\
+	}								\
+} while (0)
+
+/**
+ * scoped_masked_user_read_access - Start a scoped __user_masked_read_access()
+ * @_usrc:	Pointer to the user space address to read from
+ * @_ecode:	Code to inject for the failure case
+ *
+ * For further information see __scoped_masked_user_access() above.
+ */
+#define scoped_masked_user_read_access(_usrc, _ecode, _code)	\
+	__scoped_masked_user_access(read, (_usrc), _ecode, ({_code}))
+
+/**
+ * scoped_masked_user_write_access - Start a scoped __user_masked_write_access()
+ * @_udst:	Pointer to the user space address to write to
+ * @_ecode:	Code to inject for the failure case
+ *
+ * For further information see __scoped_masked_user_access() above.
+ */
+#define scoped_masked_user_write_access(_udst, _ecode, _code)	\
+	__scoped_masked_user_access(write, (_udst), _ecode, ({_code}))
+
+/**
+ * scoped_masked_user_rw_access - Start a scoped __user_masked_rw_access()
+ * @_uptr	Pointer to the user space address to read from and write to
+ * @_ecode:	Code to inject for the failure case
+ *
+ * For further information see __scoped_masked_user_access() above.
+ */
+#define scoped_masked_user_rw_access(_uptr, _ecode, _code)	\
+	__scoped_masked_user_access(rw, (_uptr), _ecode, ({_code}))
+
+/**
+ * scoped_get_user - Read user memory from within a scoped masked access section
+ * @_dst:	The destination variable to store the read value
+ * @_usrc:	Pointer to the user space address to read from
+ */
+#define scoped_get_user(_dst, _usrc)				\
+	unsafe_get_user((_dst), (_usrc), scope_fault)
+
+/**
+ * scoped_put_user - Write user memory from within a scoped masked access section
+ * @_val:	Value to write
+ * @_udst:	Pointer to the user space address to write to
+ */
+#define scoped_put_user(_val, _udst)				\
+	unsafe_put_user((_val), (_udst), scope_fault)
+
 #ifdef CONFIG_HARDENED_USERCOPY
 void __noreturn usercopy_abort(const char *name, const char *detail,
 			       bool to_user, unsigned long offset,


