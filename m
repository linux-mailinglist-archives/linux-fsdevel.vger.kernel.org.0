Return-Path: <linux-fsdevel+bounces-7404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640A28247A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 18:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B45285A00
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 17:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF95128DD1;
	Thu,  4 Jan 2024 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZBpTMlz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29A728DB0;
	Thu,  4 Jan 2024 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-67f85d29d14so3442796d6.1;
        Thu, 04 Jan 2024 09:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704390202; x=1704995002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFIIryb7mYBnbq82yqxhExlh548l2vMivKOd0SRme00=;
        b=LZBpTMlzlvSFhndchxh6GGDnaVyfsaGGPElGi+Aji3acjLRKgkNUQOtw7yfTgpdsBG
         nikT1jhKiPxLuikCaVbYII5yZGzaXVXCcDKcmVWgBKHeC1yWwurE6tPyI3OxZ+jQcMYa
         jlObwR82c3Ogtgny5JSRIFwY5cT6tgvssqen/KgDoND6OLsJgO59ld5E9VwfNDugjrJF
         2BEK6TPsesdNlK3Nid+ckbOspXJ0xO0FJ4cdR9mUH0bpccJRkzbG8SFV2lvur8luxX/z
         97WD+sUbYRz9sS8OBiy6ycKUpaEJP9p2qeBFF+zacgzOSkUM2862NfzgrCEsw7ARXZRL
         gujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704390202; x=1704995002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFIIryb7mYBnbq82yqxhExlh548l2vMivKOd0SRme00=;
        b=gYMvLdJLqAEsAj+cLttgCLRo769n92PK64V/e29d+mCKczWJoVecXFznMoUmZcfJ17
         qzhB2YZ7KP+N6Ii1GaWC+0wxj/YguFQS6RBcJQMxTnj63IzfScE5atuUlKD78iCRm18N
         6BjReQLQAitVslvSLOWYq7FOtZTsbDmGPp2RxSGcPTPqdNd4YE2wpS/m7K8LVic11J+P
         FSLVkzAhRJ36LwrpfBuPPux/yixBLt1EUwvd9s41Hhx/xRN4BZz6oxh6M937PMWk5Umu
         CayzCcG6xzpojJwPGwSE0oI5xbBNEj1LU8NdkDnRIqyZVAVfIl+Eb0RyWg4q7XtP8hCn
         qiDA==
X-Gm-Message-State: AOJu0Yz1DEJfef5TkFH8Adkd6tLKViVTTsn1CRCHoBdzkD6t301qWKlG
	6SHWePewUIVNp22FXFkeAzyrIjvNuPbqsGDAFKo=
X-Google-Smtp-Source: AGHT+IEHl1VuMRuCwI1C5vMpY4u0MXtJn5SASZHzotUrJ++6zFJluian9dLYoVysDl6Rvad8aB/SpU7cNEl04nmj9hs=
X-Received: by 2002:a05:6214:e6d:b0:67e:e37c:6f73 with SMTP id
 jz13-20020a0562140e6d00b0067ee37c6f73mr1101446qvb.54.1704390201715; Thu, 04
 Jan 2024 09:43:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170429478711.50646.12675561629884992953.stgit@bazille.1015granger.net>
 <170429517779.50646.9656897459585544068.stgit@bazille.1015granger.net>
 <CAOQ4uxgMLWGqqoSNvSgB=Qfmw6Brk2eO6yB7FZqX6p-DcTiUtw@mail.gmail.com> <ZZbAQEgqbV72RJn8@tissot.1015granger.net>
In-Reply-To: <ZZbAQEgqbV72RJn8@tissot.1015granger.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 4 Jan 2024 19:43:10 +0200
Message-ID: <CAOQ4uxhB506ZunNzmnyk=FKCRHEPOupV34vcfjVMJ9o9SDVJow@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] exportfs: fix the fallback implementation of the
 get_name export operation
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, jlayton@redhat.com, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Jeff Layton <jlayton@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	trondmy@hammerspace.com, viro@zeniv.linux.org.uk, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 4:27=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com>=
 wrote:
>
> On Thu, Jan 04, 2024 at 09:39:04AM +0200, Amir Goldstein wrote:
> > On Wed, Jan 3, 2024 at 5:19=E2=80=AFPM Chuck Lever <cel@kernel.org> wro=
te:
> > >
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > >
> > > The fallback implementation for the get_name export operation uses
> > > readdir() to try to match the inode number to a filename. That filena=
me
> > > is then used together with lookup_one() to produce a dentry.
> > > A problem arises when we match the '.' or '..' entries, since that
> > > causes lookup_one() to fail. This has sometimes been seen to occur fo=
r
> > > filesystems that violate POSIX requirements around uniqueness of inod=
e
> > > numbers, something that is common for snapshot directories.
> > >
> > > This patch just ensures that we skip '.' and '..' rather than allowin=
g a
> > > match.
> > >
> > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > Acked-by: Amir Goldstein <amir73il@gmail.com>
> > > Link: https://lore.kernel.org/linux-nfs/CAOQ4uxiOZobN76OKB-VBNXWeFKVw=
LW_eK5QtthGyYzWU9mjb7Q@mail.gmail.com/
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > ---
> > >  fs/exportfs/expfs.c |    4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> > > index 3ae0154c5680..84af58eaf2ca 100644
> > > --- a/fs/exportfs/expfs.c
> > > +++ b/fs/exportfs/expfs.c
> > > @@ -255,7 +255,9 @@ static bool filldir_one(struct dir_context *ctx, =
const char *name, int len,
> > >                 container_of(ctx, struct getdents_callback, ctx);
> > >
> > >         buf->sequence++;
> > > -       if (buf->ino =3D=3D ino && len <=3D NAME_MAX) {
> > > +       /* Ignore the '.' and '..' entries */
> > > +       if ((len > 2 || name[0] !=3D '.' || (len =3D=3D 2 && name[1] =
!=3D '.')) &&
> > > +           buf->ino =3D=3D ino && len <=3D NAME_MAX) {
> >
> >
> > Thank you for creating the helper, but if you already went to this trou=
ble,
> > I think it is better to introduce is_dot_dotdot() as a local helper alr=
eady
> > in this backportable patch, so that stable kernel code is same as upstr=
eam
> > code (good for future fixes) and then dedupe the local helper with the =
rest
> > of the local helpers in patch 2?
>
> There's now no Fixes: nor a Cc: stable on 1/2. You convinced me that
> 1/2 will not result in any external behavior change.
>
> The upshot is I do not expect 1/2 will be backported, unless I have
> grossly misread your emails.
>

It's not what I meant, but I don't want to bother you about this.

I meant patch 1 is backportable:
- adds static is_dot_dotdot() in expfs.c and uses it
- patch 2 the same as you posted, but also removes is_dot_dotdot() from exp=
fs.c

No big deal.
Patch 1, as far as I am concerned, patch 1 can stay as it is

Thanks,
Amir.

