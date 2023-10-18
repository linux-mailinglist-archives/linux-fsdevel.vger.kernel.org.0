Return-Path: <linux-fsdevel+bounces-642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A86C97CDB91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C00B21971
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8A23589B;
	Wed, 18 Oct 2023 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMjjVlYs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5963B3588D;
	Wed, 18 Oct 2023 12:26:42 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9D698;
	Wed, 18 Oct 2023 05:26:40 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c5c91bec75so46212735ad.3;
        Wed, 18 Oct 2023 05:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697632000; x=1698236800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrF6Arw8KaTBf2vf2RpOGiYaWBYg9JY9IvGW6oCUD8s=;
        b=hMjjVlYsnFHwq4jEpXJ6or9uDqM2i1ewOpiMJi55SAR6khIhe2dxn/vHyUna+Y7Has
         mhPKJZ0SzMXzMLqH7CNqLEHp8tFY8Nk/2YTa/xd27IVgZO36q5UedNeUQCjpDU/w5R26
         A3q1A5LaPg9PYsejg8ve2RwApTqcBTcoXsrQQwk8RL8Llu565Si9xMnJ6U+pJUAwUIA0
         7BQ4jQ5swnHkl97uc2QHmgJ+8ekvnvcwqVMsCju7XH4I7JvyUbkG2D+eFQOhHWsQxySA
         +dqMAEcrhxjw+qRXssy9aTUgPMpVzZ5tMGUxk6xQX65hM23EewNA7A1CpgBjHdhMl8ep
         SBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632000; x=1698236800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrF6Arw8KaTBf2vf2RpOGiYaWBYg9JY9IvGW6oCUD8s=;
        b=C2Z6vEF/jeisREdbRWWrxrWko5A5U5CxsOPNgIgLO9selaqG3m989lBYBGnnyoqPsL
         AqHznzlfvWN+DILqJUaKUcvHKkutxf61CpipDXbirIhlFc4ANx+kf0H4LIdKKPayw0nO
         i8I326erKgvPMrmOSENym6v++g9EPHqsEqv9n2aEbyIrmVb6vRSDdImw40fkCGmOzBfH
         6qhaB//x4R1SQHBBWfAkuMD3ZZ6RteLXFtR6jMfO3g5Xn8s5r6DmPrQelMBedj5O8rfg
         rRMY2Gc+Oaqc9EuWxRZeVwEbMbB2b5/knDFHBZpoU+AywIfUcSFO8hsUt5jbSGK8nMv5
         1AIA==
X-Gm-Message-State: AOJu0YyGHyfoK11pxNMoKr5SVtHGz4/qoQqSXzSM1kjhyxNGjD9jUrY7
	CNrwqjUzIoCOyjaOm3UZEVU=
X-Google-Smtp-Source: AGHT+IEmjFJfsKiZHETfpeXzb8w6Bz66rmrnXd6VftqnE4L0JQm7jLthzP8//r8z0zuWbq252ryeQA==
X-Received: by 2002:a17:902:e88b:b0:1c9:dd73:dc9e with SMTP id w11-20020a170902e88b00b001c9dd73dc9emr5998926plg.44.1697632000016;
        Wed, 18 Oct 2023 05:26:40 -0700 (PDT)
Received: from wedsonaf-dev.. ([2804:389:7122:43b8:9b73:6339:3351:cce0])
        by smtp.googlemail.com with ESMTPSA id j1-20020a170902c3c100b001c736b0037fsm3411046plj.231.2023.10.18.05.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:26:39 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH 14/19] rust: fs: add per-superblock data
Date: Wed, 18 Oct 2023 09:25:13 -0300
Message-Id: <20231018122518.128049-15-wedsonaf@gmail.com>
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

Allow Rust file systems to associate [typed] data to super blocks when
they're created. Since we only have a pointer-sized field in which to
store the state, it must implement the `ForeignOwnable` trait.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/fs.rs         | 42 +++++++++++++++++++++++++++++++++------
 samples/rust/rust_rofs.rs |  4 +++-
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 5b7eaa16d254..e9a9362d2897 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -7,7 +7,7 @@
 //! C headers: [`include/linux/fs.h`](../../include/linux/fs.h)
 
 use crate::error::{code::*, from_result, to_result, Error, Result};
-use crate::types::{ARef, AlwaysRefCounted, Either, Opaque};
+use crate::types::{ARef, AlwaysRefCounted, Either, ForeignOwnable, Opaque};
 use crate::{
     bindings, folio::LockedFolio, init::PinInit, str::CStr, time::Timespec, try_pin_init,
     ThisModule,
@@ -20,11 +20,14 @@
 
 /// A file system type.
 pub trait FileSystem {
+    /// Data associated with each file system instance (super-block).
+    type Data: ForeignOwnable + Send + Sync;
+
     /// The name of the file system type.
     const NAME: &'static CStr;
 
     /// Returns the parameters to initialise a super block.
-    fn super_params(sb: &NewSuperBlock<Self>) -> Result<SuperParams>;
+    fn super_params(sb: &NewSuperBlock<Self>) -> Result<SuperParams<Self::Data>>;
 
     /// Initialises and returns the root inode of the given superblock.
     ///
@@ -174,7 +177,7 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> impl PinInit<
                 fs.owner = module.0;
                 fs.name = T::NAME.as_char_ptr();
                 fs.init_fs_context = Some(Self::init_fs_context_callback::<T>);
-                fs.kill_sb = Some(Self::kill_sb_callback);
+                fs.kill_sb = Some(Self::kill_sb_callback::<T>);
                 fs.fs_flags = 0;
 
                 // SAFETY: Pointers stored in `fs` are static so will live for as long as the
@@ -195,10 +198,22 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> impl PinInit<
         })
     }
 
