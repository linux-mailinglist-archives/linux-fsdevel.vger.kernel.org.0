Return-Path: <linux-fsdevel+bounces-644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942187CDB93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49095280BE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A813358B8;
	Wed, 18 Oct 2023 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hd40ALlE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958A93589F;
	Wed, 18 Oct 2023 12:26:52 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB2B98;
	Wed, 18 Oct 2023 05:26:49 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c871a095ceso47718905ad.2;
        Wed, 18 Oct 2023 05:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697632009; x=1698236809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIRlHb8w4YCxwuLbKyafSjcNKaAgvRUfsH7H7yMCuts=;
        b=Hd40ALlE+fkuSTcVe1HhwBw0TycVh8HQlNgCibOi3pGMaEK0E3iBuRg9wb133kSMDb
         VAZCUioHNthTk+a1bhRTQ4tx9VrAkw8plhbDFXUGRHgUTB+izhavu6BqD7M40nUfM4ld
         plJLmQ8LOCsp7Jl7cMtcB5hd5nuey/55pkHIFl6hKfnZMS6uZxtsB0Roy9KigVkpzHjH
         W/PDNKxgArsUygkDuNYxxNNx6fVkXSnQdn1fIFmGl2w2q/BdNhdIbYObXIxbJlgZoFAT
         1ikSBiYBPLUwLaRtNJnU1q1+Tf2dLVwJFWN1IUMB5DNDC9J/roWNFW1kImZGif5ti0Jg
         TxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632009; x=1698236809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIRlHb8w4YCxwuLbKyafSjcNKaAgvRUfsH7H7yMCuts=;
        b=FTj6qepLoIfEtPW06y7jPCKiKPzdj51MUXierpAXGOJ7cy3xNsLVBXPxtt+WtayTrx
         kfLpEuq4xakDZsOxb6XafLFzGSsQGjpb/QQjrKakv+D/4FGTar9TWgrJAt1z+3VNkLxM
         wRerwDnGckJYk7dcISdr3Vk/6ZNQHM/UHnkUv5M+AA+V6QqFQTEP5kans09yq+EwftrV
         J26a7NmzRnAKUkNtKiT1y4qefmxYsbFFMvz3s+oSnrZJAdX9salZvXEG9Y/LjNnTCzOq
         krgNnlDMWabXhiix3Pgc7xs6xPmaP4aM6q5G8WCZLYdzQjV34Z7HtnObx+fc1RXFOtn/
         A4Ag==
X-Gm-Message-State: AOJu0YyMEb/wAMx8qOdlVk42XqJ9IxOblYgr+u2TF4nkkHIx98n8iygx
	3naESk+hJugohIyBYE6QA9Y=
X-Google-Smtp-Source: AGHT+IGUody+YcT2caZetiZtfnANTx3tDKRbbIbPF9yfafpVCA5C6Pu45Xc+9xKQiXkRCkPDC648+g==
X-Received: by 2002:a17:903:2308:b0:1c6:21b4:30bb with SMTP id d8-20020a170903230800b001c621b430bbmr5868140plh.15.1697632009145;
        Wed, 18 Oct 2023 05:26:49 -0700 (PDT)
Received: from wedsonaf-dev.. ([2804:389:7122:43b8:9b73:6339:3351:cce0])
        by smtp.googlemail.com with ESMTPSA id j1-20020a170902c3c100b001c736b0037fsm3411046plj.231.2023.10.18.05.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:26:48 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH 16/19] rust: fs: allow file systems backed by a block device
Date: Wed, 18 Oct 2023 09:25:15 -0300
Message-Id: <20231018122518.128049-17-wedsonaf@gmail.com>
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

