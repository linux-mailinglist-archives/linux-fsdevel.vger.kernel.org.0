Return-Path: <linux-fsdevel+bounces-629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC2B7CDB7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E4A1C20D6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34447347C3;
	Wed, 18 Oct 2023 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh2MO0Fu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFDE341A1;
	Wed, 18 Oct 2023 12:25:46 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707E6112;
	Wed, 18 Oct 2023 05:25:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9d922c039so54580295ad.3;
        Wed, 18 Oct 2023 05:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697631944; x=1698236744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xex43RS2jNp3vQd6oNEUXyjdswTtSBFkdu+lQ9eZYV0=;
        b=Rh2MO0FuxoyWaDoGp0i2hcbU0P0nq6f6x179mXNCuu/9vRQy1TYejZKFcmDhLBVJxG
         Mg+b2/3VYUzHvCeCbPq8BTlZm+j4Urz9ZoRVKN+x54cbpyWFtNX2NN9dhZaLRcW9FYDN
         ZeOw25McPwyFP8s7dxNMuCqAy01j3Hs8H778S8X31nmJO//HeqbENyByvt6wqPCwRqdL
         pLWz5I5irHjpQKrk9tbHd5inuBZechh0FetkwEq+7HZ8aC3EAbLjZRDC2gRmQRn7+SAW
         Ha0xrB4SDgUCYDIJHEaDVDcpu6ZSHz+QlrrHjcqylaPowiVcXrwBxVgZrs6TU7oUdsbb
         ToKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697631944; x=1698236744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xex43RS2jNp3vQd6oNEUXyjdswTtSBFkdu+lQ9eZYV0=;
        b=Rf77AjxiAqBOpcfydXhx+VBWD6E29bUz90LdQxEGuMncSfxiDZjNIiPrBxJvpvcBCN
         YEtwVowN9vW1q4NTJalnMSP+Rm6HHKXA7hLBrd7fhbF2fon8+jWz90wl+NI/AIb1bpCT
         jLgvLA+ORBgbcyYfvNlhIe00vCFN8bnvhgA2jNI5Ah9CALQDfYju+fTYx5TGpkCVjyPv
         vMYsoDC0F2mTRzuwwa6pWZLG+/2IiX8UB8nSrO0Jcp9TKYDIoKOG+uxKY9KB1CIPZwyP
         XylWpuRz4lbSn/TmXRuwKU5CUpU40uCfP/eKRqquH9Bwc7qZMDmN87kQTVetJLuVdYSo
         xBMQ==
X-Gm-Message-State: AOJu0Yzyva50sIbZYNxQPXOgeOFPpw2L3PA3+kggUDQbj+8pDdSASk8N
	KsBwac34cCST0ki7CnE8V9o=
X-Google-Smtp-Source: AGHT+IHkRBzV2dTXTNWcXbjYFGuqrxzZoK1XnpQG76IA1lMQfND1KnbOY7w4b+5ctUXQ1kZ0GTAcow==
X-Received: by 2002:a17:903:32d0:b0:1ca:1be4:bda4 with SMTP id i16-20020a17090332d000b001ca1be4bda4mr5525882plr.4.1697631943795;
        Wed, 18 Oct 2023 05:25:43 -0700 (PDT)
Received: from wedsonaf-dev.. ([2804:389:7122:43b8:9b73:6339:3351:cce0])
        by smtp.googlemail.com with ESMTPSA id j1-20020a170902c3c100b001c736b0037fsm3411046plj.231.2023.10.18.05.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:25:43 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH 01/19] rust: fs: add registration/unregistration of file systems
Date: Wed, 18 Oct 2023 09:25:00 -0300
Message-Id: <20231018122518.128049-2-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018122518.128049-1-wedsonaf@gmail.com>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wedson Almeida Filho <walmeida@microsoft.com>

Allow basic registration and unregistration of Rust file system types.
Unregistration happens automatically when a registration variable is
dropped (e.g., when it goes out of scope).

