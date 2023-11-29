Return-Path: <linux-fsdevel+bounces-4193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6895C7FD98D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 15:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8971C203D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4731C6A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jbrtbR+e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B55B2
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 05:11:31 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db402e6f61dso7808614276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 05:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701263490; x=1701868290; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+PIqA5OWa+CUhuOr08fI/v9F95ZV2PMUhXtjoxfvkw=;
        b=jbrtbR+eeVkBLFt/BX0FL6SIkn4LGE/FDZkIJSwEH0SbY34WaGJ8BQK/MaWUqhJrFW
         QpFN2AljKfuPtdTIb9yNFPK8war4fcZVV272UY6BMKh4fr8RLn9JznEyccThFow5lJgs
         Z3l6aSu5iXFJOUPqCvT+uyplCOR4AWzIDkTSvbYpKVHLtPZi4advoPxPAp8MvgJ0hQvW
         2bCfuI5csWgGqeZ/uaMBF+M7+ueO2ILP8TeDIgBlol+fySHsTXckNZ6s4wHKh3J3o6mf
         +Y7IUZ8RgBSrGsFOiU6esYlqjX4x+YRTSVV74xihLmE13lrvBX5wg4z1WA5mWtbS+zBs
         3Npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701263490; x=1701868290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+PIqA5OWa+CUhuOr08fI/v9F95ZV2PMUhXtjoxfvkw=;
        b=rlRGkil9n/hvMG0Z/S0QwfZzuLIElA0VRHVhd5demu+clHYhncZRBvvwujzxcWCM8u
         k+dgaDYupW98CPo5umy6klhqcETzbLwgjmEUXUdYRH4x9GAx9s7nBQU8ixJgYlnz6vco
         PpKSq2bco+SN8qhRBcwNAHzv7uupafpxNo/KefYGBguvfl1yzzQI9sDkMFMWm87AxAt0
         TGlGHz1UL4fatHKCwylPr+RYyNbFFgysXg0PRZWIS4eJZ349//g3OfVDzi4y//hW/POL
         HFHlo81SoQ/DoPec7xfLr4Q9Vsts+dq5dnELfKkUpZmw0DIwPONK639xZdHcclnfHo6Z
         ZXOw==
X-Gm-Message-State: AOJu0Ywb50T3cnQnL1cbOgCngdJvONxQS4xKSrSf6qiWtW7QVDYkpnWw
	TCtS5D/3TZMjTKdyldkfuqrd7+ZseJWOw8Y=
X-Google-Smtp-Source: AGHT+IHmespvZy5s7Ip3mJ0mf6eFh6ZLQ6vzLqsvwESBu9GnbHUlPsKFocbK51mB9QzS1IwGPqksJwjBqcM/HnY=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:bac9:0:b0:daf:52c3:c373 with SMTP id
 a9-20020a25bac9000000b00daf52c3c373mr273071ybk.8.1701263490273; Wed, 29 Nov
 2023 05:11:30 -0800 (PST)
Date: Wed, 29 Nov 2023 13:11:25 +0000
In-Reply-To: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6420; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=47u/r70ygVSpW6vTYUCJ4BVeloqGeXZGkJcYMBqQg5o=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlZzhqhiX8DHIjTD2wKQWwc5SHo00Hr117qRf8U
 TxwjCk011eJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZWc4agAKCRAEWL7uWMY5
 RlqSD/9V5u/KKAdd4dXT2nyIcvtct0CAtU1kWe8krQxKvkXaq8ZGPyvco0tDjo+c5HOtgJdzHzi
 9qi4W29Lt1TXWnku8QlgiagDyAnR5evvmSeU2/KS4kqWwJ6idD8HucS3wKMNrz8nwIo78z3rgYw
 iKlmXEBG7iu2HLzV7ydPqa6kxTeBtp35JZmxK+1ALPqdaqPDQeGeKFv7w4UZ4lrwN0sEO9A7JlK
 ugnfZy4Mq80QPK6EB33wbykZBTRZ+PVg6hu4FzF2QtcgO3UOgZ3vXG3dp3oVGoAeXEWqVfp+6g4
 zbodTxkRiu3oG1RvhUq6kdMUi/xGV7auHqnPi+UdDEYkgZBCjZ3Y68PlpoH2Lxv6tQ1z/cvOLfH
 +cEW17uRBvtCPOPas1jWn3zQYlTeirdGoZ7OI9fmdUu+/Ml6rSyfHRYxWUtGUH4oHk+xK1gioV2
 E0cEehl7bhy2UsgiTXobXdP13h+V/FoXriA0yhAbC3TOi0+kPmVRGQ2WvUJmAuVUgWQXKhbEjRN
 S6zpacIfQ+HZKP299C7x99V5gZytW/6SuwT0JQiYVM53oT50hj0bL9VbWQV7bX9rY0VuDzn/no/
 qhJEBQ3JuvngATVmkctd1htWsNSZBdLOPPqKM7OIUNaBKWORXXEYnK5uqfC6jLyrYxFbA4I8XEb yEY0RLsm5tug3VA==
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129-alice-file-v1-3-f81afe8c7261@google.com>
Subject: [PATCH 3/7] rust: security: add abstraction for secctx
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Adds an abstraction for viewing the string representation of a security
context.

