Return-Path: <linux-fsdevel+bounces-4991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF87806FF6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 13:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C63F4B20CBB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE8236AF4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AI+Adgcw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58244181
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 04:00:04 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5caf61210e3so95723117b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 04:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701864003; x=1702468803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLPw/cBgJ0pNgJm8eE7aQ+KAHAiPGK+jutonPeJcGnA=;
        b=AI+AdgcwxGAT/n2PKzvPSetoX4mXzHwUQZH78WUiLgLh8vxyzFe7LKl+jh+9lsb0Re
         63XcobEYgMvbzHeLBdVlj/XOeMIx2A+XhKgaaZaUflZ5JtnZfnMTObvFj9bdrSMB3xH1
         f38IhHPpo+84/7zDxnZjyvsnaSYr2M9UAVDXeyBfqAoGUpJgMBa1Rbj6yHLn4nbk7asN
         VU99Q1+vATbY8/wR+jYfvUIirdV8zh0BAAd0XYP11iVi21O4gXN3VZQ00XeHCI6DbhcO
         ukv1lPVQtiJ4lXwlWV5Pql1E3KWfkjd69gk6uYOsBlNedkLTIRDJSlLx6YyEUOlH3G7P
         dM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701864003; x=1702468803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLPw/cBgJ0pNgJm8eE7aQ+KAHAiPGK+jutonPeJcGnA=;
        b=oUwlEOVpwQhNa/Y9Z7hBA1ZpSGedRV20lp+jrrGGio3R1tdHvE588Gg0JFGwxcE2zi
         vOhVCekRFDgupiSR0VztPY91VUbKxKlpkIwqcZaA/TtZWeTVJLqW2sDa+pHrFdQqlKk4
         Lez6fajazNMInq06PWFA+Ix5zHeySUBLdzv/YDz7UNh8c97oQKS1KscplLsd4SHjf3O8
         e4TVEwpvK/RoQWGtpy42NrGvs14KxK/JXdPigK9BeAWRe9NztTODbdAb/9wGArh+gXqf
         bIhXVwQAN+K4jgUts8rQM/WMhfVHA3kSHL7FFWLNi++pe6Et1unj7nHaie9PT7zt76JW
         /gdg==
X-Gm-Message-State: AOJu0YzxDx9+aI5Q+MqOxXENIxgfhz97OjkGtqWvYpSh+K1ojs7RRtln
	c7/KP97AO1VWAQ1b1xLJkYmuSLtALbRIUw4=
X-Google-Smtp-Source: AGHT+IHnjTwn89g/3gZ0rUrhLKVW1ogZkP+ZdktJ5hw4l/C4A0NqN3tW5yq2T0PBUdfPKMUoAYRnTaxAEyj4kdU=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a81:b627:0:b0:5d4:1b2d:f43f with SMTP id
 u39-20020a81b627000000b005d41b2df43fmr8121ywh.6.1701864003433; Wed, 06 Dec
 2023 04:00:03 -0800 (PST)
Date: Wed, 06 Dec 2023 11:59:46 +0000
In-Reply-To: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=11330; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=fS+EISoJsOycGxjrMPeviEtEZy2GAzGu9mh6cNsegxY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlcGI5tzCvzZUNwoppJ1OHi0LOvB+Mr/uD1R1Tp
 YwDNYjKrMqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZXBiOQAKCRAEWL7uWMY5
 Ri63D/9My5FdhgPod4Xr3p1UAu9q5kpqykQLHYRcH7ncR8PlKewdzPipKOCEfwI0oQGFEw5GRbL
 11No1TgjpEkoMBzuX6PvprYnd+8zIguxfrEpQR3+3bOAPphdF8BC+sCUNCu4vQnB3HM1GQrw8EI
 M2pMpq1jdO7KluxGT62Xb/1bMl8Mn6lVi5KwlSgeTIW3MUcO197RU/FgfDK2nUGnp+je8KFP/YU
 itmXaTDNuK+QyyvLYtHu9QUBkRHjJ2Z+go8FbX5qKG55qs/uVJwCMcG1PFlP0XqTbLF1lv8jqW4
 RYk3p1wj9bsQNhNdvst9nJhrMiMF6gldbHbCkqZVtxszBdhr0Lja/rbN9dx176Rtg1ROsywQurk
 8eQrAaRnMGZt+KiAfEXOjikx9+n0zq5HT6UavhOKrRYPzSDYO9OeKiDYyTroEpG5UYAXRE5Pwn2
 7wnXA/W86h4AunNf6fk0yYNkZV1T+ZKbUG/zfKzhbT8/S0spqV9w7ZfrslpumuTlHabbuJKy7WP
 GZdgbCa8UJ0Z26u6p4hA0ba81B4RJsdPdlTXQzjCX/DS7682+HA+GUwHyEXLPuwwch+0dfMdGeZ
 NrMBPKm9qDoPdWtRwqLQggxt7I522nz76jVRRnjyQxhs8PRsyaMp2tLNMr+UAjrVPagdJDLq2nW qPa2ycnWxhxhfpg==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231206-alice-file-v2-1-af617c0d9d94@google.com>
