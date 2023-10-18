Return-Path: <linux-fsdevel+bounces-636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB85B7CDB8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F632811C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A46D35897;
	Wed, 18 Oct 2023 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmOy+nj8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1060E35891;
	Wed, 18 Oct 2023 12:26:16 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4F611A;
	Wed, 18 Oct 2023 05:26:14 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bd96cfb99cso2729654b3a.2;
        Wed, 18 Oct 2023 05:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697631974; x=1698236774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VI9w5cgDuGKLdDBL1zMH5+SdDPFuOUVLpieG9kVjiA=;
        b=ZmOy+nj8lg3BGJ8Jux2fahGgwJciANI6iceb7hgfDHEQ1xnaPNhd8cs5ThWpEpZyuD
         /jzEb4FWD8333IZOxEKPxIzp1yMDufV7Rpg0dVxe6IGwVI8t4UCvHXVIeqsSCBByfHT8
         p6ds6ZrOmTEcxkl0G+fVsnoSh/IvfqdAxweApWY1nyJUc7YSupWcjztKyhRqUjWasNSP
         WqDrqhk1H+u8JULhHht2I+PNQIud9fGpAVkZ3LDkrK8TsYSLA8WFwSRQrFuPS8+KHCy8
         QmGsnx7r6gi7/HjPHIPvHUJoMOSum2Wq7nxvcqwPYA4izvx0bb04dWgjmi+iGZ52/fN0
         gitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697631974; x=1698236774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VI9w5cgDuGKLdDBL1zMH5+SdDPFuOUVLpieG9kVjiA=;
        b=i3F5Dzj4B5oq6QKN6LzZvjhbrDVl2wqrUCWUr4Eji79vKCpD3cqjebZWLP7M0K7Pyz
         0SsB4SVL45glGypuLl45o3ZpEJ0X7ews3tk/gxlROZOjI3eKD+y20Ue5LLuJEWUlkXMv
         GgIq3AJl6Abr16TMLRWFbJn1hvW0NcE8AMcf9qWhGcQfCO/5f4pDLnAPyRUOYL4c4xf3
         IbAhZskocj2VNGrhejKWssZTO9F6F5MKpwFQnoTrEuWgpNYydG3/dH7FGHxpkI0xk5L6
         SQSteppE0/AIUMCCp03uBykwysv3q0pBmOwlhSCYT+bU82o3AafoGOzTetp+8qUToUBt
         +JcA==
X-Gm-Message-State: AOJu0YxhVQsUmEu8arGRNql5mJtu7OOTp7D3L10VSy0+m0oCrlavw33U
	DKgeXTzL9mljm5NdiYch+FEiLmnhAzM=
X-Google-Smtp-Source: AGHT+IHAiqGG2CZaJruE1lNlAxnhiRC/F1x94UGSUpCWeH0bK/UFwCuObKzFu0tj/1yEKEAvFrjs3w==
X-Received: by 2002:a05:6a21:a101:b0:171:8e16:ea86 with SMTP id aq1-20020a056a21a10100b001718e16ea86mr4174703pzc.31.1697631974217;
        Wed, 18 Oct 2023 05:26:14 -0700 (PDT)
Received: from wedsonaf-dev.. ([2804:389:7122:43b8:9b73:6339:3351:cce0])
        by smtp.googlemail.com with ESMTPSA id j1-20020a170902c3c100b001c736b0037fsm3411046plj.231.2023.10.18.05.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:26:13 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH 08/19] rust: fs: introduce `FileSystem::lookup`
Date: Wed, 18 Oct 2023 09:25:07 -0300
Message-Id: <20231018122518.128049-9-wedsonaf@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wedson Almeida Filho <walmeida@microsoft.com>

Allow Rust file systems to create inodes that are children of a
directory inode when they're looked up by name.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/error.rs      |  1 -
 rust/kernel/fs.rs         | 65 +++++++++++++++++++++++++++++++++++++--
 samples/rust/rust_rofs.rs | 25 +++++++++++++++
 3 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index e6d7ce46be55..484fa7c11de1 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -131,7 +131,6 @@ pub fn to_errno(self) -> core::ffi::c_int {
     }
 
     /// Returns the error encoded as a pointer.
