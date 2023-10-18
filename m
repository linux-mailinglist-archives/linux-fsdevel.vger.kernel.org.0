Return-Path: <linux-fsdevel+bounces-638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8922F7CDB8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82F79B21430
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE258347A9;
	Wed, 18 Oct 2023 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fd3rpBty"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA351DDFC;
	Wed, 18 Oct 2023 12:26:25 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F052112;
	Wed, 18 Oct 2023 05:26:23 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ca6809fb8aso22946905ad.1;
        Wed, 18 Oct 2023 05:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697631983; x=1698236783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw7Bt710S9wSgq7lYwmiNaJcrZn0u8YLmYwj+jhFGJE=;
        b=fd3rpBty1UIm35fgsgMx0xcQzlrZ/kpHW7btmTFnsF6238b0yXSm5GJN52BwYC2Xj3
         5AhspMX8cKDRm/ALYmNtPa9nFVhmoEqbpqSYpeu/9I+fTIVYlkGGrVI6+PKNIEOyoTTM
         gsVwT6pxN5UygXVyLIVQDp4ehlq/Qhr22EzmC/3iTVEKQpE8AsL8g3MXBUEWsddk+9SM
         DDj3QIw/iGLNByhW6+Rf8JLc9avaEcKp1Ei3WCmZUeFLdKLtSOiI7g6lLLM9czeu2cv5
         ciw2a/iwmhkf2N4rzT39NCl/FOXjX9FZjnyt0/aqyJmDAZlSqCqaq4pk5mzOVQb55dfm
         Epfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697631983; x=1698236783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tw7Bt710S9wSgq7lYwmiNaJcrZn0u8YLmYwj+jhFGJE=;
        b=ZytczmKWgTbxAc37wN3BwY69B1GW3EPTQLdHrBwzFNoCsIt8aRPWgQWLmmfABHweAN
         cWEHqC1vaEbVvXZqJ6O7u5BktqzzRcjj0clplXpFBkw388aqQzkoMWZBnBPQ1mdttg0/
         yJQHgdZM41DSrtBoFSptdyP2fh1KRtlXQdhlTCB6tw1rM8nGyrCGb0903iOeQbhQyi02
         WbH1g27wQ3IoTXkbDOCZBqq0vq2HmJSDHz8d+L95PAwT9e9YPrUvtX1fxCVqLTjRijyJ
         MVk6V7U3/oouJDjMBIm0pHc/7TbIn/mOTonOLi+A/4RHx+XueR4TCgN5bi5IapvurKo+
         F6aA==
X-Gm-Message-State: AOJu0YyWQWYvSgW+Y5a64tl6ov/Ap3hDviEZrQiNSZa8Ht5iVIRzO7Jo
	o1PokKAoZbHKJRZYimeHbjc=
X-Google-Smtp-Source: AGHT+IHX6mepXTgcyTGX7wAyKHqMQZGOk55mDoa3YY/X49KACM8npsQb+3j1IqlhtuYu4pPtY0SJRQ==
X-Received: by 2002:a17:903:32d0:b0:1c9:e0f9:a676 with SMTP id i16-20020a17090332d000b001c9e0f9a676mr4846526plr.6.1697631982965;
        Wed, 18 Oct 2023 05:26:22 -0700 (PDT)
Received: from wedsonaf-dev.. ([2804:389:7122:43b8:9b73:6339:3351:cce0])
        by smtp.googlemail.com with ESMTPSA id j1-20020a170902c3c100b001c736b0037fsm3411046plj.231.2023.10.18.05.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:26:22 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH 10/19] rust: fs: introduce `FileSystem::read_folio`
Date: Wed, 18 Oct 2023 09:25:09 -0300
Message-Id: <20231018122518.128049-11-wedsonaf@gmail.com>
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

Allow Rust file systems to create regular file inodes backed by the page
cache. The contents of such files are read into folios via `read_folio`.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/folio.rs      |  1 -
 rust/kernel/fs.rs         | 75 +++++++++++++++++++++++++++++++++++++--
 samples/rust/rust_rofs.rs | 69 ++++++++++++++++++++++++-----------
 3 files changed, 122 insertions(+), 23 deletions(-)

diff --git a/rust/kernel/folio.rs b/rust/kernel/folio.rs
index ef8a08b97962..b7f80291b0e1 100644
--- a/rust/kernel/folio.rs
+++ b/rust/kernel/folio.rs
@@ -123,7 +123,6 @@ impl LockedFolio<'_> {
     /// Callers must ensure that the folio is valid and locked. Additionally, that the
     /// responsibility of unlocking is transferred to the new instance of [`LockedFolio`]. Lastly,
     /// that the returned [`LockedFolio`] doesn't outlive the refcount that keeps it alive.