Subject: [PATCH v2 1/7] rust: file: add Rust abstraction for `struct file`
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

This abstraction makes it possible to manipulate the open files for a
process. The new `File` struct wraps the C `struct file`. When accessing
it using the smart pointer `ARef<File>`, the pointer will own a
reference count to the file. When accessing it as `&File`, then the
reference does not own a refcount, but the borrow checker will ensure
that the reference count does not hit zero while the `&File` is live.

Since this is intended to manipulate the open files of a process, we
introduce a `from_fd` constructor that corresponds to the C `fget`
method. In future patches, it will become possible to create a new fd in
a process and bind it to a `File`. Rust Binder will use these to send
fds from one process to another.

We also provide a method for accessing the file's flags. Rust Binder
will use this to access the flags of the Binder fd to check whether the
non-blocking flag is set, which affects what the Binder ioctl does.

This introduces a struct for the EBADF error type, rather than just
using the Error type directly. This has two advantages:
* `File::from_fd` returns a `Result<ARef<File>, BadFdError>`, which the
  compiler will represent as a single pointer, with null being an error.
  This is possible because the compiler understands that `BadFdError`
  has only one possible value, and it also understands that the
  `ARef<File>` smart pointer is guaranteed non-null.
* Additionally, we promise to users of the method that the method can
  only fail with EBADF, which means that they can rely on this promise
  without having to inspect its implementation.
That said, there are also two disadvantages:
* Defining additional error types involves boilerplate.
* The question mark operator will only utilize the `From` trait once,
  which prevents you from using the question mark operator on
  `BadFdError` in methods that return some third error type that the
  kernel `Error` is convertible into. (However, it works fine in methods
  that return `Error`.)

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   2 +
 rust/helpers.c                  |   7 ++
 rust/kernel/file.rs             | 196 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 4 files changed, 206 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 85f013ed4ca4..beed3ef1fbc3 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -8,6 +8,8 @@
 
 #include <kunit/test.h>
 #include <linux/errname.h>
+#include <linux/file.h>
+#include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
 #include <linux/wait.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index 70e59efd92bc..03141a3608a4 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -25,6 +25,7 @@
 #include <linux/build_bug.h>
 #include <linux/err.h>
 #include <linux/errname.h>
+#include <linux/fs.h>
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/sched/signal.h>
@@ -157,6 +158,12 @@ void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
 }
 EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
 
