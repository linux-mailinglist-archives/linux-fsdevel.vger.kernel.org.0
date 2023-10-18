Return-Path: <linux-fsdevel+bounces-645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2C57CDB94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E2E11C20D13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6954F36AE6;
	Wed, 18 Oct 2023 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bcc7ShLo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36983589F;
	Wed, 18 Oct 2023 12:26:57 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C9FA3;
	Wed, 18 Oct 2023 05:26:55 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9daca2b85so51353115ad.1;
        Wed, 18 Oct 2023 05:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697632014; x=1698236814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4oGNCYkMKOT/RkEtS/bAaMFpJ0/Ena/JQgVAj+ViHo=;
        b=Bcc7ShLo99LZjwHpkMQq4cI+s5WrbjUa1JheJ4NuBALzebPWzir59vuHac4QqsWe5O
         mDLJ17Y0DZMqVXT6BwW4Jm++yuBJnqEETQaPYPZ8OszJJv/m/T0e9lUcFJsXoPAhZZz1
         B99yma+tokR1u4P5soBGlDYoLgCBtcqLT9o83DtAdBXCOYkNrDCV9jICVHvwaBx2hy0J
         IoGnmqjLPJqxUwU2S1Jen5Pn7lNEhfIVr3n/KofWpN/9IYGMQALw8fbtnHgnw5Tr7HM6
         QcHcMEo7x0qkZTiNj5qrVHrOa3PUT6ib3pNt8wcwiludM89EeAcfQa9z+n5w6W9a06Tj
         8Dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632014; x=1698236814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4oGNCYkMKOT/RkEtS/bAaMFpJ0/Ena/JQgVAj+ViHo=;
        b=le7QSlmieTVinVv6JY1Gwz1TnRe7UCH9n+sr7gTqXLLIqYWlG0BGAYeWVD0V7ZnrxC
         CQXzbsjnJFjg3I4IdFVTBX7J00CLzPb2EUZDi+MS9TaJWm3VhjgHlDQPVCU4VYiJ9Y1Q
         xNLqjjUZTiqJOmUeIEm0q2vpBUS5NMaemqSKo581dGF2si0Pytg+32mYvFCYHocW7yTI
         PE5TY7YPiy/T1ABHqy+wCMQI6PmX1kEYhsrnmed1HpszjZ2l68Ay6pBtmigsd6+bjzLL
         NvFRdfyIedA01mzsBV+sxi0KfOmTGBkHVRGv9uKYv6LL5uD1+RvChwGwqcLFg0nZ7NJY
         uKwg==
X-Gm-Message-State: AOJu0YyMN9S//eWAhBz3M4PYfjqfA0tJFWdWFaQmkwZEd/WwB/Jv2zJQ
	mcqcZkggkltjiBStUf5rujA=
X-Google-Smtp-Source: AGHT+IGhVCRC4nGm0aTH85dmW+gmyNDm2vQ9FljuKqJ0Sz8FTe8woVLMwfnO+sSHuwSw36zRU0ETpg==
X-Received: by 2002:a17:903:41cc:b0:1b8:8682:62fb with SMTP id u12-20020a17090341cc00b001b8868262fbmr7551078ple.4.1697632014298;
        Wed, 18 Oct 2023 05:26:54 -0700 (PDT)
Received: from wedsonaf-dev.. ([2804:389:7122:43b8:9b73:6339:3351:cce0])
        by smtp.googlemail.com with ESMTPSA id j1-20020a170902c3c100b001c736b0037fsm3411046plj.231.2023.10.18.05.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:26:54 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH 17/19] rust: fs: allow per-inode data
Date: Wed, 18 Oct 2023 09:25:16 -0300
Message-Id: <20231018122518.128049-18-wedsonaf@gmail.com>
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

Allow Rust file systems to attach extra [typed] data to each inode. If
no data is needed, use the regular inode kmem_cache, otherwise we create
a new one.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/helpers.c            |   7 +++
 rust/kernel/fs.rs         | 128 +++++++++++++++++++++++++++++++++++---
 rust/kernel/mem_cache.rs  |   2 -
 samples/rust/rust_rofs.rs |   9 ++-
 4 files changed, 131 insertions(+), 15 deletions(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index bc19f3b7b93e..7b12a6d4cf5c 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -222,6 +222,13 @@ void rust_helper_kunmap_local(const void *vaddr)
 }
 EXPORT_SYMBOL_GPL(rust_helper_kunmap_local);
 
