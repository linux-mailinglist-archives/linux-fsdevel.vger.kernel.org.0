Return-Path: <linux-fsdevel+bounces-4992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D45C806FF7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 13:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15311F214CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC9B36AE3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hS+fTvAJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C511BD
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 04:00:08 -0800 (PST)
Received: by mail-lf1-x14a.google.com with SMTP id 2adb3069b0e04-50bfd790d42so2453304e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 04:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701864007; x=1702468807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4h5TtcDHBkvr+2eo+ds5tqRTeDmTOKySCbN+YJdlDo=;
        b=hS+fTvAJRnWwcfurJLNGFWS3IHxZsryQ6Rn8J4ZuDm1MWhcHDrB0v1pt5A0oQ6Wpyc
         BQ6Ij/t6nFxu0p8cgH7SSTE/Cv1wisxZ4bebeQroSJYUTBRYsZTC1WJKq7m5zcg4cFxA
         EOvuY/81Bs32oUxT0NcSsANhjvBwpqi1wvOgpfpS6clbTrAx726DbkRSraGFWxcFaGF9
         9GYlZ2DWjpuEY9DZfG2onAEiqLvnMZm9GKrxItAHq6vM51fuubC08Wwtq+fRfnLUXf9O
         kCFJw/op40SfNHqmNotit4q5Kc+ET10zTpDr8kYGL3Bg0qpvZsGYd4UAZ7Jg8Jr9+KXY
         0upA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701864007; x=1702468807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4h5TtcDHBkvr+2eo+ds5tqRTeDmTOKySCbN+YJdlDo=;
        b=Qu9HIqVYDKL9mzWgGSC9sJZe0G2RJfnG6tnzQUYSF9KC45IAq3xQ8E/ZLw0RuG2QR7
         F3exj7dpAwuL2VNSG9VrTEHbdWaw0ZzsTeaSHT9CCJY6ZAhHJicy/VsoFonrVI9x2Q3B
         fBzfTHvCgxDzY0De3Z+mjYjtqcFVzCrR8Q67DMYCyrn2redJfUYBHEm7dbDWWBOMyKk8
         BOYXTtB4isoQjA7G9UgMjXcANo8rsf8oepGrpbv19H6iDOAmhln0CiWjkPtZKxhMxdZb
         3zO3/ddQ+MOtl7UWgzomaVoLRo/DJXfDCETJUN5P41XWlB3HalO8VnXQ20qGeJqIbGBY
         wVrw==
X-Gm-Message-State: AOJu0Yy2pG1oAPun6ENlVKEBGA4FXlnzp6speEpxdPPl3L5HFjm4TQq0
	uPVxKpQaSD31JP1ULPoQpyT9iI0v6B9MJ3A=
X-Google-Smtp-Source: AGHT+IFUlZXxN3xc9glrJ6y1laVME7KrGF3BWN6lxwqRCFh67SrX2kH7P2bsaNKZLkZviIk70A8VgUdmvGVDgr8=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:2810:b0:50b:fa87:ec7e with SMTP
 id cf16-20020a056512281000b0050bfa87ec7emr8592lfb.2.1701864006500; Wed, 06
 Dec 2023 04:00:06 -0800 (PST)
Date: Wed, 06 Dec 2023 11:59:47 +0000
In-Reply-To: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6664; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Vm1W1WVMEXarXNOCcD4vjJx3cnrZOnPrxh0AiYWusOY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlcGI5vSsFMnG38B3rWjePZ20b8+wpfFKfcctgA
 AqrR4pi9vaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZXBiOQAKCRAEWL7uWMY5
 RhjUD/9DPZhmptqt8Yroautfb0PINF75GwF4YPTEeGm0XoT5DCH1WcBy03aPyiSnRkYxIr7fYai
 GLxLHjowK7BpyV+WajJyrBODTVO68sorORLofCHjoVHJEEDc/iczDs1NEunjShzU8dw19Kw2MG2
 G77RmtsMjIbTJW9xhEqyHkRCJQ50qeaqOcao+NMpWFmiN4MIeW4i1TzQjkj8v/RW4FrxSHybv6g
 4qOckgZNBsTKix4WqoxtuImFWZkBflfoC+54yPEsgpZUU6cyNP34Ur3LJA04s4wygkvyB4LZ2bI
 8zaU1SO9ByC8rYGIjbi5uZVjoZ0Gm9GMHCxeJEZgR45bN8tXut1WnpiQ0WhSzmG86HPmr/ZqqAv
 SiBt85Qfmhu5+f5vRry13WuhAmThCT4RZ0R7lvjocrhJAlgM5jY/hSfL/aqiyAmtWFJeelNbd8K
 /SXoyZ9WNFsalnzfYMYmlKrN+7ZE8Pb6J/cxcHYBClVUeIEmoGLdSZLr8FwJZZJqc8EihN4tTeH
 1E0n9BRU6OgkI4i19R/Mq2P3n1tyDExnRVgWwiE71sidFDqWWNLzeEz7lHb4GjJWzqsrQoD2xHY
 +PIerDizftBdGkiP+KWRYeSvAxUO91VfeQyOIuv+grXGLBsFUwc06+0D/9FMn+llXafWX/SYbOR s3mvrbcakKZ+eyw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231206-alice-file-v2-2-af617c0d9d94@google.com>