File systems registered this way are visible in `/proc/filesystems` but
cannot be mounted yet because `init_fs_context` fails.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/error.rs            |  2 -
 rust/kernel/fs.rs               | 80 +++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |  1 +
 4 files changed, 82 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/fs.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3b620ae07021..9c23037b33d0 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -8,6 +8,7 @@
 
 #include <kunit/test.h>
 #include <linux/errname.h>
+#include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
 #include <linux/wait.h>
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 05fcab6abfe6..e6d7ce46be55 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -320,8 +320,6 @@ pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
 ///     })
 /// }
 /// ```
-// TODO: Remove `dead_code` marker once an in-kernel client is available.
-#[allow(dead_code)]
 pub(crate) fn from_result<T, F>(f: F) -> T
 where
     T: From<i16>,
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
new file mode 100644
index 000000000000..f3fb09db41ba
--- /dev/null
+++ b/rust/kernel/fs.rs
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Kernel file systems.
+//!
+//! This module allows Rust code to register new kernel file systems.
+//!
+//! C headers: [`include/linux/fs.h`](../../include/linux/fs.h)
+
+use crate::error::{code::*, from_result, to_result, Error};
+use crate::types::Opaque;
+use crate::{bindings, init::PinInit, str::CStr, try_pin_init, ThisModule};
+use core::{marker::PhantomPinned, pin::Pin};
+use macros::{pin_data, pinned_drop};
+
+/// A file system type.
+pub trait FileSystem {
+    /// The name of the file system type.
+    const NAME: &'static CStr;
+}
+
+/// A registration of a file system.
+#[pin_data(PinnedDrop)]
+pub struct Registration {
+    #[pin]
+    fs: Opaque<bindings::file_system_type>,
+    #[pin]
+    _pin: PhantomPinned,
+}
+
+// SAFETY: `Registration` doesn't provide any `&self` methods, so it is safe to pass references
+// to it around.
+unsafe impl Sync for Registration {}
+
+// SAFETY: Both registration and unregistration are implemented in C and safe to be performed
+// from any thread, so `Registration` is `Send`.
+unsafe impl Send for Registration {}
+
+impl Registration {
+    /// Creates the initialiser of a new file system registration.
+    pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            _pin: PhantomPinned,
+            fs <- Opaque::try_ffi_init(|fs_ptr: *mut bindings::file_system_type| {
+                // SAFETY: `try_ffi_init` guarantees that `fs_ptr` is valid for write.
+                unsafe { fs_ptr.write(bindings::file_system_type::default()) };
+
+                // SAFETY: `try_ffi_init` guarantees that `fs_ptr` is valid for write, and it has
+                // just been initialised above, so it's also valid for read.
+                let fs = unsafe { &mut *fs_ptr };
+                fs.owner = module.0;
+                fs.name = T::NAME.as_char_ptr();
+                fs.init_fs_context = Some(Self::init_fs_context_callback);
+                fs.kill_sb = Some(Self::kill_sb_callback);
+                fs.fs_flags = 0;
+
+                // SAFETY: Pointers stored in `fs` are static so will live for as long as the
+                // registration is active (it is undone in `drop`).
+                to_result(unsafe { bindings::register_filesystem(fs_ptr) })
+            }),
+        })
+    }
+
+    unsafe extern "C" fn init_fs_context_callback(
+        _fc_ptr: *mut bindings::fs_context,
+    ) -> core::ffi::c_int {
+        from_result(|| Err(ENOTSUPP))
+    }
+
+    unsafe extern "C" fn kill_sb_callback(_sb_ptr: *mut bindings::super_block) {}
+}
+
+#[pinned_drop]
+impl PinnedDrop for Registration {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: If an instance of `Self` has been successfully created, a call to
+        // `register_filesystem` has necessarily succeeded. So it's ok to call
+        // `unregister_filesystem` on the previously registered fs.
+        unsafe { bindings::unregister_filesystem(self.fs.get()) };
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 187d58f906a5..00059b80c240 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -34,6 +34,7 @@
 mod allocator;
 mod build_assert;
 pub mod error;
+pub mod fs;
 pub mod init;
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]
-- 
2.34.1


