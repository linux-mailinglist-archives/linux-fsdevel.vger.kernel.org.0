Return-Path: <linux-fsdevel+bounces-4995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB6D806FFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 13:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953061F215C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FF636B0C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="No3XEkct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C585D47
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 04:00:17 -0800 (PST)
Received: by mail-lf1-x14a.google.com with SMTP id 2adb3069b0e04-50bf87fcb29so3018122e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 04:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701864015; x=1702468815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ex3XFDrwLoR/nkrJxHEDseFTPk4W5eJ7YuU+mGVpLsc=;
        b=No3XEkcta1a6FXzlMWKhKCqGE75LE+SEfRNsTmERIWjCzRa7NuaHpzxJrdR7vbZjtf
         GqyMHe4CmEsqr4z38KG1OMOBqBlneNmRNACrobnjHXxJWm/2+SE67uVDCQrSdbSV5oqp
         +ekkN9btKDV6bax6xMnx0a/Er+9Wfsk+a1U7h5Nje7wumV35TTaRs54FL51N76dGsapz
         2Cq/+COiZHGKyNN940AHyvwqQLI33YrqOu5T0Qe16h5NR9DtfnND3gC6e6INkCf/0vQp
         VK4LIV9vYGl9rS5/SwVo/25dobAq2fry7F4AwBCyGZ0IkJfsNTBWNDhniVRhFLRUOc+o
         BHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701864015; x=1702468815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ex3XFDrwLoR/nkrJxHEDseFTPk4W5eJ7YuU+mGVpLsc=;
        b=kRDEKNl6kzGsoN8GUIvoR9EdPm30J4BdknmRbg1EaKDr4G1Wr96xWvrWPVojqdPan0
         UWtVbIeT1l+81FoI6QWZD/27dYIDRjOV3j6ErLIgza42gfWrjj6Pv/5fQXXm8AmC5Bms
         MHORzamOL59nVifWLw1S58zJ5RLKKx5ou2q6EiZ+kiiyDELW0EnZVHLgWb/FqOPXewPE
         dG1tAAnHZM49xHfXc6F9Eja7Goi1byc2h9oXKKX/fl9sYFf0zl4HbUUjgUVc8P97dc6a
         7C5YZj78TfGYYAjTeLfjIDkQhHjvaBqwih3IsG6ceWu5NBUJhmJrGat1jgtczcr5oiTG
         ADNw==
X-Gm-Message-State: AOJu0Yw4QJYHo1IkLihFlZNZ/Ptg3jrHJV5EgSd2f0EbduCPhWF//5au
	P51BwYZicCF/HJoQALC5NttpVnm85YE9fOs=
X-Google-Smtp-Source: AGHT+IFV2wNOA6+gAb0Zk05c7RUksRnkiW/1TaPoCAbGzoANtA5hmVSDV1Q71yj0+RCjgkjL6+0iRrX3nAhgc10=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:ac2:519c:0:b0:50c:60:eedf with SMTP id
 u28-20020ac2519c000000b0050c0060eedfmr8111lfi.9.1701864015140; Wed, 06 Dec
 2023 04:00:15 -0800 (PST)