-    #[allow(dead_code)]
     pub(crate) fn to_ptr<T>(self) -> *mut T {
         // SAFETY: self.0 is a valid error due to its invariant.
         unsafe { bindings::ERR_PTR(self.0.into()) as *mut _ }
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 89611c44e4c5..681fef8e3af1 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -33,6 +33,9 @@ pub trait FileSystem {
     ///
     /// [`DirEmitter::pos`] holds the current position of the directory reader.
     fn read_dir(inode: &INode<Self>, emitter: &mut DirEmitter) -> Result;
+
+    /// Returns the inode corresponding to the directory entry with the given name.
+    fn lookup(parent: &INode<Self>, name: &[u8]) -> Result<ARef<INode<Self>>>;
 }
 
 /// The types of directory entries reported by [`FileSystem::read_dir`].
@@ -226,8 +229,7 @@ pub fn init(self, params: INodeParams) -> Result<ARef<INode<T>>> {
         let mode = match params.typ {
             INodeType::Dir => {
                 inode.__bindgen_anon_3.i_fop = &Tables::<T>::DIR_FILE_OPERATIONS;
-                // SAFETY: `simple_dir_inode_operations` never changes, it's safe to reference it.
-                inode.i_op = unsafe { &bindings::simple_dir_inode_operations };
+                inode.i_op = &Tables::<T>::DIR_INODE_OPERATIONS;
                 bindings::S_IFDIR
             }
         };
@@ -530,6 +532,62 @@ impl<T: FileSystem + ?Sized> Tables<T> {
             }
         })
     }
+
+    const DIR_INODE_OPERATIONS: bindings::inode_operations = bindings::inode_operations {
+        lookup: Some(Self::lookup_callback),
+        get_link: None,
+        permission: None,
+        get_inode_acl: None,
+        readlink: None,
+        create: None,
+        link: None,
+        unlink: None,
+        symlink: None,
+        mkdir: None,
+        rmdir: None,
+        mknod: None,
+        rename: None,
+        setattr: None,
+        getattr: None,
+        listxattr: None,
+        fiemap: None,
+        update_time: None,
+        atomic_open: None,
+        tmpfile: None,
+        get_acl: None,
+        set_acl: None,
+        fileattr_set: None,
+        fileattr_get: None,
+        get_offset_ctx: None,
+    };
+
+    extern "C" fn lookup_callback(
+        parent_ptr: *mut bindings::inode,
+        dentry: *mut bindings::dentry,
+        _flags: u32,
+    ) -> *mut bindings::dentry {
+        // SAFETY: The C API guarantees that `parent_ptr` is a valid inode.
+        let parent = unsafe { &*parent_ptr.cast::<INode<T>>() };
+
+        // SAFETY: The C API guarantees that `dentry` is valid for read. Since the name is
+        // immutable, it's ok to read its length directly.
+        let len = unsafe { (*dentry).d_name.__bindgen_anon_1.__bindgen_anon_1.len };
+        let Ok(name_len) = usize::try_from(len) else {
+            return ENOENT.to_ptr();
+        };
+
+        // SAFETY: The C API guarantees that `dentry` is valid for read. Since the name is
+        // immutable, it's ok to read it directly.
+        let name = unsafe { core::slice::from_raw_parts((*dentry).d_name.name, name_len) };
+        match T::lookup(parent, name) {
+            Err(e) => e.to_ptr(),
+            // SAFETY: The returned inode is valid and referenced (by the type invariants), so
+            // it is ok to transfer this increment to `d_splice_alias`.
+            Ok(inode) => unsafe {
+                bindings::d_splice_alias(ManuallyDrop::new(inode).0.get(), dentry)
+            },
+        }
+    }
 }
 
 /// Directory entry emitter.
@@ -637,6 +695,9 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
 ///     fn read_dir(_: &INode<Self>, _: &mut DirEmitter) -> Result {
 ///         todo!()
 ///     }
+///     fn lookup(_: &INode<Self>, _: &[u8]) -> Result<ARef<INode<Self>>> {
+///         todo!()
+///     }
 /// }
 /// # }
 /// ```
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
index 4e61a94afa70..4cc8525884a9 100644
--- a/samples/rust/rust_rofs.rs
+++ b/samples/rust/rust_rofs.rs
@@ -89,4 +89,29 @@ fn read_dir(inode: &INode<Self>, emitter: &mut DirEmitter) -> Result {
 
         Ok(())
     }
+
+    fn lookup(parent: &INode<Self>, name: &[u8]) -> Result<ARef<INode<Self>>> {
+        if parent.ino() != 1 {
+            return Err(ENOENT);
+        }
+
+        match name {
+            b"subdir" => match parent.super_block().get_or_create_inode(2)? {
+                Either::Left(existing) => Ok(existing),
+                Either::Right(new) => new.init(INodeParams {
+                    typ: INodeType::Dir,
+                    mode: 0o555,
+                    size: 0,
+                    blocks: 1,
+                    nlink: 2,
+                    uid: 0,
+                    gid: 0,
+                    atime: UNIX_EPOCH,
+                    ctime: UNIX_EPOCH,
+                    mtime: UNIX_EPOCH,
+                }),
+            },
+            _ => Err(ENOENT),
+        }
+    }
 }
-- 
2.34.1