+struct file *rust_helper_get_file(struct file *f)
+{
+	return get_file(f);
+}
+EXPORT_SYMBOL_GPL(rust_helper_get_file);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
new file mode 100644
index 000000000000..29e1aacacd06
--- /dev/null
+++ b/rust/kernel/file.rs
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Files and file descriptors.
+//!
+//! C headers: [`include/linux/fs.h`](../../../../include/linux/fs.h) and
+//! [`include/linux/file.h`](../../../../include/linux/file.h)
+
+use crate::{
+    bindings,
+    error::{code::*, Error, Result},
+    types::{ARef, AlwaysRefCounted, Opaque},
+};
+use core::ptr;
+
+/// Flags associated with a [`File`].
+pub mod flags {
+    /// File is opened in append mode.
+    pub const O_APPEND: u32 = bindings::O_APPEND;
+
+    /// Signal-driven I/O is enabled.
+    pub const O_ASYNC: u32 = bindings::FASYNC;
+
+    /// Close-on-exec flag is set.
+    pub const O_CLOEXEC: u32 = bindings::O_CLOEXEC;
+
+    /// File was created if it didn't already exist.
+    pub const O_CREAT: u32 = bindings::O_CREAT;
+
+    /// Direct I/O is enabled for this file.
+    pub const O_DIRECT: u32 = bindings::O_DIRECT;
+
+    /// File must be a directory.
+    pub const O_DIRECTORY: u32 = bindings::O_DIRECTORY;
+
+    /// Like [`O_SYNC`] except metadata is not synced.
+    pub const O_DSYNC: u32 = bindings::O_DSYNC;
+
+    /// Ensure that this file is created with the `open(2)` call.
+    pub const O_EXCL: u32 = bindings::O_EXCL;
+
+    /// Large file size enabled (`off64_t` over `off_t`).
+    pub const O_LARGEFILE: u32 = bindings::O_LARGEFILE;
+
+    /// Do not update the file last access time.
+    pub const O_NOATIME: u32 = bindings::O_NOATIME;
+
+    /// File should not be used as process's controlling terminal.
+    pub const O_NOCTTY: u32 = bindings::O_NOCTTY;
+
+    /// If basename of path is a symbolic link, fail open.
+    pub const O_NOFOLLOW: u32 = bindings::O_NOFOLLOW;
+
+    /// File is using nonblocking I/O.
+    pub const O_NONBLOCK: u32 = bindings::O_NONBLOCK;
+
+    /// Also known as `O_NDELAY`.
+    ///
+    /// This is effectively the same flag as [`O_NONBLOCK`] on all architectures
+    /// except SPARC64.
+    pub const O_NDELAY: u32 = bindings::O_NDELAY;
+
+    /// Used to obtain a path file descriptor.
+    pub const O_PATH: u32 = bindings::O_PATH;
+
+    /// Write operations on this file will flush data and metadata.
+    pub const O_SYNC: u32 = bindings::O_SYNC;
+
+    /// This file is an unnamed temporary regular file.
+    pub const O_TMPFILE: u32 = bindings::O_TMPFILE;
+
+    /// File should be truncated to length 0.
+    pub const O_TRUNC: u32 = bindings::O_TRUNC;
+
+    /// Bitmask for access mode flags.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::file;
+    /// # fn do_something() {}
+    /// # let flags = 0;
+    /// if (flags & file::flags::O_ACCMODE) == file::flags::O_RDONLY {
+    ///     do_something();
+    /// }
+    /// ```
+    pub const O_ACCMODE: u32 = bindings::O_ACCMODE;
+
+    /// File is read only.
+    pub const O_RDONLY: u32 = bindings::O_RDONLY;
+
+    /// File is write only.
+    pub const O_WRONLY: u32 = bindings::O_WRONLY;
+
+    /// File can be both read and written.
+    pub const O_RDWR: u32 = bindings::O_RDWR;
+}
+
+/// Wraps the kernel's `struct file`.
+///
+/// # Invariants
+///
+/// Instances of this type are always ref-counted, that is, a call to `get_file` ensures that the
+/// allocation remains valid at least until the matching call to `fput`.
+#[repr(transparent)]
+pub struct File(Opaque<bindings::file>);
+
+// SAFETY: By design, the only way to access a `File` is via an immutable reference or an `ARef`.
+// This means that the only situation in which a `File` can be accessed mutably is when the
+// refcount drops to zero and the destructor runs. It is safe for that to happen on any thread, so
+// it is ok for this type to be `Send`.
+unsafe impl Send for File {}
+
+// SAFETY: All methods defined on `File` that take `&self` are safe to call even if other threads
+// are concurrently accessing the same `struct file`, because those methods either access immutable
+// properties or have proper synchronization to ensure that such accesses are safe.
+unsafe impl Sync for File {}
+
+impl File {
+    /// Constructs a new `struct file` wrapper from a file descriptor.
+    ///
+    /// The file descriptor belongs to the current process.
+    pub fn fget(fd: u32) -> Result<ARef<Self>, BadFdError> {
+        // SAFETY: FFI call, there are no requirements on `fd`.
+        let ptr = ptr::NonNull::new(unsafe { bindings::fget(fd) }).ok_or(BadFdError)?;
+
+        // SAFETY: `fget` either returns null or a valid pointer to a file, and we checked for null
+        // above.
+        //
+        // INVARIANT: `fget` increments the refcount before returning.
+        Ok(unsafe { ARef::from_raw(ptr.cast()) })
+    }
+
+    /// Creates a reference to a [`File`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` points at a valid file and that its refcount does not
+    /// reach zero during the lifetime 'a.
+    pub unsafe fn from_ptr<'a>(ptr: *const bindings::file) -> &'a File {
+        // SAFETY: The caller guarantees that the pointer is not dangling and stays valid for the
+        // duration of 'a. The cast is okay because `File` is `repr(transparent)`.
+        //
+        // INVARIANT: The safety requirements guarantee that the refcount does not hit zero during
+        // 'a.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Returns a raw pointer to the inner C struct.
+    #[inline]
+    pub fn as_ptr(&self) -> *mut bindings::file {
+        self.0.get()
+    }
+
+    /// Returns the flags associated with the file.
+    ///
+    /// The flags are a combination of the constants in [`flags`].
+    pub fn flags(&self) -> u32 {
+        // This `read_volatile` is intended to correspond to a READ_ONCE call.
+        //
+        // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
+        //
+        // TODO: Replace with `read_once` when available on the Rust side.
+        unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_volatile() }
+    }
+}
+
+// SAFETY: The type invariants guarantee that `File` is always ref-counted.
+unsafe impl AlwaysRefCounted for File {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::get_file(self.as_ptr()) };
+    }
+
+    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
+        unsafe { bindings::fput(obj.cast().as_ptr()) }
+    }
+}
+
+/// Represents the `EBADF` error code.
+///
+/// Used for methods that can only fail with `EBADF`.
+#[derive(Copy, Clone, Eq, PartialEq)]
+pub struct BadFdError;
+
+impl From<BadFdError> for Error {
+    fn from(_: BadFdError) -> Error {
+        EBADF
+    }
+}
+
+impl core::fmt::Debug for BadFdError {
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        f.pad("EBADF")
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e6aff80b521f..ce9abceab784 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -34,6 +34,7 @@
 mod allocator;
 mod build_assert;
 pub mod error;
+pub mod file;
 pub mod init;
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]

-- 
2.43.0.rc2.451.g8631bc7472-goog


