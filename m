Return-Path: <linux-fsdevel+bounces-5377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EEC80AEDE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 22:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757341C20AB0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 21:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9244B57892;
	Fri,  8 Dec 2023 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jivLLMoc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C3911F
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 13:34:16 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-67a8a745c43so20074006d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Dec 2023 13:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702071256; x=1702676056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taYpmdsvo9TvFlrRaL0O+bLctpwh2sTB61SCi/+bPBE=;
        b=jivLLMocttH36IUVEsdZdJ6jYhaew3ZTRYNXg/lyE466Dia0vFuGJ+ypORAf5Yi58g
         HiFEnfHIorwN0ST12BnFAOPjI1cDiABsCwvAY19aFAAlf3i0uT5YMSpKWOz0aKgEUi4u
         pxTKjG4fUkyrkeUnsQYg4BFE4nRQZ/8yI8mAPqj0hLC4256rnQp1aka+hJXDpHkdVQ02
         0Dr6roeU3w+gnAchaU3aXfbklk+jcugIstvS/Q9zZKHyezHVKCFqc6mXa57aMnQbXZdm
         5iDxrJluexhQU1/qUZftD6pQm0LqpFSnslHiJIJJ/0qwbUOslncoO7lJrACecO+cXQC7
         upAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702071256; x=1702676056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taYpmdsvo9TvFlrRaL0O+bLctpwh2sTB61SCi/+bPBE=;
        b=vnNuYNvJYnrSp0y1TqLH4Ry63orlHuTfjxG23IoNPsf/zzS5R7Jl4nz4z8F+WAQeUr
         UMR6CZWNwThH0mCYIenEBT5yeTB5eQaD1Qo+Rjbs0SL2lXd5OPQhpTESfaRNSLqfIod3
         zBDIkOVpuCAjXukMNZIixVO8slclXphVt4lHtt6CLaFJM6wQnJrrCtV2Vh39LMbEOHGc
         Kv7JLXc+1u0idM9Rt0tzB84Z+RCS8MzNkdDgx6AkCPCdj+7RB03IWSlPSmShFHTu5Erp
         aLYFiEywaegvq8pmz0gB+GCLMNv6VTU2Xx48/HXUAGm7EE/L4dX8b2Aqm1UmfHwPtrIl
         J36w==
X-Gm-Message-State: AOJu0YxnoXcf+C9H/td8eU6YMEi+qdqAe1G/AZjfxgcAnAWVF06H0enU
	p21zawXs7vE+Qhibf1CCHWWVYS8q3aOVSCHPeYY=
X-Google-Smtp-Source: AGHT+IHWFvKoqs6FyL9lI+z2em4bmdfwZRUHf+UY7yNBmjh1slZTcf0pbdvTSSlmjfF3R5tmFgbEMfomF8UrOzAN/m8=
X-Received: by 2002:a0c:de14:0:b0:67a:2372:30fa with SMTP id
 t20-20020a0cde14000000b0067a237230famr1747926qvk.16.1702071256055; Fri, 08
 Dec 2023 13:34:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207123825.4011620-1-amir73il@gmail.com> <20231207123825.4011620-5-amir73il@gmail.com>
 <20231208185302.wkzvwthf5vuuuk3s@quack3>
In-Reply-To: <20231208185302.wkzvwthf5vuuuk3s@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 8 Dec 2023 23:34:04 +0200
Message-ID: <CAOQ4uxi+6VMAdyREODOpMLiZ26Q_1R981H-eOwOA8gJsrsSqrA@mail.gmail.com>
Subject: Re: [PATCH 4/4] fsnotify: pass access range in file permission hooks
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, David Howells <dhowells@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 8:53=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 07-12-23 14:38:25, Amir Goldstein wrote:
> > In preparation for pre-content permission events with file access range=
,
> > move fsnotify_file_perm() hook out of security_file_permission() and in=
to
> > the callers that have the access range information and pass the access
> > range to fsnotify_file_perm().
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> So why don't you pass the range into security_file_permission() instead o=
f
> pulling fsnotify out of the hook? I mean conceptually the accessed range
> makes sense for the hook as well although no LSM currently cares about it=
.
> Also it would address the Christian's concern.
>

I don't think it would be nice if the signature of
security_file_permission() did not match the signature of the LSM
methods of the same name (i.e. call_int_hook(file_permission, 0, file, mask=
);

I think that calling fsnotify_perm(), which is not an LSM,
from security_file_permission()/security_file_open() was a hack to
begin with and that decoupling fsnotify_perm() hooks from security
hooks is a good thing.

Also, it is needed for future work. If you look at commit
"fs: hold s_write_srcu for pre-modify permission events on write"
on my sb_write_barrier branch, you will see that the fsnotify
modify permission hook moves (again) into start_file_write_area().

So yes, fsnotify permission hooks become first class vfs hooks and
not LSM hooks, but then again, fsnotify_xxx hooks for async events
are already first class vfs hooks, and many times in the same
vfs_xxx helpers that will have the fsnotify permission hooks in them.

> > diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> > index 0a9d6a8a747a..45e6ecbca057 100644
> > --- a/include/linux/fsnotify.h
> > +++ b/include/linux/fsnotify.h
> > @@ -103,7 +103,8 @@ static inline int fsnotify_file(struct file *file, =
__u32 mask)
> >  /*
> >   * fsnotify_file_perm - permission hook before file access
> >   */
> > -static inline int fsnotify_file_perm(struct file *file, int perm_mask)
> > +static inline int fsnotify_file_perm(struct file *file, int perm_mask,
> > +                                  const loff_t *ppos, size_t count)
> >  {
> >       __u32 fsnotify_mask =3D FS_ACCESS_PERM;
>
> Also why do you actually pass in loff_t * instead of plain loff_t? You
> don't plan to change it, do you?

No I don't.

I used NULL to communicate "no range info" to fanotify.
It is currently only used from iterate_dir(), but filesystems may need to
use that to report other cases of pre-content access with no clear range in=
fo.

I could leave fsnotify_file_perm(file, mask) for reporting events without
range info and add fsnotify_file_area(file, mask, pos, count) for reporting
access permission with range info.

Do you think that would be better?

Thanks,
Amir.

