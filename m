Return-Path: <linux-fsdevel+bounces-4994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D2D806FF9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 13:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7081F2141A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AD736AF8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZwVFUyXa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BAA1BF
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 04:00:14 -0800 (PST)
Received: by mail-lj1-x249.google.com with SMTP id 38308e7fff4ca-2ca0fbea7efso20092631fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 04:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701864012; x=1702468812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HX24dnaE+B8dQD9+a06Kja65k0fpP3j7QxTbOLGSMKA=;
        b=ZwVFUyXaHyrTd7KDatNq1jU8PrRUP1K+jmKb/35ykTvXSDll5fYj3ec/6n89kN4pZA
         GmCrdWokguzi68RHWOss5O40OIjEbUB3/bahur9YclJMQK5eALxtTNU1UvwmG34rM76a
         EO8OqqBSQoa3oxFwQeTFvsHfI5tLOavWstbADBaAxbXkTA30Tu6/ZgQXlQK7gwdhploP
         3+au7KiqsGeAy7ichAUezunAWn0tewZgHjAYivcNq9lQDEerruXXgOjnH1otceShq7BS
         DATU8R9aCId+CJzZkjgAk25h841VwH0Cy6JmLkRtoVeD/0m08tbVUY1K5xIwIt1VHyYD
         mL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701864012; x=1702468812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HX24dnaE+B8dQD9+a06Kja65k0fpP3j7QxTbOLGSMKA=;
        b=CChi2Q8G7Esm/7MkC6yjXBmsMMjqWUsV3Gx0280lgGT75/SQ2Kg6e5fkQYjjZDw8hC
         SpcADZLpkqFs0X+4+QPIWjeWaCCHUSQDNSAYFp9fAaF8HuR+SsMEmhIfKrSY9c+wFwM8
         DSv/LarFdVyp07jAnenKDy84eAD6ZLCsLXKQzpwKImIOdvsC894YT46NeXNEOulp+gZK
         qxbOQgEH0cmqxl7OeDyU+d4qCqc6nadWB18qyjAlfnuLhC2jZnkOgh1zIRY0VkcG1Xm7
         1pPXkdF5nxLtt7Ic+diIZwwwlCS4gSttIaqJ2yO+nh9GkxUTz+iMZFMkTnnKD5FzZqru
         PAgA==
X-Gm-Message-State: AOJu0YwuedCCHXbXk4mnHnCDJHNO3EVM6TV8RutZgPIqvnkvFAb6byDG
	2CmkNtfWLAAXnpmNU1ThySOke8I4OhBEWcw=
X-Google-Smtp-Source: AGHT+IGG4rfer9+wb6zLaC0ZQniLETPL4UJyJZrGKw6weysjcfPAL174MeYMqyYdp5VvSFl66sr88hufBfW61i4=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:651c:505:b0:2ca:1c35:b1ff with SMTP
 id o5-20020a05651c050500b002ca1c35b1ffmr9827ljp.5.1701864012431; Wed, 06 Dec
 2023 04:00:12 -0800 (PST)
Date: Wed, 06 Dec 2023 11:59:49 +0000
In-Reply-To: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5468; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=LT6/jKb5BgD0V7zv4tSIyAeTufgj7OW+bdLBEekMnp4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlcGI7V8wurNQW4hYt9klw3U62E/cywt/0hlVdD
 6nZ+2BMuJ+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZXBiOwAKCRAEWL7uWMY5
 RhD1EACRGMMcqA4bUhsKfa9wFlf609ZQqnQQSJRSW8UOl43LGBLRRCL8vRet9dopXE8coV3A43k
 9xPvGwlpCwcx5qhpqcNYFfxgLVwC0cZU0F4GlNQAI3D2B+7lwY5gy98+u7EW579s1hT0k5QTtol
 AqDj3UTgC662YcZ83oGzowWKvyjD+ED/NaAbYM84wFq69be2RMQzSzsF7tVO43FrBObluw8c50Q
 vT9PurHi9w9wkaCK2vaNMtDNJn9ESgIqHp1ix/0Ov6kh6cYNoqSAqbX3IfkOmgsWbpk99s4EySY
 nOokKzDDI3VMgQJJ5cFCcs56i1TxH4fGIFAH1WiWXV0YAoRgzX3XJIy7yW0lzio1Uboj3MuEzK/
 kjJ8Ng9/YIk9jyNlLpfmwKcgfw6Degxrf5yUXhK648+2T+Ykpo7XPNZ4u/xp/TWPoojZuqMmkbF
 8yl+hC2IyTltKFWXzGfrvPA6UffcOttzlh7gqqEhApR1cts5yrM5/zpfe++RMpepig4Td4CXpqz
 m03C+jgn47zZbgf/1nJf1gERuLlvVtADzJ8h/J4lxHwfGPeeYFsDFElYK2wHsOJjh1Nn0e6/y/j
 OW8JPxYsk03Vnw/QFYZl+7TVaEhRdwTW3noYpf/xBKovm1LH1sXNVEhRWTmKTOkWw+5YsSiw//T b2tP+Dcxiqhjlow==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231206-alice-file-v2-4-af617c0d9d94@google.com>
