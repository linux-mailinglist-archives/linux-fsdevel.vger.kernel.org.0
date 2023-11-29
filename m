Return-Path: <linux-fsdevel+bounces-4194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523387FD98E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 15:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F631282378
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B784C3218B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZPSHsaSF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647EE10E5
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 05:12:06 -0800 (PST)
Received: by mail-lj1-x24a.google.com with SMTP id 38308e7fff4ca-2c9bbb18743so9854011fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 05:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701263524; x=1701868324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=esiXX39j7TBHYEJzpKp+/f8CbFmH8JGrCtrqMVnVTxs=;
        b=ZPSHsaSFsodDALg4wMXiPT1b9FBJ7F87h0+ORAPJ8RwYh6FjbWH8okFnbR+EMypaUp
         0zik3t8ZadLYLgDxVhdcfyb9vQ+x5IDXVhiovvvgb10YljIJP0DTbVlNwLbjJIpBkmS7
         zxCiIaj7dIjPSscCe9TKhBfGbj2PcQ72l+D2EABofmVVfbNMe1CCcsm5ws0/uEtGrsGn
         SuTOVxD2gDziukuxCxp8w9Y8BhM4HB/OSVtjW+vCC2a+L/eW2MhotwuXQ3kDgkIubeq/
         lsSoPOapIA9kN2Heg8nPpt4evQ+j2OgyJiCMsIz27ihE7/6OEUYtmFyJimvNzA043+A1
         UpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701263524; x=1701868324;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=esiXX39j7TBHYEJzpKp+/f8CbFmH8JGrCtrqMVnVTxs=;
        b=QoWKpf7QoTKhwAHrmzSZp6WIaAZS5blvR0+b/oMlfgBg2hjmbAMwFRpmAdxmZ22Jfh
         f8UVXwNff5nBIUKbCRvYMqPkKN4TA2Vi1DNtw3BHeDLDye7/LGrywS7rErgeDdO9oPY4
         8B3xBdVqnPna6qOyvhlUah61jqVw7sU6aUAW6zsfQpSzh1giIxY6SI/QRSkxdSGmJdcr
         zE05eATLZrxzev2dwrJFliXAN/sPkVIc6YMG58eCPisyoGJRvsEiuryd2I3ZGYQDqGpJ
         y9FIjleI9ekFyG6lJJB7ash7gHtCpcyI/2ERfZ8Tt6bxvqUOruBUsor6E2vE9+e/ZiTz
         K0HA==
X-Gm-Message-State: AOJu0YyjgMSZLnHqUDN7VobOZuNdNQqhOjTm0dzqSwzR+DrqDoJRQfhg
	BCU4Cufcyk6uwlVqTug0w3QLeZqbiyi1u/o=
X-Google-Smtp-Source: AGHT+IEHkVVfWS9BaS8ByCS7vIZyPFgO7jKlTCeXF8NGMQTxeGrWD+UWcjF+D+ckG3L8k8lP8kqV0TrhZRqV9G0=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:9110:0:b0:2c9:bc04:c096 with SMTP id
 m16-20020a2e9110000000b002c9bc04c096mr38076ljg.8.1701263524554; Wed, 29 Nov
 2023 05:12:04 -0800 (PST)
Date: Wed, 29 Nov 2023 13:11:56 +0000
In-Reply-To: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4281; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=SUMv8jXGAij3l0jBYJ4Ms5z5jJZ9MMahswDWLeA0kW4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlZzMyLtWU3gmtQGN7swi+G8KMYaE/xHeadwZsb
 f4gruq0HDuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZWczMgAKCRAEWL7uWMY5
 RljxD/45lWUS95ldd319LMIbnsKDH8muiHzIgmCnI/Ux8ekOfs63WXOW6PMtpqlv2iZobLGYJv0
 P9w0M1AKHI9s8ubw8ZFE+DOe6aa/2VTShlRKLi+Ka60afXjsTAEOY7l7vlDeDkU2qc5yMDNqErg
 hykmgusYIDJpSoOc8OaPMuR+V8jwxue/cP233vUY1HLlTf0TD3j0wOXn7cd+7zqH9iitsRnNyY4
 Osu/48J1Wgic6eeI4i6+z478nY0uXs1fAWFBz8veBAwl9LCzi4avMG4SG/9Jv/CVB6Beq21tH5P
 GezShTMCYkKx08ZCrK0ckmIlfVaoVcMNInULaCznCgTrOv1iIZS63z8hlYkIOQskVbG17LXo9nF
 RfjdNRMH2YwYuxW3wdkNXJBc1oEGQCqWF7vqYchI3ryaNgpdFUcMJxupAe046aPUyBBOLJPuVIJ
 3r84UtEGw+76Z+VbNDnAQdyHNFhKpvAvN6iX2nh5Am6ytp3eqYCNQiQ1RvXKbrMqR0+n8JhJoEt
 cL7Sv4Ias/SNUymafiEKQymxb4Af3F8BgKMANSHTU3Zm+Frzxm44c4xBp3X01IaPO335vmvao+a
 TEKWUG+9kx2sOIv7JKHksvoWevZD+SHwwAGCtGE7CCtoOoFg5iWOY51/afby0TdZEsmJeidtTsP je6av9Munk+4B6w==
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129-alice-file-v1-4-f81afe8c7261@google.com>
Subject: [PATCH 4/7] rust: file: add `FileDescriptorReservation`
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
 rust/kernel/file.rs | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
index f1f71c3d97e2..2186a6ea3f2f 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -11,7 +11,7 @@
     error::{code::*, Error, Result},
     types::{ARef, AlwaysRefCounted, Opaque},
 };
-use core::ptr;
+use core::{marker::PhantomData, ptr};
 
 /// Flags associated with a [`File`].
 pub mod flags {
@@ -180,6 +180,68 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
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
+    /// This is necessary because the C FFI calls assume that `current` is set to the task that
+    /// owns the fd in question.
+    _not_send_sync: PhantomData<*mut ()>,
+}
+
+impl FileDescriptorReservation {
+    /// Creates a new file descriptor reservation.
+    pub fn new(flags: u32) -> Result<Self> {
+        // SAFETY: FFI call, there are no safety requirements on `flags`.
+        let fd: i32 = unsafe { bindings::get_unused_fd_flags(flags) };
+        if fd < 0 {
+            return Err(Error::from_errno(fd));
+        }
+        Ok(Self {
+            fd: fd as _,
+            _not_send_sync: PhantomData,
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
+    pub fn commit(self, file: ARef<File>) {
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

-- 
2.43.0.rc1.413.gea7ed67945-goog


