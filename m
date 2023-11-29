Return-Path: <linux-fsdevel+bounces-4195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 717737FD98F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 15:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28FEC1F20C1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A407332C7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="seezu6Ah"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C68610DD
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 05:12:25 -0800 (PST)
Received: by mail-lf1-x14a.google.com with SMTP id 2adb3069b0e04-50aa6b26836so7645899e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 05:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701263543; x=1701868343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jdn+NMvalWu2DX8Rm0t7kAAGEBw7/t9Uqy6Z/eCT3dQ=;
        b=seezu6AhKOabbKhc6zu7EmPoVOghl6g8w6Jk2qMxHeSf7Ilowwzr0Iw+HNI2y7RwJD
         8jvazds4UAVYd9mx7CTpb8EVlcCVEIBiP1wOPTffO12uhUJ8fTvuFi9X/AYT0i79EdwX
         0UM2br3x645sI/mwtACih4p0BlgWtzY78zo2KVrPYgfQTv/nGyTM7cm6EUTxuMiaAF+Y
         fIAeFIVcaq5dQrixm6pNtMgqxGRDE7kRomc43h23cxf41o9PkdMJq+QmP2sT5L3DmAjA
         J8FmdZHQPsa3KPkzLrYs1pWTU/BTUVDt+JGtFugRGYqitGYAdhyIVdejxYRoLtCYXsav
         pGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701263543; x=1701868343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jdn+NMvalWu2DX8Rm0t7kAAGEBw7/t9Uqy6Z/eCT3dQ=;
        b=gq/g7ILtEqqi/bYgMTfw2HOek8RjSsPpo95ACVjasj/pLzeclj8ydGX8spGu9ksSso
         t1irrBASO6zV8DLCCSfy67AuoHsngfOJP1yXT4jOHlTJT8ExYhBkDi/tmJFNlrWNGRPl
         WStgf5/p1k+ud+XDDkdgDtkc2KksAmMN/1yfvNyLBhm1ZII+h35oiGQExvE2pwjKMuz0
         MqdLm0JPmDNbIAwuBhUrugfhHmRYyKMnNUxMoNgByGXzqU5uMSuGKTsk8LhBKkfJJVKM
         V5OHFDYAyMomQWKW3mS3sfmiA8laWYB++dKeBZInfvvzQllmVnOnFlujDH9CJn1rfi8J
         ai/g==
X-Gm-Message-State: AOJu0YywQ8QsC9rohv7kfSxWiSzdgzUaj1u9vb/v0vaxmSqSvARAo0l+
	iahKEV+h+26+n2G391m8e/jLVRPlyH/H1eM=
X-Google-Smtp-Source: AGHT+IEB/mXh/ZPS7PjkiGVqEG+SAnf3KNvYIg4NixJhPAVSZEHh3/5vKQR8huIBTAygzHua1slJ8dlnDO6e0dM=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:ac2:5224:0:b0:50b:bca7:968c with SMTP id
 i4-20020ac25224000000b0050bbca7968cmr58963lfl.11.1701263543178; Wed, 29 Nov
 2023 05:12:23 -0800 (PST)
Date: Wed, 29 Nov 2023 13:12:17 +0000
In-Reply-To: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6837; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=fzhPWG3FyEb6bwd3huD/CCWPlg1T+DI/I6PnRrR6U60=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlZzMyxp/PiE2vc51gW7AeguEkf+zG+hlvclKDg
 z15KrtnzgeJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZWczMgAKCRAEWL7uWMY5
 Rr0qD/sEfvqOb/IvSsLWcLMiUMGY1ZzjqsXSsbGWHIw5ZhJfuDcIjm4XM1OkrOwdyDRnUixIFHO
 rHrqNwf6vIUvWLx+d+0IKNUYFPRrx4Jo8T/9ITcfwCkYCj8WV1ouAXWe3EK154x+3SW6BkUj1W/
 zsxlPzIy5zVju+h0FNheyCpN2Z8+XrvLR/q5ussUBYroyuT0AjGC0AeR4TA/pgcnQ60ek1YVniA
 2Tqq3xzYdX7HlT9ivqOgzUCPWdfSaksZB6Zsj8VYS2QT1qiH19c9fu7razhL87/xeQbHBEwphHx
 aGghuDnMfE/oU/KlnMB2xHru4JP8E1NteTa4ZLMnLS/36cwT6sEELQq0mS1sJVqCpw0Fmrjx0qk
 AuKzgL5xhYqsroAD1/NX4GxAgaXrcIkRbdM84FY1ALLWZoWkYUydRGQRBxFybL+G/vr4IFK1bfP
 QXljESusHDDgQMCj4UPE0c+u9F8V3Wyhzy9iVbc+denXT/xR5nwg8EWMkugWZy7lPdGTyag1zFY
 MQguoJGaHrdpT9eAAf4fCtnjoTorm6MAOc7NOI2lfrHVIaK/l4aqmP8PX66//ke8l6eGZnuORaz
 zx5rCKJ5w8KFsKXp9EG9SkYJ+w9O4JDg9sn5ZtcOpKglyp/pR2fu2Iuw54AR4nClN4TAU5sm2D5 ouAI5yUjfk31JMQ==
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129-alice-file-v1-5-f81afe8c7261@google.com>
Subject: [PATCH 5/7] rust: file: add `Kuid` wrapper
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
 rust/helpers.c                  | 45 ++++++++++++++++++++++++++
 rust/kernel/cred.rs             |  5 +--
 rust/kernel/task.rs             | 71 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 119 insertions(+), 3 deletions(-)

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
index b2299bc7ac1f..1a27b968a907 100644
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
@@ -132,12 +143,34 @@ pub fn pid(&self) -> Pid {
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
+        // SAFETY: We know that `self.0.get()` is valid by the type invariant. The rest is just FFI
+        // calls.
+        unsafe {
+            let namespace = bindings::task_active_pid_ns(bindings::get_current());
+            bindings::task_tgid_nr_ns(self.0.get(), namespace)
+        }
+    }
+
     /// Wakes up the task.
     pub fn wake_up(&self) {
         // SAFETY: By the type invariant, we know that `self.0.get()` is non-null and valid.
@@ -147,6 +180,42 @@ pub fn wake_up(&self) {
     }
 }
 
+impl Kuid {
+    /// Get the current euid.
+    pub fn current_euid() -> Kuid {
+        // SAFETY: Just an FFI call.
+        Self {
+            kuid: unsafe { bindings::current_euid() },
+        }
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
+    /// Converts this kernel UID into a UID that userspace understands. Uses the namespace of the
+    /// current task.
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
2.43.0.rc1.413.gea7ed67945-goog