Date: Wed, 06 Dec 2023 11:59:50 +0000
In-Reply-To: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6837; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=nSD1RHFiSgmdte3sXm2CuEd4KKb3h+aVVxb/9ER4D6k=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlcGI7qpjyrfDIi3Px1DbLbn4cXTm32iM/TT6P/
 Aa9cVXYk7WJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZXBiOwAKCRAEWL7uWMY5
 Rt4KD/9zI0mvZ5UC1bcQXnp4cBkKv2N4XTt6BO7BMq1naJpgTEJaDGfTzxV2Uq5619DVuFsz4Sr
 HrLo0Z0UYqnhHmh82PAB5Mc1RnUbdqddzLYfUqyCsMDBqvmYpsXbAVzgdF9aciAp+yKxPTBKYs7
 M635Y+sq6M/6b9v4n1mDfJfqBmGj4ER9HNRZiBohtTTEzQz+JdN/Di9ZfJ4qZOo89TCHtIBIj61
 ntGx31Lp1q+HoiWDkBBFPmtAhlmOm2A66Yoag51GLHyZuDqMMaem6cbo87Yzi+GIOFD0UbeW+Ka
 pGcPxh/4oDKqET+P0BfLbPLPQ+39M5uVpvaYFJSbEJzgnCyf4OlXlVzeH2vJhepZWZr1XHeeL4b
 c3saxXMSctJbBcwc6VMW7Hyzb3ysaVkJJeKw06UPfOtbmgDzYbBTHJHkizhEAR0GjaKDhMhqpT3
 aJlQmEvcxFMgkFzkb1J9YFRD+rrbg7v0cysTGlWfXLUFAL6W99Sj28iIgGWrLkq/fcrOcRI24Oj
 u/9cbTDF1NGsMxCHCTYys/pWCmUq6VBgXXCq3bR0CKhnwZsHqgKE9Qgp3Dt6xlg2RPfrr2gpdPD
 JpktRE/UEIRg5n/cozS8rnvaiCtyl00XSSDcaDx8jX9peeQZ31LKgLNQifkTGvhNoEEwngfmVFo 4YilCXYXvA4/Mag==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231206-alice-file-v2-5-af617c0d9d94@google.com>
Subject: [PATCH v2 5/7] rust: file: add `Kuid` wrapper
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

Adds a wrapper around `kuid_t` called `Kuid`. This allows us to define
various operations on kuids such as equality and current_euid. It also
lets us provide conversions from kuid into userspace values.

Rust Binder needs these operations because it needs to compare kuids for
equality, and it needs to tell userspace about the pid and uid of
incoming transactions.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  | 45 +++++++++++++++++++++++++++
 rust/kernel/cred.rs             |  5 +--
 rust/kernel/task.rs             | 68 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 116 insertions(+), 3 deletions(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 81b13a953eae..700f01840188 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -11,6 +11,7 @@
 #include <linux/errname.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/pid_namespace.h>
 #include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index fd633d9db79a..58e3a9dff349 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -142,6 +142,51 @@ void rust_helper_put_task_struct(struct task_struct *t)
 }
 EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
 
