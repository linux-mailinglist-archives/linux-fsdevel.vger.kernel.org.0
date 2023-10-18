Return-Path: <linux-fsdevel+bounces-634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BA77CDB88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 632DDB2159A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A3034CDF;
	Wed, 18 Oct 2023 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmkzsGeT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A0834CD8;
	Wed, 18 Oct 2023 12:26:07 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A103810F;
	Wed, 18 Oct 2023 05:26:05 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ca215cc713so26763595ad.3;
        Wed, 18 Oct 2023 05:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697631965; x=1698236765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfXrH0ngDYVWfqSiSt/qHAsoIVeF72UwAYxZtAykxtw=;
        b=JmkzsGeTQHEK3TF+XIJlZT6u1HaCSuIt18HoWXvjvfd3R1l0Y5J4rsDwo6mtvfSgON
         0Q9Mr8AbFcHZ9wbNMrtCt9v/Jr/f7I2amtlxObDseCxTUeHtvRiM4k/aHZYcgWSoUlpe
         ToJrVENQBm1ivJkNZ64SEIkMnSUAIdByCNc1gjdBLKS4bHnY7ZR4AwPzQzSC71mGM4ME
         +Jw/zvn3r0D/t/nAyHZO+5nzZHrLU0LQjvfEHPbzmZeFTZy8n23CJ2pFM7XV1/jbk1Jq
         rv+8kImxz+9BK0sIOawv3aTUfA6k5XZau2u/RV85dKmMLzvNvh5tyAok4sYmQlMmrlBE
         KSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697631965; x=1698236765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfXrH0ngDYVWfqSiSt/qHAsoIVeF72UwAYxZtAykxtw=;
        b=S8Pl53SjtwBYc+NMnS+WWbtwNt/VSdWYdGBwvFHNl2nKLtJHJIKQmmjpVhfO4VHFSy
         5D7pcHbJfsY+dZWSs/q39s3F2otkY8idB7cyYawT/ichNSLdf5QT/iYzCiECypKgF7Qy
         34f66eLoVD/2YjAs3K7BEf4GNGAhGWyYnyXRA37QwBO4TOTzyqbEPm7ANV/QrrB+OCRe
         5m3DP6Hgqvb7Svcg+Q4aeC/w8ymR8Xr8fU/x/1ry3ErFwIJ3V8iUCogxyuqrwFH1N3eN
         qxV9HO/0SnslS8cbRkg5tsZOnC1dek+a4smzWM8DlnDQ1w7d6erEC1qmdZbhGW7xmKif
         yiJQ==
X-Gm-Message-State: AOJu0Yz2keupYsewOgKWWRXQVjgv8xHQimVbQfYByFOAVLKcVCiEPeQs
	aHXTWapetTm2i2wVArqMdYI=
X-Google-Smtp-Source: AGHT+IFmu1LYmaqPb9u0A7F701UcFReA8OCRcFUK2e/RMJcPNXzo9dEt76JmfnTNgbCFV0vpkStiYA==
X-Received: by 2002:a17:903:7c4:b0:1ca:79b6:ce42 with SMTP id ko4-20020a17090307c400b001ca79b6ce42mr4311720plb.47.1697631964904;
        Wed, 18 Oct 2023 05:26:04 -0700 (PDT)
Received: from wedsonaf-dev.. ([2804:389:7122:43b8:9b73:6339:3351:cce0])
        by smtp.googlemail.com with ESMTPSA id j1-20020a170902c3c100b001c736b0037fsm3411046plj.231.2023.10.18.05.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:26:04 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH 06/19] rust: fs: introduce `FileSystem::init_root`
Date: Wed, 18 Oct 2023 09:25:05 -0300
Message-Id: <20231018122518.128049-7-wedsonaf@gmail.com>
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

Allow Rust file systems to specify their root directory. Also allow them
to create (and do cache lookups of) directory inodes. (More types of
inodes are added in subsequent patches in the series.)

The `NewINode` type ensures that a new inode is properly initialised
before it is marked so. It also facilitates error paths by automatically
marking inodes as failed if they're not properly initialised.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/helpers.c            |  12 +++
 rust/kernel/fs.rs         | 178 +++++++++++++++++++++++++++++++-------
 samples/rust/rust_rofs.rs |  22 ++++-
 3 files changed, 181 insertions(+), 31 deletions(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index fe45f8ddb31f..c5a2bec6467d 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -145,6 +145,18 @@ struct kunit *rust_helper_kunit_get_current_test(void)
 }
 EXPORT_SYMBOL_GPL(rust_helper_kunit_get_current_test);
 
+void rust_helper_i_uid_write(struct inode *inode, uid_t uid)
+{
+	i_uid_write(inode, uid);
+}
+EXPORT_SYMBOL_GPL(rust_helper_i_uid_write);
+
+void rust_helper_i_gid_write(struct inode *inode, gid_t gid)
+{
+	i_gid_write(inode, gid);
+}
+EXPORT_SYMBOL_GPL(rust_helper_i_gid_write);
+
 off_t rust_helper_i_size_read(const struct inode *inode)
 {
 	return i_size_read(inode);
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 30fa1f312f33..f3a41cf57502 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -7,9 +7,9 @@
 //! C headers: [`include/linux/fs.h`](../../include/linux/fs.h)
 
 use crate::error::{code::*, from_result, to_result, Error, Result};
-use crate::types::{AlwaysRefCounted, Opaque};
-use crate::{bindings, init::PinInit, str::CStr, try_pin_init, ThisModule};
-use core::{marker::PhantomData, marker::PhantomPinned, pin::Pin, ptr};
+use crate::types::{ARef, AlwaysRefCounted, Either, Opaque};
+use crate::{bindings, init::PinInit, str::CStr, time::Timespec, try_pin_init, ThisModule};
+use core::{marker::PhantomData, marker::PhantomPinned, mem::ManuallyDrop, pin::Pin, ptr};
 use macros::{pin_data, pinned_drop};
 
 /// Maximum size of an inode.
@@ -22,6 +22,12 @@ pub trait FileSystem {
 
     /// Returns the parameters to initialise a super block.
     fn super_params(sb: &NewSuperBlock<Self>) -> Result<SuperParams>;
+
+    /// Initialises and returns the root inode of the given superblock.
+    ///
+    /// This is called during initialisation of a superblock after [`FileSystem::super_params`] has
+    /// completed successfully.
+    fn init_root(sb: &SuperBlock<Self>) -> Result<ARef<INode<Self>>>;
 }
 
 /// A registration of a file system.
@@ -143,12 +149,136 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
 
+/// An inode that is locked and hasn't been initialised yet.
+#[repr(transparent)]
+pub struct NewINode<T: FileSystem + ?Sized>(ARef<INode<T>>);
+
+impl<T: FileSystem + ?Sized> NewINode<T> {
+    /// Initialises the new inode with the given parameters.
+    pub fn init(self, params: INodeParams) -> Result<ARef<INode<T>>> {
+        // SAFETY: This is a new inode, so it's safe to manipulate it mutably.
+        let inode = unsafe { &mut *self.0 .0.get() };
+
+        let mode = match params.typ {
+            INodeType::Dir => {
+                // SAFETY: `simple_dir_operations` never changes, it's safe to reference it.
+                inode.__bindgen_anon_3.i_fop = unsafe { &bindings::simple_dir_operations };
+
+                // SAFETY: `simple_dir_inode_operations` never changes, it's safe to reference it.
+                inode.i_op = unsafe { &bindings::simple_dir_inode_operations };
+                bindings::S_IFDIR
+            }
+        };
+
+        inode.i_mode = (params.mode & 0o777) | u16::try_from(mode)?;
+        inode.i_size = params.size;
+        inode.i_blocks = params.blocks;
+
+        inode.__i_ctime = params.ctime.into();
+        inode.i_mtime = params.mtime.into();
+        inode.i_atime = params.atime.into();
+
+        // SAFETY: inode is a new inode, so it is valid for write.
+        unsafe {
+            bindings::set_nlink(inode, params.nlink);
+            bindings::i_uid_write(inode, params.uid);
+            bindings::i_gid_write(inode, params.gid);
+            bindings::unlock_new_inode(inode);
+        }
+
+        // SAFETY: We are manually destructuring `self` and preventing `drop` from being called.
+        Ok(unsafe { (&ManuallyDrop::new(self).0 as *const ARef<INode<T>>).read() })
+    }
+}
+
+impl<T: FileSystem + ?Sized> Drop for NewINode<T> {
+    fn drop(&mut self) {
+        // SAFETY: The new inode failed to be turned into an initialised inode, so it's safe (and
+        // in fact required) to call `iget_failed` on it.
+        unsafe { bindings::iget_failed(self.0 .0.get()) };
+    }
+}
+
+/// The type of the inode.
+#[derive(Copy, Clone)]
+pub enum INodeType {
+    /// Directory type.
+    Dir,
+}
+
+/// Required inode parameters.
+///
+/// This is used when creating new inodes.
+pub struct INodeParams {
+    /// The access mode. It's a mask that grants execute (1), write (2) and read (4) access to
+    /// everyone, the owner group, and the owner.
+    pub mode: u16,
+
+    /// Type of inode.
+    ///
+    /// Also carries additional per-type data.
+    pub typ: INodeType,
+
+    /// Size of the contents of the inode.
+    ///
+    /// Its maximum value is [`MAX_LFS_FILESIZE`].
+    pub size: i64,
+
+    /// Number of blocks.
+    pub blocks: u64,
+
+    /// Number of links to the inode.
+    pub nlink: u32,
+
+    /// User id.
+    pub uid: u32,
+
+    /// Group id.
+    pub gid: u32,
+
+    /// Creation time.
+    pub ctime: Timespec,
+
+    /// Last modification time.
+    pub mtime: Timespec,
+
+    /// Last access time.
+    pub atime: Timespec,
+}
+
 /// A file system super block.
 ///
 /// Wraps the kernel's `struct super_block`.
 #[repr(transparent)]
 pub struct SuperBlock<T: FileSystem + ?Sized>(Opaque<bindings::super_block>, PhantomData<T>);
 
+impl<T: FileSystem + ?Sized> SuperBlock<T> {
+    /// Tries to get an existing inode or create a new one if it doesn't exist yet.
+    pub fn get_or_create_inode(&self, ino: Ino) -> Result<Either<ARef<INode<T>>, NewINode<T>>> {
+        // SAFETY: The only initialisation missing from the superblock is the root, and this
+        // function is needed to create the root, so it's safe to call it.
+        let inode =
+            ptr::NonNull::new(unsafe { bindings::iget_locked(self.0.get(), ino) }).ok_or(ENOMEM)?;
+
+        // SAFETY: `inode` is valid for read, but there could be concurrent writers (e.g., if it's
+        // an already-initialised inode), so we use `read_volatile` to read its current state.
+        let state = unsafe { ptr::read_volatile(ptr::addr_of!((*inode.as_ptr()).i_state)) };
+        if state & u64::from(bindings::I_NEW) == 0 {
+            // The inode is cached. Just return it.
+            //
+            // SAFETY: `inode` had its refcount incremented by `iget_locked`; this increment is now
+            // owned by `ARef`.
+            Ok(Either::Left(unsafe { ARef::from_raw(inode.cast()) }))
+        } else {
+            // SAFETY: The new inode is valid but not fully initialised yet, so it's ok to create a
+            // `NewINode`.
+            Ok(Either::Right(NewINode(unsafe {
+                ARef::from_raw(inode.cast())
+            })))
+        }
+    }
+}
+
 /// Required superblock parameters.
 ///
 /// This is returned by implementations of [`FileSystem::super_params`].
@@ -215,41 +345,28 @@ impl<T: FileSystem + ?Sized> Tables<T> {
             sb.0.s_blocksize = 1 << sb.0.s_blocksize_bits;
             sb.0.s_flags |= bindings::SB_RDONLY;
 
-            // The following is scaffolding code that will be removed in a subsequent patch. It is
-            // needed to build a root dentry, otherwise core code will BUG().
-            // SAFETY: `sb` is the superblock being initialised, it is valid for read and write.
-            let inode = unsafe { bindings::new_inode(&mut sb.0) };
-            if inode.is_null() {
-                return Err(ENOMEM);
-            }
-
-            // SAFETY: `inode` is valid for write.
-            unsafe { bindings::set_nlink(inode, 2) };
-
-            {
-                // SAFETY: This is a newly-created inode. No other references to it exist, so it is
-                // safe to mutably dereference it.
-                let inode = unsafe { &mut *inode };
-                inode.i_ino = 1;
-                inode.i_mode = (bindings::S_IFDIR | 0o755) as _;
-
-                // SAFETY: `simple_dir_operations` never changes, it's safe to reference it.
-                inode.__bindgen_anon_3.i_fop = unsafe { &bindings::simple_dir_operations };
+            // SAFETY: The callback contract guarantees that `sb_ptr` is a unique pointer to a
+            // newly-created (and initialised above) superblock.
+            let sb = unsafe { &mut *sb_ptr.cast() };
+            let root = T::init_root(sb)?;
 
-                // SAFETY: `simple_dir_inode_operations` never changes, it's safe to reference it.
-                inode.i_op = unsafe { &bindings::simple_dir_inode_operations };
+            // Reject root inode if it belongs to a different superblock.
+            if !ptr::eq(root.super_block(), sb) {
+                return Err(EINVAL);
             }
 
             // SAFETY: `d_make_root` requires that `inode` be valid and referenced, which is the
             // case for this call.
             //
             // It takes over the inode, even on failure, so we don't need to clean it up.
-            let dentry = unsafe { bindings::d_make_root(inode) };
+            let dentry = unsafe { bindings::d_make_root(ManuallyDrop::new(root).0.get()) };
             if dentry.is_null() {
                 return Err(ENOMEM);
             }
 
-            sb.0.s_root = dentry;
+            // SAFETY: The callback contract guarantees that `sb_ptr` is a unique pointer to a
+            // newly-created (and initialised above) superblock.
+            unsafe { (*sb_ptr).s_root = dentry };
 
             Ok(0)
         })
@@ -314,9 +431,9 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
 ///
 /// ```
 /// # mod module_fs_sample {
-/// use kernel::fs::{NewSuperBlock, SuperParams};
+/// use kernel::fs::{INode, NewSuperBlock, SuperBlock, SuperParams};
 /// use kernel::prelude::*;
-/// use kernel::{c_str, fs};
+/// use kernel::{c_str, fs, types::ARef};
 ///
 /// kernel::module_fs! {
 ///     type: MyFs,
@@ -332,6 +449,9 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
 ///     fn super_params(_: &NewSuperBlock<Self>) -> Result<SuperParams> {
 ///         todo!()
 ///     }
+///     fn init_root(_sb: &SuperBlock<Self>) -> Result<ARef<INode<Self>>> {
+///         todo!()
+///     }
 /// }
 /// # }
 /// ```
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
index 9878bf88b991..9e5f4c7d1c06 100644
--- a/samples/rust/rust_rofs.rs
+++ b/samples/rust/rust_rofs.rs
@@ -2,9 +2,9 @@
 
 //! Rust read-only file system sample.
 
-use kernel::fs::{NewSuperBlock, SuperParams};
+use kernel::fs::{INode, INodeParams, INodeType, NewSuperBlock, SuperBlock, SuperParams};
 use kernel::prelude::*;
-use kernel::{c_str, fs};
+use kernel::{c_str, fs, time::UNIX_EPOCH, types::ARef, types::Either};
 
 kernel::module_fs! {
     type: RoFs,
@@ -26,4 +26,22 @@ fn super_params(_sb: &NewSuperBlock<Self>) -> Result<SuperParams> {
             time_gran: 1,
         })
     }
+
+    fn init_root(sb: &SuperBlock<Self>) -> Result<ARef<INode<Self>>> {
+        match sb.get_or_create_inode(1)? {
+            Either::Left(existing) => Ok(existing),
+            Either::Right(new) => new.init(INodeParams {
+                typ: INodeType::Dir,
+                mode: 0o555,
+                size: 1,
+                blocks: 1,
+                nlink: 2,
+                uid: 0,
+                gid: 0,
+                atime: UNIX_EPOCH,
+                ctime: UNIX_EPOCH,
+                mtime: UNIX_EPOCH,
+            }),
+        }
+    }
 }
-- 
2.34.1


