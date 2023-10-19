Return-Path: <linux-fsdevel+bounces-760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEF57CFCD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 16:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E061C20D6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 14:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965F22FE1C;
	Thu, 19 Oct 2023 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZhTa2xh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE992FE13
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 14:33:59 +0000 (UTC)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F540195
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 07:33:57 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d852b28ec3bso9088807276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 07:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697726036; x=1698330836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDjLug5hf3bXeKiJXgN2m00hJ8i4tYtBfCbplmbScVg=;
        b=RZhTa2xhrNh0Nsjg/As2Eqa7sM+fqxIRDIlThjYtps0TP5u9BEjGlkXvgwEw1BY1zr
         7mHxEIe4odAFm6NwugKWA1Z9b9HrEm2lxerH7l3HL6Ag8HQQwe9DXmcSELm/Vt7tX+jO
         k4xady6CwGlL7SiyW7XgUCqnhxCkPmJIkJdXtLE/g+YAtF7YGKbLMiMrB+WfNEY1l40C
         aLfH7GS6ExpKSqvEt1Oea7QNoY1b9CtpCrrnwcuYrOHUTwtUN4mTC7sFgv+E70cu2xnc
         M+MKZVZnzzCoW/6Jpc+oRYm9cH6fhljxuqEL5X9COY862CubV08q6hbdGs11AuaYavhO
         Y97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726036; x=1698330836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDjLug5hf3bXeKiJXgN2m00hJ8i4tYtBfCbplmbScVg=;
        b=eM3oVij/jg2gn2XmGDJO64DmUPb6/AmCPJc7eqxWA/jXwZyLgRz2CsmFjTiYaKUxd1
         sOcjirTzGi0jYMZRc1qubLmvmaGy6z6m6ZjHDcjmYWazz79p6J1ghQ9mlKxqlktA918G
         k8gULZ7QhJI59ozpBZ0sLps73nXx+2CntRIbjuvTNgwJwL9juAFAal30SnYYp9qNqMp5
         kKPaybBX+bfW/llJ8Viq1pSLfRPz9o42aeXW+GB8SJCUwvEElHZV/mS+A1sS1j5ulgMn
         XD6wMXTsP9WWQBA/inAowAstjWfbeHDA9543QqQEEjoZG+rKI87R2pPSCzb5IZsNGF3W
         TVoQ==
X-Gm-Message-State: AOJu0YzOnbgdK+3PsH/LRWSbGDG6ThAxgv9eniXO34GtIhznrjfHyHP0
	UO0KeBAAxITddex9973omx1wJv5FPbnslITHl1k81svQpT0=
X-Google-Smtp-Source: AGHT+IGHc2fgsHmCpsXmar2P/tavs6EnNGdUDKO2ZS5/GCBjQPtrt5t0C47it5pe6pF3LXPymEsRCf7xNstbvDbLbvA=
X-Received: by 2002:a25:8e87:0:b0:d9b:e407:663f with SMTP id
 q7-20020a258e87000000b00d9be407663fmr2525476ybl.15.1697726036148; Thu, 19 Oct
 2023 07:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016160902.2316986-1-amir73il@gmail.com>
In-Reply-To: <20231016160902.2316986-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Oct 2023 17:33:44 +0300
Message-ID: <CAOQ4uxh=cLySge6htd+DnJrqAKF=C_oJYfVrbpvQGik0wR-+iw@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 7:09=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> Miklos,
>
> I've shared several POC branches since the posting of v13 back in May
> and played with several API choices. It is time to post v14.
>
> The API we converged to is server managed shared backing files that are
> referenced by backing id plus per-file re-opened backing_file.
>
> This model looks coherent to me. I think that the example server [3]
> demonstrates that this API is simple enough to work with.
>
> There is quite a bit of re-factored code in this version - I've actually
> declared this common code as a new vfs subsystem [stackable filesystems]
> in MAINTAINERS per Christian's request.
>
> The re-factored common code is based on overlayfs-next and Christian's
> vfs.misc branch (for the backing_file changes).
>
> I am not posting performance numbers again. Alessio has already posted
> performance numbers back in v12 and nothing has changed in this regard.
> We are using a variant of v12 patches in production and the performance
> improvement is very noticable.
>
> Bernd and Nikolaus have helped with improving running fstests on fuse
> passthrough examples.
>
> I have ran the -g auto fstests with v14 patches with the example server.
> Compared to the baseline test results with passthrough_hp, the backing
> file passthrough passes several more test, mainly tests related to data
> coherency, such as generic/451.