Allow Rust file systems that are backed by block devices (in addition to
in-memory ones).

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |  14 +++
 rust/kernel/fs.rs               | 177 +++++++++++++++++++++++++++++---
 rust/kernel/fs/buffer.rs        |   1 -
 4 files changed, 180 insertions(+), 13 deletions(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index d328375f7cb7..8403f13d4d48 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <linux/bio.h>
 #include <linux/buffer_head.h>
 #include <linux/errname.h>
 #include <linux/fs.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index a5393c6b93f2..bc19f3b7b93e 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -21,6 +21,7 @@
  */
 
 #include <kunit/test-bug.h>
+#include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/bug.h>
 #include <linux/build_bug.h>
@@ -252,6 +253,13 @@ unsigned int rust_helper_MKDEV(unsigned int major, unsigned int minor)
 EXPORT_SYMBOL_GPL(rust_helper_MKDEV);
 
 #ifdef CONFIG_BUFFER_HEAD
+struct buffer_head *rust_helper_sb_bread(struct super_block *sb,
+		sector_t block)
+{
+	return sb_bread(sb, block);
+}
+EXPORT_SYMBOL_GPL(rust_helper_sb_bread);
+
 void rust_helper_get_bh(struct buffer_head *bh)
 {
 	get_bh(bh);
@@ -265,6 +273,12 @@ void rust_helper_put_bh(struct buffer_head *bh)
 EXPORT_SYMBOL_GPL(rust_helper_put_bh);
 #endif
 
+sector_t rust_helper_bdev_nr_sectors(struct block_device *bdev)
+{
+	return bdev_nr_sectors(bdev);
+}
+EXPORT_SYMBOL_GPL(rust_helper_bdev_nr_sectors);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 4f04cb1d3c6f..b1ad5c110dbb 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -7,11 +7,9 @@
 //! C headers: [`include/linux/fs.h`](../../include/linux/fs.h)
 
 use crate::error::{code::*, from_result, to_result, Error, Result};
-use crate::types::{ARef, AlwaysRefCounted, Either, ForeignOwnable, Opaque};
-use crate::{
-    bindings, folio::LockedFolio, init::PinInit, str::CStr, time::Timespec, try_pin_init,
-    ThisModule,
-};
+use crate::folio::{LockedFolio, UniqueFolio};
+use crate::types::{ARef, AlwaysRefCounted, Either, ForeignOwnable, Opaque, ScopeGuard};
+use crate::{bindings, init::PinInit, str::CStr, time::Timespec, try_pin_init, ThisModule};
 use core::{marker::PhantomData, marker::PhantomPinned, mem::ManuallyDrop, pin::Pin, ptr};
 use macros::{pin_data, pinned_drop};
 
@@ -21,6 +19,17 @@
 /// Maximum size of an inode.
 pub const MAX_LFS_FILESIZE: i64 = bindings::MAX_LFS_FILESIZE;
 
+/// Type of superblock keying.
+///
+/// It determines how C's `fs_context_operations::get_tree` is implemented.
+pub enum Super {
+    /// Multiple independent superblocks may exist.
+    Independent,
+
+    /// Uses a block device.
+    BlockDev,
+}
+
 /// A file system type.
 pub trait FileSystem {
     /// Data associated with each file system instance (super-block).
@@ -29,6 +38,9 @@ pub trait FileSystem {
     /// The name of the file system type.
     const NAME: &'static CStr;
 
+    /// Determines how superblocks for this file system type are keyed.
+    const SUPER_TYPE: Super = Super::Independent;
+
     /// Returns the parameters to initialise a super block.
     fn super_params(sb: &NewSuperBlock<Self>) -> Result<SuperParams<Self::Data>>;
 
@@ -181,7 +193,9 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> impl PinInit<
                 fs.name = T::NAME.as_char_ptr();
                 fs.init_fs_context = Some(Self::init_fs_context_callback::<T>);
                 fs.kill_sb = Some(Self::kill_sb_callback::<T>);
-                fs.fs_flags = 0;
+                fs.fs_flags = if let Super::BlockDev = T::SUPER_TYPE {
+                    bindings::FS_REQUIRES_DEV as i32
+                } else { 0 };
 
                 // SAFETY: Pointers stored in `fs` are static so will live for as long as the
                 // registration is active (it is undone in `drop`).
@@ -204,9 +218,16 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> impl PinInit<
     unsafe extern "C" fn kill_sb_callback<T: FileSystem + ?Sized>(
         sb_ptr: *mut bindings::super_block,
     ) {
-        // SAFETY: In `get_tree_callback` we always call `get_tree_nodev`, so `kill_anon_super` is
-        // the appropriate function to call for cleanup.
-        unsafe { bindings::kill_anon_super(sb_ptr) };
+        match T::SUPER_TYPE {
+            // SAFETY: In `get_tree_callback` we always call `get_tree_bdev` for
+            // `Super::BlockDev`, so `kill_block_super` is the appropriate function to call
+            // for cleanup.
+            Super::BlockDev => unsafe { bindings::kill_block_super(sb_ptr) },
+            // SAFETY: In `get_tree_callback` we always call `get_tree_nodev` for
+            // `Super::Independent`, so `kill_anon_super` is the appropriate function to call
+            // for cleanup.
+            Super::Independent => unsafe { bindings::kill_anon_super(sb_ptr) },
+        }
 
         // SAFETY: The C API contract guarantees that `sb_ptr` is valid for read.
         let ptr = unsafe { (*sb_ptr).s_fs_info };
@@ -479,6 +500,65 @@ pub fn get_or_create_inode(&self, ino: Ino) -> Result<Either<ARef<INode<T>>, New
             })))
         }
     }
