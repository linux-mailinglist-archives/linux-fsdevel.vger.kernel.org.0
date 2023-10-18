Return-Path: <linux-fsdevel+bounces-637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777DE7CDB8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CBF9280EF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AAB358AF;
	Wed, 18 Oct 2023 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaNZigKQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A4D358A3;
	Wed, 18 Oct 2023 12:26:21 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09305116;
	Wed, 18 Oct 2023 05:26:19 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1caa371dcd8so7635195ad.0;
        Wed, 18 Oct 2023 05:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697631978; x=1698236778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faga32+UB08pXXYjH8Xoi0IpDu5Cj+Cqa9Vnfplfui4=;
        b=AaNZigKQf5HquBYd488kxYjmfeFcFMHzz9CStJG4rpKiJu0jPR28F7F32EII7Pj24T
         2ZPgR6lPvhEMQv5N1ybbO1CcJOKjvfL7QcWdEu6HzdxLiR8RGRPyJKWbLvauaMCUrkGm
         IohmL/SRP07u++ypscbywF20+PYkAX+1KCdVZj572fYH+QjA/EfkOmnHpWTTw7fwdL4r
         8hS0nQXYsfo8Ych3389b2iCl0TlaS9IupQy9ToNJJoShTmesvPW3WPB0nAvKZrY5gbXs
         23fGXcSaDzH18WdUys9SOJIgCRYpw+l5kIMNm4IygUHvviyK5LYfjLYBAeuGsd3bVHPw
         CM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697631978; x=1698236778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faga32+UB08pXXYjH8Xoi0IpDu5Cj+Cqa9Vnfplfui4=;
        b=tfsWrCtZSaYU2aW03UTC5No0psmjosyLJCaqNnfUiowuSwJ4GFVyAaI4r4KyqMcfVs
         Cnk4x1nFXQ5OEHNvH+X54y1JUkgfEtNPaaE3Gueo++PM+rbsO0GJ5d5mNlbX7fvbz0Hl
         ZzfOYjVxGsGJfjHy18ahGGCkO+w2RjLmgjqJ8baEXCo00opBlL5sLEU/Gn7/p6DFRFe4
         J0sDkto0ol+DSeJdvUcW4T5TM++IigTGlWhYcsnW6e3RV7YnVvnfs/25gHPe1q4svCDF
         hrpXxP4RML27+YyoOkX7gnByxAB5oHHRktU7nBplLzXmonJcXSTUQLcC0lF/UyYgppc5
         0pJQ==
X-Gm-Message-State: AOJu0Yymbz89TKYxmkViAAECPEhsSoX+RhqvDjkRZ/drSU1NKVCDwznv
	eKGbtXhfAfDRUuGoiujq7og=
X-Google-Smtp-Source: AGHT+IGuqmopLtWEmMFS8GxV6IVwolnbr7D96FufPBfeXCR6T08KFASr57fpppBgMIzJ5gtM6lA6ag==
X-Received: by 2002:a17:903:246:b0:1c7:5a63:43bb with SMTP id j6-20020a170903024600b001c75a6343bbmr6044847plh.8.1697631978312;
        Wed, 18 Oct 2023 05:26:18 -0700 (PDT)
Received: from wedsonaf-dev.. ([2804:389:7122:43b8:9b73:6339:3351:cce0])
        by smtp.googlemail.com with ESMTPSA id j1-20020a170902c3c100b001c736b0037fsm3411046plj.231.2023.10.18.05.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:26:18 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH 09/19] rust: folio: introduce basic support for folios
Date: Wed, 18 Oct 2023 09:25:08 -0300
Message-Id: <20231018122518.128049-10-wedsonaf@gmail.com>
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

Allow Rust file systems to handle ref-counted folios.

Provide the minimum needed to implement `read_folio` (part of `struct
address_space_operations`) in read-only file systems and to read
uncached blocks.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/bindings/bindings_helper.h |   3 +
 rust/bindings/lib.rs            |   2 +
 rust/helpers.c                  |  81 ++++++++++++
 rust/kernel/folio.rs            | 215 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 5 files changed, 302 insertions(+)
 create mode 100644 rust/kernel/folio.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ca1898ce9527..53a99ea512d1 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/fs_context.h>
 #include <linux/slab.h>