This is needed by Rust Binder because it has feature where a process can
view the string representation of the security context for incoming
transactions. The process can use that to authenticate incoming
transactions, and since the feature is provided by the kernel, the
process can trust that the security context is legitimate.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  | 21 +++++++++
 rust/kernel/cred.rs             |  8 ++++
 rust/kernel/lib.rs              |  1 +
 rust/kernel/security.rs         | 78 +++++++++++++++++++++++++++++++++
 5 files changed, 109 insertions(+)
 create mode 100644 rust/kernel/security.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 6d1bd2229aab..81b13a953eae 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -11,6 +11,7 @@
 #include <linux/errname.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
 #include <linux/wait.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index 10ed69f76424..fd633d9db79a 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -30,6 +30,7 @@
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/sched/signal.h>
+#include <linux/security.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
@@ -177,6 +178,26 @@ void rust_helper_put_cred(const struct cred *cred)
 }
 EXPORT_SYMBOL_GPL(rust_helper_put_cred);
 
+#ifndef CONFIG_SECURITY
+void rust_helper_security_cred_getsecid(const struct cred *c, u32 *secid)
+{
+	security_cred_getsecid(c, secid);
+}
+EXPORT_SYMBOL_GPL(rust_helper_security_cred_getsecid);
+
+int rust_helper_security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+{
+	return security_secid_to_secctx(secid, secdata, seclen);
+}
+EXPORT_SYMBOL_GPL(rust_helper_security_secid_to_secctx);
+
+void rust_helper_security_release_secctx(char *secdata, u32 seclen)
+{
+	security_release_secctx(secdata, seclen);
+}
+EXPORT_SYMBOL_GPL(rust_helper_security_release_secctx);
+#endif
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
index 497058ec89bb..3794937b5294 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -43,6 +43,14 @@ pub unsafe fn from_ptr<'a>(ptr: *const bindings::cred) -> &'a Credential {
         unsafe { &*ptr.cast() }
     }
 
+    /// Get the id for this security context.
+    pub fn get_secid(&self) -> u32 {
+        let mut secid = 0;
+        // SAFETY: The invariants of this type ensures that the pointer is valid.
+        unsafe { bindings::security_cred_getsecid(self.0.get(), &mut secid) };
+        secid
+    }
+
     /// Returns the effective UID of the given credential.
     pub fn euid(&self) -> bindings::kuid_t {
         // SAFETY: By the type invariant, we know that `self.0` is valid.
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 097fe9bb93ed..342cb02c495a 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -42,6 +42,7 @@
 pub mod kunit;
 pub mod prelude;
 pub mod print;
+pub mod security;
 mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
new file mode 100644
index 000000000000..69c10ed89a57
--- /dev/null
+++ b/rust/kernel/security.rs
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Linux Security Modules (LSM).
+//!
+//! C header: [`include/linux/security.h`](../../../../include/linux/security.h).
+
+use crate::{
+    bindings,
+    error::{to_result, Result},
+};
+
+/// A security context string.
+///
+/// The struct has the invariant that it always contains a valid security context.
+pub struct SecurityCtx {
+    secdata: *mut core::ffi::c_char,
+    seclen: usize,
+}
+
+impl SecurityCtx {
+    /// Get the security context given its id.
+    pub fn from_secid(secid: u32) -> Result<Self> {
+        let mut secdata = core::ptr::null_mut();
+        let mut seclen = 0;
+        // SAFETY: Just a C FFI call. The pointers are valid for writes.
+        unsafe {
+            to_result(bindings::security_secid_to_secctx(
+                secid,
+                &mut secdata,
+                &mut seclen,
+            ))?;
+        }
+
+        // If the above call did not fail, then we have a valid security
+        // context, so the invariants are not violated.
+        Ok(Self {
+            secdata,
+            seclen: usize::try_from(seclen).unwrap(),
+        })
+    }
+
+    /// Returns whether the security context is empty.
+    pub fn is_empty(&self) -> bool {
+        self.seclen == 0
+    }
+
+    /// Returns the length of this security context.
+    pub fn len(&self) -> usize {
+        self.seclen
+    }
+
+    /// Returns the bytes for this security context.
+    pub fn as_bytes(&self) -> &[u8] {
+        let mut ptr = self.secdata;
+        if ptr.is_null() {
+            // Many C APIs will use null pointers for strings of length zero, but
+            // `slice::from_raw_parts` doesn't allow the pointer to be null even if the length is
+            // zero. Replace the pointer with a dangling but non-null pointer in this case.
+            debug_assert_eq!(self.seclen, 0);
+            ptr = core::ptr::NonNull::dangling().as_ptr();
+        }
+
+        // SAFETY: The call to `security_secid_to_secctx` guarantees that the pointer is valid for
+        // `seclen` bytes. Furthermore, if the length is zero, then we have ensured that the
+        // pointer is not null.
+        unsafe { core::slice::from_raw_parts(ptr.cast(), self.seclen) }
+    }
+}
+
+impl Drop for SecurityCtx {
+    fn drop(&mut self) {
+        // SAFETY: This frees a pointer that came from a successful call to
+        // `security_secid_to_secctx`.
+        unsafe {
+            bindings::security_release_secctx(self.secdata, self.seclen as u32);
+        }
+    }
+}
-- 
2.43.0.rc1.413.gea7ed67945-goog


