Return-Path: <linux-fsdevel+bounces-628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 869BB7CDB7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B02D1F21EE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEED347A7;
	Wed, 18 Oct 2023 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/2LrsG+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966F2341A1;
	Wed, 18 Oct 2023 12:25:43 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190DE10E;
	Wed, 18 Oct 2023 05:25:40 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c9d3a21f7aso54620885ad.2;
        Wed, 18 Oct 2023 05:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697631939; x=1698236739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EHs9rCs8x4QUhZl508/QQpGlG46IC0KzP6IesPq9PKQ=;
        b=U/2LrsG+cNQ2jsSRFQABnZwrZFO0XF2HqJS8JVJJmd1SzXLuGEpRck++8PjkeCD3C7
         NVUpPVzorHNx16u5+7o4kOz9WVaIXQFxthDJ73gLmQYihNWcBhLmnVQoP7LWeifrp0xc
         8OLZjVW9JEl7OniR6gPrvv7tHRIWHxhVETONbuG3L2WZr7/6lsUcRgIVW54fQhnMD8Gv
         GWoLjNMMpIVMILV69K2iJa+ZB9fyOVNyteKCWlPNIn0BI24rwlh5gxttYkthB4eyTyuw
         HHeuSsFGHD1Fbtuc349Jq4hrJ281fzBQrri6uIQdwjLid+pNlNiPp6xWTUJzu9aiSZgI
         1vbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697631939; x=1698236739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EHs9rCs8x4QUhZl508/QQpGlG46IC0KzP6IesPq9PKQ=;
        b=cnpzojBh5jq88lIWapd6/EvkmS3O+W9awASOle2kKpb7erV+F8H4RsLVNND586dHhT
         IQXf1k9MNwrinF/cP5Ii9ze161rjvRGEcXy4ZMluX2wxdWgWYGhlMXfAsO/BEjj/p23C
         GAgeniK+lDTVnD8p8ZciMaQ8xRuCxov/Xjr9qMzfijTb1ocbWaipVfixuw8N7c7yOtOR
         ZtR3hSMWvtgsrIF4V7E2qGQTflxww38iarFw59A3Ows94fbkUoARIj2ZeHh+yKsEcTpI
         rfWJBxXq5YIQ/1YCamtoioa39mXoUrqXRJPFk42Rz9mSPMzIasUBm8DFraJBUxXBnhko
         3vJw==
X-Gm-Message-State: AOJu0Yw4I94QkgIuNzqMFP5eT1qiZsTa5boiGc98x/XHpX0ypO9PzWAl
	BXeCk/Q/lNNbOlsvPuY6tC0=
X-Google-Smtp-Source: AGHT+IGPlLnxWcUSiSEWJfC4z5iw6hs7k7HUWD5Q6zQMMfeUVqq5hXqzfyTOUg+EczxpvqNEx2CQYg==
X-Received: by 2002:a17:902:c404:b0:1bc:6c8:cded with SMTP id k4-20020a170902c40400b001bc06c8cdedmr6507130plk.67.1697631939386;
        Wed, 18 Oct 2023 05:25:39 -0700 (PDT)
Received: from wedsonaf-dev.. ([2804:389:7122:43b8:9b73:6339:3351:cce0])
        by smtp.googlemail.com with ESMTPSA id j1-20020a170902c3c100b001c736b0037fsm3411046plj.231.2023.10.18.05.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:25:39 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH 00/19] Rust abstractions for VFS
Date: Wed, 18 Oct 2023 09:24:59 -0300
Message-Id: <20231018122518.128049-1-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This series introduces Rust abstractions that allow page-cache-backed read-only
file systems to be written in Rust.

There are two file systems that are built on top of these abstractions: tarfs
and puzzlefs. The former has zero unsafe blocks and is included as a patch in
this series; the latter is described elsewhere [1]. We limit the functionality
to the bare minimum needed to implement them.