+void *rust_helper_alloc_inode_sb(struct super_block *sb,
+				 struct kmem_cache *cache, gfp_t gfp)
+{
+	return alloc_inode_sb(sb, cache, gfp);
+}
+EXPORT_SYMBOL_GPL(rust_helper_alloc_inode_sb);
+
 void rust_helper_i_uid_write(struct inode *inode, uid_t uid)
 {
 	i_uid_write(inode, uid);
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index b1ad5c110dbb..b07203758674 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -9,8 +9,12 @@
 use crate::error::{code::*, from_result, to_result, Error, Result};
 use crate::folio::{LockedFolio, UniqueFolio};
 use crate::types::{ARef, AlwaysRefCounted, Either, ForeignOwnable, Opaque, ScopeGuard};
-use crate::{bindings, init::PinInit, str::CStr, time::Timespec, try_pin_init, ThisModule};
-use core::{marker::PhantomData, marker::PhantomPinned, mem::ManuallyDrop, pin::Pin, ptr};
+use crate::{
+    bindings, container_of, init::PinInit, mem_cache::MemCache, str::CStr, time::Timespec,
+    try_pin_init, ThisModule,
+};
+use core::mem::{size_of, ManuallyDrop, MaybeUninit};
+use core::{marker::PhantomData, marker::PhantomPinned, pin::Pin, ptr};
 use macros::{pin_data, pinned_drop};
 
 #[cfg(CONFIG_BUFFER_HEAD)]
@@ -35,6 +39,9 @@ pub trait FileSystem {
     /// Data associated with each file system instance (super-block).
     type Data: ForeignOwnable + Send + Sync;
 
+    /// Type of data associated with each inode.
+    type INodeData: Send + Sync;
+
     /// The name of the file system type.
     const NAME: &'static CStr;
 
@@ -165,6 +172,7 @@ fn try_from(v: u32) -> Result<Self> {
 pub struct Registration {
     #[pin]
     fs: Opaque<bindings::file_system_type>,
+    inode_cache: Option<MemCache>,
     #[pin]
     _pin: PhantomPinned,
 }
@@ -182,6 +190,14 @@ impl Registration {
     pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> impl PinInit<Self, Error> {
         try_pin_init!(Self {
             _pin: PhantomPinned,
+            inode_cache: if size_of::<T::INodeData>() == 0 {
+                None
+            } else {
+                Some(MemCache::try_new::<INodeWithData<T::INodeData>>(
+                    T::NAME,
+                    Some(Self::inode_init_once_callback::<T>),
+                )?)
+            },
             fs <- Opaque::try_ffi_init(|fs_ptr: *mut bindings::file_system_type| {
                 // SAFETY: `try_ffi_init` guarantees that `fs_ptr` is valid for write.
                 unsafe { fs_ptr.write(bindings::file_system_type::default()) };
@@ -239,6 +255,16 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> impl PinInit<
             unsafe { T::Data::from_foreign(ptr) };
         }
     }
+
+    unsafe extern "C" fn inode_init_once_callback<T: FileSystem + ?Sized>(
+        outer_inode: *mut core::ffi::c_void,
+    ) {
+        let ptr = outer_inode.cast::<INodeWithData<T::INodeData>>();
+
+        // SAFETY: This is only used in `new`, so we know that we have a valid `INodeWithData`
+        // instance whose inode part can be initialised.
+        unsafe { bindings::inode_init_once(ptr::addr_of_mut!((*ptr).inode)) };
+    }
 }
 
 #[pinned_drop]
@@ -280,6 +306,15 @@ pub fn super_block(&self) -> &SuperBlock<T> {
         unsafe { &*(*self.0.get()).i_sb.cast() }
     }
 
+    /// Returns the data associated with the inode.
+    pub fn data(&self) -> &T::INodeData {
+        let outerp = container_of!(self.0.get(), INodeWithData<T::INodeData>, inode);
+        // SAFETY: `self` is guaranteed to be valid by the existence of a shared reference
+        // (`&self`) to it. Additionally, we know `T::INodeData` is always initialised in an
+        // `INode`.
+        unsafe { &*(*outerp).data.as_ptr() }
+    }
+
     /// Returns the size of the inode contents.
     pub fn size(&self) -> i64 {
         // SAFETY: `self` is guaranteed to be valid by the existence of a shared reference.
@@ -300,15 +335,29 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
 
+struct INodeWithData<T> {
+    data: MaybeUninit<T>,
+    inode: bindings::inode,
+}
+
 /// An inode that is locked and hasn't been initialised yet.
 #[repr(transparent)]
 pub struct NewINode<T: FileSystem + ?Sized>(ARef<INode<T>>);
 
 impl<T: FileSystem + ?Sized> NewINode<T> {
     /// Initialises the new inode with the given parameters.
-    pub fn init(self, params: INodeParams) -> Result<ARef<INode<T>>> {
-        // SAFETY: This is a new inode, so it's safe to manipulate it mutably.
-        let inode = unsafe { &mut *self.0 .0.get() };
+    pub fn init(self, params: INodeParams<T::INodeData>) -> Result<ARef<INode<T>>> {
+        let outerp = container_of!(self.0 .0.get(), INodeWithData<T::INodeData>, inode);
+
+        // SAFETY: This is a newly-created inode. No other references to it exist, so it is
+        // safe to mutably dereference it.
+        let outer = unsafe { &mut *outerp.cast_mut() };
+
+        // N.B. We must always write this to a newly allocated inode because the free callback
+        // expects the data to be initialised and drops it.
+        outer.data.write(params.value);
+
+        let inode = &mut outer.inode;
 
         let mode = match params.typ {
             INodeType::Dir => {
@@ -424,7 +473,7 @@ pub enum INodeType {
 /// Required inode parameters.
 ///
 /// This is used when creating new inodes.
-pub struct INodeParams {
+pub struct INodeParams<T> {
     /// The access mode. It's a mask that grants execute (1), write (2) and read (4) access to
     /// everyone, the owner group, and the owner.
     pub mode: u16,
@@ -459,6 +508,9 @@ pub struct INodeParams {
 
     /// Last access time.
     pub atime: Timespec,
+
+    /// Value to attach to this node.
+    pub value: T,
 }
 
 /// A file system super block.
@@ -735,8 +787,12 @@ impl<T: FileSystem + ?Sized> Tables<T> {
     }
 
     const SUPER_BLOCK: bindings::super_operations = bindings::super_operations {
-        alloc_inode: None,
-        destroy_inode: None,
+        alloc_inode: if size_of::<T::INodeData>() != 0 {
+            Some(Self::alloc_inode_callback)
+        } else {
+            None
+        },
+        destroy_inode: Some(Self::destroy_inode_callback),
         free_inode: None,
         dirty_inode: None,
         write_inode: None,
@@ -766,6 +822,61 @@ impl<T: FileSystem + ?Sized> Tables<T> {
         shutdown: None,
     };
 
+    unsafe extern "C" fn alloc_inode_callback(
+        sb: *mut bindings::super_block,
+    ) -> *mut bindings::inode {
+        // SAFETY: The callback contract guarantees that `sb` is valid for read.
+        let super_type = unsafe { (*sb).s_type };
+
+        // SAFETY: This callback is only used in `Registration`, so `super_type` is necessarily
+        // embedded in a `Registration`, which is guaranteed to be valid because it has a
+        // superblock associated to it.
+        let reg = unsafe { &*container_of!(super_type, Registration, fs) };
+
+        // SAFETY: `sb` and `cache` are guaranteed to be valid by the callback contract and by
+        // the existence of a superblock respectively.
+        let ptr = unsafe {
+            bindings::alloc_inode_sb(sb, MemCache::ptr(&reg.inode_cache), bindings::GFP_KERNEL)
+        }
+        .cast::<INodeWithData<T::INodeData>>();
+        if ptr.is_null() {
+            return ptr::null_mut();
+        }
+        ptr::addr_of_mut!((*ptr).inode)
+    }
+
+    unsafe extern "C" fn destroy_inode_callback(inode: *mut bindings::inode) {
+        // SAFETY: By the C contract, `inode` is a valid pointer.
+        let is_bad = unsafe { bindings::is_bad_inode(inode) };
+
+        // SAFETY: The inode is guaranteed to be valid by the callback contract. Additionally, the
+        // superblock is also guaranteed to still be valid by the inode existence.
+        let super_type = unsafe { (*(*inode).i_sb).s_type };
+
+        // SAFETY: This callback is only used in `Registration`, so `super_type` is necessarily
+        // embedded in a `Registration`, which is guaranteed to be valid because it has a
+        // superblock associated to it.
+        let reg = unsafe { &*container_of!(super_type, Registration, fs) };
+        let ptr = container_of!(inode, INodeWithData<T::INodeData>, inode).cast_mut();
+
+        if !is_bad {
+            // SAFETY: The code either initialises the data or marks the inode as bad. Since the
+            // inode is not bad, the data is initialised, and thus safe to drop.
+            unsafe { ptr::drop_in_place((*ptr).data.as_mut_ptr()) };
+        }
+
+        if size_of::<T::INodeData>() == 0 {
+            // SAFETY: When the size of `INodeData` is zero, we don't use a separate mem_cache, so
+            // it is allocated from the regular mem_cache, which is what `free_inode_nonrcu` uses
+            // to free the inode.
+            unsafe { bindings::free_inode_nonrcu(inode) };
+        } else {
+            // The callback contract guarantees that the inode was previously allocated via the
+            // `alloc_inode_callback` callback, so it is safe to free it back to the cache.
+            unsafe { bindings::kmem_cache_free(MemCache::ptr(&reg.inode_cache), ptr.cast()) };
+        }
+    }
+
     unsafe extern "C" fn statfs_callback(
         dentry: *mut bindings::dentry,
         buf: *mut bindings::kstatfs,
@@ -1120,6 +1231,7 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
 /// struct MyFs;
 /// impl fs::FileSystem for MyFs {
 ///     type Data = ();
+///     type INodeData =();
 ///     const NAME: &'static CStr = c_str!("myfs");
 ///     fn super_params(_: &NewSuperBlock<Self>) -> Result<SuperParams<Self::Data>> {
 ///         todo!()
diff --git a/rust/kernel/mem_cache.rs b/rust/kernel/mem_cache.rs
index 05e5f2bc9781..bf6ce2d2d3e1 100644
--- a/rust/kernel/mem_cache.rs
+++ b/rust/kernel/mem_cache.rs
@@ -20,7 +20,6 @@ impl MemCache {
     /// Allocates a new `kmem_cache` for type `T`.
     ///
     /// `init` is called by the C code when entries are allocated.
-    #[allow(dead_code)]
     pub(crate) fn try_new<T>(
         name: &'static CStr,
         init: Option<unsafe extern "C" fn(*mut core::ffi::c_void)>,
@@ -43,7 +42,6 @@ pub(crate) fn try_new<T>(
     /// Returns the pointer to the `kmem_cache` instance, or null if it's `None`.
     ///
     /// This is a helper for functions like `alloc_inode_sb` where the cache is optional.
-    #[allow(dead_code)]
     pub(crate) fn ptr(c: &Option<Self>) -> *mut bindings::kmem_cache {
         match c {
             Some(m) => m.ptr.as_ptr(),
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
index 093425650f26..dfe745439842 100644
--- a/samples/rust/rust_rofs.rs
+++ b/samples/rust/rust_rofs.rs
@@ -53,6 +53,7 @@ struct Entry {
 struct RoFs;
 impl fs::FileSystem for RoFs {
     type Data = ();
+    type INodeData = &'static Entry;
     const NAME: &'static CStr = c_str!("rust-fs");
 
     fn super_params(_sb: &NewSuperBlock<Self>) -> Result<SuperParams<Self::Data>> {
@@ -79,6 +80,7 @@ fn init_root(sb: &SuperBlock<Self>) -> Result<ARef<INode<Self>>> {
                 atime: UNIX_EPOCH,
                 ctime: UNIX_EPOCH,
                 mtime: UNIX_EPOCH,
+                value: &ENTRIES[0],
             }),
         }
     }
@@ -122,6 +124,7 @@ fn lookup(parent: &INode<Self>, name: &[u8]) -> Result<ARef<INode<Self>>> {
                         atime: UNIX_EPOCH,
                         ctime: UNIX_EPOCH,
                         mtime: UNIX_EPOCH,
+                        value: e,
                     }),
                 };
             }
@@ -131,11 +134,7 @@ fn lookup(parent: &INode<Self>, name: &[u8]) -> Result<ARef<INode<Self>>> {
     }
 
     fn read_folio(inode: &INode<Self>, mut folio: LockedFolio<'_>) -> Result {
-        let data = match inode.ino() {
-            2 => ENTRIES[2].contents,
-            3 => ENTRIES[3].contents,
-            _ => return Err(EINVAL),
-        };
+        let data = inode.data().contents;
 
         let pos = usize::try_from(folio.pos()).unwrap_or(usize::MAX);
         let copied = if pos >= data.len() {
-- 
2.34.1


