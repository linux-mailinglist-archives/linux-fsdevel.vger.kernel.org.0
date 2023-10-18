Return-Path: <linux-fsdevel+bounces-647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C6A7CDB97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0FDAB21C55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636CF347AB;
	Wed, 18 Oct 2023 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G40kn9DB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99131341A5;
	Wed, 18 Oct 2023 12:27:06 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408B1112;
	Wed, 18 Oct 2023 05:27:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9d407bb15so57083175ad.0;
        Wed, 18 Oct 2023 05:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697632024; x=1698236824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WW97z1/PhNr6yRKp2DsDMj86gMe+7lyob+R76qs++n4=;
        b=G40kn9DB/dl2OpeoLOPTVOB0AUjKmHkSE+5jKpeR+vu1CITOFijR28hDTfI0wrdaof
         NCsDXPy9HD2aLae9aXYff5BhRO/oTYZBFQjNlQ9JHtTPBuA6qqS+7y/W8oc+AIohLzdj
         i2DPI2Kbqm330iLH0idn2f5GIZylvUC76H0+MhFkk9oxVbHNhWibkcMB9C25RvsjfSt5
         YCHpzkz6asQmPib5TO0XBp4SpQJgm44od3eRr8yuwV9cEkw8JHbRkcGKBIz2dAcKbSGM
         xRgXBL+/YIieuc2HxMfKshRpk8DQ6pjfo+HDrPxtGajpCYXzLoIYC2TJLytmcPz+mLH8
         8t6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632024; x=1698236824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WW97z1/PhNr6yRKp2DsDMj86gMe+7lyob+R76qs++n4=;
        b=L1WiCsC+bUGfp3ityD2DicYRICDMFf8VOJ19AR2Ykb2kp6kpXwinuTqwW3CxGC8q22
         e7JBfj3zt9lHWFMtwfC+qZRwIYDw5lHDnLA+ifsC0i5LKnOHAo62Wx4gRvZd6dgDa8aq
         0K+p4FhQS4ak20mAAeUHB0oGe09qmaOD1EcZxRgqcZn5GkjkFtiyGpzxhSlMjlWLfR2v
         wajuPxO3hPuWLwLesOhfsrQbSSY4eaCW6KLAZYh+pxgA3qbZR71UDHeKTSsz/NtQovQp
         ceQaVCpGDjN1qpfmwm3qXXXGQnYWdXwR8sNYfaVp1S7qb7jhEzqf6HUm1NGLth8nkeIi
         636A==
X-Gm-Message-State: AOJu0Yyh1rRirVyN4I9S/7K7vPwdUM/5IW8lHVX9lSqXbw8UhzXenXzU
	hyCA4ynSUFytjtZ9bDPZLxA=
X-Google-Smtp-Source: AGHT+IFJMhkaG5JqJbKqTYW4s3HNsRTDHmpOm68nw+3WbyX3+kZ7yOAy+rfixB8SUYGtMBEjy44Y0g==
X-Received: by 2002:a17:902:fb87:b0:1ca:1c55:abcf with SMTP id lg7-20020a170902fb8700b001ca1c55abcfmr4724487plb.3.1697632023529;
        Wed, 18 Oct 2023 05:27:03 -0700 (PDT)
Received: from wedsonaf-dev.. ([2804:389:7122:43b8:9b73:6339:3351:cce0])
        by smtp.googlemail.com with ESMTPSA id j1-20020a170902c3c100b001c736b0037fsm3411046plj.231.2023.10.18.05.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:27:03 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH 19/19] tarfs: introduce tar fs
Date: Wed, 18 Oct 2023 09:25:18 -0300
Message-Id: <20231018122518.128049-20-wedsonaf@gmail.com>
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

It is a file system based on tar files and an index appended to them (to
facilitate finding fs entries without having to traverse the whole tar
file).

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/Kconfig                        |   1 +
 fs/Makefile                       |   1 +
 fs/tarfs/Kconfig                  |  16 ++
 fs/tarfs/Makefile                 |   8 +
 fs/tarfs/defs.rs                  |  80 ++++++++
 fs/tarfs/tar.rs                   | 322 ++++++++++++++++++++++++++++++
 scripts/generate_rust_analyzer.py |   2 +-
 7 files changed, 429 insertions(+), 1 deletion(-)
 create mode 100644 fs/tarfs/Kconfig
 create mode 100644 fs/tarfs/Makefile
 create mode 100644 fs/tarfs/defs.rs
 create mode 100644 fs/tarfs/tar.rs