+
+    /// Reads a block from the block device.
+    #[cfg(CONFIG_BUFFER_HEAD)]
+    pub fn bread(&self, block: u64) -> Result<ARef<buffer::Head>> {
+        // Fail requests for non-blockdev file systems. This is a compile-time check.
+        match T::SUPER_TYPE {
+            Super::BlockDev => {}
+            _ => return Err(EIO),
+        }
+
+        // SAFETY: This function is only valid after the `NeedsInit` typestate, so the block size
+        // is known and the superblock can be used to read blocks.
+        let ptr =
+            ptr::NonNull::new(unsafe { bindings::sb_bread(self.0.get(), block) }).ok_or(EIO)?;
+        // SAFETY: `sb_bread` returns a referenced buffer head. Ownership of the increment is
+        // passed to the `ARef` instance.
+        Ok(unsafe { ARef::from_raw(ptr.cast()) })
+    }
+
+    /// Reads `size` bytes starting from `offset` bytes.
+    ///
+    /// Returns an iterator that returns slices based on blocks.
+    #[cfg(CONFIG_BUFFER_HEAD)]
+    pub fn read(
+        &self,
+        offset: u64,
+        size: u64,
+    ) -> Result<impl Iterator<Item = Result<buffer::View>> + '_> {
+        struct BlockIter<'a, T: FileSystem + ?Sized> {
+            sb: &'a SuperBlock<T>,
+            next_offset: u64,
+            end: u64,
+        }
+        impl<'a, T: FileSystem + ?Sized> Iterator for BlockIter<'a, T> {
+            type Item = Result<buffer::View>;
+
+            fn next(&mut self) -> Option<Self::Item> {
+                if self.next_offset >= self.end {
+                    return None;
+                }
+
+                // SAFETY: The superblock is valid and has had its block size initialised.
+                let block_size = unsafe { (*self.sb.0.get()).s_blocksize };
+                let bh = match self.sb.bread(self.next_offset / block_size) {
+                    Ok(bh) => bh,
+                    Err(e) => return Some(Err(e)),
+                };
+                let boffset = self.next_offset & (block_size - 1);
+                let bsize = core::cmp::min(self.end - self.next_offset, block_size - boffset);
+                self.next_offset += bsize;
+                Some(Ok(buffer::View::new(bh, boffset as usize, bsize as usize)))
+            }
+        }
+        Ok(BlockIter {
+            sb: self,
+            next_offset: offset,
+            end: offset.checked_add(size).ok_or(ERANGE)?,
+        })
+    }
 }
 
 /// Required superblock parameters.
