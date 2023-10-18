Return-Path: <linux-fsdevel+bounces-635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC287CDB89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C871C20921
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3256935892;
	Wed, 18 Oct 2023 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLaC7rG6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BBF34CD8;
	Wed, 18 Oct 2023 12:26:12 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123F510F;
	Wed, 18 Oct 2023 05:26:10 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c888b3a25aso44296675ad.0;
        Wed, 18 Oct 2023 05:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697631969; x=1698236769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQfRqske9UjvRdn/X8+SlAcIjXiT81OZyHev4WJ/7us=;
        b=dLaC7rG6TTHfHnd6udtfR5th5XipTyXlzw2n8ZNlWd3eYK3VKNUKTD+ISb5tsD8n8f
         +XVsUxUAeq6xOtH6GbF9k/rpdJRO3PCuecwxt9ggwpj2DDKJUqYCAvo4K0/x7n3KmPUy
         SX6honsWKkg2ad4su/hAYGOF+9SvGXcQJbCo2fFHCiyxDpYDM2bQiHSjStgtBf7fulV5
         1B095Rs7RfjBKtCIm9+IWlY5L4LHdW0uEzxrQc1Iqw7gDr3oJs8OOfeFP8K+o4l7iqar
         WoZfSm7fWhJvJGKsq0JpWgOSNo6aBEBTj0ChhkiTbyLM7UD5DNVzlKGJNkLI6DT02yQS
         k9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697631969; x=1698236769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQfRqske9UjvRdn/X8+SlAcIjXiT81OZyHev4WJ/7us=;
        b=APTFudB18PLkNcZjexq4QXaxS7Yug0rMpTGV3rz08VjpqEF07TqDLv44QpwodOulO1
         B/MZTvSqDy2BfeCANoav5UVzpm8HjpW69Trdavxf4fDUpDIo3JnOykGbiGrnbyKNm1Yq
         3OFIDbNIWYfUzurUWsXV2C96YeGbdyZiNKzePVLexr9uMW+0j5ZkzCsAxkfBUWjhiYkQ
         B/kt8k5F09YIObEtuo4wS4Oe+gZRvHlQtdOWDUyXt7Vzk6wSTadfpBP8U8llMT21G1GN
         ppX5MDl5IG9YDsTNsyqnN7dQT/gcVCGKZ8B3FPQqPm/7xvlqjtuHGGB4keQdifV4TEF6
         qkOQ==
X-Gm-Message-State: AOJu0Yxot2nRiHpp9o7FDGgvX4ZBB7E5bYtQen36d0oUMBbQjDiFWgRm
	SlH6V9Y7ga1hlAXlXcQ5btw=
X-Google-Smtp-Source: AGHT+IEBF0C1PT+8JLZU2VMZ95DnDX+wvC93KMcFKddQHcTyEjYu+C3a5E7D/7nlpt9Re1KMDj+Sow==
X-Received: by 2002:a17:902:c412:b0:1c3:1f0c:fb82 with SMTP id k18-20020a170902c41200b001c31f0cfb82mr5566145plk.41.1697631969398;
        Wed, 18 Oct 2023 05:26:09 -0700 (PDT)
Received: from wedsonaf-dev.. ([2804:389:7122:43b8:9b73:6339:3351:cce0])
        by smtp.googlemail.com with ESMTPSA id j1-20020a170902c3c100b001c736b0037fsm3411046plj.231.2023.10.18.05.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:26:09 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH 07/19] rust: fs: introduce `FileSystem::read_dir`
Date: Wed, 18 Oct 2023 09:25:06 -0300
Message-Id: <20231018122518.128049-8-wedsonaf@gmail.com>
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

