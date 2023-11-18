Return-Path: <linux-fsdevel+bounces-3116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 261507EFEA2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 10:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC9E4B20AB3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 09:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B2C101FE;
	Sat, 18 Nov 2023 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMm2w3rg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE45D50;
	Sat, 18 Nov 2023 01:09:10 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5c5d59adeedso20122487b3.3;
        Sat, 18 Nov 2023 01:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700298550; x=1700903350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvCiUP97ZvMN3NmcdplUSil1OBub6JKNRfaV9NtMQBo=;
        b=BMm2w3rgKs5UKuWsJDmrXo7H6j1xX9z3gqX7wAFXkYMdJc2T5nDL6tWqPWHgZVlr17
         iPXbCm6fORWVSq6BclXr04Fl2NvNhF9sHoFKY0OVlB4Igv1bnA5/QP/zpa2KDuRG676o
         TEpCL38cm57W8CTcvnWu/slC9fZWfMrv19QFEqLidhms0pBh5wRR4nRKy2L61ACKb6R0
         9aJ75d/ZVdb61KJptiCHxQyoxh9g9bqWnTzp7EEXT/JeoIHomxcwV4E2ovQKKfc5k8SA
         eb9aFFA5pITXDiOISNLjpUOKO9NtcKHtWV94HhzPq9iFJiPYzN/w1xtrD20v88ZKxfPg
         Bnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700298550; x=1700903350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvCiUP97ZvMN3NmcdplUSil1OBub6JKNRfaV9NtMQBo=;
        b=GHTzFIPtuO4D+yPM1ifQIIxNQDLnKivWqzL7tEmZG6GbzDuW7hHbXQ/lIAHjsLwW+d
         aAi4iKMCXjsl0lx7vKllLrbKmBlsHlIlpf8grp8fbxfD6pLD5OdVxhVL+1767VrPV1gp
         WhRJgm+oobCvjQCsRPDyc+Sq0DZCscOO5va0dGctVHRnbnikX+gz5+G1GD6IPmuHPX51
         BPxcwf54FMR2PkCYzhFbVuro78/AmzoPo/udTQDlJgbXcOYZ8Dzsqsprm9b2Qi2DjmRc
         qunuUUJqgPDUuHs5X0Dtl06zTzvtlwoMOq5CoBOfU12psR+8wlIRuzZ/oyKhdpijXcY7
         qPvw==
X-Gm-Message-State: AOJu0YwNfscUX2JnAHssfuNCxk8zW79GNEhL1JluLKvxIfp80cD2aCN6
	PxNNBrHRmRCNr2+E5+0IH7eXtAEudMHwCvSP+0s=
X-Google-Smtp-Source: AGHT+IESNjulQiJHIv2PWj9FQQnB1/9OUFZeVraEluu9OcZmAVLtC6ij0lF+dT1UQ+xbHTUZBvZy04IN7n1Vsydvz/8=
X-Received: by 2002:a81:4e51:0:b0:5b3:f5f8:c5bf with SMTP id
 c78-20020a814e51000000b005b3f5f8c5bfmr2021850ywb.9.1700298549973; Sat, 18 Nov
 2023 01:09:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114153254.1715969-1-amir73il@gmail.com> <20231114153254.1715969-13-amir73il@gmail.com>
 <20231117194622.GD1513185@perftesting>
