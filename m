Return-Path: <linux-fsdevel+bounces-643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380B27CDB92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C601C20CF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F002358A4;
	Wed, 18 Oct 2023 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyeqwKD4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA95F3589F;
	Wed, 18 Oct 2023 12:26:46 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8458498;
	Wed, 18 Oct 2023 05:26:45 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1caa371dcd8so7638785ad.0;
        Wed, 18 Oct 2023 05:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697632005; x=1698236805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P61MlmjSe7FvOE0BP4exDriXbJ7DtpV2uo0UJk2lGNE=;
        b=EyeqwKD4xdSujiWwLPP214P2B5IpkIFrCK65XLtYHiZqX/sYuA3QHCbZraT7v0gwuf
         VcN6vUeodOF0xM4j9e9rjn7h+vAMDXAx38iA95jD+vUxf+f1PzMybOLV6vpxmyb9O9YU
         nBfaYjLNPbj8D1Dh4NYwwYV0ZauIxsQEY5/X63hh80AvuIxeTXs3bFsqQVnTaDdPhG1j
         W05IhQpI2RAo/LDuctzsJRoyTYp5AdaHfTeD31CUyRkRza0UlqQNFOIN37pAQaHK8Ugy
         gklrukWassIc1dF08QRaykiJATb9KzH0jXnv1VxWb7UUTFgZrLcqS6cKN89+HU2BlD6w
         cXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632005; x=1698236805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P61MlmjSe7FvOE0BP4exDriXbJ7DtpV2uo0UJk2lGNE=;
        b=C3i7dIj+YgNFnS/FVIB3W4Ty3onGYI+RIPD2sjVVSPu537qWVHrjQ86o+eF4RMR6as
         gvhharIaxHwBpQLzTHHRRiS4FsrqnEomsusVygyDJUjrAPvcDU1jk+S3LKMI5baXbCIr
         wEzGJcoKHn0vLX1JU/5PZ3cy5xgNmgUJeiaZ+dTSjzwo/kM5LsXPFvUaOX6zdSNDVhRe
         eDMeA0D1EnuvtGqftBWCEQuFgsj5YLuGV8n11XRBSkS31uzKNDrmOdd458SVthEdsX9F
         tMuBWwZFitVUaEPSrwLJixKBlTiry1VjH9vrH5uYYVeyiOvfVhijUuGe4myk9CFXzIeA
         afeQ==
X-Gm-Message-State: AOJu0YyTwiCad54m63eLKaaBsAjCzjFgvCncwHhMHPgO1kB46VWkb6mH
	DDtguUT/sl5c/P0l84Xm6IA=
X-Google-Smtp-Source: AGHT+IGJiScp1ydvE92KBOPsTi3tQLxd/SrIvUI5Yyt54VAn3eBvbK1Es43KLCTPy6UIGK9mbUXrbQ==
X-Received: by 2002:a17:902:bd0c:b0:1c9:b5a6:44a0 with SMTP id p12-20020a170902bd0c00b001c9b5a644a0mr4664021pls.23.1697632004899;
        Wed, 18 Oct 2023 05:26:44 -0700 (PDT)
Received: from wedsonaf-dev.. ([2804:389:7122:43b8:9b73:6339:3351:cce0])
        by smtp.googlemail.com with ESMTPSA id j1-20020a170902c3c100b001c736b0037fsm3411046plj.231.2023.10.18.05.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:26:44 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH 15/19] rust: fs: add basic support for fs buffer heads
Date: Wed, 18 Oct 2023 09:25:14 -0300
Message-Id: <20231018122518.128049-16-wedsonaf@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wedson Almeida Filho <walmeida@microsoft.com>

Introduce the abstractions that will be used by modules to handle buffer
heads, which will be used to access cached blocks from block devices.

All dead-code annotations are removed in the next commit in the series.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  | 15 ++++++++
 rust/kernel/fs.rs               |  3 ++
 rust/kernel/fs/buffer.rs        | 61 +++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+)
 create mode 100644 rust/kernel/fs/buffer.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index e2b2ccc835e3..d328375f7cb7 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <linux/buffer_head.h>
 #include <linux/errname.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index af335d1912e7..a5393c6b93f2 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -21,6 +21,7 @@
  */
 
 #include <kunit/test-bug.h>
+#include <linux/buffer_head.h>
 #include <linux/bug.h>
 #include <linux/build_bug.h>
 #include <linux/cacheflush.h>
@@ -250,6 +251,20 @@ unsigned int rust_helper_MKDEV(unsigned int major, unsigned int minor)
 }
 EXPORT_SYMBOL_GPL(rust_helper_MKDEV);
 
+#ifdef CONFIG_BUFFER_HEAD
+void rust_helper_get_bh(struct buffer_head *bh)
+{
+	get_bh(bh);
+}
+EXPORT_SYMBOL_GPL(rust_helper_get_bh);
+
+void rust_helper_put_bh(struct buffer_head *bh)
+{
+	put_bh(bh);
+}
+EXPORT_SYMBOL_GPL(rust_helper_put_bh);
+#endif
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index e9a9362d2897..4f04cb1d3c6f 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -15,6 +15,9 @@
 use core::{marker::PhantomData, marker::PhantomPinned, mem::ManuallyDrop, pin::Pin, ptr};
 use macros::{pin_data, pinned_drop};
 
+#[cfg(CONFIG_BUFFER_HEAD)]
+pub mod buffer;
+
 /// Maximum size of an inode.
 pub const MAX_LFS_FILESIZE: i64 = bindings::MAX_LFS_FILESIZE;
 
diff --git a/rust/kernel/fs/buffer.rs b/rust/kernel/fs/buffer.rs
new file mode 100644
index 000000000000..6052af8822b3
--- /dev/null
+++ b/rust/kernel/fs/buffer.rs
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! File system buffers.
+//!
+//! C headers: [`include/linux/buffer_head.h`](../../../include/linux/buffer_head.h)
+
+use crate::types::{ARef, AlwaysRefCounted, Opaque};
+use core::ptr;
+
+/// Wraps the kernel's `struct buffer_head`.
+///
+/// # Invariants
+///
+/// Instances of this type are always ref-counted, that is, a call to `get_bh` ensures that the
+/// allocation remains valid at least until the matching call to `put_bh`.
+#[repr(transparent)]
+pub struct Head(Opaque<bindings::buffer_head>);
+
+// SAFETY: The type invariants guarantee that `INode` is always ref-counted.
+unsafe impl AlwaysRefCounted for Head {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::get_bh(self.0.get()) };
+    }
+
+    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
+        unsafe { bindings::put_bh(obj.cast().as_ptr()) }
+    }
+}
+
+impl Head {
+    /// Returns the block data associated with the given buffer head.
+    pub fn data(&self) -> &[u8] {
+        let h = self.0.get();
+        // SAFETY: The existence of a shared reference guarantees that the buffer head is
+        // available and so we can access its contents.
+        unsafe { core::slice::from_raw_parts((*h).b_data.cast(), (*h).b_size) }
+    }
+}
+
+/// A view of a buffer.
+///
+/// It may contain just a contiguous subset of the buffer.
+pub struct View {
+    head: ARef<Head>,
+    offset: usize,
+    size: usize,
+}
+
+impl View {
+    #[allow(dead_code)]
+    pub(crate) fn new(head: ARef<Head>, offset: usize, size: usize) -> Self {
+        Self { head, size, offset }
+    }
+
+    /// Returns the view of the buffer head.
+    pub fn data(&self) -> &[u8] {
+        &self.head.data()[self.offset..][..self.size]
+    }
+}
-- 
2.34.1


