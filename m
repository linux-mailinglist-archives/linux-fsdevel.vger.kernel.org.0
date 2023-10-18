Return-Path: <linux-fsdevel+bounces-641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445BB7CDB90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE009281C7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA30635880;
	Wed, 18 Oct 2023 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWwC7ejq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3858634CD8;
	Wed, 18 Oct 2023 12:26:38 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92551A3;
	Wed, 18 Oct 2023 05:26:36 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9e072472bso43378095ad.2;
        Wed, 18 Oct 2023 05:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697631996; x=1698236796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAu3pHskPx/aJCWIgEBHcZgsDQetzFIBW3HnwZzPP4A=;
        b=SWwC7ejqeVTMQ0PRDV0w5QJlNQjmekgkyR9Uf0NM4W3OQNjT1MkUOEof5k4sX1HDhx
         sWQO3Xf4QPCrtF+A2Ojb1hbxPe6zce6CGX0h4JLGKE+8MqGp1NtXN9VXA/A1XxiIL/6N
         p2jSCwJAgamntFWxJbgdph1EoP2PSfwYrkO0Sd8kDqnQ1e62dhS0+txpVMagHIKFCpCZ
         u1E/sCW7BFaGzYHsK7r96Li5Tr/yx3vhHS8yX9C2PrEdauc61LnpGU721VbdtkixqgjD
         MACyYZy1J3EHafHqmyO93GXLraLsCecTFu3MyCJkTd4D8knkA45jtLOZujgXFJi8aE/a
         4WDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697631996; x=1698236796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAu3pHskPx/aJCWIgEBHcZgsDQetzFIBW3HnwZzPP4A=;
        b=feCn1uINVrxHRGwLJXVdQRfq6LIR0wNVNW8VulAHkpcdb7sPJpBFWlMuHiYtUTsPue
         mtL/uwrhleP2oCCrE0d8xfa60H8yrflpf90HlYmBKNrQTrMCmOmq1XDUWTSH6zD9ngVF
         63wa9xFR8WTA6lX4J3F6da4dsEoGTpQ6ufnRKdF0mfKcS3R4RfyGgytjsfz909M+Pmpa
         pf8FTI3Ph3C4eCuxv+iS1Ao/BhbVpdFHXkZ6fkfNWjHDCjoq/pLDx+O99eJJEg5hStUE
         HjmlC6wLPBF6/SoL5DCLv/GJzOlBBr9grCjlvh6RCTSLQLjASmRm7Azw+6wXolHCA3VA
         Bzzw==
X-Gm-Message-State: AOJu0YyfVyZI2Jy1YamJa4mWq8WuzdhL1QVxRCc2KntKUU6HY/ihf6HM
	/TDgzyb/L0XhscpHUbWEgvA=
X-Google-Smtp-Source: AGHT+IEI0RDYwCYuWpJg3YZyfeHMjcAhdxWPSZlm/x9z7fif5xmQVVB933XrGK2H6DVXDQbg9QJr/Q==
X-Received: by 2002:a17:903:41ce:b0:1ca:4d35:b2ec with SMTP id u14-20020a17090341ce00b001ca4d35b2ecmr6056864ple.15.1697631995907;
        Wed, 18 Oct 2023 05:26:35 -0700 (PDT)
Received: from wedsonaf-dev.. ([2804:389:7122:43b8:9b73:6339:3351:cce0])
        by smtp.googlemail.com with ESMTPSA id j1-20020a170902c3c100b001c736b0037fsm3411046plj.231.2023.10.18.05.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:26:35 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH 13/19] rust: fs: introduce more inode types
Date: Wed, 18 Oct 2023 09:25:12 -0300
Message-Id: <20231018122518.128049-14-wedsonaf@gmail.com>
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

Allow Rust file system modules to create inodes that are symlinks,
pipes, sockets, char devices and block devices (in addition to the
already-supported directories and regular files).

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/helpers.c            |  6 +++
 rust/kernel/fs.rs         | 88 +++++++++++++++++++++++++++++++++++++++
 samples/rust/rust_rofs.rs |  9 +++-
 3 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index f2ce3e7b688c..af335d1912e7 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -244,6 +244,12 @@ void rust_helper_mapping_set_large_folios(struct address_space *mapping)
 }
 EXPORT_SYMBOL_GPL(rust_helper_mapping_set_large_folios);
 
