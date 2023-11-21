Return-Path: <linux-fsdevel+bounces-3332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED9A7F363D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 19:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23A71B20C45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 18:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E342209C;
	Tue, 21 Nov 2023 18:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlWtaPuY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359B1110
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 10:40:08 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41b7ec4cceeso33370091cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 10:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700592007; x=1701196807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+np6dLyahHAcJ+VXunq38EwRwNFUCW1lBrSh0KCvvU=;
        b=NlWtaPuYfGgq72QferuXBtLf0gBm34tESYRWkpZJFJlbK34HIuY0qWsKo27vVmyfO6
         9KgUxad/TfI5dTsitnJmrNri6JMvl/Y2+YFwY2NEf5ItOzfjuYCXnc2laJDcQwJlGGrO
         MaT0hC3Xy7XvN6kcAGQecZF00q9RdAD+nd18z4sHydK9zuvnzJzhbX1+ZAojFIKsP2kf
         n5PWqTGP3cfAv/VMiI8m6BLb13gAgA8r3bZmXITED9tZIl4nhnX2oV8+APF453zWRsVi
         x/nOxmUqGH11wsjy4LGDRvCmDQeOwMRR1F/Mv8IXlKWAd6kXPyzps2VzwvFnGEu2D1v3
         cyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700592007; x=1701196807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+np6dLyahHAcJ+VXunq38EwRwNFUCW1lBrSh0KCvvU=;
        b=jBxN0G/NYw6P3jVdzucGC1pXvUR2LdwdH4EZz5IIRkMRxWJ5gNFjD8vQ5Frtwzrsra
         M2qJMZa0FOe7mm70P32GApgRPVER06NTPbttc0DQjd91ENFD4KLKreIgzJOl26MmDE39
         eZV/ADBNxaxrdoEmNRiOU3XPZQEozoec9eB5raupH50z21BpAjP0MxX2ameM3QUM4Bix
         sqIz+z9s0itmI7HX9S7cPtPcyaDSE6l3wQ6ZIlJCCfXuQSgUakzWH3IairIBWcG62UIS
         MHtq8HQv54FjOY21e7gDgUwHkT5yV1KnxkSadUyErJbBrxkQHExjsIrmF0hWMphBvx4I
         wpsg==
X-Gm-Message-State: AOJu0YwHm2fJ2LAMihhTtNT62KBjV1twf0u/rHiZF+DUbVI2f5cUCpmt
	KsXQ1H+3M+vzwEgtTmXyLg3oHliUOdzkSB8PTeY=
X-Google-Smtp-Source: AGHT+IFdeuwBCxycDfDUnQxsgSwD77TuEUH+nQrPYo3og3DMbyUua+hozBUAdGW7lcLTGCPF+ZeHb0LNfIb+P9NLwVs=
X-Received: by 2002:ac8:5d0f:0:b0:41e:29ac:1300 with SMTP id
 f15-20020ac85d0f000000b0041e29ac1300mr14643719qtx.27.1700592007248; Tue, 21
 Nov 2023 10:40:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114153321.1716028-1-amir73il@gmail.com> <20231114153321.1716028-8-amir73il@gmail.com>
 <20231121-datum-computer-93e188fe5469@brauner>
In-Reply-To: <20231121-datum-computer-93e188fe5469@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Nov 2023 20:39:55 +0200
Message-ID: <CAOQ4uxhBOstK5gyX_T6d8RnQa1CBtDsnG0CMUbAuinqYmA-arg@mail.gmail.com>
Subject: Re: [PATCH 07/15] remap_range: move file_start_write() to after
 permission hook
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 5:10=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Nov 14, 2023 at 05:33:13PM +0200, Amir Goldstein wrote:
> > In vfs code, file_start_write() is usually called after the permission
> > hook in rw_verify_area().  vfs_dedupe_file_range_one() is an exception
> > to this rule.
> >
> > In vfs_dedupe_file_range_one(), move file_start_write() to after the
> > the rw_verify_area() checks to make them "start-write-safe".
> >
> > This is needed for fanotify "pre content" events.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/remap_range.c | 32 +++++++++++++-------------------
> >  1 file changed, 13 insertions(+), 19 deletions(-)
> >
> > diff --git a/fs/remap_range.c b/fs/remap_range.c
> > index 42f79cb2b1b1..de4b09d0ba1d 100644
> > --- a/fs/remap_range.c
> > +++ b/fs/remap_range.c
> > @@ -445,46 +445,40 @@ loff_t vfs_dedupe_file_range_one(struct file *src=
_file, loff_t src_pos,
> >       WARN_ON_ONCE(remap_flags & ~(REMAP_FILE_DEDUP |
> >                                    REMAP_FILE_CAN_SHORTEN));
> >
> > -     ret =3D mnt_want_write_file(dst_file);
> > -     if (ret)
> > -             return ret;
> > -
> >       /*
> >        * This is redundant if called from vfs_dedupe_file_range(), but =
other
> >        * callers need it and it's not performance sesitive...
> >        */
> >       ret =3D remap_verify_area(src_file, src_pos, len, false);
> >       if (ret)
> > -             goto out_drop_write;
> > +             return ret;
> >
> >       ret =3D remap_verify_area(dst_file, dst_pos, len, true);
> >       if (ret)
> > -             goto out_drop_write;
> > +             return ret;
> >
> > -     ret =3D -EPERM;
> >       if (!allow_file_dedupe(dst_file))
> > -             goto out_drop_write;
> > +             return -EPERM;
>
> So that check specifically should come after mnt_want_write_file()
> because it calls inode_permission() which takes the mount's idmapping
> into account. And before you hold mnt_want_write_file() the idmapping of
> the mount can still change. Once you've gotten write access though we
> tell the anyone trying to change the mount's write-relevant properties
> to go away.
>
> With your changes that check might succeed now but fail later. So please
> move that check below mnt_want_write_file(). That shouldn't be a
> problem.
>

Right. Good catch!

Thanks,
Amir.