+kuid_t rust_helper_task_uid(struct task_struct *task)
+{
+	return task_uid(task);
+}
+EXPORT_SYMBOL_GPL(rust_helper_task_uid);
+
+kuid_t rust_helper_task_euid(struct task_struct *task)
+{
+	return task_euid(task);
+}
+EXPORT_SYMBOL_GPL(rust_helper_task_euid);
+
+#ifndef CONFIG_USER_NS
+uid_t rust_helper_from_kuid(struct user_namespace *to, kuid_t uid)
+{
+	return from_kuid(to, uid);
+}
+EXPORT_SYMBOL_GPL(rust_helper_from_kuid);
+#endif /* CONFIG_USER_NS */
+
+bool rust_helper_uid_eq(kuid_t left, kuid_t right)
+{
+	return uid_eq(left, right);
+}
+EXPORT_SYMBOL_GPL(rust_helper_uid_eq);
+
+kuid_t rust_helper_current_euid(void)
+{
+	return current_euid();
+}
+EXPORT_SYMBOL_GPL(rust_helper_current_euid);
+
+struct user_namespace *rust_helper_current_user_ns(void)
+{
+	return current_user_ns();
+}
+EXPORT_SYMBOL_GPL(rust_helper_current_user_ns);
+
+pid_t rust_helper_task_tgid_nr_ns(struct task_struct *tsk,
+				  struct pid_namespace *ns)
+{
+	return task_tgid_nr_ns(tsk, ns);
+}
+EXPORT_SYMBOL_GPL(rust_helper_task_tgid_nr_ns);
+
 struct kunit *rust_helper_kunit_get_current_test(void)
 {
 	return kunit_get_current_test();
diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
index 3794937b5294..fbc749788bfa 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -8,6 +8,7 @@
 
 use crate::{
     bindings,
+    task::Kuid,
     types::{AlwaysRefCounted, Opaque},
 };
 
@@ -52,9 +53,9 @@ pub fn get_secid(&self) -> u32 {
     }
 
     /// Returns the effective UID of the given credential.
-    pub fn euid(&self) -> bindings::kuid_t {
+    pub fn euid(&self) -> Kuid {
         // SAFETY: By the type invariant, we know that `self.0` is valid.
-        unsafe { (*self.0.get()).euid }
+        Kuid::from_raw(unsafe { (*self.0.get()).euid })
     }
 }
 
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index b2299bc7ac1f..7a3a07660af7 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -5,7 +5,12 @@
 //! C header: [`include/linux/sched.h`](../../../../include/linux/sched.h).
 
 use crate::{bindings, types::Opaque};
-use core::{marker::PhantomData, ops::Deref, ptr};
+use core::{
+    cmp::{Eq, PartialEq},
+    marker::PhantomData,
+    ops::Deref,
+    ptr,
+};
 
 /// Returns the currently running task.
 #[macro_export]
@@ -78,6 +83,12 @@ unsafe impl Sync for Task {}
 /// The type of process identifiers (PIDs).
 type Pid = bindings::pid_t;
 
+/// The type of user identifiers (UIDs).
+#[derive(Copy, Clone)]
+pub struct Kuid {
+    kuid: bindings::kuid_t,
+}
+
 impl Task {
     /// Returns a task reference for the currently executing task/thread.
     ///
@@ -132,12 +143,32 @@ pub fn pid(&self) -> Pid {
         unsafe { *ptr::addr_of!((*self.0.get()).pid) }
     }
 
+    /// Returns the UID of the given task.
+    pub fn uid(&self) -> Kuid {
+        // SAFETY: By the type invariant, we know that `self.0` is valid.
+        Kuid::from_raw(unsafe { bindings::task_uid(self.0.get()) })
+    }
+
+    /// Returns the effective UID of the given task.
+    pub fn euid(&self) -> Kuid {
+        // SAFETY: By the type invariant, we know that `self.0` is valid.
+        Kuid::from_raw(unsafe { bindings::task_euid(self.0.get()) })
+    }
+
     /// Determines whether the given task has pending signals.
     pub fn signal_pending(&self) -> bool {
         // SAFETY: By the type invariant, we know that `self.0` is valid.
         unsafe { bindings::signal_pending(self.0.get()) != 0 }
     }
 
+    /// Returns the given task's pid in the current pid namespace.
+    pub fn pid_in_current_ns(&self) -> Pid {
+        // SAFETY: Calling `task_active_pid_ns` with the current task is always safe.
+        let namespace = unsafe { bindings::task_active_pid_ns(bindings::get_current()) };
+        // SAFETY: We know that `self.0.get()` is valid by the type invariant.
+        unsafe { bindings::task_tgid_nr_ns(self.0.get(), namespace) }
+    }
+
     /// Wakes up the task.
     pub fn wake_up(&self) {
         // SAFETY: By the type invariant, we know that `self.0.get()` is non-null and valid.
@@ -147,6 +178,41 @@ pub fn wake_up(&self) {
     }
 }
 
+impl Kuid {
+    /// Get the current euid.
+    pub fn current_euid() -> Kuid {
+        // SAFETY: Just an FFI call.
+        Self::from_raw(unsafe { bindings::current_euid() })
+    }
+
+    /// Create a `Kuid` given the raw C type.
+    pub fn from_raw(kuid: bindings::kuid_t) -> Self {
+        Self { kuid }
+    }
+
+    /// Turn this kuid into the raw C type.
+    pub fn into_raw(self) -> bindings::kuid_t {
+        self.kuid
+    }
+
+    /// Converts this kernel UID into a userspace UID.
+    ///
+    /// Uses the namespace of the current task.
+    pub fn into_uid_in_current_ns(self) -> bindings::uid_t {
+        // SAFETY: Just an FFI call.
+        unsafe { bindings::from_kuid(bindings::current_user_ns(), self.kuid) }
+    }
+}
+
+impl PartialEq for Kuid {
+    fn eq(&self, other: &Kuid) -> bool {
+        // SAFETY: Just an FFI call.
+        unsafe { bindings::uid_eq(self.kuid, other.kuid) }
+    }
+}
+
+impl Eq for Kuid {}
+
 // SAFETY: The type invariants guarantee that `Task` is always ref-counted.
 unsafe impl crate::types::AlwaysRefCounted for Task {
     fn inc_ref(&self) {

-- 
2.43.0.rc2.451.g8631bc7472-goog