+unsigned int rust_helper_MKDEV(unsigned int major, unsigned int minor)
+{
+	return MKDEV(major, minor);
+}
+EXPORT_SYMBOL_GPL(rust_helper_MKDEV);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 8f34da50e694..5b7eaa16d254 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -112,8 +112,13 @@ pub enum DirEntryType {
 impl From<INodeType> for DirEntryType {
     fn from(value: INodeType) -> Self {
         match value {
+            INodeType::Fifo => DirEntryType::Fifo,
+            INodeType::Chr(_, _) => DirEntryType::Chr,
             INodeType::Dir => DirEntryType::Dir,
+            INodeType::Blk(_, _) => DirEntryType::Blk,
             INodeType::Reg => DirEntryType::Reg,
+            INodeType::Lnk => DirEntryType::Lnk,
+            INodeType::Sock => DirEntryType::Sock,
         }
     }
 }
@@ -281,6 +286,46 @@ pub fn init(self, params: INodeParams) -> Result<ARef<INode<T>>> {
                 unsafe { bindings::mapping_set_large_folios(inode.i_mapping) };
                 bindings::S_IFREG
             }
+            INodeType::Lnk => {
+                inode.i_op = &Tables::<T>::LNK_INODE_OPERATIONS;
+                inode.i_data.a_ops = &Tables::<T>::FILE_ADDRESS_SPACE_OPERATIONS;
+
+                // SAFETY: `inode` is valid for write as it's a new inode.
+                unsafe { bindings::inode_nohighmem(inode) };
+                bindings::S_IFLNK
+            }
+            INodeType::Fifo => {
+                // SAFETY: `inode` is valid for write as it's a new inode.
+                unsafe { bindings::init_special_inode(inode, bindings::S_IFIFO as _, 0) };
+                bindings::S_IFIFO
+            }
+            INodeType::Sock => {
+                // SAFETY: `inode` is valid for write as it's a new inode.
+                unsafe { bindings::init_special_inode(inode, bindings::S_IFSOCK as _, 0) };
+                bindings::S_IFSOCK
+            }
+            INodeType::Chr(major, minor) => {
+                // SAFETY: `inode` is valid for write as it's a new inode.
+                unsafe {
+                    bindings::init_special_inode(
+                        inode,
+                        bindings::S_IFCHR as _,
+                        bindings::MKDEV(major, minor & bindings::MINORMASK),
+                    )
+                };
+                bindings::S_IFCHR
+            }
+            INodeType::Blk(major, minor) => {
+                // SAFETY: `inode` is valid for write as it's a new inode.
+                unsafe {
+                    bindings::init_special_inode(
+                        inode,
+                        bindings::S_IFBLK as _,
+                        bindings::MKDEV(major, minor & bindings::MINORMASK),
+                    )
+                };
+                bindings::S_IFBLK
+            }
         };
 
         inode.i_mode = (params.mode & 0o777) | u16::try_from(mode)?;
@@ -315,11 +360,26 @@ fn drop(&mut self) {
 /// The type of the inode.
 #[derive(Copy, Clone)]
 pub enum INodeType {
+    /// Named pipe (first-in, first-out) type.
+    Fifo,
+
+    /// Character device type.
+    Chr(u32, u32),
+
     /// Directory type.
     Dir,
 
+    /// Block device type.
+    Blk(u32, u32),
+
     /// Regular file type.
     Reg,
+
+    /// Symbolic link type.
+    Lnk,
+
+    /// Named unix-domain socket type.
+    Sock,
 }
 
 /// Required inode parameters.
@@ -701,6 +761,34 @@ extern "C" fn lookup_callback(
         }
     }
 
+    const LNK_INODE_OPERATIONS: bindings::inode_operations = bindings::inode_operations {
+        lookup: None,
+        get_link: Some(bindings::page_get_link),
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
     const FILE_ADDRESS_SPACE_OPERATIONS: bindings::address_space_operations =
         bindings::address_space_operations {
             writepage: None,
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
index ef651ad38185..95ce28efa1c3 100644
--- a/samples/rust/rust_rofs.rs
+++ b/samples/rust/rust_rofs.rs
@@ -23,7 +23,7 @@ struct Entry {
     contents: &'static [u8],
 }
 
-const ENTRIES: [Entry; 3] = [
+const ENTRIES: [Entry; 4] = [
     Entry {
         name: b".",
         ino: 1,
@@ -42,6 +42,12 @@ struct Entry {
         etype: INodeType::Reg,
         contents: b"hello\n",
     },
+    Entry {
+        name: b"link.txt",
+        ino: 3,
+        etype: INodeType::Lnk,
+        contents: b"./test.txt",
+    },
 ];
 
 struct RoFs;
@@ -125,6 +131,7 @@ fn lookup(parent: &INode<Self>, name: &[u8]) -> Result<ARef<INode<Self>>> {
     fn read_folio(inode: &INode<Self>, mut folio: LockedFolio<'_>) -> Result {
         let data = match inode.ino() {
             2 => ENTRIES[2].contents,
+            3 => ENTRIES[3].contents,
             _ => return Err(EINVAL),
         };
 
-- 
2.34.1