Allow Rust file systems to report the contents of their directory
inodes. The reported entries cannot be opened yet.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/fs.rs         | 193 +++++++++++++++++++++++++++++++++++++-
 samples/rust/rust_rofs.rs |  49 +++++++++-
 2 files changed, 236 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index f3a41cf57502..89611c44e4c5 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -28,6 +28,70 @@ pub trait FileSystem {
     /// This is called during initialisation of a superblock after [`FileSystem::super_params`] has
     /// completed successfully.
     fn init_root(sb: &SuperBlock<Self>) -> Result<ARef<INode<Self>>>;
+
+    /// Reads directory entries from directory inodes.
+    ///
+    /// [`DirEmitter::pos`] holds the current position of the directory reader.
+    fn read_dir(inode: &INode<Self>, emitter: &mut DirEmitter) -> Result;
+}
+
+/// The types of directory entries reported by [`FileSystem::read_dir`].
+#[repr(u32)]
+#[derive(Copy, Clone)]
+pub enum DirEntryType {
+    /// Unknown type.
+    Unknown = bindings::DT_UNKNOWN,
+
+    /// Named pipe (first-in, first-out) type.
+    Fifo = bindings::DT_FIFO,
+
+    /// Character device type.
+    Chr = bindings::DT_CHR,
+
+    /// Directory type.
+    Dir = bindings::DT_DIR,
+
+    /// Block device type.
+    Blk = bindings::DT_BLK,
+
+    /// Regular file type.
+    Reg = bindings::DT_REG,
+
+    /// Symbolic link type.
+    Lnk = bindings::DT_LNK,
+
+    /// Named unix-domain socket type.
+    Sock = bindings::DT_SOCK,
+
+    /// White-out type.
+    Wht = bindings::DT_WHT,
+}
+
+impl From<INodeType> for DirEntryType {
+    fn from(value: INodeType) -> Self {
+        match value {
+            INodeType::Dir => DirEntryType::Dir,
+        }
+    }
+}
+
+impl core::convert::TryFrom<u32> for DirEntryType {
+    type Error = crate::error::Error;
+
+    fn try_from(v: u32) -> Result<Self> {
+        match v {
+            v if v == Self::Unknown as u32 => Ok(Self::Unknown),
+            v if v == Self::Fifo as u32 => Ok(Self::Fifo),
+            v if v == Self::Chr as u32 => Ok(Self::Chr),
+            v if v == Self::Dir as u32 => Ok(Self::Dir),
+            v if v == Self::Blk as u32 => Ok(Self::Blk),
+            v if v == Self::Reg as u32 => Ok(Self::Reg),
+            v if v == Self::Lnk as u32 => Ok(Self::Lnk),
+            v if v == Self::Sock as u32 => Ok(Self::Sock),
+            v if v == Self::Wht as u32 => Ok(Self::Wht),
+            _ => Err(EDOM),
+        }
+    }
 }
 
 /// A registration of a file system.
@@ -161,9 +225,7 @@ pub fn init(self, params: INodeParams) -> Result<ARef<INode<T>>> {
 
         let mode = match params.typ {
             INodeType::Dir => {
-                // SAFETY: `simple_dir_operations` never changes, it's safe to reference it.
-                inode.__bindgen_anon_3.i_fop = unsafe { &bindings::simple_dir_operations };
-
+                inode.__bindgen_anon_3.i_fop = &Tables::<T>::DIR_FILE_OPERATIONS;
                 // SAFETY: `simple_dir_inode_operations` never changes, it's safe to reference it.
                 inode.i_op = unsafe { &bindings::simple_dir_inode_operations };
                 bindings::S_IFDIR
@@ -403,6 +465,126 @@ impl<T: FileSystem + ?Sized> Tables<T> {
         free_cached_objects: None,
         shutdown: None,
     };
+
+    const DIR_FILE_OPERATIONS: bindings::file_operations = bindings::file_operations {
+        owner: ptr::null_mut(),
+        llseek: Some(bindings::generic_file_llseek),
+        read: Some(bindings::generic_read_dir),
+        write: None,
+        read_iter: None,
+        write_iter: None,
+        iopoll: None,
+        iterate_shared: Some(Self::read_dir_callback),
+        poll: None,
+        unlocked_ioctl: None,
+        compat_ioctl: None,
+        mmap: None,
+        mmap_supported_flags: 0,
+        open: None,
+        flush: None,
+        release: None,
+        fsync: None,
+        fasync: None,
+        lock: None,
+        get_unmapped_area: None,
+        check_flags: None,
+        flock: None,
+        splice_write: None,
+        splice_read: None,
+        splice_eof: None,
+        setlease: None,
+        fallocate: None,
+        show_fdinfo: None,
+        copy_file_range: None,
+        remap_file_range: None,
+        fadvise: None,
+        uring_cmd: None,
+        uring_cmd_iopoll: None,
+    };
+
+    unsafe extern "C" fn read_dir_callback(
+        file: *mut bindings::file,
+        ctx_ptr: *mut bindings::dir_context,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The C API guarantees that `file` is valid for read. And since `f_inode` is
+            // immutable, we can read it directly.
+            let inode = unsafe { &*(*file).f_inode.cast::<INode<T>>() };
+
+            // SAFETY: The C API guarantees that this is the only reference to the `dir_context`
+            // instance.
+            let emitter = unsafe { &mut *ctx_ptr.cast::<DirEmitter>() };
+            let orig_pos = emitter.pos();
+
+            // Call the module implementation. We ignore errors if directory entries have been
+            // succesfully emitted: this is because we want users to see them before the error.
+            match T::read_dir(inode, emitter) {
+                Ok(_) => Ok(0),
+                Err(e) => {
+                    if emitter.pos() == orig_pos {
+                        Err(e)
+                    } else {
+                        Ok(0)
+                    }
+                }
+            }
+        })
+    }
+}
+
+/// Directory entry emitter.
+///
+/// This is used in [`FileSystem::read_dir`] implementations to report the directory entry.
+#[repr(transparent)]
+pub struct DirEmitter(bindings::dir_context);
+
+impl DirEmitter {
+    /// Returns the current position of the emitter.
+    pub fn pos(&self) -> i64 {
+        self.0.pos
+    }
+
+    /// Emits a directory entry.
+    ///
+    /// `pos_inc` is the number with which to increment the current position on success.
+    ///
+    /// `name` is the name of the entry.
+    ///
+    /// `ino` is the inode number of the entry.
+    ///
+    /// `etype` is the type of the entry.
+    ///
+    /// Returns `false` when the entry could not be emitted, possibly because the user-provided
+    /// buffer is full.
+    pub fn emit(&mut self, pos_inc: i64, name: &[u8], ino: Ino, etype: DirEntryType) -> bool {
+        let Ok(name_len) = i32::try_from(name.len()) else {
+            return false;
+        };
+
+        let Some(actor) = self.0.actor else {
+            return false;
+        };
+
+        let Some(new_pos) = self.0.pos.checked_add(pos_inc) else {
+            return false;
+        };
+
+        // SAFETY: `name` is valid at least for the duration of the `actor` call.
+        let ret = unsafe {
+            actor(
+                &mut self.0,
+                name.as_ptr().cast(),
+                name_len,
+                self.0.pos,
+                ino,
+                etype as _,
+            )
+        };
+        if ret {
+            self.0.pos = new_pos;
+        }
+        ret
+    }
 }
 
 /// Kernel module that exposes a single file system implemented by `T`.
