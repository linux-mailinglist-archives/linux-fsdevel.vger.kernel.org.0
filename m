Return-Path: <linux-fsdevel+bounces-4996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D1C806FFC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 13:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BC71B20C91
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0301136AF1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O1AvjKra"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10825D4F
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 04:00:19 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d67fc68a82so75733597b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 04:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701864018; x=1702468818; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2Vb6XnFBNT/vwoBLNsBzMzVsVm0lPXO15u2hoL76Ng=;
        b=O1AvjKrazk6JmWuKnwFvjvFOrcx4IlRwMZm6SezcMbuA0ogM/A7jdUTYliqEMvzx3c
         mb6KP+p5xZztquD9a9YwpgjseL9pHuwnJcBSZKiSg5mFcFUEmraaqwOEtKXUmmc/ALN2
         iNwROSxxKlkxEHG9BiDxsTEexNdO39d+CGsT39MECcofQBH76fSyFKRgRrpJmoUE1xu8
         VgThICM1i8aEC2ezDe+4NpAcmWELSUDeZTUIAt4Kbh2JITKKbRZjaISx4T2ylmNnXS50
         AfnvYpSmLts6/xTBukJZ5PEEJNddOxC+xahwj5a23aoSjqaBm/OiKOJAiBvoiKCfozIi
         0/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701864018; x=1702468818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2Vb6XnFBNT/vwoBLNsBzMzVsVm0lPXO15u2hoL76Ng=;
        b=XfYmdpjAWmp3D7GwYgoQRHPrsiM0H0paBl10v702LP5/urUz+ewbyCLS/1pmOQGNvQ
         y5Wrigv56hAkLqsIShPqiCm0+vb7xG1W+gyCV3cYTLneXHQumkO8AASOaDnY5LLM+q7E
         Hpox80UHiUJpQ79Vedfw52f2CSRLdVAG6AcVurz1avSss/MMP4nTGe3eHFJLWT3sAzTj
         ToB8KqCgZ/heIkeXzNGNN4QSy+d6fCo3UzIQcufQr4ifYT+F8FJ+q8eiNoYE4dIEK4Xo
         3dgj2q6x348PGdgkwh+hCrkEnjInxsoL2JzMJLFTeMMtZzyCvhJK6OE0eeh0AyHT7xdG
         q39g==
X-Gm-Message-State: AOJu0Yz9SgELZ7GTSblGMMAHoNBksqBhkSkhqdqinnhOTddTExmIcfaW
	Rpikl0Kppvmw3oA3qdsDsoKjOGLOQQtx0og=
X-Google-Smtp-Source: AGHT+IH1KoLuU0UnF3Vl2p4fqkjvUSHg4h8gImLmOYiYyXeo5fjtozQfAlbJM9wNb/t/px3KgxT+M8tHN+mI1gw=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:3244:b0:5ca:5fcd:7063 with SMTP
 id fg4-20020a05690c324400b005ca5fcd7063mr8743ywb.3.1701864018242; Wed, 06 Dec
 2023 04:00:18 -0800 (PST)
Date: Wed, 06 Dec 2023 11:59:51 +0000
In-Reply-To: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=11026; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=F2Jb32LY5rLgggxlU69aJ4MLraHZcw8F9PxXVr+ujgk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlcGI8kapIc9cnaSVwJuC2VIEOUtI/5p082wwVl
 FSNa5NwlgiJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZXBiPAAKCRAEWL7uWMY5
 Rq5yEACet4Qi4t6lEVcVeB70AKFLpl2XJ0Yd8QYFqbNl9L3OtcXJO8i/Be5iXFWITgjxC+jxYBz
 IllRj8e4crAvleRpseTOi190hejnKvXyxfoiCNlSdbk3DeKvzCT16vCWb3i7F2tgEV5NeROJ/vh
 f6K1T+F+h6CP8d0+D7HOnF9zFfD5eHhiv0yE+0z9mitmQagZrwMaHQFCwrDwrl9KTqtxb+I5Xnd
 Ko/2V+HUbZP1asNsWP3rpbXEDaAUHUCrOZUw1K/yklSKNwveUVd5Phe4HSgl0uoc7Z9BVoDjzR5
 fcPOHQ3krlznkVkXMli8adCS/TbRPvN8SwxpciChIsFWAbM2/UWMq7V0ochGDJ2GNu6env+HsVM
 avyWbMq4nxx8H7g4HSb+zIVDw/ohZozC/xJ+hnbJFNsP0yl53B4tv3jrPV0t7mA3nKqcna1ZaLr
 UZqBZGOH1rIoq0Ga3c5vXgHBHVHLCvg5uqcZJnM0YL8Wz4EwRNtV5ylFMqnlKLqcC5cD8AHisdI
 m7ZR2f6cjRxPVDK4FKcfarqnBBXv/wbMmQOVlv4KEmQbXT/4md6xOldpFcHMCYuxCCKCdZkUFwj
 VazJw8Wj7C5NNx2Jbk/NdE9E3NwaUVYjz2O8ozCY51cPEdT+Ezz5gh9kW057qkvZrqT83RLqHhs /n0JIs/3McjwR4Q==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231206-alice-file-v2-6-af617c0d9d94@google.com>