Subject: [PATCH v2 2/7] rust: cred: add Rust abstraction for `struct cred`
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
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add a wrapper around `struct cred` called `Credential`, and provide
functionality to get the `Credential` associated with a `File`.

Rust Binder must check the credentials of processes when they attempt to
perform various operations, and these checks usually take a
`&Credential` as parameter. The security_binder_set_context_mgr function
would be one example. This patch is necessary to access these security_*
methods from Rust.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  | 13 +++++++++
 rust/kernel/cred.rs             | 64 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/file.rs             | 16 +++++++++++
 rust/kernel/lib.rs              |  1 +
 5 files changed, 95 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index beed3ef1fbc3..6d1bd2229aab 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <linux/cred.h>
 #include <linux/errname.h>
 #include <linux/file.h>
 #include <linux/fs.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index 03141a3608a4..10ed69f76424 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -23,6 +23,7 @@
 #include <kunit/test-bug.h>
 #include <linux/bug.h>
 #include <linux/build_bug.h>
+#include <linux/cred.h>
 #include <linux/err.h>
 #include <linux/errname.h>
 #include <linux/fs.h>
@@ -164,6 +165,18 @@ struct file *rust_helper_get_file(struct file *f)
 }
 EXPORT_SYMBOL_GPL(rust_helper_get_file);
 
+const struct cred *rust_helper_get_cred(const struct cred *cred)
+{
+	return get_cred(cred);
+}
+EXPORT_SYMBOL_GPL(rust_helper_get_cred);
+
+void rust_helper_put_cred(const struct cred *cred)
+{
+	put_cred(cred);
+}
+EXPORT_SYMBOL_GPL(rust_helper_put_cred);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
new file mode 100644
index 000000000000..497058ec89bb
--- /dev/null
+++ b/rust/kernel/cred.rs
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Credentials management.
+//!
+//! C header: [`include/linux/cred.h`](../../../../include/linux/cred.h)
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/security/credentials.html>
+
+use crate::{
+    bindings,
+    types::{AlwaysRefCounted, Opaque},
+};
+
+/// Wraps the kernel's `struct cred`.
+///
+/// # Invariants
+///
+/// Instances of this type are always ref-counted, that is, a call to `get_cred` ensures that the
+/// allocation remains valid at least until the matching call to `put_cred`.
+#[repr(transparent)]
+pub struct Credential(pub(crate) Opaque<bindings::cred>);
+
+// SAFETY: By design, the only way to access a `Credential` is via an immutable reference or an
+// `ARef`. This means that the only situation in which a `Credential` can be accessed mutably is
+// when the refcount drops to zero and the destructor runs. It is safe for that to happen on any
+// thread, so it is ok for this type to be `Send`.
+unsafe impl Send for Credential {}
+
+// SAFETY: It's OK to access `Credential` through shared references from other threads because
+// we're either accessing properties that don't change or that are properly synchronised by C code.
+unsafe impl Sync for Credential {}
+
+impl Credential {
+    /// Creates a reference to a [`Credential`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`Credential`] reference.
+    pub unsafe fn from_ptr<'a>(ptr: *const bindings::cred) -> &'a Credential {
+        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
+        // `Credential` type being transparent makes the cast ok.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Returns the effective UID of the given credential.
+    pub fn euid(&self) -> bindings::kuid_t {
+        // SAFETY: By the type invariant, we know that `self.0` is valid.
+        unsafe { (*self.0.get()).euid }
+    }
+}
+
+// SAFETY: The type invariants guarantee that `Credential` is always ref-counted.
+unsafe impl AlwaysRefCounted for Credential {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::get_cred(self.0.get()) };
+    }
+
+    unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
+        unsafe { bindings::put_cred(obj.cast().as_ptr()) };
+    }
+}
diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
index 29e1aacacd06..a88140794a8d 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -7,6 +7,7 @@
 
 use crate::{
     bindings,
+    cred::Credential,
     error::{code::*, Error, Result},
     types::{ARef, AlwaysRefCounted, Opaque},
 };
@@ -151,6 +152,21 @@ pub fn as_ptr(&self) -> *mut bindings::file {
         self.0.get()
     }
 
+    /// Returns the credentials of the task that originally opened the file.
+    pub fn cred(&self) -> &Credential {
+        // SAFETY: Since the caller holds a reference to the file, it is guaranteed that its
+        // refcount does not hit zero during this function call.
+        //
+        // It's okay to read the `f_cred` field without synchronization as `f_cred` is never
+        // changed after initialization of the file.
+        let ptr = unsafe { (*self.as_ptr()).f_cred };
+
+        // SAFETY: The signature of this function ensures that the caller will only access the
+        // returned credential while the file is still valid, and the C side ensures that the
+        // credential stays valid at least as long as the file.
+        unsafe { Credential::from_ptr(ptr) }
+    }
+
     /// Returns the flags associated with the file.
     ///
     /// The flags are a combination of the constants in [`flags`].
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ce9abceab784..097fe9bb93ed 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -33,6 +33,7 @@
 #[cfg(not(testlib))]
 mod allocator;
 mod build_assert;
+pub mod cred;
 pub mod error;
 pub mod file;
 pub mod init;

-- 
2.43.0.rc2.451.g8631bc7472-goog