+#include <linux/pagemap.h>
 #include <linux/refcount.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
@@ -27,3 +28,5 @@ const slab_flags_t BINDINGS_SLAB_ACCOUNT = SLAB_ACCOUNT;
 const unsigned long BINDINGS_SB_RDONLY = SB_RDONLY;
 
 const loff_t BINDINGS_MAX_LFS_FILESIZE = MAX_LFS_FILESIZE;
+
+const size_t BINDINGS_PAGE_SIZE = PAGE_SIZE;
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 426915d3fb57..a96b7f08e57d 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -59,3 +59,5 @@ mod bindings_helper {
 pub const SB_RDONLY: core::ffi::c_ulong = BINDINGS_SB_RDONLY;
 
 pub const MAX_LFS_FILESIZE: loff_t = BINDINGS_MAX_LFS_FILESIZE;
+
+pub const PAGE_SIZE: usize = BINDINGS_PAGE_SIZE;
diff --git a/rust/helpers.c b/rust/helpers.c
index c5a2bec6467d..f2ce3e7b688c 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -23,10 +23,14 @@
 #include <kunit/test-bug.h>
 #include <linux/bug.h>
 #include <linux/build_bug.h>
+#include <linux/cacheflush.h>
 #include <linux/err.h>
 #include <linux/errname.h>
 #include <linux/fs.h>
+#include <linux/highmem.h>
+#include <linux/mm.h>
 #include <linux/mutex.h>
+#include <linux/pagemap.h>
 #include <linux/refcount.h>
 #include <linux/sched/signal.h>
 #include <linux/spinlock.h>
@@ -145,6 +149,77 @@ struct kunit *rust_helper_kunit_get_current_test(void)
 }
 EXPORT_SYMBOL_GPL(rust_helper_kunit_get_current_test);
 