-    unsafe extern "C" fn kill_sb_callback(sb_ptr: *mut bindings::super_block) {
+    unsafe extern "C" fn kill_sb_callback<T: FileSystem + ?Sized>(
+        sb_ptr: *mut bindings::super_block,
+    ) {
         // SAFETY: In `get_tree_callback` we always call `get_tree_nodev`, so `kill_anon_super` is
         // the appropriate function to call for cleanup.
         unsafe { bindings::kill_anon_super(sb_ptr) };
+
+        // SAFETY: The C API contract guarantees that `sb_ptr` is valid for read.
+        let ptr = unsafe { (*sb_ptr).s_fs_info };
+        if !ptr.is_null() {
+            // SAFETY: The only place where `s_fs_info` is assigned is `NewSuperBlock::init`, where
+            // it's initialised with the result of an `into_foreign` call. We checked above that
+            // `ptr` is non-null because it would be null if we never reached the point where we
+            // init the field.
+            unsafe { T::Data::from_foreign(ptr) };
+        }
     }
 }
 
@@ -429,6 +444,14 @@ pub struct INodeParams {
 pub struct SuperBlock<T: FileSystem + ?Sized>(Opaque<bindings::super_block>, PhantomData<T>);
 
 impl<T: FileSystem + ?Sized> SuperBlock<T> {
+    /// Returns the data associated with the superblock.
+    pub fn data(&self) -> <T::Data as ForeignOwnable>::Borrowed<'_> {
+        // SAFETY: This method is only available after the `NeedsData` typestate, so `s_fs_info`
+        // has been initialised initialised with the result of a call to `T::into_foreign`.
+        let ptr = unsafe { (*self.0.get()).s_fs_info };
+        unsafe { T::Data::borrow(ptr) }
+    }
+
     /// Tries to get an existing inode or create a new one if it doesn't exist yet.
     pub fn get_or_create_inode(&self, ino: Ino) -> Result<Either<ARef<INode<T>>, NewINode<T>>> {
         // SAFETY: The only initialisation missing from the superblock is the root, and this
@@ -458,7 +481,7 @@ pub fn get_or_create_inode(&self, ino: Ino) -> Result<Either<ARef<INode<T>>, New
 /// Required superblock parameters.
 ///
 /// This is returned by implementations of [`FileSystem::super_params`].
-pub struct SuperParams {
+pub struct SuperParams<T: ForeignOwnable + Send + Sync> {
     /// The magic number of the superblock.
     pub magic: u32,
 
@@ -472,6 +495,9 @@ pub struct SuperParams {
 
     /// Granularity of c/m/atime in ns (cannot be worse than a second).
     pub time_gran: u32,
+
+    /// Data to be associated with the superblock.
+    pub data: T,
 }
 
 /// A superblock that is still being initialised.
@@ -522,6 +548,9 @@ impl<T: FileSystem + ?Sized> Tables<T> {
             sb.0.s_blocksize = 1 << sb.0.s_blocksize_bits;
             sb.0.s_flags |= bindings::SB_RDONLY;
 
+            // N.B.: Even on failure, `kill_sb` is called and frees the data.
+            sb.0.s_fs_info = params.data.into_foreign().cast_mut();
+
             // SAFETY: The callback contract guarantees that `sb_ptr` is a unique pointer to a
             // newly-created (and initialised above) superblock.
             let sb = unsafe { &mut *sb_ptr.cast() };
@@ -934,8 +963,9 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
 ///
 /// struct MyFs;
 /// impl fs::FileSystem for MyFs {
+///     type Data = ();
 ///     const NAME: &'static CStr = c_str!("myfs");
-///     fn super_params(_: &NewSuperBlock<Self>) -> Result<SuperParams> {
+///     fn super_params(_: &NewSuperBlock<Self>) -> Result<SuperParams<Self::Data>> {
 ///         todo!()
 ///     }
 ///     fn init_root(_sb: &SuperBlock<Self>) -> Result<ARef<INode<Self>>> {
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
index 95ce28efa1c3..093425650f26 100644
--- a/samples/rust/rust_rofs.rs
+++ b/samples/rust/rust_rofs.rs
@@ -52,14 +52,16 @@ struct Entry {
 
 struct RoFs;
 impl fs::FileSystem for RoFs {
+    type Data = ();
     const NAME: &'static CStr = c_str!("rust-fs");
 
-    fn super_params(_sb: &NewSuperBlock<Self>) -> Result<SuperParams> {
+    fn super_params(_sb: &NewSuperBlock<Self>) -> Result<SuperParams<Self::Data>> {
         Ok(SuperParams {
             magic: 0x52555354,
             blocksize_bits: 12,
             maxbytes: fs::MAX_LFS_FILESIZE,
             time_gran: 1,
+            data: (),
         })
     }
 
-- 
2.34.1