Subject: [PATCH v2 6/7] rust: file: add `DeferredFdCloser`
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

To close an fd from kernel space, we could call `ksys_close`. However,
if we do this to an fd that is held using `fdget`, then we may trigger a
use-after-free. Introduce a helper that can be used to close an fd even
if the fd is currently held with `fdget`. This is done by grabbing an
extra refcount to the file and dropping it in a task work once we return
to userspace.

This is necessary for Rust Binder because otherwise the user might try
to have Binder close its fd for /dev/binder, which would cause problems
as this happens inside an ioctl on /dev/binder, and ioctls hold the fd
using `fdget`.

Additional motivation can be found in commit 80cd795630d6 ("binder: fix
use-after-free due to ksys_close() during fdget()") and in the comments
on `binder_do_fd_close`.

If there is some way to detect whether an fd is currently held with
`fdget`, then this could be optimized to skip the allocation and task
work when this is not the case. Another possible optimization would be
to combine several fds into a single task work, since this is used with
fd arrays that might hold several fds.

That said, it might not be necessary to optimize it, because Rust Binder
has two ways to send fds: BINDER_TYPE_FD and BINDER_TYPE_FDA. With
BINDER_TYPE_FD, it is userspace's responsibility to close the fd, so
this mechanism is used only by BINDER_TYPE_FDA, but fd arrays are used
rarely these days.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   2 +
 rust/helpers.c                  |   8 ++
 rust/kernel/file.rs             | 157 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 166 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 700f01840188..c8daee341df6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -9,6 +9,7 @@
 #include <kunit/test.h>
 #include <linux/cred.h>
 #include <linux/errname.h>
+#include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/pid_namespace.h>
@@ -17,6 +18,7 @@
 #include <linux/refcount.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/task_work.h>
 #include <linux/workqueue.h>
 
 /* `bindgen` gets confused at certain things. */
diff --git a/rust/helpers.c b/rust/helpers.c
index 58e3a9dff349..d146bbf25aec 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -32,6 +32,7 @@
 #include <linux/sched/signal.h>
 #include <linux/security.h>
 #include <linux/spinlock.h>
+#include <linux/task_work.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
@@ -243,6 +244,13 @@ void rust_helper_security_release_secctx(char *secdata, u32 seclen)
 EXPORT_SYMBOL_GPL(rust_helper_security_release_secctx);
 #endif
 
+void rust_helper_init_task_work(struct callback_head *twork,
+				task_work_func_t func)
+{
+	init_task_work(twork, func);
+}
+EXPORT_SYMBOL_GPL(rust_helper_init_task_work);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
index 2d036d4636a0..eba96af4bdf7 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -11,7 +11,8 @@
     error::{code::*, Error, Result},
     types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
 };
-use core::{marker::PhantomData, ptr};
+use alloc::boxed::Box;
+use core::{alloc::AllocError, marker::PhantomData, mem, ptr};
 
 /// Flags associated with a [`File`].
 pub mod flags {
@@ -257,6 +258,160 @@ fn drop(&mut self) {
     }
 }
 