+void *rust_helper_kmap(struct page *page)
+{
+	return kmap(page);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kmap);
+
+void rust_helper_kunmap(struct page *page)
+{
+	kunmap(page);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kunmap);
+
+void rust_helper_folio_get(struct folio *folio)
+{
+	folio_get(folio);
+}
+EXPORT_SYMBOL_GPL(rust_helper_folio_get);
+
+void rust_helper_folio_put(struct folio *folio)
+{
+	folio_put(folio);
+}
+EXPORT_SYMBOL_GPL(rust_helper_folio_put);
+
+struct page *rust_helper_folio_page(struct folio *folio, size_t n)
+{
+	return folio_page(folio, n);
+}
+
+loff_t rust_helper_folio_pos(struct folio *folio)
+{
+	return folio_pos(folio);
+}
+EXPORT_SYMBOL_GPL(rust_helper_folio_pos);
+
+size_t rust_helper_folio_size(struct folio *folio)
+{
+	return folio_size(folio);
+}
+EXPORT_SYMBOL_GPL(rust_helper_folio_size);
+
+void rust_helper_folio_mark_uptodate(struct folio *folio)
+{
+	folio_mark_uptodate(folio);
+}
+EXPORT_SYMBOL_GPL(rust_helper_folio_mark_uptodate);
+
+void rust_helper_folio_set_error(struct folio *folio)
+{
+	folio_set_error(folio);
+}
+EXPORT_SYMBOL_GPL(rust_helper_folio_set_error);
+
+void rust_helper_flush_dcache_folio(struct folio *folio)
+{
+	flush_dcache_folio(folio);
+}
+EXPORT_SYMBOL_GPL(rust_helper_flush_dcache_folio);
+
+void *rust_helper_kmap_local_folio(struct folio *folio, size_t offset)
+{
+	return kmap_local_folio(folio, offset);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kmap_local_folio);
+
+void rust_helper_kunmap_local(const void *vaddr)
+{
+	kunmap_local(vaddr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kunmap_local);
+
 void rust_helper_i_uid_write(struct inode *inode, uid_t uid)
 {
 	i_uid_write(inode, uid);
@@ -163,6 +238,12 @@ off_t rust_helper_i_size_read(const struct inode *inode)
 }
 EXPORT_SYMBOL_GPL(rust_helper_i_size_read);
 
+void rust_helper_mapping_set_large_folios(struct address_space *mapping)
+{
+	mapping_set_large_folios(mapping);
+}
+EXPORT_SYMBOL_GPL(rust_helper_mapping_set_large_folios);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/folio.rs b/rust/kernel/folio.rs
new file mode 100644
index 000000000000..ef8a08b97962
--- /dev/null
+++ b/rust/kernel/folio.rs
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Groups of contiguous pages, folios.
+//!
+//! C headers: [`include/linux/mm.h`](../../include/linux/mm.h)
+
+use crate::error::{code::*, Result};
+use crate::types::{ARef, AlwaysRefCounted, Opaque, ScopeGuard};
+use core::{cmp::min, ptr};
+
+/// Wraps the kernel's `struct folio`.
+///
+/// # Invariants
+///
+/// Instances of this type are always ref-counted, that is, a call to `folio_get` ensures that the
+/// allocation remains valid at least until the matching call to `folio_put`.
+#[repr(transparent)]
+pub struct Folio(pub(crate) Opaque<bindings::folio>);
+
+// SAFETY: The type invariants guarantee that `Folio` is always ref-counted.
+unsafe impl AlwaysRefCounted for Folio {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::folio_get(self.0.get()) };
+    }
+
+    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
+        unsafe { bindings::folio_put(obj.cast().as_ptr()) }
+    }
+}
+
+impl Folio {
+    /// Tries to allocate a new folio.
+    ///
+    /// On success, returns a folio made up of 2^order pages.
+    pub fn try_new(order: u32) -> Result<UniqueFolio> {
+        if order > bindings::MAX_ORDER {
+            return Err(EDOM);
+        }
+
+        // SAFETY: We checked that `order` is within the max allowed value.
+        let f = ptr::NonNull::new(unsafe { bindings::folio_alloc(bindings::GFP_KERNEL, order) })
+            .ok_or(ENOMEM)?;
+
+        // SAFETY: The folio returned by `folio_alloc` is referenced. The ownership of the
+        // reference is transferred to the `ARef` instance.
+        Ok(UniqueFolio(unsafe { ARef::from_raw(f.cast()) }))
+    }
+
+    /// Returns the byte position of this folio in its file.
+    pub fn pos(&self) -> i64 {
+        // SAFETY: The folio is valid because the shared reference implies a non-zero refcount.
+        unsafe { bindings::folio_pos(self.0.get()) }
+    }
+
+    /// Returns the byte size of this folio.
+    pub fn size(&self) -> usize {
+        // SAFETY: The folio is valid because the shared reference implies a non-zero refcount.
+        unsafe { bindings::folio_size(self.0.get()) }
+    }
+
+    /// Flushes the data cache for the pages that make up the folio.
+    pub fn flush_dcache(&self) {
+        // SAFETY: The folio is valid because the shared reference implies a non-zero refcount.
+        unsafe { bindings::flush_dcache_folio(self.0.get()) }
+    }
+}
+
+/// A [`Folio`] that has a single reference to it.
+pub struct UniqueFolio(pub(crate) ARef<Folio>);
+
+impl UniqueFolio {
+    /// Maps the contents of a folio page into a slice.
+    pub fn map_page(&self, page_index: usize) -> Result<MapGuard<'_>> {
+        if page_index >= self.0.size() / bindings::PAGE_SIZE {
+            return Err(EDOM);
+        }
+
+        // SAFETY: We just checked that the index is within bounds of the folio.
+        let page = unsafe { bindings::folio_page(self.0 .0.get(), page_index) };
+
+        // SAFETY: `page` is valid because it was returned by `folio_page` above.
+        let ptr = unsafe { bindings::kmap(page) };
+
+        // SAFETY: We just mapped `ptr`, so it's valid for read.
+        let data = unsafe { core::slice::from_raw_parts(ptr.cast::<u8>(), bindings::PAGE_SIZE) };
+
+        Ok(MapGuard { data, page })
+    }
+}
+
+/// A mapped [`UniqueFolio`].
+pub struct MapGuard<'a> {
+    data: &'a [u8],
+    page: *mut bindings::page,
+}
+
+impl core::ops::Deref for MapGuard<'_> {
+    type Target = [u8];
+
+    fn deref(&self) -> &Self::Target {
+        self.data
+    }
+}
+
+impl Drop for MapGuard<'_> {
+    fn drop(&mut self) {
+        // SAFETY: A `MapGuard` instance is only created when `kmap` succeeds, so it's ok to unmap
+        // it when the guard is dropped.
+        unsafe { bindings::kunmap(self.page) };
+    }
+}
+
+/// A locked [`Folio`].
+pub struct LockedFolio<'a>(&'a Folio);
+
+impl LockedFolio<'_> {
+    /// Creates a new locked folio from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the folio is valid and locked. Additionally, that the
+    /// responsibility of unlocking is transferred to the new instance of [`LockedFolio`]. Lastly,
+    /// that the returned [`LockedFolio`] doesn't outlive the refcount that keeps it alive.
+    #[allow(dead_code)]
+    pub(crate) unsafe fn from_raw(folio: *const bindings::folio) -> Self {
+        let ptr = folio.cast();
+        // SAFETY: The safety requirements ensure that `folio` (from which `ptr` is derived) is
+        // valid and will remain valid while the `LockedFolio` instance lives.
+        Self(unsafe { &*ptr })
+    }
+
+    /// Marks the folio as being up to date.
+    pub fn mark_uptodate(&mut self) {
+        // SAFETY: The folio is valid because the shared reference implies a non-zero refcount.
+        unsafe { bindings::folio_mark_uptodate(self.0 .0.get()) }
+    }
+
+    /// Sets the error flag on the folio.
+    pub fn set_error(&mut self) {
+        // SAFETY: The folio is valid because the shared reference implies a non-zero refcount.
+        unsafe { bindings::folio_set_error(self.0 .0.get()) }
+    }
+
+    fn for_each_page(
+        &mut self,
+        offset: usize,
+        len: usize,
+        mut cb: impl FnMut(&mut [u8]) -> Result,
+    ) -> Result {
+        let mut remaining = len;
+        let mut next_offset = offset;
+
+        // Check that we don't overflow the folio.
+        let end = offset.checked_add(len).ok_or(EDOM)?;
+        if end > self.size() {
+            return Err(EINVAL);
+        }
+
+        while remaining > 0 {
+            let page_offset = next_offset & (bindings::PAGE_SIZE - 1);
+            let usable = min(remaining, bindings::PAGE_SIZE - page_offset);
+            // SAFETY: The folio is valid because the shared reference implies a non-zero refcount;
+            // `next_offset` is also guaranteed be lesss than the folio size.
+            let ptr = unsafe { bindings::kmap_local_folio(self.0 .0.get(), next_offset) };
+
+            // SAFETY: `ptr` was just returned by the `kmap_local_folio` above.
+            let _guard = ScopeGuard::new(|| unsafe { bindings::kunmap_local(ptr) });
+
+            // SAFETY: `kmap_local_folio` maps whole page so we know it's mapped for at least
+            // `usable` bytes.
+            let s = unsafe { core::slice::from_raw_parts_mut(ptr.cast::<u8>(), usable) };
+            cb(s)?;
+
+            next_offset += usable;
+            remaining -= usable;
+        }
+
+        Ok(())
+    }
+
+    /// Writes the given slice into the folio.
+    pub fn write(&mut self, offset: usize, data: &[u8]) -> Result {
+        let mut remaining = data;
+
+        self.for_each_page(offset, data.len(), |s| {
+            s.copy_from_slice(&remaining[..s.len()]);
+            remaining = &remaining[s.len()..];
+            Ok(())
+        })
+    }
+
+    /// Writes zeroes into the folio.
+    pub fn zero_out(&mut self, offset: usize, len: usize) -> Result {
+        self.for_each_page(offset, len, |s| {
+            s.fill(0);
+            Ok(())
+        })
+    }
+}
+
+impl core::ops::Deref for LockedFolio<'_> {
+    type Target = Folio;
+    fn deref(&self) -> &Self::Target {
+        self.0
+    }
+}
+
+impl Drop for LockedFolio<'_> {
+    fn drop(&mut self) {
+        // SAFETY: The folio is valid because the shared reference implies a non-zero refcount.
+        unsafe { bindings::folio_unlock(self.0 .0.get()) }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 00059b80c240..0e85b380da64 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -34,6 +34,7 @@
 mod allocator;
 mod build_assert;
 pub mod error;
+pub mod folio;
 pub mod fs;
 pub mod init;
 pub mod ioctl;
-- 
2.34.1