diff --git a/fs/Kconfig b/fs/Kconfig
index aa7e03cc1941..f4b8c33ea624 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -331,6 +331,7 @@ source "fs/sysv/Kconfig"
 source "fs/ufs/Kconfig"
 source "fs/erofs/Kconfig"
 source "fs/vboxsf/Kconfig"
+source "fs/tarfs/Kconfig"
 
 endif # MISC_FILESYSTEMS
 
diff --git a/fs/Makefile b/fs/Makefile
index f9541f40be4e..e3389f8b049d 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -129,3 +129,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
+obj-$(CONFIG_TARFS_FS)		+= tarfs/
diff --git a/fs/tarfs/Kconfig b/fs/tarfs/Kconfig
new file mode 100644
index 000000000000..d3e19eb2adbc
--- /dev/null
+++ b/fs/tarfs/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+config TARFS_FS
+	tristate "TAR file system support"
+	depends on RUST && BLOCK
+	select BUFFER_HEAD
+	help
+	  This is a simple read-only file system intended for mounting
+	  tar files that have had an index appened to them.
+
+	  To compile this file system support as a module, choose M here: the
+	  module will be called tarfs.
+
+	  If you don't know whether you need it, then you don't need it:
+	  answer N.
diff --git a/fs/tarfs/Makefile b/fs/tarfs/Makefile
new file mode 100644
index 000000000000..011c5d64fbe3
--- /dev/null
+++ b/fs/tarfs/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the linux tarfs filesystem routines.
+#
+
+obj-$(CONFIG_TARFS_FS) += tarfs.o
+
+tarfs-y := tar.o
diff --git a/fs/tarfs/defs.rs b/fs/tarfs/defs.rs
new file mode 100644
index 000000000000..7481b75aaab2
--- /dev/null
+++ b/fs/tarfs/defs.rs
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Definitions of tarfs structures.
+
+use kernel::types::LE;
+
+/// Flags used in [`Inode::flags`].
+pub mod inode_flags {
+    /// Indicates that the inode is opaque.
+    ///
+    /// When set, inode will have the "trusted.overlay.opaque" set to "y" at runtime.
+    pub const OPAQUE: u8 = 0x1;
+}
+
+kernel::derive_readable_from_bytes! {
+    /// An inode in the tarfs inode table.
+    #[repr(C)]
+    pub struct Inode {
+        /// The mode of the inode.
+        ///
+        /// The bottom 9 bits are the rwx bits for owner, group, all.
+        ///
+        /// The bits in the [`S_IFMT`] mask represent the file mode.
+        pub mode: LE<u16>,
+
+        /// Tarfs flags for the inode.
+        ///
+        /// Values are drawn from the [`inode_flags`] module.
+        pub flags: u8,
+
+        /// The bottom 4 bits represent the top 4 bits of mtime.
+        pub hmtime: u8,
+
+        /// The owner of the inode.
+        pub owner: LE<u32>,
+
+        /// The group of the inode.
+        pub group: LE<u32>,
+
+        /// The bottom 32 bits of mtime.
+        pub lmtime: LE<u32>,
+
+        /// Size of the contents of the inode.
+        pub size: LE<u64>,
+
+        /// Either the offset to the data, or the major and minor numbers of a device.
+        ///
+        /// For the latter, the 32 LSB are the minor, and the 32 MSB are the major numbers.
+        pub offset: LE<u64>,
+    }
+
+    /// An entry in a tarfs directory entry table.
+    #[repr(C)]
+    pub struct DirEntry {
+        /// The inode number this entry refers to.
+        pub ino: LE<u64>,
+
+        /// The offset to the name of the entry.
+        pub name_offset: LE<u64>,
+
+        /// The length of the name of the entry.
+        pub name_len: LE<u64>,
+
+        /// The type of entry.
+        pub etype: u8,
+
+        /// Unused padding.
+        pub _padding: [u8; 7],
+    }
+
+    /// The super-block of a tarfs instance.
+    #[repr(C)]
+    pub struct Header {
+        /// The offset to the beginning of the inode-table.
+        pub inode_table_offset: LE<u64>,
+
+        /// The number of inodes in the file system.
+        pub inode_count: LE<u64>,
+    }
+}
diff --git a/fs/tarfs/tar.rs b/fs/tarfs/tar.rs
new file mode 100644
index 000000000000..1a71b1ccf8e7
--- /dev/null
+++ b/fs/tarfs/tar.rs
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! File system based on tar files and an index.
+
+use core::mem::size_of;
+use defs::*;
+use kernel::fs::{
+    DirEmitter, DirEntryType, INode, INodeParams, INodeType, NewSuperBlock, Stat, Super,
+    SuperBlock, SuperParams,
+};
+use kernel::types::{ARef, Either, FromBytes};
+use kernel::{c_str, folio::Folio, folio::LockedFolio, fs, prelude::*};
+
+pub mod defs;
+
+kernel::module_fs! {
+    type: TarFs,
+    name: "tarfs",
+    author: "Wedson Almeida Filho <walmeida@microsoft.com>",
+    description: "File system for indexed tar files",
+    license: "GPL",
+}
+
+const SECTOR_SIZE: u64 = 512;
+const TARFS_BSIZE: u64 = 1 << TARFS_BSIZE_BITS;
+const TARFS_BSIZE_BITS: u8 = 12;
+const SECTORS_PER_BLOCK: u64 = TARFS_BSIZE / SECTOR_SIZE;
+const TARFS_MAGIC: u32 = 0x54415246;
+
+static_assert!(SECTORS_PER_BLOCK > 0);
+
+struct INodeData {
+    offset: u64,
+    flags: u8,
+}
+
+struct TarFs {
+    data_size: u64,
+    inode_table_offset: u64,
+    inode_count: u64,
+}
+
+impl TarFs {
+    fn iget(sb: &SuperBlock<Self>, ino: u64) -> Result<ARef<INode<Self>>> {
+        // Check that the inode number is valid.
+        let h = sb.data();
+        if ino == 0 || ino > h.inode_count {
+            return Err(ENOENT);
+        }
+
+        // Create an inode or find an existing (cached) one.
+        let inode = match sb.get_or_create_inode(ino)? {
+            Either::Left(existing) => return Ok(existing),
+            Either::Right(new) => new,
+        };
+
+        static_assert!((TARFS_BSIZE as usize) % size_of::<Inode>() == 0);
+
+        // Load inode details from storage.
+        let offset = h.inode_table_offset + (ino - 1) * u64::try_from(size_of::<Inode>())?;
+
+        let bh = sb.bread(offset / TARFS_BSIZE)?;
+        let b = bh.data();
+        let idata = Inode::from_bytes(b, (offset & (TARFS_BSIZE - 1)) as usize).ok_or(EIO)?;
+
+        let mode = idata.mode.value();
+
+        // Ignore inodes that have unknown mode bits.
+        if (u32::from(mode) & !(fs::mode::S_IFMT | 0o777)) != 0 {
+            return Err(ENOENT);
+        }
+
+        let doffset = idata.offset.value();
+        let size = idata.size.value().try_into()?;
+        let secs = u64::from(idata.lmtime.value()) | (u64::from(idata.hmtime & 0xf) << 32);
+        let ts = kernel::time::Timespec::new(secs, 0)?;
+        let typ = match u32::from(mode) & fs::mode::S_IFMT {
+            fs::mode::S_IFREG => INodeType::Reg,
+            fs::mode::S_IFDIR => INodeType::Dir,
+            fs::mode::S_IFLNK => INodeType::Lnk,
+            fs::mode::S_IFSOCK => INodeType::Sock,
+            fs::mode::S_IFIFO => INodeType::Fifo,
+            fs::mode::S_IFCHR => INodeType::Chr((doffset >> 32) as u32, doffset as u32),
+            fs::mode::S_IFBLK => INodeType::Blk((doffset >> 32) as u32, doffset as u32),
+            _ => return Err(ENOENT),
+        };
+        inode.init(INodeParams {
+            typ,
+            mode: mode & 0o777,
+            size,
+            blocks: (idata.size.value() + TARFS_BSIZE - 1) / TARFS_BSIZE,
+            nlink: 1,
+            uid: idata.owner.value(),
+            gid: idata.group.value(),
+            ctime: ts,
+            mtime: ts,
+            atime: ts,
+            value: INodeData {
+                offset: doffset,
+                flags: idata.flags,
+            },
+        })
+    }
+
+    fn name_eq(sb: &SuperBlock<Self>, mut name: &[u8], offset: u64) -> Result<bool> {
+        for v in sb.read(offset, name.len().try_into()?)? {
+            let v = v?;
+            let b = v.data();
+            if b != &name[..b.len()] {
+                return Ok(false);
+            }
+            name = &name[b.len()..];
+        }
+        Ok(true)
+    }
+
+    fn read_name(sb: &SuperBlock<Self>, mut name: &mut [u8], offset: u64) -> Result<bool> {
+        for v in sb.read(offset, name.len().try_into()?)? {
+            let v = v?;
+            let b = v.data();
+            name[..b.len()].copy_from_slice(b);
+            name = &mut name[b.len()..];
+        }
+        Ok(true)
+    }
+}
+
+impl fs::FileSystem for TarFs {
+    type Data = Box<Self>;
+    type INodeData = INodeData;
+    const NAME: &'static CStr = c_str!("tar");
+    const SUPER_TYPE: Super = Super::BlockDev;
+
+    fn super_params(sb: &NewSuperBlock<Self>) -> Result<SuperParams<Self::Data>> {
+        let scount = sb.sector_count()?;
+        if scount < SECTORS_PER_BLOCK {
+            pr_err!("Block device is too small: sector count={scount}\n");
+            return Err(ENXIO);
+        }
+
+        let tarfs = {
+            let mut folio = Folio::try_new(0)?;
+            sb.sread(
+                (scount / SECTORS_PER_BLOCK - 1) * SECTORS_PER_BLOCK,
+                SECTORS_PER_BLOCK as usize,
+                &mut folio,
+            )?;
+            let mapped = folio.map_page(0)?;
+            let hdr =
+                Header::from_bytes(&mapped, (TARFS_BSIZE - SECTOR_SIZE) as usize).ok_or(EIO)?;
+            Box::try_new(TarFs {
+                inode_table_offset: hdr.inode_table_offset.value(),
+                inode_count: hdr.inode_count.value(),
+                data_size: scount.checked_mul(SECTOR_SIZE).ok_or(ERANGE)?,
+            })?
+        };
+
+        // Check that the inode table starts within the device data and is aligned to the block
+        // size.
+        if tarfs.inode_table_offset >= tarfs.data_size {
+            pr_err!(
+                "inode table offset beyond data size: {} >= {}\n",
+                tarfs.inode_table_offset,
+                tarfs.data_size
+            );
+            return Err(E2BIG);
+        }
+
+        if tarfs.inode_table_offset % SECTOR_SIZE != 0 {
+            pr_err!(
+                "inode table offset not aligned to sector size: {}\n",
+                tarfs.inode_table_offset,
+            );
+            return Err(EDOM);
+        }
+
+        // Check that the last inode is within bounds (and that there is no overflow when
+        // calculating its offset).
+        let offset = tarfs
+            .inode_count
+            .checked_mul(u64::try_from(size_of::<Inode>())?)
+            .ok_or(ERANGE)?
+            .checked_add(tarfs.inode_table_offset)
+            .ok_or(ERANGE)?;
+        if offset > tarfs.data_size {
+            pr_err!(
+                "inode table extends beyond the data size : {} > {}\n",
+                tarfs.inode_table_offset + (tarfs.inode_count * size_of::<Inode>() as u64),
+                tarfs.data_size,
+            );
+            return Err(E2BIG);
+        }
+
+        Ok(SuperParams {
+            magic: TARFS_MAGIC,
+            blocksize_bits: TARFS_BSIZE_BITS,
+            maxbytes: fs::MAX_LFS_FILESIZE,
+            time_gran: 1000000000,
+            data: tarfs,
+        })
+    }
+
+    fn init_root(sb: &SuperBlock<Self>) -> Result<ARef<INode<Self>>> {
+        Self::iget(sb, 1)
+    }
+
+    fn read_dir(inode: &INode<Self>, emitter: &mut DirEmitter) -> Result {
+        let sb = inode.super_block();
+        let mut name = Vec::<u8>::new();
+        let pos = emitter.pos();
+
+        if pos < 0 || pos % size_of::<DirEntry>() as i64 != 0 {
+            return Err(ENOENT);
+        }
+
+        if pos >= inode.size() {
+            return Ok(());
+        }
+
+        // Make sure the inode data doesn't overflow the data area.
+        let size = u64::try_from(inode.size())?;
+        if inode.data().offset.checked_add(size).ok_or(EIO)? > sb.data().data_size {
+            return Err(EIO);
+        }
+
+        for v in sb.read(inode.data().offset + pos as u64, size - pos as u64)? {
+            for e in DirEntry::from_bytes_to_slice(v?.data()).ok_or(EIO)? {
+                let name_len = usize::try_from(e.name_len.value())?;
+                if name_len > name.len() {
+                    name.try_resize(name_len, 0)?;
+                }
+
+                Self::read_name(sb, &mut name[..name_len], e.name_offset.value())?;
+
+                if !emitter.emit(
+                    size_of::<DirEntry>() as i64,
+                    &name[..name_len],
+                    e.ino.value(),
+                    DirEntryType::try_from(u32::from(e.etype))?,
+                ) {
+                    return Ok(());
+                }
+            }
+        }
+
+        Ok(())
+    }
+
+    fn lookup(parent: &INode<Self>, name: &[u8]) -> Result<ARef<INode<Self>>> {
+        let name_len = u64::try_from(name.len())?;
+        let sb = parent.super_block();
+
+        for v in sb.read(parent.data().offset, parent.size().try_into()?)? {
+            for e in DirEntry::from_bytes_to_slice(v?.data()).ok_or(EIO)? {
+                if e.name_len.value() != name_len || e.name_len.value() > usize::MAX as u64 {
+                    continue;
+                }
+                if Self::name_eq(sb, name, e.name_offset.value())? {
+                    return Self::iget(sb, e.ino.value());
+                }
+            }
+        }
+
+        Err(ENOENT)
+    }
+
+    fn read_folio(inode: &INode<Self>, mut folio: LockedFolio<'_>) -> Result {
+        let pos = u64::try_from(folio.pos()).unwrap_or(u64::MAX);
+        let size = u64::try_from(inode.size())?;
+        let sb = inode.super_block();
+
+        let copied = if pos >= size {
+            0
+        } else {
+            let offset = inode.data().offset.checked_add(pos).ok_or(ERANGE)?;
+            let len = core::cmp::min(size - pos, folio.size().try_into()?);
+            let mut foffset = 0;
+
+            if offset.checked_add(len).ok_or(ERANGE)? > sb.data().data_size {
+                return Err(EIO);
+            }
+
+            for v in sb.read(offset, len)? {
+                let v = v?;
+                folio.write(foffset, v.data())?;
+                foffset += v.data().len();
+            }
+            foffset
+        };
+
+        folio.zero_out(copied, folio.size() - copied)?;
+        folio.mark_uptodate();
+        folio.flush_dcache();
+
+        Ok(())
+    }
+
+    fn read_xattr(inode: &INode<Self>, name: &CStr, outbuf: &mut [u8]) -> Result<usize> {
+        if inode.data().flags & inode_flags::OPAQUE == 0
+            || name.as_bytes() != b"trusted.overlay.opaque"
+        {
+            return Err(ENODATA);
+        }
+
+        if !outbuf.is_empty() {
+            outbuf[0] = b'y';
+        }
+
+        Ok(1)
+    }
+
+    fn statfs(sb: &SuperBlock<Self>) -> Result<Stat> {
+        let data = sb.data();
+        Ok(Stat {
+            magic: TARFS_MAGIC,
+            namelen: i64::MAX,
+            bsize: TARFS_BSIZE as _,
+            blocks: data.inode_table_offset / TARFS_BSIZE,
+            files: data.inode_count,
+        })
+    }
+}
diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index fc52bc41d3e7..8dc74991894e 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -116,7 +116,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     # Then, the rest outside of `rust/`.
     #
     # We explicitly mention the top-level folders we want to cover.
-    extra_dirs = map(lambda dir: srctree / dir, ("samples", "drivers"))
+    extra_dirs = map(lambda dir: srctree / dir, ("samples", "drivers", "fs"))
     if external_src is not None:
         extra_dirs = [external_src]
     for folder in extra_dirs:
-- 
2.34.1