-    #[allow(dead_code)]
     pub(crate) unsafe fn from_raw(folio: *const bindings::folio) -> Self {
         let ptr = folio.cast();
         // SAFETY: The safety requirements ensure that `folio` (from which `ptr` is derived) is
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 681fef8e3af1..ee3dce87032b 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -8,7 +8,10 @@
 
 use crate::error::{code::*, from_result, to_result, Error, Result};
 use crate::types::{ARef, AlwaysRefCounted, Either, Opaque};
-use crate::{bindings, init::PinInit, str::CStr, time::Timespec, try_pin_init, ThisModule};
+use crate::{
+    bindings, folio::LockedFolio, init::PinInit, str::CStr, time::Timespec, try_pin_init,
+    ThisModule,
+};
 use core::{marker::PhantomData, marker::PhantomPinned, mem::ManuallyDrop, pin::Pin, ptr};
 use macros::{pin_data, pinned_drop};
 
@@ -36,6 +39,9 @@ pub trait FileSystem {
 
     /// Returns the inode corresponding to the directory entry with the given name.
     fn lookup(parent: &INode<Self>, name: &[u8]) -> Result<ARef<INode<Self>>>;
+
+    /// Reads the contents of the inode into the given folio.
+    fn read_folio(inode: &INode<Self>, folio: LockedFolio<'_>) -> Result;
 }
 
 /// The types of directory entries reported by [`FileSystem::read_dir`].
@@ -74,6 +80,7 @@ impl From<INodeType> for DirEntryType {
     fn from(value: INodeType) -> Self {
         match value {
             INodeType::Dir => DirEntryType::Dir,
+            INodeType::Reg => DirEntryType::Reg,
         }
     }
 }
@@ -232,6 +239,15 @@ pub fn init(self, params: INodeParams) -> Result<ARef<INode<T>>> {
                 inode.i_op = &Tables::<T>::DIR_INODE_OPERATIONS;
                 bindings::S_IFDIR
             }
+            INodeType::Reg => {
+                // SAFETY: `generic_ro_fops` never changes, it's safe to reference it.
+                inode.__bindgen_anon_3.i_fop = unsafe { &bindings::generic_ro_fops };
+                inode.i_data.a_ops = &Tables::<T>::FILE_ADDRESS_SPACE_OPERATIONS;
+
+                // SAFETY: The `i_mapping` pointer doesn't change and is valid.
+                unsafe { bindings::mapping_set_large_folios(inode.i_mapping) };
+                bindings::S_IFREG
+            }
         };
 
         inode.i_mode = (params.mode & 0o777) | u16::try_from(mode)?;
@@ -268,6 +284,9 @@ fn drop(&mut self) {
 pub enum INodeType {
     /// Directory type.
     Dir,
+
+    /// Regular file type.
+    Reg,
 }
 
 /// Required inode parameters.
@@ -588,6 +607,55 @@ extern "C" fn lookup_callback(
             },
         }
     }
+
+    const FILE_ADDRESS_SPACE_OPERATIONS: bindings::address_space_operations =
+        bindings::address_space_operations {
+            writepage: None,
+            read_folio: Some(Self::read_folio_callback),
+            writepages: None,
+            dirty_folio: None,
+            readahead: None,
+            write_begin: None,
+            write_end: None,
+            bmap: None,
+            invalidate_folio: None,
+            release_folio: None,
+            free_folio: None,
+            direct_IO: None,
+            migrate_folio: None,
+            launder_folio: None,
+            is_partially_uptodate: None,
+            is_dirty_writeback: None,
+            error_remove_page: None,
+            swap_activate: None,
+            swap_deactivate: None,
+            swap_rw: None,
+        };
+
+    extern "C" fn read_folio_callback(
+        _file: *mut bindings::file,
+        folio: *mut bindings::folio,
+    ) -> i32 {
+        from_result(|| {
+            // SAFETY: All pointers are valid and stable.
+            let inode = unsafe {
+                &*(*(*folio)
+                    .__bindgen_anon_1
+                    .page
+                    .__bindgen_anon_1
+                    .__bindgen_anon_1
+                    .mapping)
+                    .host
+                    .cast::<INode<T>>()
+            };
+
+            // SAFETY: The C contract guarantees that the folio is valid and locked, with ownership
+            // of the lock transferred to the callee (this function). The folio is also guaranteed
+            // not to outlive this function.
+            T::read_folio(inode, unsafe { LockedFolio::from_raw(folio) })?;
+            Ok(0)
+        })
+    }
 }
 
 /// Directory entry emitter.