+/// Helper used for closing file descriptors in a way that is safe even if the file is currently
+/// held using `fdget`.
+///
+/// Additional motivation can be found in commit 80cd795630d6 ("binder: fix use-after-free due to
+/// ksys_close() during fdget()") and in the comments on `binder_do_fd_close`.
+pub struct DeferredFdCloser {
+    inner: Box<DeferredFdCloserInner>,
+}
+
+/// SAFETY: This just holds an allocation with no real content, so there's no safety issue with
+/// moving it across threads.
+unsafe impl Send for DeferredFdCloser {}
+unsafe impl Sync for DeferredFdCloser {}
+
+#[repr(C)]
+struct DeferredFdCloserInner {
+    twork: mem::MaybeUninit<bindings::callback_head>,
+    file: *mut bindings::file,
+}
+
+impl DeferredFdCloser {
+    /// Create a new [`DeferredFdCloser`].
+    pub fn new() -> Result<Self, AllocError> {
+        Ok(Self {
+            inner: Box::try_new(DeferredFdCloserInner {
+                twork: mem::MaybeUninit::uninit(),
+                file: core::ptr::null_mut(),
+            })?,
+        })
+    }
+
+    /// Schedule a task work that closes the file descriptor when this task returns to userspace.
+    ///
+    /// Fails if this is called from a context where we cannot run work when returning to
+    /// userspace. (E.g., from a kthread.)
+    pub fn close_fd(self, fd: u32) -> Result<(), DeferredFdCloseError> {
+        use bindings::task_work_notify_mode_TWA_RESUME as TWA_RESUME;
+
+        // In this method, we schedule the task work before closing the file. This is because
+        // scheduling a task work is fallible, and we need to know whether it will fail before we
+        // attempt to close the file.
+
+        // SAFETY: Getting a pointer to current is always safe.
+        let current = unsafe { bindings::get_current() };
+
+        // SAFETY: Accessing the `flags` field of `current` is always safe.
+        let is_kthread = (unsafe { (*current).flags } & bindings::PF_KTHREAD) != 0;
+        if is_kthread {
+            return Err(DeferredFdCloseError::TaskWorkUnavailable);
+        }
+
+        // This disables the destructor of the box, so the allocation is not cleaned up
+        // automatically below.
+        let inner = Box::into_raw(self.inner);
+
+        // The `callback_head` field is first in the struct, so this cast correctly gives us a
+        // pointer to the field.
+        let callback_head = inner.cast::<bindings::callback_head>();
+        // SAFETY: This pointer offset operation does not go out-of-bounds.
+        let file_field = unsafe { core::ptr::addr_of_mut!((*inner).file) };
+
+        // SAFETY: The `callback_head` pointer is compatible with the `do_close_fd` method.
+        unsafe { bindings::init_task_work(callback_head, Some(Self::do_close_fd)) };
+        // SAFETY: The `callback_head` pointer points at a valid and fully initialized task work
+        // that is ready to be scheduled.
+        //
+        // If the task work gets scheduled as-is, then it will be a no-op. However, we will update
+        // the file pointer below to tell it which file to fput.
+        let res = unsafe { bindings::task_work_add(current, callback_head, TWA_RESUME) };
+
+        if res != 0 {
+            // SAFETY: Scheduling the task work failed, so we still have ownership of the box, so
+            // we may destroy it.
+            unsafe { drop(Box::from_raw(inner)) };
+
+            return Err(DeferredFdCloseError::TaskWorkUnavailable);
+        }
+
+        // SAFETY: Just an FFI call. This is safe no matter what `fd` is.
+        let file = unsafe { bindings::close_fd_get_file(fd) };
+        if file.is_null() {
+            // We don't clean up the task work since that might be expensive if the task work queue
+            // is long. Just let it execute and let it clean up for itself.
+            return Err(DeferredFdCloseError::BadFd);
+        }
+
+        // SAFETY: The `file` pointer points at a valid file.
+        unsafe { bindings::get_file(file) };
+
+        // SAFETY: Due to the above `get_file`, even if the current task holds an `fdget` to
+        // this file right now, the refcount will not drop to zero until after it is released
+        // with `fdput`. This is because when using `fdget`, you must always use `fdput` before
+        // returning to userspace, and our task work runs after any `fdget` users have returned
+        // to userspace.
+        //
+        // Note: fl_owner_t is currently a void pointer.
+        unsafe { bindings::filp_close(file, (*current).files as bindings::fl_owner_t) };
+
+        // We update the file pointer that the task work is supposed to fput.
+        //
+        // SAFETY: Task works are executed on the current thread once we return to userspace, so
+        // this write is guaranteed to happen before `do_close_fd` is called, which means that a
+        // race is not possible here.
+        //
+        // It's okay to pass this pointer to the task work, since we just acquired a refcount with
+        // the previous call to `get_file`. Furthermore, the refcount will not drop to zero during
+        // an `fdget` call, since we defer the `fput` until after returning to userspace.
+        unsafe { *file_field = file };
+
+        Ok(())
+    }
+
+    // SAFETY: This function is an implementation detail of `close_fd`, so its safety comments
+    // should be read in extension of that method.
+    unsafe extern "C" fn do_close_fd(inner: *mut bindings::callback_head) {
+        // SAFETY: In `close_fd` we use this method together with a pointer that originates from a
+        // `Box<DeferredFdCloserInner>`, and we have just been given ownership of that allocation.
+        let inner = unsafe { Box::from_raw(inner as *mut DeferredFdCloserInner) };
+        if !inner.file.is_null() {
+            // SAFETY: This drops a refcount we acquired in `close_fd`. Since this callback runs in
+            // a task work after we return to userspace, it is guaranteed that the current thread
+            // doesn't hold this file with `fdget`, as `fdget` must be released before returning to
+            // userspace.
+            unsafe { bindings::fput(inner.file) };
+        }
+        // Free the allocation.
+        drop(inner);
+    }
+}
+
+/// Represents a failure to close an fd in a deferred manner.
+#[derive(Copy, Clone, Eq, PartialEq)]
+pub enum DeferredFdCloseError {
+    /// Closing the fd failed because we were unable to schedule a task work.
+    TaskWorkUnavailable,
+    /// Closing the fd failed because the fd does not exist.
+    BadFd,
+}
+
+impl From<DeferredFdCloseError> for Error {
+    fn from(err: DeferredFdCloseError) -> Error {
+        match err {
+            DeferredFdCloseError::TaskWorkUnavailable => ESRCH,
+            DeferredFdCloseError::BadFd => EBADF,
+        }
+    }
+}
+
+impl core::fmt::Debug for DeferredFdCloseError {
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        Error::from(*self).fmt(f)
+    }
+}
+
 /// Represents the `EBADF` error code.
 ///
 /// Used for methods that can only fail with `EBADF`.

-- 
2.43.0.rc2.451.g8631bc7472-goog