Rust file system modules can be declared with the `module_fs` macro and are
required to implement the following functions (which are part of the
`FileSystem` trait):

impl FileSystem for MyFS {
    fn super_params(sb: &NewSuperBlock<Self>) -> Result<SuperParams<Self::Data>>;
    fn init_root(sb: &SuperBlock<Self>) -> Result<ARef<INode<Self>>>;
    fn read_dir(inode: &INode<Self>, emitter: &mut DirEmitter) -> Result;
    fn lookup(parent: &INode<Self>, name: &[u8]) -> Result<ARef<INode<Self>>>;
    fn read_folio(inode: &INode<Self>, folio: LockedFolio<'_>) -> Result;
}

They can optionally implement the following:

fn read_xattr(inode: &INode<Self>, name: &CStr, outbuf: &mut [u8]) -> Result<usize>;
fn statfs(sb: &SuperBlock<Self>) -> Result<Stat>;

They may also choose the type of the data they can attach to superblocks and/or
inodes.

There a couple of issues that are likely to lead to unsoundness that have to do
with the unregistration of file systems. I will send separate emails about
them.

A git tree is available here:
    git://github.com/wedsonaf/linux.git vfs

Web:
    https://github.com/wedsonaf/linux/commits/vfs

[1]: The PuzzleFS container filesystem: https://lwn.net/Articles/945320/

Wedson Almeida Filho (19):
  rust: fs: add registration/unregistration of file systems
  rust: fs: introduce the `module_fs` macro
  samples: rust: add initial ro file system sample
  rust: fs: introduce `FileSystem::super_params`
  rust: fs: introduce `INode<T>`
  rust: fs: introduce `FileSystem::init_root`
  rust: fs: introduce `FileSystem::read_dir`
  rust: fs: introduce `FileSystem::lookup`
  rust: folio: introduce basic support for folios
  rust: fs: introduce `FileSystem::read_folio`
  rust: fs: introduce `FileSystem::read_xattr`
  rust: fs: introduce `FileSystem::statfs`
  rust: fs: introduce more inode types
  rust: fs: add per-superblock data
  rust: fs: add basic support for fs buffer heads
  rust: fs: allow file systems backed by a block device
  rust: fs: allow per-inode data
  rust: fs: export file type from mode constants
  tarfs: introduce tar fs

 fs/Kconfig                        |    1 +
 fs/Makefile                       |    1 +
 fs/tarfs/Kconfig                  |   16 +
 fs/tarfs/Makefile                 |    8 +
 fs/tarfs/defs.rs                  |   80 ++
 fs/tarfs/tar.rs                   |  322 +++++++
 rust/bindings/bindings_helper.h   |   13 +
 rust/bindings/lib.rs              |    6 +
 rust/helpers.c                    |  142 ++++
 rust/kernel/error.rs              |    6 +-
 rust/kernel/folio.rs              |  214 +++++
 rust/kernel/fs.rs                 | 1290 +++++++++++++++++++++++++++++
 rust/kernel/fs/buffer.rs          |   60 ++
 rust/kernel/lib.rs                |    2 +
 rust/kernel/mem_cache.rs          |    2 -
 samples/rust/Kconfig              |   10 +
 samples/rust/Makefile             |    1 +
 samples/rust/rust_rofs.rs         |  154 ++++
 scripts/generate_rust_analyzer.py |    2 +-
 19 files changed, 2324 insertions(+), 6 deletions(-)
 create mode 100644 fs/tarfs/Kconfig
 create mode 100644 fs/tarfs/Makefile
 create mode 100644 fs/tarfs/defs.rs
 create mode 100644 fs/tarfs/tar.rs
 create mode 100644 rust/kernel/folio.rs
 create mode 100644 rust/kernel/fs.rs
 create mode 100644 rust/kernel/fs/buffer.rs
 create mode 100644 samples/rust/rust_rofs.rs


base-commit: b0bc357ef7a98904600826dea3de79c0c67eb0a7
-- 
2.34.1


