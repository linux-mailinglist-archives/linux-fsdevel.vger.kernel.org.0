Return-Path: <linux-fsdevel+bounces-1664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CA17DD6F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 21:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFE428188D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 20:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62B7225AB;
	Tue, 31 Oct 2023 20:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEwQVD8e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C551DFE8;
	Tue, 31 Oct 2023 20:14:23 +0000 (UTC)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58F1F5;
	Tue, 31 Oct 2023 13:14:20 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9ac31cb051so5541260276.3;
        Tue, 31 Oct 2023 13:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698783260; x=1699388060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hH/Y3bTLE66gvwan6iYnqa0I9rCjLlt9oT6IPVZRNMg=;
        b=NEwQVD8elMXf7is88L6G0OKdcFsHHeSrOlPKlksFgg/sc9Kj5GsTo2C9VYcpCybXLC
         3DQxlCGHE3bda5JmLvCIwRALXaQtYppY6Wy7kstXTDy99mok16uQiJXIWAoZZF4mJS6W
         4tGTHCJcbQR4VNlRBjz34ZWXZobIN6ek5RD/3wclS1xtGihlX3SKMz18OexMbsCD2x7T
         lEroAbp843P9BQauWOT0lRtT1KVqt1sSloHwbgWOCbEHiCEfmkcODjR1yE5N7XiVIBao
         RvBRFgAGhBDpCD9vc+tzHhW6J7UwHha/e4Hb8aqAr2MU1g5dUEbez0O/lePTCEIXrz/U
         Ad+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698783260; x=1699388060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hH/Y3bTLE66gvwan6iYnqa0I9rCjLlt9oT6IPVZRNMg=;
        b=GYGcP6CsorwlMrLtOtktW4XA9Zd3OYT+Cf2DmLIAjz5vYd28nfh6JfH70a/NR06lvg
         pEjijBvLvTmcwJclXnGEnZAmoDe7YPCmob5eWn2PxEl9BlamC9KaUlqw+znJfCI2TtIP
         cknXraPfh2ZtaKGyQyCWyHlcYTlIY0B/ygY69wESOmParI72wL2YaPj4aCNpENNpmazO
         UU8Xk5T//fiQI2oFDf2JdzNXrHEf/J7Bs1LNKins2+l+cB8lFryDsyrcGcnH3vU4tQCY
         oHz2DcCUmNwI1bcYAxHLcuj4EQufjtH7JUCchpzxccF39J8zpWzY1JowANqe2Dn7xaqp
         mxCw==
X-Gm-Message-State: AOJu0YzjRUFcWjt16bSUKUBI3kqdjJWkR0XQbEalnUtpLjn7kVnRrrbA
	ZiWZdRkupdEDZC+r1j0pzcjI2pF4Bu0peBJJX6s=
X-Google-Smtp-Source: AGHT+IEapJom88s2TF5FkEIzywMTyVpY+Ly1D4FOxirRlEOTtJl5AcNvRFjFpIQAtXZ3uxwB+mlHG9bB9Y0w8yLp2es=
X-Received: by 2002:a25:aa47:0:b0:d9a:5895:2c74 with SMTP id
 s65-20020a25aa47000000b00d9a58952c74mr12278461ybi.42.1698783259737; Tue, 31
 Oct 2023 13:14:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <ZT7BPUAxsHQ/H/Hm@casper.infradead.org>
In-Reply-To: <ZT7BPUAxsHQ/H/Hm@casper.infradead.org>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Tue, 31 Oct 2023 17:14:08 -0300
Message-ID: <CANeycqrm1KCH=hOf2WyCg8BVZkX3DnPpaA3srrajgRfz0x=PiQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 29 Oct 2023 at 17:32, Matthew Wilcox <willy@infradead.org> wrote:
> > impl FileSystem for MyFS {
> >     fn super_params(sb: &NewSuperBlock<Self>) -> Result<SuperParams<Self::Data>>;
> >     fn init_root(sb: &SuperBlock<Self>) -> Result<ARef<INode<Self>>>;
> >     fn read_dir(inode: &INode<Self>, emitter: &mut DirEmitter) -> Result;
> >     fn lookup(parent: &INode<Self>, name: &[u8]) -> Result<ARef<INode<Self>>>;
> >     fn read_folio(inode: &INode<Self>, folio: LockedFolio<'_>) -> Result;
> > }
>
> Does it make sense to describe filesystem methods like this?  As I
> understand (eg) how inodes are laid out, we typically malloc a
>
> foofs_inode {
>         x; y; z;
>         struct inode vfs_inode;
> };
>
> and then the first line of many functions that take an inode is:
>
>         struct ext2_inode_info *ei = EXT2_I(dir);
>
> That feels like unnecessary boilerplate, and might lead to questions like
> "What if I'm passed an inode that isn't an ext2 inode".  Do we want to
> always pass in the foofs_inode instead of the inode?

We're well aligned here. :)

Note that the type is `&INode<Self>` -- `Self` is an alias for the
type implementing this filesystem. For example, in tarfs, the type is
really `&INode<TarFs>`, so it is what you're asking for: the TarFs
filesystem only sees TarFs inodes and superblocks (through the
FileSystem trait, maybe they have to deal with other inodes for other
reasons).

In fact, when you have inode of type `INode<TarFs>`, and you have a call like:

let d = inode.data();

What you get back has the type declared in `TarFs::INodeData`.
Similarly, if you do:

let d = inode.super_block().data();

What you get back has the type declared in `TarFs::Data`.

So all `container_of` calls are hidden away, and we store super-block
data in `s_fs_info` and inode data by having a new struct that
contains the data the fs wants plus a struct inode (this is done with
generics, it's called `INodeWithData`). This is required for type
safety: you always get the right type. If someone changes the type in
one place but forgets to change it in another place, they'll get a
compilation error.

> Also, I see you're passing an inode to read_dir.  Why did you decide to
> do that?  There's information in the struct file that's either necessary
> or useful to have in the filesystem.  Maybe not in toy filesystems, but eg
> network filesystems need user credentials to do readdir, which are stored
> in struct file.  Block filesystems store readahead data in struct file.

Because the two file systems we have don't use anything from `struct
file` beyond the inode.

Passing a `file` to `read_dir` would require us to introduce an
unnecessary abstraction that no one uses, which we've been told not to
do.

There is no technical reason that makes it impractical though. We can
add it when the need arises.

