Return-Path: <linux-fsdevel+bounces-632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 906A27CDB84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B302A1C2084B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E73347C3;
	Wed, 18 Oct 2023 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ewd2j9jC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F218E30;
	Wed, 18 Oct 2023 12:25:58 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F1D112;
	Wed, 18 Oct 2023 05:25:56 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c0ecb9a075so46362565ad.2;
        Wed, 18 Oct 2023 05:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697631956; x=1698236756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjSzpmMOCT4LT2rUtlPcM7n6DjRhsgcGb736/u49gDg=;
        b=Ewd2j9jCBjIERVtOfQQRLUDWnp7I002KuSZ9TxAgjnWj7CGTzdgrNSolSxZbsFFVFI
         bps4G55/vqY6WQ+DHJiK8DRY9NmbtB92ROThjfmvJyuumTvM/9qbdAuBm6Z0ns23IJuN
         X7v35yBPXnN6dLRL1aWij3gnV5sozCzIQiWpWEcW2gsZ5zoWAhweoUoY0ArvqaSvKzbF
         ahheIZGBC8HXSqFyCGMrTPeFqLYTnulXzCaLp87uU7dGSXeeeS4f7urJDtym8+w5zw/o
         cCjt1EWW2YnEHLwrrjQhgqXQ2fbma20QA2khrAZDWkrWhEa4WjR5/4cMBO5k6zldirDS
         qRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697631956; x=1698236756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjSzpmMOCT4LT2rUtlPcM7n6DjRhsgcGb736/u49gDg=;
        b=iMEyfuWpQmv5hC1Zd0D/me3qDI122wBr8rt26XPXaYoyaOXRPyeNsy4h5TMtoSy93G
         TDiDr1+iQGG5jubxoBQIpf7xvcFRjORzgUFK4hFwNBLdg1e+s3Sr/wvGTX2NsEQGg93y
         iX2cyPizjcVU4cKd/y3QVhCyPOaZpOsss4PbJxaGpfHODPMSQP1m7WgkauLTEyPaquaC
         MB1id6iQYSXD4dRHZ84NQCfxfJB9hGsCii/bdrlBtuEABiPHgoUucegmltlx8IDpkJjX
         LFfMkJMZHkw1+hkmqj28oHnjoe8aN9RrV2RNVxsKYKGXxqJhDwIbL4L1H2lfhBc6zZpY
         PO6A==
X-Gm-Message-State: AOJu0YzAtBAVEUn4wjthRVgXPCNR+Pxg7rJutTMcRaW7692LWp1N7OfE
	Kg9pP6kUBvoIuH0r0lzIqtk=
X-Google-Smtp-Source: AGHT+IEHljYLnC89JKm6iOfPV87ciAsr2h6+vZ7wTinfr7t5Iz4HcfpApQZRogtGDAiTONOmMQz7mg==
X-Received: by 2002:a17:902:ce8d:b0:1c8:9a60:387f with SMTP id f13-20020a170902ce8d00b001c89a60387fmr5835248plg.56.1697631956015;
        Wed, 18 Oct 2023 05:25:56 -0700 (PDT)
Received: from wedsonaf-dev.. ([2804:389:7122:43b8:9b73:6339:3351:cce0])
        by smtp.googlemail.com with ESMTPSA id j1-20020a170902c3c100b001c736b0037fsm3411046plj.231.2023.10.18.05.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:25:55 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH 04/19] rust: fs: introduce `FileSystem::super_params`
Date: Wed, 18 Oct 2023 09:25:03 -0300
Message-Id: <20231018122518.128049-5-wedsonaf@gmail.com>
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

Allow Rust file systems to initialise superblocks, which allows them
to be mounted (though they are still empty).