@@ -673,7 +741,7 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
 /// # mod module_fs_sample {
 /// use kernel::fs::{DirEmitter, INode, NewSuperBlock, SuperBlock, SuperParams};
 /// use kernel::prelude::*;
-/// use kernel::{c_str, fs, types::ARef};
+/// use kernel::{c_str, folio::LockedFolio, fs, types::ARef};
 ///
 /// kernel::module_fs! {
 ///     type: MyFs,
@@ -698,6 +766,9 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
 ///     fn lookup(_: &INode<Self>, _: &[u8]) -> Result<ARef<INode<Self>>> {
 ///         todo!()
 ///     }
+///     fn read_folio(_: &INode<Self>, _: LockedFolio<'_>) -> Result {
+///         todo!()
+///     }
 /// }
 /// # }
 /// ```
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
index 4cc8525884a9..ef651ad38185 100644
--- a/samples/rust/rust_rofs.rs
+++ b/samples/rust/rust_rofs.rs
@@ -6,7 +6,7 @@
     DirEmitter, INode, INodeParams, INodeType, NewSuperBlock, SuperBlock, SuperParams,
 };
 use kernel::prelude::*;
-use kernel::{c_str, fs, time::UNIX_EPOCH, types::ARef, types::Either};
+use kernel::{c_str, folio::LockedFolio, fs, time::UNIX_EPOCH, types::ARef, types::Either};
 
 kernel::module_fs! {
     type: RoFs,
@@ -20,6 +20,7 @@ struct Entry {
     name: &'static [u8],
     ino: u64,
     etype: INodeType,
+    contents: &'static [u8],
 }
 
 const ENTRIES: [Entry; 3] = [
@@ -27,16 +28,19 @@ struct Entry {
         name: b".",
         ino: 1,
         etype: INodeType::Dir,
+        contents: b"",
     },
     Entry {
         name: b"..",
         ino: 1,
         etype: INodeType::Dir,
+        contents: b"",
     },
     Entry {
-        name: b"subdir",
+        name: b"test.txt",
         ino: 2,
-        etype: INodeType::Dir,
+        etype: INodeType::Reg,
+        contents: b"hello\n",
     },
 ];
 
@@ -95,23 +99,48 @@ fn lookup(parent: &INode<Self>, name: &[u8]) -> Result<ARef<INode<Self>>> {
             return Err(ENOENT);
         }
 
-        match name {
-            b"subdir" => match parent.super_block().get_or_create_inode(2)? {
-                Either::Left(existing) => Ok(existing),
-                Either::Right(new) => new.init(INodeParams {
-                    typ: INodeType::Dir,
-                    mode: 0o555,
-                    size: 0,
-                    blocks: 1,
-                    nlink: 2,
-                    uid: 0,
-                    gid: 0,
-                    atime: UNIX_EPOCH,
-                    ctime: UNIX_EPOCH,
-                    mtime: UNIX_EPOCH,
-                }),
-            },
-            _ => Err(ENOENT),
+        for e in &ENTRIES {
+            if name == e.name {
+                return match parent.super_block().get_or_create_inode(e.ino)? {
+                    Either::Left(existing) => Ok(existing),
+                    Either::Right(new) => new.init(INodeParams {
+                        typ: e.etype,
+                        mode: 0o444,
+                        size: e.contents.len().try_into()?,
+                        blocks: 1,
+                        nlink: 1,
+                        uid: 0,
+                        gid: 0,
+                        atime: UNIX_EPOCH,
+                        ctime: UNIX_EPOCH,
+                        mtime: UNIX_EPOCH,
+                    }),
+                };
+            }
         }
+
+        Err(ENOENT)
+    }
+
+    fn read_folio(inode: &INode<Self>, mut folio: LockedFolio<'_>) -> Result {
+        let data = match inode.ino() {
+            2 => ENTRIES[2].contents,
+            _ => return Err(EINVAL),
+        };
+
+        let pos = usize::try_from(folio.pos()).unwrap_or(usize::MAX);
+        let copied = if pos >= data.len() {
+            0
+        } else {
+            let to_copy = core::cmp::min(data.len() - pos, folio.size());
+            folio.write(0, &data[pos..][..to_copy])?;
+            to_copy
+        };
+
+        folio.zero_out(copied, folio.size() - copied)?;
+        folio.mark_uptodate();
+        folio.flush_dcache();
+
+        Ok(())
     }
 }
-- 
2.34.1


