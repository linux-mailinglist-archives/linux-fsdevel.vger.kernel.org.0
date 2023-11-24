Return-Path: <linux-fsdevel+bounces-3661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E617F6EBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 09:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196E92815C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 08:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340083D9F;
	Fri, 24 Nov 2023 08:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqbaZX0t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD3D91
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 00:45:21 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-677fb277b7cso8783936d6.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 00:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700815521; x=1701420321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyhRcE5UqoIeS8bKF94q3jBEqGo9ug8qoFP7V04nO7M=;
        b=IqbaZX0tvgW9oMKjjjov9ABAOvHXSMkxOff1IgXwnXoCo71EvB3524e/sxg68WiIVd
         a0im9Z1X64a0cOhHt9XyVkoq4lLM9fcB/mpwBSvlcOs/98Xm0OpwDXs20LodmR4F+guy
         0aOpqcA07Qo+lTlMs6qOJ6mCT1XcCNM4Aig+86u2+Ki/coROTuQWzfjn++IQzKOi4mLm
         1IbifXt78xEooOjH8Y7RjAPZd5J3Z/uqE7wQghdD8ry0CZY+NkSN+Uhask8v54kWyD1T
         0lnocRxtcJaUrbNyFJyo/jBp7/SFMgUwCX2+KAxryaMutBYTpmvVPHg+1DOH3xVFw7JV
         yfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700815521; x=1701420321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyhRcE5UqoIeS8bKF94q3jBEqGo9ug8qoFP7V04nO7M=;
        b=igN6XhiZ/rUd3VRlxuMptZ/Ffno3peloMFWOTHo6CB2pJ6R/HCmmkzK2jre7yeZazL
         V2wc0yLB6+fa3Nugvx2VeJ2pBQI63ZM5HwkGovtoWinbjHG8Zme9NYbgbFQ7Op79aNci
         WTp4oqCeaPq/k8rpAoz9WurHQcoAUhLz9A0hLisDwPCcry/o0PnHSDArvTkfeZr94Meb
         Dwa88p1f+vEwiw9Qb7hrePVbyy8TfKK0uKRVav25RbeVuThX9n1tIVJrKTjbhyoXrw8h
         udZ2fiw+6LrSR23KcEB0c9Apa4l5NP97gi6hmZsDZvyMz4h0v/QZms2+D6hvf73nai9O
         WUzw==
X-Gm-Message-State: AOJu0Yw8RIqIXBxUOEPyGs291qoyoBAXVlrT83rxPn4JYsm6zYnhLBVV
	qtCw21R78VNxJbqb10TIV8yto03kL+9ccERIUXI=
X-Google-Smtp-Source: AGHT+IESrhH0MX981xTnJgHhlmn2J3ZJXRZE6zcKNkbVKVbWElhPytOkz7YAybjm8nEYcpwj+EJ/GnMlV81m1iR6NS0=
X-Received: by 2002:ad4:420f:0:b0:66d:36fb:474d with SMTP id
 k15-20020ad4420f000000b0066d36fb474dmr2284093qvp.1.1700815520969; Fri, 24 Nov
 2023 00:45:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122122715.2561213-1-amir73il@gmail.com> <20231122122715.2561213-12-amir73il@gmail.com>
 <20231123170814.nvw5jflqzbwcbnaj@quack3>