Some scaffolding code is added to create an empty directory as the root.
It is replaced by proper inode creation in a subsequent patch in this
series.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/bindings/bindings_helper.h |   5 +
 rust/bindings/lib.rs            |   4 +
 rust/kernel/fs.rs               | 176 ++++++++++++++++++++++++++++++--
 samples/rust/rust_rofs.rs       |  10 ++
 4 files changed, 189 insertions(+), 6 deletions(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 9c23037b33d0..ca1898ce9527 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -9,6 +9,7 @@
 #include <kunit/test.h>
 #include <linux/errname.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
 #include <linux/wait.h>
@@ -22,3 +23,7 @@ const gfp_t BINDINGS___GFP_ZERO = __GFP_ZERO;
 const slab_flags_t BINDINGS_SLAB_RECLAIM_ACCOUNT = SLAB_RECLAIM_ACCOUNT;
 const slab_flags_t BINDINGS_SLAB_MEM_SPREAD = SLAB_MEM_SPREAD;
 const slab_flags_t BINDINGS_SLAB_ACCOUNT = SLAB_ACCOUNT;
+
+const unsigned long BINDINGS_SB_RDONLY = SB_RDONLY;
+
+const loff_t BINDINGS_MAX_LFS_FILESIZE = MAX_LFS_FILESIZE;
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 6a8c6cd17e45..426915d3fb57 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -55,3 +55,7 @@ mod bindings_helper {
 pub const SLAB_RECLAIM_ACCOUNT: slab_flags_t = BINDINGS_SLAB_RECLAIM_ACCOUNT;
 pub const SLAB_MEM_SPREAD: slab_flags_t = BINDINGS_SLAB_MEM_SPREAD;
 pub const SLAB_ACCOUNT: slab_flags_t = BINDINGS_SLAB_ACCOUNT;
+
+pub const SB_RDONLY: core::ffi::c_ulong = BINDINGS_SB_RDONLY;
+
+pub const MAX_LFS_FILESIZE: loff_t = BINDINGS_MAX_LFS_FILESIZE;
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 1df54c234101..31cf643aaded 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -6,16 +6,22 @@
 //!
 //! C headers: [`include/linux/fs.h`](../../include/linux/fs.h)
 
-use crate::error::{code::*, from_result, to_result, Error};
+use crate::error::{code::*, from_result, to_result, Error, Result};
 use crate::types::Opaque;
 use crate::{bindings, init::PinInit, str::CStr, try_pin_init, ThisModule};
 use core::{marker::PhantomData, marker::PhantomPinned, pin::Pin};
 use macros::{pin_data, pinned_drop};
 
+/// Maximum size of an inode.
+pub const MAX_LFS_FILESIZE: i64 = bindings::MAX_LFS_FILESIZE;
+
 /// A file system type.
 pub trait FileSystem {
     /// The name of the file system type.
     const NAME: &'static CStr;
+
+    /// Returns the parameters to initialise a super block.
+    fn super_params(sb: &NewSuperBlock<Self>) -> Result<SuperParams>;
 }
 
 /// A registration of a file system.
@@ -49,7 +55,7 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> impl PinInit<
                 let fs = unsafe { &mut *fs_ptr };
                 fs.owner = module.0;
                 fs.name = T::NAME.as_char_ptr();
-                fs.init_fs_context = Some(Self::init_fs_context_callback);
+                fs.init_fs_context = Some(Self::init_fs_context_callback::<T>);
                 fs.kill_sb = Some(Self::kill_sb_callback);
                 fs.fs_flags = 0;
 
@@ -60,13 +66,22 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> impl PinInit<
         })
     }
 
-    unsafe extern "C" fn init_fs_context_callback(
-        _fc_ptr: *mut bindings::fs_context,
+    unsafe extern "C" fn init_fs_context_callback<T: FileSystem + ?Sized>(
+        fc_ptr: *mut bindings::fs_context,
     ) -> core::ffi::c_int {
-        from_result(|| Err(ENOTSUPP))
+        from_result(|| {
+            // SAFETY: The C callback API guarantees that `fc_ptr` is valid.
+            let fc = unsafe { &mut *fc_ptr };
+            fc.ops = &Tables::<T>::CONTEXT;
+            Ok(0)
+        })
     }
 
-    unsafe extern "C" fn kill_sb_callback(_sb_ptr: *mut bindings::super_block) {}
+    unsafe extern "C" fn kill_sb_callback(sb_ptr: *mut bindings::super_block) {
+        // SAFETY: In `get_tree_callback` we always call `get_tree_nodev`, so `kill_anon_super` is
+        // the appropriate function to call for cleanup.
+        unsafe { bindings::kill_anon_super(sb_ptr) };
+    }
 }
 
 #[pinned_drop]