@@ -511,6 +591,70 @@ pub struct SuperParams<T: ForeignOwnable + Send + Sync> {
 #[repr(transparent)]
 pub struct NewSuperBlock<T: FileSystem + ?Sized>(bindings::super_block, PhantomData<T>);
 
+impl<T: FileSystem + ?Sized> NewSuperBlock<T> {
+    /// Reads sectors.
+    ///
+    /// `count` must be such that the total size doesn't exceed a page.
+    pub fn sread(&self, sector: u64, count: usize, folio: &mut UniqueFolio) -> Result {
+        // Fail requests for non-blockdev file systems. This is a compile-time check.
+        match T::SUPER_TYPE {
+            // The superblock is valid and given that it's a blockdev superblock it must have a
+            // valid `s_bdev`.
+            Super::BlockDev => {}
+            _ => return Err(EIO),
+        }
+
+        crate::build_assert!(count * (bindings::SECTOR_SIZE as usize) <= bindings::PAGE_SIZE);
+
+        // Read the sectors.
+        let mut bio = bindings::bio::default();
+        let bvec = Opaque::<bindings::bio_vec>::uninit();
+
+        // SAFETY: `bio` and `bvec` are allocated on the stack, they're both valid.
+        unsafe {
+            bindings::bio_init(
+                &mut bio,
+                self.0.s_bdev,
+                bvec.get(),
+                1,
+                bindings::req_op_REQ_OP_READ,
+            )
+        };
+
+        // SAFETY: `bio` was just initialised with `bio_init` above, so it's safe to call
+        // `bio_uninit` on the way out.
+        let mut bio =
+            ScopeGuard::new_with_data(bio, |mut b| unsafe { bindings::bio_uninit(&mut b) });
+
+        // SAFETY: We have one free `bvec` (initialsied above). We also know that size won't exceed
+        // a page size (build_assert above).
+        unsafe {
+            bindings::bio_add_folio_nofail(
+                &mut *bio,
+                folio.0 .0.get(),
+                count * (bindings::SECTOR_SIZE as usize),
+                0,
+            )
+        };
+        bio.bi_iter.bi_sector = sector;
+
+        // SAFETY: The bio was fully initialised above.
+        to_result(unsafe { bindings::submit_bio_wait(&mut *bio) })?;
+        Ok(())
+    }
+
+    /// Returns the number of sectors in the underlying block device.
+    pub fn sector_count(&self) -> Result<u64> {
+        // Fail requests for non-blockdev file systems. This is a compile-time check.
+        match T::SUPER_TYPE {
+            // The superblock is valid and given that it's a blockdev superblock it must have a
+            // valid `s_bdev`.
+            Super::BlockDev => Ok(unsafe { bindings::bdev_nr_sectors(self.0.s_bdev) }),
+            _ => Err(EIO),
+        }
+    }
+}
+
 struct Tables<T: FileSystem + ?Sized>(T);
 impl<T: FileSystem + ?Sized> Tables<T> {
     const CONTEXT: bindings::fs_context_operations = bindings::fs_context_operations {
@@ -523,9 +667,18 @@ impl<T: FileSystem + ?Sized> Tables<T> {
     };
 
     unsafe extern "C" fn get_tree_callback(fc: *mut bindings::fs_context) -> core::ffi::c_int {
-        // SAFETY: `fc` is valid per the callback contract. `fill_super_callback` also has
-        // the right type and is a valid callback.
-        unsafe { bindings::get_tree_nodev(fc, Some(Self::fill_super_callback)) }
+        match T::SUPER_TYPE {
+            // SAFETY: `fc` is valid per the callback contract. `fill_super_callback` also has
+            // the right type and is a valid callback.
+            Super::BlockDev => unsafe {
+                bindings::get_tree_bdev(fc, Some(Self::fill_super_callback))
+            },
+            // SAFETY: `fc` is valid per the callback contract. `fill_super_callback` also has
+            // the right type and is a valid callback.
+            Super::Independent => unsafe {
+                bindings::get_tree_nodev(fc, Some(Self::fill_super_callback))
+            },
+        }
     }
 
     unsafe extern "C" fn fill_super_callback(
diff --git a/rust/kernel/fs/buffer.rs b/rust/kernel/fs/buffer.rs
index 6052af8822b3..de23d0fee66c 100644
--- a/rust/kernel/fs/buffer.rs
+++ b/rust/kernel/fs/buffer.rs
@@ -49,7 +49,6 @@ pub struct View {
 }
 
 impl View {
-    #[allow(dead_code)]
     pub(crate) fn new(head: ARef<Head>, offset: usize, size: usize) -> Self {
         Self { head, size, offset }
     }
-- 
2.34.1