@@ -431,7 +613,7 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
 ///
 /// ```
 /// # mod module_fs_sample {
-/// use kernel::fs::{INode, NewSuperBlock, SuperBlock, SuperParams};
+/// use kernel::fs::{DirEmitter, INode, NewSuperBlock, SuperBlock, SuperParams};
 /// use kernel::prelude::*;
 /// use kernel::{c_str, fs, types::ARef};
 ///
@@ -452,6 +634,9 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
 ///     fn init_root(_sb: &SuperBlock<Self>) -> Result<ARef<INode<Self>>> {
 ///         todo!()
 ///     }
+///     fn read_dir(_: &INode<Self>, _: &mut DirEmitter) -> Result {
+///         todo!()
+///     }
 /// }
 /// # }
 /// ```
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
index 9e5f4c7d1c06..4e61a94afa70 100644
--- a/samples/rust/rust_rofs.rs
+++ b/samples/rust/rust_rofs.rs
@@ -2,7 +2,9 @@
 
 //! Rust read-only file system sample.
 
-use kernel::fs::{INode, INodeParams, INodeType, NewSuperBlock, SuperBlock, SuperParams};
+use kernel::fs::{
+    DirEmitter, INode, INodeParams, INodeType, NewSuperBlock, SuperBlock, SuperParams,
+};
 use kernel::prelude::*;
 use kernel::{c_str, fs, time::UNIX_EPOCH, types::ARef, types::Either};
 
@@ -14,6 +16,30 @@
     license: "GPL",
 }
 
+struct Entry {
+    name: &'static [u8],
+    ino: u64,
+    etype: INodeType,
+}
+
+const ENTRIES: [Entry; 3] = [
+    Entry {
+        name: b".",
+        ino: 1,
+        etype: INodeType::Dir,
+    },
+    Entry {
+        name: b"..",
+        ino: 1,
+        etype: INodeType::Dir,
+    },
+    Entry {
+        name: b"subdir",
+        ino: 2,
+        etype: INodeType::Dir,
+    },
+];
+
 struct RoFs;
 impl fs::FileSystem for RoFs {
     const NAME: &'static CStr = c_str!("rust-fs");
@@ -33,7 +59,7 @@ fn init_root(sb: &SuperBlock<Self>) -> Result<ARef<INode<Self>>> {
             Either::Right(new) => new.init(INodeParams {
                 typ: INodeType::Dir,
                 mode: 0o555,
-                size: 1,
+                size: ENTRIES.len().try_into()?,
                 blocks: 1,
                 nlink: 2,
                 uid: 0,
@@ -44,4 +70,23 @@ fn init_root(sb: &SuperBlock<Self>) -> Result<ARef<INode<Self>>> {
             }),
         }
     }
+
+    fn read_dir(inode: &INode<Self>, emitter: &mut DirEmitter) -> Result {
+        if inode.ino() != 1 {
+            return Ok(());
+        }
+
+        let pos = emitter.pos();
+        if pos >= ENTRIES.len().try_into()? {
+            return Ok(());
+        }
+
+        for e in ENTRIES.iter().skip(pos.try_into()?) {
+            if !emitter.emit(1, e.name, e.ino, e.etype.into()) {
+                break;
+            }
+        }
+
+        Ok(())
+    }
 }
-- 
2.34.1