In-Reply-To: <20231123170814.nvw5jflqzbwcbnaj@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 Nov 2023 10:45:09 +0200
Message-ID: <CAOQ4uxg268s8hWY761yvLtkozGMy-4BAa2KHRAYK0XvDrVOVww@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] fs: move permission hook out of do_iter_write()
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 6:18=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 22-11-23 14:27:10, Amir Goldstein wrote:
> > In many of the vfs helpers, the rw_verity_area() checks are called befo=
re
>                                         ^^ verify
>
> > taking sb_start_write(), making them "start-write-safe".
> > do_iter_write() is an exception to this rule.
> >
> > do_iter_write() has two callers - vfs_iter_write() and vfs_writev().
> > Move rw_verify_area() and other checks from do_iter_write() out to
> > its callers to make them "start-write-safe".
> >
> > Move also the fsnotify_modify() hook to align with similar pattern
> > used in vfs_write() and other vfs helpers.
> >
> > This is needed for fanotify "pre content" events.
> >
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Just one more nit below. Otherwise feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
>
> > diff --git a/fs/read_write.c b/fs/read_write.c
> > index 87ca50f16a23..6c40468efe19 100644
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -852,28 +852,10 @@ EXPORT_SYMBOL(vfs_iter_read);
> >  static ssize_t do_iter_write(struct file *file, struct iov_iter *iter,
> >                            loff_t *pos, rwf_t flags)
> >  {
> > -     size_t tot_len;
> > -     ssize_t ret =3D 0;
> > -
> > -     if (!(file->f_mode & FMODE_WRITE))
> > -             return -EBADF;
> > -     if (!(file->f_mode & FMODE_CAN_WRITE))
> > -             return -EINVAL;
> > -
> > -     tot_len =3D iov_iter_count(iter);
> > -     if (!tot_len)
> > -             return 0;
> > -     ret =3D rw_verify_area(WRITE, file, pos, tot_len);
> > -     if (ret < 0)
> > -             return ret;
> > -
> >       if (file->f_op->write_iter)
> > -             ret =3D do_iter_readv_writev(file, iter, pos, WRITE, flag=
s);
> > -     else
> > -             ret =3D do_loop_readv_writev(file, iter, pos, WRITE, flag=
s);
> > -     if (ret > 0)
> > -             fsnotify_modify(file);
> > -     return ret;
> > +             return do_iter_readv_writev(file, iter, pos, WRITE, flags=
);
> > +
> > +     return do_loop_readv_writev(file, iter, pos, WRITE, flags);
> >  }
>
> Since do_iter_write() is now trivial and has only two callers, one of whi=
ch
> has made sure file->f_op->write_iter !=3D NULL, can we perhaps just fold =
this
> into the callers? One less wrapper in the maze...

Yeh, nice cleanup.

Cristian,

Can you please fold this patch:

diff --git a/fs/read_write.c b/fs/read_write.c
index 6c40468efe19..46a90aa0ad56 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -849,15 +849,6 @@ ssize_t vfs_iter_read(struct file *file, struct
iov_iter *iter, loff_t *ppos,
 }
 EXPORT_SYMBOL(vfs_iter_read);

-static ssize_t do_iter_write(struct file *file, struct iov_iter *iter,
-                            loff_t *pos, rwf_t flags)
-{
-       if (file->f_op->write_iter)
-               return do_iter_readv_writev(file, iter, pos, WRITE, flags);
-
-       return do_loop_readv_writev(file, iter, pos, WRITE, flags);
-}
-
 ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
                            struct iov_iter *iter)
 {
@@ -908,7 +899,7 @@ ssize_t vfs_iter_write(struct file *file, struct
iov_iter *iter, loff_t *ppos,
                return ret;

        file_start_write(file);
-       ret =3D do_iter_write(file, iter, ppos, flags);
+       ret =3D do_iter_readv_writev(file, iter, ppos, WRITE, flags);
        if (ret > 0)
                fsnotify_modify(file);
        file_end_write(file);
@@ -962,7 +953,10 @@ static ssize_t vfs_writev(struct file *file,
const struct iovec __user *vec,
                goto out;

        file_start_write(file);
-       ret =3D do_iter_write(file, &iter, pos, flags);
+       if (file->f_op->write_iter)
+               ret =3D do_iter_readv_writev(file, &iter, pos, WRITE, flags=
);
+       else
+               ret =3D do_loop_readv_writev(file, &iter, pos, WRITE, flags=
);
        if (ret > 0)
                fsnotify_modify(file);
        file_end_write(file);
--