In-Reply-To: <20231117194622.GD1513185@perftesting>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 18 Nov 2023 11:08:58 +0200
Message-ID: <CAOQ4uxihfJJRxxUhAmOwtD97Lg8PL8RgXw88rH1UfEeP8AtP+w@mail.gmail.com>
Subject: Re: [PATCH 12/15] fs: move kiocb_start_write() into vfs_iocb_iter_write()
To: Josef Bacik <josef@toxicpanda.com>, David Howells <dhowells@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-unionfs@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 9:46=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Tue, Nov 14, 2023 at 05:32:51PM +0200, Amir Goldstein wrote:
> > In vfs code, sb_start_write() is usually called after the permission ho=
ok
> > in rw_verify_area().  vfs_iocb_iter_write() is an exception to this rul=
e,
> > where kiocb_start_write() is called by its callers.
> >
> > Move kiocb_start_write() from the callers into vfs_iocb_iter_write()
> > after the rw_verify_area() checks, to make them "start-write-safe".
> >
> > This is needed for fanotify "pre content" events.
> >
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/cachefiles/io.c  | 2 --
> >  fs/overlayfs/file.c | 1 -
> >  fs/read_write.c     | 2 ++
> >  3 files changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
> > index 009d23cd435b..3d3667807636 100644
> > --- a/fs/cachefiles/io.c
> > +++ b/fs/cachefiles/io.c
> > @@ -319,8 +319,6 @@ int __cachefiles_write(struct cachefiles_object *ob=
ject,
> >               ki->iocb.ki_complete =3D cachefiles_write_complete;
> >       atomic_long_add(ki->b_writing, &cache->b_writing);
> >
> > -     kiocb_start_write(&ki->iocb);
> > -
>
> This bit is subtly wrong, there's a little bit below that does
>
>         ret =3D cachefiles_inject_write_error();
>         if (ret =3D=3D 0)
>                 ret =3D vfs_iocb_iter_write(file, &ki->iocb, iter);
>
> If cachefiles_inject_write_error() returns non-zero it'll fallthrough bel=
ow and
> call cachefiles_write_complete() and complete the kiocb that hasn't start=
ed yet.

Ouch! good catch!

My initial proposal for kiocb_{start,end}_write() has an internal
IOCB_WRITE_STARTED flag to protect against this sort of error,
but Jens convinced me to remove it.

In io_uring and aio.c, IOCB_WRITE is set only after kiocb_start_write(),
so kiocb_end_write() is effectively gated by the IOCB_WRITE flag.
I could make this change in cachefiles/io.c to use IOCB_WRITE flag
as an indication for kiocb_start_write().

It's a bit ugly, but I can't think of anything better and maybe for the pur=
pose
of error injection, the hack is not so bad?

Thanks,
Amir.

--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -259,7 +259,8 @@ static void cachefiles_write_complete(struct kiocb
*iocb, long ret)

        _enter("%ld", ret);

-       kiocb_end_write(iocb);
+       if (iocb->ki_flags & IOCB_WRITE)
+               kiocb_end_write(iocb);

        if (ret < 0)
                trace_cachefiles_io_error(object, inode, ret,
@@ -305,7 +306,7 @@ int __cachefiles_write(struct cachefiles_object *object=
,
        refcount_set(&ki->ki_refcnt, 2);
        ki->iocb.ki_filp        =3D file;
        ki->iocb.ki_pos         =3D start_pos;
-       ki->iocb.ki_flags       =3D IOCB_DIRECT | IOCB_WRITE;
+       ki->iocb.ki_flags       =3D IOCB_DIRECT;
        ki->iocb.ki_ioprio      =3D get_current_ioprio();
        ki->object              =3D object;
        ki->start               =3D start_pos;
@@ -319,16 +320,17 @@ int __cachefiles_write(struct cachefiles_object *obje=
ct,
                ki->iocb.ki_complete =3D cachefiles_write_complete;
        atomic_long_add(ki->b_writing, &cache->b_writing);

-       kiocb_start_write(&ki->iocb);
-
        get_file(ki->iocb.ki_filp);
        cachefiles_grab_object(object, cachefiles_obj_get_ioreq);

        trace_cachefiles_write(object, file_inode(file), ki->iocb.ki_pos, l=
en);
        old_nofs =3D memalloc_nofs_save();
        ret =3D cachefiles_inject_write_error();
-       if (ret =3D=3D 0)
+       if (ret =3D=3D 0) {
+               kiocb_start_write(&ki->iocb);
+               ki->iocb.ki_flags |=3D IOCB_WRITE;
                ret =3D vfs_iocb_iter_write(file, &ki->iocb, iter);
+       }
        memalloc_nofs_restore(old_nofs);
        switch (ret) {
        case -EIOCBQUEUED:

