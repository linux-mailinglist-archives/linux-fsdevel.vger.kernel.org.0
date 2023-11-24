Return-Path: <linux-fsdevel+bounces-3662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539457F71C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 11:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852221C20873
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 10:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E3E1EB34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYazDFT7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F7F1722
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 00:48:26 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5c85e8fdd2dso15363267b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 00:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700815706; x=1701420506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DYbnhKp+QnOs31E3bnNX6xtrsAjKMHRqMeiXmcTn+U=;
        b=FYazDFT7uSWti8yiEArM2zG03BSkVTQKMwzatWg7kBWi9XB48SSPAlBLgpQ+P48B6f
         YaQBwTOTHcBg+JoV9MgGKXeIxgsw4oeTtAzCPjK8TKV7Dc/GUcex65F+DE2Rfl/+dMH2
         y/j/OsWOO0LrgtHd2jSrTVYStmTq+4ZfxAASCPmcI3cxnIGO518w0dwbRYXgOpyPqxbT
         uAdoxhlzT/c/itIRYbyVBH2o3+YJB0VfAVKP5D1AMAdcuGCsmquan04/O2DhwegVihwq
         WtB1F2vx5bFceZp2TOfUs+ceK7HqRh0xkFdjXjrpjpNCtiBcP8mXYXJpw47RL2RrxNHk
         lCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700815706; x=1701420506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DYbnhKp+QnOs31E3bnNX6xtrsAjKMHRqMeiXmcTn+U=;
        b=u3KVPQwEieD/y2Men4P6JmkYgGbGnTAW1ISl+Eh67CAnT2tkaBtXq3egMiYpcAH3jk
         oqhvV3lp/8tmrSnqjIMrQB5422maH5ulNwLriazq+5IOhGAKqAI3JTcF1vr0GFn07bk5
         TLPEnBhtCzZPyMEIshZ9mfQangL4wuc41cN/tpqyAeq5Oq9hgR/hL8flYmY7zrjT4RPT
         gN4XH8TAz0ELvlDSX4Ar7oQcBNfdOOwPqhzd7ZRektP1E0iEDb95RqKYPMU5x2CLsEpf
         j6Uru7gkR1HC+Dn4xNrQE5XXsh/o/nz5JYjB7XMYdCFA6nb7p+FIbUHxGUKm4I9V/Dm7
         m+Yg==
X-Gm-Message-State: AOJu0YwCRT7ugx2FBHMeD8rfpwknVGujaGwM7mbEqvPQBUj/ih+QXG7S
	SXMZWgxLDGeVL5xDrRqoKmE0prn/aswblavj6gw=
X-Google-Smtp-Source: AGHT+IFyxt1DhSibhK5bNqM3FR7sUE8OzcdPCxy27crBwF4rOmvrTlM49I52d/c5fe2zBr5TGqI8oHoabJJGCbtMyDw=
X-Received: by 2002:a81:a14f:0:b0:5ca:8b7c:b1d4 with SMTP id
 y76-20020a81a14f000000b005ca8b7cb1d4mr1820331ywg.16.1700815705951; Fri, 24
 Nov 2023 00:48:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122122715.2561213-1-amir73il@gmail.com> <20231122122715.2561213-13-amir73il@gmail.com>
 <20231123171358.yfbo6zcnovyf2vd5@quack3>
In-Reply-To: <20231123171358.yfbo6zcnovyf2vd5@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 Nov 2023 10:48:14 +0200
Message-ID: <CAOQ4uxiq2ysZAfU6intEdqhuTom_HV99uM9Mz1b+4EfLhrz14g@mail.gmail.com>
Subject: Re: [PATCH v2 12/16] fs: move permission hook out of do_iter_read()
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 6:21=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 22-11-23 14:27:11, Amir Goldstein wrote:
> > We recently moved fsnotify hook, rw_verify_area() and other checks from
> > do_iter_write() out to its two callers.
> >
> > for consistency, do the same thing for do_iter_read() - move the
>   ^^^ For
>
> > rw_verify_area() checks and fsnotify hook to the callers vfs_iter_read(=
)
> > and vfs_readv().
> >
> > This aligns those vfs helpers with the pattern used in vfs_read() and
> > vfs_iocb_iter_read() and the vfs write helpers, where all the checks ar=
e
> > in the vfs helpers and the do_* or call_* helpers do the work.
> >
> > This is needed for fanotify "pre content" events.
> >
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Also one nit below. Otherwise feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> > +/*
> > + * Low-level helpers don't perform rw sanity checks.
> > + * The caller is responsible for that.
> > + */
> >  static ssize_t do_iter_read(struct file *file, struct iov_iter *iter,
> > -             loff_t *pos, rwf_t flags)
> > +                         loff_t *pos, rwf_t flags)
> > +{
> > +     if (file->f_op->read_iter)
> > +             return do_iter_readv_writev(file, iter, pos, READ, flags)=
;
> > +
> > +     return do_loop_readv_writev(file, iter, pos, READ, flags);
> > +}
>
> Similarly as with do_iter_write() I don't think there's much point in thi=
s
> helper when there's actually only one real user, the other one can just
> call do_iter_readv_writev().

Yeh, nice.

Christian,

Can you please fold this patch:

BTW, both patches need a very mild edit of commit message
to mention removal of do_iter_{read/write}() and the minor
spelling mistake fixes pointed out by Jan.

Thanks,
Amir.

diff --git a/fs/read_write.c b/fs/read_write.c
index 8358ace9282e..2953fea9b65b 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -784,19 +784,6 @@ static ssize_t do_loop_readv_writev(struct file
*filp, struct iov_iter *iter,
        return ret;
 }

-/*
- * Low-level helpers don't perform rw sanity checks.
- * The caller is responsible for that.
- */
-static ssize_t do_iter_read(struct file *file, struct iov_iter *iter,
-                           loff_t *pos, rwf_t flags)
-{
-       if (file->f_op->read_iter)
-               return do_iter_readv_writev(file, iter, pos, READ, flags);
-
-       return do_loop_readv_writev(file, iter, pos, READ, flags);
-}
-
 ssize_t vfs_iocb_iter_read(struct file *file, struct kiocb *iocb,
                           struct iov_iter *iter)
 {
@@ -845,7 +832,7 @@ ssize_t vfs_iter_read(struct file *file, struct
iov_iter *iter, loff_t *ppos,
        if (ret < 0)
                return ret;

-       ret =3D do_iter_read(file, iter, ppos, flags);
+       ret =3D do_iter_readv_writev(file, iter, ppos, READ, flags);
 out:
        if (ret >=3D 0)
                fsnotify_access(file);
@@ -939,7 +926,10 @@ static ssize_t vfs_readv(struct file *file, const
struct iovec __user *vec,
        if (ret < 0)
                goto out;

-       ret =3D do_iter_read(file, &iter, pos, flags);
+       if (file->f_op->read_iter)
+               ret =3D do_iter_readv_writev(file, &iter, pos, READ, flags)=
;
+       else
+               ret =3D do_loop_readv_writev(file, &iter, pos, READ, flags)=
;
 out:
        if (ret >=3D 0)
                fsnotify_access(file);
--