@@ -79,6 +94,151 @@ fn drop(self: Pin<&mut Self>) {
     }
 }
 
+/// A file system super block.
+///
+/// Wraps the kernel's `struct super_block`.
+#[repr(transparent)]
+pub struct SuperBlock<T: FileSystem + ?Sized>(Opaque<bindings::super_block>, PhantomData<T>);
+
+/// Required superblock parameters.
+///
+/// This is returned by implementations of [`FileSystem::super_params`].
+pub struct SuperParams {
+    /// The magic number of the superblock.
+    pub magic: u32,
+
+    /// The size of a block in powers of 2 (i.e., for a value of `n`, the size is `2^n`).
+    pub blocksize_bits: u8,
+
+    /// Maximum size of a file.
+    ///
+    /// The maximum allowed value is [`MAX_LFS_FILESIZE`].
+    pub maxbytes: i64,
+
+    /// Granularity of c/m/atime in ns (cannot be worse than a second).
+    pub time_gran: u32,
+}
+
+/// A superblock that is still being initialised.
+///
+/// # Invariants
+///
+/// The superblock is a newly-created one and this is the only active pointer to it.
+#[repr(transparent)]
+pub struct NewSuperBlock<T: FileSystem + ?Sized>(bindings::super_block, PhantomData<T>);
+
+struct Tables<T: FileSystem + ?Sized>(T);
+impl<T: FileSystem + ?Sized> Tables<T> {
+    const CONTEXT: bindings::fs_context_operations = bindings::fs_context_operations {
+        free: None,
+        parse_param: None,
+        get_tree: Some(Self::get_tree_callback),
+        reconfigure: None,
+        parse_monolithic: None,
+        dup: None,
+    };
+
+    unsafe extern "C" fn get_tree_callback(fc: *mut bindings::fs_context) -> core::ffi::c_int {
+        // SAFETY: `fc` is valid per the callback contract. `fill_super_callback` also has
+        // the right type and is a valid callback.
+        unsafe { bindings::get_tree_nodev(fc, Some(Self::fill_super_callback)) }
+    }
+
+    unsafe extern "C" fn fill_super_callback(
+        sb_ptr: *mut bindings::super_block,
+        _fc: *mut bindings::fs_context,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The callback contract guarantees that `sb_ptr` is a unique pointer to a
+            // newly-created superblock.
+            let sb = unsafe { &mut *sb_ptr.cast() };
+            let params = T::super_params(sb)?;
+
+            sb.0.s_magic = params.magic as _;
+            sb.0.s_op = &Tables::<T>::SUPER_BLOCK;
+            sb.0.s_maxbytes = params.maxbytes;
+            sb.0.s_time_gran = params.time_gran;
+            sb.0.s_blocksize_bits = params.blocksize_bits;
+            sb.0.s_blocksize = 1;
+            if sb.0.s_blocksize.leading_zeros() < params.blocksize_bits.into() {
+                return Err(EINVAL);
+            }
+            sb.0.s_blocksize = 1 << sb.0.s_blocksize_bits;
+            sb.0.s_flags |= bindings::SB_RDONLY;
+
+            // The following is scaffolding code that will be removed in a subsequent patch. It is
+            // needed to build a root dentry, otherwise core code will BUG().
+            // SAFETY: `sb` is the superblock being initialised, it is valid for read and write.
+            let inode = unsafe { bindings::new_inode(&mut sb.0) };
+            if inode.is_null() {
+                return Err(ENOMEM);
+            }
+
+            // SAFETY: `inode` is valid for write.
+            unsafe { bindings::set_nlink(inode, 2) };
+
+            {
+                // SAFETY: This is a newly-created inode. No other references to it exist, so it is
+                // safe to mutably dereference it.
+                let inode = unsafe { &mut *inode };
+                inode.i_ino = 1;
+                inode.i_mode = (bindings::S_IFDIR | 0o755) as _;
+
+                // SAFETY: `simple_dir_operations` never changes, it's safe to reference it.
+                inode.__bindgen_anon_3.i_fop = unsafe { &bindings::simple_dir_operations };
+
+                // SAFETY: `simple_dir_inode_operations` never changes, it's safe to reference it.
+                inode.i_op = unsafe { &bindings::simple_dir_inode_operations };
+            }
+
+            // SAFETY: `d_make_root` requires that `inode` be valid and referenced, which is the
+            // case for this call.
+            //
+            // It takes over the inode, even on failure, so we don't need to clean it up.
+            let dentry = unsafe { bindings::d_make_root(inode) };
+            if dentry.is_null() {
+                return Err(ENOMEM);
+            }
+
+            sb.0.s_root = dentry;
+
+            Ok(0)
+        })
+    }
+
+    const SUPER_BLOCK: bindings::super_operations = bindings::super_operations {
+        alloc_inode: None,
+        destroy_inode: None,
+        free_inode: None,
+        dirty_inode: None,
+        write_inode: None,
+        drop_inode: None,
+        evict_inode: None,
+        put_super: None,
+        sync_fs: None,
+        freeze_super: None,
+        freeze_fs: None,
+        thaw_super: None,
+        unfreeze_fs: None,
+        statfs: None,
+        remount_fs: None,
+        umount_begin: None,
+        show_options: None,
+        show_devname: None,
+        show_path: None,
+        show_stats: None,
+        #[cfg(CONFIG_QUOTA)]
+        quota_read: None,
+        #[cfg(CONFIG_QUOTA)]
+        quota_write: None,
+        #[cfg(CONFIG_QUOTA)]
+        get_dquots: None,
+        nr_cached_objects: None,
+        free_cached_objects: None,
+        shutdown: None,
+    };
+}
+
 /// Kernel module that exposes a single file system implemented by `T`.
 #[pin_data]
 pub struct Module<T: FileSystem + ?Sized> {
@@ -105,6 +265,7 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
 ///
 /// ```
 /// # mod module_fs_sample {
+/// use kernel::fs::{NewSuperBlock, SuperParams};
 /// use kernel::prelude::*;
 /// use kernel::{c_str, fs};
 ///
@@ -119,6 +280,9 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
 /// struct MyFs;
 /// impl fs::FileSystem for MyFs {
 ///     const NAME: &'static CStr = c_str!("myfs");
+///     fn super_params(_: &NewSuperBlock<Self>) -> Result<SuperParams> {
+///         todo!()
+///     }
 /// }
 /// # }
 /// ```
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
index 1c00b1da8b94..9878bf88b991 100644
--- a/samples/rust/rust_rofs.rs
+++ b/samples/rust/rust_rofs.rs
@@ -2,6 +2,7 @@
 
 //! Rust read-only file system sample.
 
+use kernel::fs::{NewSuperBlock, SuperParams};
 use kernel::prelude::*;
 use kernel::{c_str, fs};
 
@@ -16,4 +17,13 @@
 struct RoFs;
 impl fs::FileSystem for RoFs {
     const NAME: &'static CStr = c_str!("rust-fs");
+
+    fn super_params(_sb: &NewSuperBlock<Self>) -> Result<SuperParams> {
+        Ok(SuperParams {
+            magic: 0x52555354,
+            blocksize_bits: 12,
+            maxbytes: fs::MAX_LFS_FILESIZE,
+            time_gran: 1,
+        })
+    }
 }
-- 
2.34.1


