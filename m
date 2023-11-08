Return-Path: <linux-fsdevel+bounces-2343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C257E4E31
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 01:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5DD1C20D80
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 00:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D1D186F;
	Wed,  8 Nov 2023 00:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQVQUwma"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F541368;
	Wed,  8 Nov 2023 00:36:04 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F9E10F8;
	Tue,  7 Nov 2023 16:36:03 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a7af20c488so76731827b3.1;
        Tue, 07 Nov 2023 16:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699403763; x=1700008563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sZcPU1tT6P9orfWJS8ydvQfBV3TSdNyPdSTnZZcrTCA=;
        b=dQVQUwmaZAtNco3NrGTJyR213dAVeZALAO9ZBkOzLJ23rIf6uo69XeeAabV/uq83KG
         bF8Q5RnqPf+gUgPQM+6CkPoRYgionCKMNBKdqWp1O78etwYrprPmy4NJPboMrG91Nc9k
         Dq4W2QEv1hYL710vHUGbnqnS8+RdyvpD81HmDU18ePc0gsoqsupyslbh9ucJzf2jCMmX
         qvFufC1GQo4dfsvgB7bu7KGw1xJ1Kh8GWXi4dhBnMtY0qHGm6f6hUuCRlBGIvSpZuxc6
         w/glgvzYLgxplIm0NLB4wX1itR8oZaoJy1szMD1plpBOMZWpw4jTD+2UqzwcG4FBesI7
         LqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699403763; x=1700008563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZcPU1tT6P9orfWJS8ydvQfBV3TSdNyPdSTnZZcrTCA=;
        b=D4s/3wA8owRcbmp9IgbXf7gofxmVNA/gp9It/9EVO450eZYRx59UitRdr5vlygN//m
         nr7RKzAorHMPoPg2Ld7gOnTnG56NOSgPjhkwLNqpstmjphtCSXznjJNmfVi1StMs/uIx
         57Y0qFs9f05sud3V1WN0uHUg+HsDJPnQdtlij8E9oLA/fmmiGosn3BPLpxH4hkApzg84
         nII/j9BMj9vI/y0Wf+sIYckZJPE+NUSI0g6UVaaGzCFDfXN1jyIj8juggWwPEXgZdusi
         U5t/HQEGrXhqOonTBYN9fFMY+WeMglI00Y4mhnHLFhl63P85OFArh57zSVDTOrmDf1cH
         WNkw==
X-Gm-Message-State: AOJu0YzX24TbstgsArXkQFFAfnSXkEyQ5ZOAcNgRqqgc9HedfvWiHb4u
	tEimXaeVDDLWHewDMzyPBHv89UUrLwiF8LHtrLQ=
X-Google-Smtp-Source: AGHT+IEFmGp8XMuipCUxGbrSrIzYZAECbGzcCtL85Rkte8CpNVLDXhFVA9rVHgyx4ZupijpCOIrbnREVyzsmHEhgVmU=
X-Received: by 2002:a25:f621:0:b0:d9a:4d90:feda with SMTP id
 t33-20020a25f621000000b00d9a4d90fedamr367553ybd.62.1699403762824; Tue, 07 Nov
 2023 16:36:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-11-wedsonaf@gmail.com>
 <ZUq3nZgedcA5CF0V@casper.infradead.org> <20231107222257.GV1957730@ZenIV>
In-Reply-To: <20231107222257.GV1957730@ZenIV>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Tue, 7 Nov 2023 21:35:44 -0300
Message-ID: <CANeycqo9dpt6kB=5wizKXAF0bZLMTBr_p5QR+NB53_NDVe=agw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/19] rust: fs: introduce `FileSystem::read_folio`
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>, Christian Brauner <brauner@kernel.org>, 
	Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Nov 2023 at 19:22, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Nov 07, 2023 at 10:18:05PM +0000, Matthew Wilcox wrote:
> > On Wed, Oct 18, 2023 at 09:25:09AM -0300, Wedson Almeida Filho wrote:
> > > @@ -36,6 +39,9 @@ pub trait FileSystem {
> > >
> > >      /// Returns the inode corresponding to the directory entry with the given name.
> > >      fn lookup(parent: &INode<Self>, name: &[u8]) -> Result<ARef<INode<Self>>>;
> > > +
> > > +    /// Reads the contents of the inode into the given folio.
> > > +    fn read_folio(inode: &INode<Self>, folio: LockedFolio<'_>) -> Result;
> > >  }
> > >
> >
> > This really shouldn't be a per-filesystem operation.  We have operations
> > split up into mapping_ops, inode_ops and file_ops for a reason.  In this
> > case, read_folio() can have a very different implementation for, eg,
> > symlinks, directories and files.  So we want to have different aops
> > for each of symlinks, directories and files.  We should maintain that
> > separation for filesystems written in Rust too.  Unless there's a good
> > reason to change it, and then we should change it in C too.

read_folio() is only called for regular files and symlinks. All other
modes (directories, pipes, sockets, char devices, block devices) have
their own read callbacks that don't involve read_folio().

For the filesystems that we have in Rust today, reading the contents
of a symlink is the same as reading a file (i.e., the name of the link
target is stored the same way as data in a file). For cases when this
is different, read_folio() can of course just check the mode of the
inode and take the appropriate path.

This is also what a bunch of C file systems do. But you folks are the
ones with most experience in file systems, if you think this isn't a
good idea, we could use read_folio() only for regular files and
introduce a function for reading symblinks, say read_symlink().

> While we are at it, lookup is also very much not a per-filesystem operation.
> Take a look at e.g. procfs, for an obvious example...

The C api offers the greatest freedom: one could write a file system
where each file has its own set of mapping_ops, inode_ops and
file_ops; and while we could choose to replicate this freedom in Rust
but we haven't.

Mostly because we don't need it, and we've been repeatedly told (by
Greg KH and others) not to introduce abstractions/bindings for
anything for which there isn't a user. Besides being a longstanding
rule in the kernel, they also say that they can't reasonably decide if
the interfaces are good if they can't see the users.

The existing Rust users (tarfs and puzzlefs) only need a single
lookup. And a quick grep (git grep \\\.lookup\\\> -- fs/) appears to
show that the vast majority of C filesystems only have a single lookup
as well. So we choose simplicity, knowing well that we may have to
revisit it in the future if the needs change.

> Wait a minute... what in name of everything unholy is that thing doing tied
> to inodes in the first place?

For the same reason as above, we don't need it in our current
filesystems. A bunch of C ones (e.g., xfs, ext2, romfs, erofs) only
use the dentry to get the name and later call d_splice_alias(), so we
hide the name extraction and call to d_splice_alias() in the
"trampoline" function.

BTW, thank you Matthew and Al, I very much appreciate that you take
the time to look into and raise concerns.

Cheers,
-Wedson