Subject: [PATCH v2 4/7] rust: file: add `FileDescriptorReservation`
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

Allow for the creation of a file descriptor in two steps: first, we
reserve a slot for it, then we commit or drop the reservation. The first
step may fail (e.g., the current process ran out of available slots),
but commit and drop never fail (and are mutually exclusive).

This is needed by Rust Binder when fds are sent from one process to
another. It has to be a two-step process to properly handle the case
where multiple fds are sent: The operation must fail or succeed
atomically, which we achieve by first reserving the fds we need, and
only installing the files once we have reserved enough fds to send the
files.

Fd reservations assume that the value of `current` does not change
between the call to get_unused_fd_flags and the call to fd_install (or
put_unused_fd). By not implementing the Send trait, this abstraction
ensures that the `FileDescriptorReservation` cannot be moved into a
different process.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/file.rs  | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 rust/kernel/types.rs | 10 ++++++++
 2 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
index a88140794a8d..2d036d4636a0 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -9,9 +9,9 @@
     bindings,
     cred::Credential,
     error::{code::*, Error, Result},
-    types::{ARef, AlwaysRefCounted, Opaque},
+    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
 };
-use core::ptr;
+use core::{marker::PhantomData, ptr};
 
 /// Flags associated with a [`File`].
 pub mod flags {
@@ -193,6 +193,70 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
 
+/// A file descriptor reservation.
+///
+/// This allows the creation of a file descriptor in two steps: first, we reserve a slot for it,
+/// then we commit or drop the reservation. The first step may fail (e.g., the current process ran
+/// out of available slots), but commit and drop never fail (and are mutually exclusive).
+///
+/// Dropping the reservation happens in the destructor of this type.
+///
+/// # Invariants
+///
+/// The fd stored in this struct must correspond to a reserved file descriptor of the current task.
+pub struct FileDescriptorReservation {
+    fd: u32,
+    /// Prevent values of this type from being moved to a different task.
+    ///
+    /// The `fd_install` and `put_unused_fd` functions assume that the value of `current` is
+    /// unchanged since the call to `get_unused_fd_flags`. By adding this marker to this type, we
+    /// prevent it from being moved across task boundaries, which ensures that `current` does not
+    /// change while this value exists.
+    _not_send: NotThreadSafe,
+}
+
+impl FileDescriptorReservation {
+    /// Creates a new file descriptor reservation.
+    pub fn get_unused_fd_flags(flags: u32) -> Result<Self> {
+        // SAFETY: FFI call, there are no safety requirements on `flags`.
+        let fd: i32 = unsafe { bindings::get_unused_fd_flags(flags) };
+        if fd < 0 {
+            return Err(Error::from_errno(fd));
+        }
+        Ok(Self {
+            fd: fd as u32,
+            _not_send: PhantomData,
+        })
+    }
+
+    /// Returns the file descriptor number that was reserved.
+    pub fn reserved_fd(&self) -> u32 {
+        self.fd
+    }
+
+    /// Commits the reservation.
+    ///
+    /// The previously reserved file descriptor is bound to `file`. This method consumes the
+    /// [`FileDescriptorReservation`], so it will not be usable after this call.
+    pub fn fd_install(self, file: ARef<File>) {
+        // SAFETY: `self.fd` was previously returned by `get_unused_fd_flags`, and `file.ptr` is
+        // guaranteed to have an owned ref count by its type invariants.
+        unsafe { bindings::fd_install(self.fd, file.0.get()) };
+
+        // `fd_install` consumes both the file descriptor and the file reference, so we cannot run
+        // the destructors.
+        core::mem::forget(self);
+        core::mem::forget(file);
+    }
+}
+
+impl Drop for FileDescriptorReservation {
+    fn drop(&mut self) {
+        // SAFETY: `self.fd` was returned by a previous call to `get_unused_fd_flags`.
+        unsafe { bindings::put_unused_fd(self.fd) };
+    }
+}
+
 /// Represents the `EBADF` error code.
 ///
 /// Used for methods that can only fail with `EBADF`.
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index fdb778e65d79..a4584d6b26c0 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -387,3 +387,13 @@ pub enum Either<L, R> {
     /// Constructs an instance of [`Either`] containing a value of type `R`.
     Right(R),
 }
+
+/// Zero-sized type to mark types not [`Send`].
+///
+/// Add this type as a field to your struct if your type should not be sent to a different task.
+/// Since [`Send`] is an auto trait, adding a single field that is `!Send` will ensure that the
+/// whole type is `!Send`.
+///
+/// If a type is `!Send` it is impossible to give control over an instance of the type to another
+/// task. This is useful when a type stores task-local information for example file descriptors.
+pub type NotThreadSafe = PhantomData<*mut ()>;

-- 
2.43.0.rc2.451.g8631bc7472-goog


