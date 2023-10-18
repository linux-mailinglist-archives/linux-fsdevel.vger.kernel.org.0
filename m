Return-Path: <linux-fsdevel+bounces-633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 708867CDB85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF8A1F230DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EC434CD3;
	Wed, 18 Oct 2023 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5BsO1Sa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB275341AF;
	Wed, 18 Oct 2023 12:26:02 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D08113;
	Wed, 18 Oct 2023 05:26:00 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ca72f8ff3aso23083795ad.0;
        Wed, 18 Oct 2023 05:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697631960; x=1698236760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lklRFykrq/fpkimZQTlOYKCnVo2EhWeW5QXx0pyDJS4=;
        b=J5BsO1SaCMyucI+Z7ziPKP0NQgfacbSFHEAfU5lQaZm+WYD+nj47u/mg1MY4mrjtFg
         lgzjENtT5rMUYIf9tHov+jhrPIsFXsNTqNaUUl++x9qjOcpXbTC6BZzAn5uNhItNpouT
         4y8H0OrTcFfMBqFJQpak0VOCfnMh2eEhQrtv509faY/EZWwNKf9ThEWGGrHab173681s
         OGCeZXzTX3j67aIfZGvZmyPwBjbFCNxc9C80sRJyZyzJJpox1Pitvqomn/xYesiA+Wj2
         LrKIWHDKAwEXGco+D5/9QEXdOqW7198Uyi/U0Rr3mfJdfwYP0gx1+L7z8yPWhuosZqdw
         6GmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697631960; x=1698236760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lklRFykrq/fpkimZQTlOYKCnVo2EhWeW5QXx0pyDJS4=;
        b=BU/wk77tXPx31LkaY6KWsg96ALVmQuKowvh+I5CdpXrEjAlFe4XVWXJ4GVRc0MtSCz
         IPJ7yh9wQUmEvdI9ltadas/WrZMwKtxkmOSbN4JUMFREqLBD2HN75Ah007fuponCnu3e
         PJY66R8I2IwZ8+0AvImCYgvkGiV0rIQ66yaAYoDiImn1iHbSeuMbvVqmnXLCwJ1fWG9f
         Hg1g4uGTX+jvsOJpmGhh09nM48kDVKfavjt9V8QkwNGZSYEoQ2zikspuuKegnc0QOLXW
         sky7BzsmQWTk3EO8uzjIRGsxGQ/71bn+rF5v3EsmObpK2RII9mgOyExfCBVC3FA0bOyI
         yXqw==
X-Gm-Message-State: AOJu0YxMl/U1J2DHQkSwBHi+EwlPgkPcGpKZYe071OVUS4gHr3EaQH0X
	NfNAeGbFty3UDWMsW4yESpI=
X-Google-Smtp-Source: AGHT+IHCJio9SLQo+NCeOqNaQsEGNbvSAmKDMCDv7U8I4tFhAMgV1wV+NR+vxT/LTqO5kseEdemd1w==
X-Received: by 2002:a17:903:32ce:b0:1c9:dbd3:94f7 with SMTP id i14-20020a17090332ce00b001c9dbd394f7mr6194268plr.65.1697631960265;
        Wed, 18 Oct 2023 05:26:00 -0700 (PDT)
Received: from wedsonaf-dev.. ([2804:389:7122:43b8:9b73:6339:3351:cce0])
        by smtp.googlemail.com with ESMTPSA id j1-20020a170902c3c100b001c736b0037fsm3411046plj.231.2023.10.18.05.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:25:59 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH 05/19] rust: fs: introduce `INode<T>`
Date: Wed, 18 Oct 2023 09:25:04 -0300
Message-Id: <20231018122518.128049-6-wedsonaf@gmail.com>
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

Allow Rust file systems to handle typed and ref-counted inodes.

This is in preparation for creating new inodes (for example, to create
the root inode of a new superblock), which comes in the next patch in
the series.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/helpers.c    |  7 +++++++
 rust/kernel/fs.rs | 53 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index 4c86fe4a7e05..fe45f8ddb31f 100644
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
@@ -144,6 +145,12 @@ struct kunit *rust_helper_kunit_get_current_test(void)
 }
 EXPORT_SYMBOL_GPL(rust_helper_kunit_get_current_test);
 
+off_t rust_helper_i_size_read(const struct inode *inode)
+{
+	return i_size_read(inode);
+}
+EXPORT_SYMBOL_GPL(rust_helper_i_size_read);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 31cf643aaded..30fa1f312f33 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -7,9 +7,9 @@
 //! C headers: [`include/linux/fs.h`](../../include/linux/fs.h)
 
 use crate::error::{code::*, from_result, to_result, Error, Result};
-use crate::types::Opaque;
+use crate::types::{AlwaysRefCounted, Opaque};
 use crate::{bindings, init::PinInit, str::CStr, try_pin_init, ThisModule};
-use core::{marker::PhantomData, marker::PhantomPinned, pin::Pin};
+use core::{marker::PhantomData, marker::PhantomPinned, pin::Pin, ptr};
 use macros::{pin_data, pinned_drop};
 
 /// Maximum size of an inode.
@@ -94,6 +94,55 @@ fn drop(self: Pin<&mut Self>) {
     }
 }
 
+/// The number of an inode.
+pub type Ino = u64;
+
+/// A node in the file system index (inode).
+///
+/// Wraps the kernel's `struct inode`.
+///
+/// # Invariants
+///
+/// Instances of this type are always ref-counted, that is, a call to `ihold` ensures that the
+/// allocation remains valid at least until the matching call to `iput`.
+#[repr(transparent)]
+pub struct INode<T: FileSystem + ?Sized>(Opaque<bindings::inode>, PhantomData<T>);
+
+impl<T: FileSystem + ?Sized> INode<T> {
+    /// Returns the number of the inode.
+    pub fn ino(&self) -> Ino {
+        // SAFETY: `i_ino` is immutable, and `self` is guaranteed to be valid by the existence of a
+        // shared reference (&self) to it.
+        unsafe { (*self.0.get()).i_ino }
+    }
+
+    /// Returns the super-block that owns the inode.
+    pub fn super_block(&self) -> &SuperBlock<T> {
+        // SAFETY: `i_sb` is immutable, and `self` is guaranteed to be valid by the existence of a
+        // shared reference (&self) to it.
+        unsafe { &*(*self.0.get()).i_sb.cast() }
+    }
+
+    /// Returns the size of the inode contents.
+    pub fn size(&self) -> i64 {
+        // SAFETY: `self` is guaranteed to be valid by the existence of a shared reference.
+        unsafe { bindings::i_size_read(self.0.get()) }
+    }
+}
+
+// SAFETY: The type invariants guarantee that `INode` is always ref-counted.
+unsafe impl<T: FileSystem + ?Sized> AlwaysRefCounted for INode<T> {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::ihold(self.0.get()) };
+    }
+
+    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
+        unsafe { bindings::iput(obj.cast().as_ptr()) }
+    }
+}
+
 /// A file system super block.
 ///
 /// Wraps the kernel's `struct super_block`.
-- 
2.34.1