FWIW, baseline passthrough_hp --nocache does pass generic/451.
Not surprising considering that the test is for
"Test data integrity when mixing buffered reads and asynchronous
 direct writes a file."

>
> The following tests are the only ones that pass on baseline passthtough_h=
p
> and fail with my backing file passthrough example:
>
>   generic/080 generic/120 generic/193 generic/215 generic/355
>
> Those tests are failing because of missing mtime/atime/ctime updates

Some more detailed analysis:

generic/120 tests -o noatime and fails because atime is
updated (on the backing file).
This is a general FUSE issue and passthrough_hp --nocache fails
the same test (i.e. it only passed because of attribute cache).

generic/080, generic/215 both test for c/mtime updates after mapped writes.
It is not surprising that backing file passthrough fails these tests -
there is no "passthrough getattr" like overlayfs and there is no opportunit=
y
to invalidate the FUSE inode attribute cache.

> in some use cases and failure to strip suid/sgid bits in some cases.

The suid/sgid strip failures (generic/193, generic/355) were just a silly b=
ug.
Forgot to add file_remove_privs() in passthrough write.
I now moved it from overlayfs into the common backing_file helpers.

I don't think that the issue with mapped writes c/mtime update is a
show stopper?

Thanks,
Amir.

>
> Changes from v13 [1]:
> - rebase on 6.6-rc6 (and overlayfs and vfs next branches)
> - server managed shared backing files without auto-close mode
> - open a backing_file per fuse_file with fuse file's path and flags
> - factor out common read/write/splice/mmap helpers from overlayfs
> - factor out ioctl helpers
>
> [1] https://lore.kernel.org/r/20230519125705.598234-1-amir73il@gmail.com/
> [2] https://github.com/amir73il/linux/commits/fuse-backing-fd-v14
> [3] https://github.com/amir73il/libfuse/commits/fuse-backing-fd
>
> Amir Goldstein (12):
>   fs: prepare for stackable filesystems backing file helpers
>   fs: factor out backing_file_{read,write}_iter() helpers
>   fs: factor out backing_file_splice_{read,write}() helpers
>   fs: factor out backing_file_mmap() helper
>   fuse: factor out helper for FUSE_DEV_IOC_CLONE
>   fuse: introduce FUSE_PASSTHROUGH capability
>   fuse: pass optional backing_id in struct fuse_open_out
>   fuse: implement ioctls to manage backing files
>   fuse: implement read/write passthrough
>   fuse: implement splice_{read/write} passthrough
>   fuse: implement passthrough for mmap
>   fuse: implement passthrough for readdir
>
>  MAINTAINERS                  |   9 +
>  fs/Kconfig                   |   4 +
>  fs/Makefile                  |   1 +
>  fs/backing-file.c            | 319 ++++++++++++++++++++++++++++
>  fs/fuse/Kconfig              |  11 +
>  fs/fuse/Makefile             |   1 +
>  fs/fuse/cuse.c               |   3 +-
>  fs/fuse/dev.c                |  98 ++++++---
>  fs/fuse/dir.c                |   2 +-
>  fs/fuse/file.c               |  69 ++++--
>  fs/fuse/fuse_i.h             |  72 ++++++-
>  fs/fuse/inode.c              |  25 +++
>  fs/fuse/ioctl.c              |   3 +-
>  fs/fuse/passthrough.c        | 392 +++++++++++++++++++++++++++++++++++
>  fs/fuse/readdir.c            |  12 +-
>  fs/open.c                    |  38 ----
>  fs/overlayfs/Kconfig         |   1 +
>  fs/overlayfs/file.c          | 246 ++++------------------
>  fs/overlayfs/overlayfs.h     |   8 +-
>  fs/overlayfs/super.c         |  11 +-
>  include/linux/backing-file.h |  42 ++++
>  include/linux/fs.h           |   3 -
>  include/uapi/linux/fuse.h    |  23 +-
>  23 files changed, 1085 insertions(+), 308 deletions(-)
>  create mode 100644 fs/backing-file.c
>  create mode 100644 fs/fuse/passthrough.c
>  create mode 100644 include/linux/backing-file.h
>
> --
> 2.34.1
>

