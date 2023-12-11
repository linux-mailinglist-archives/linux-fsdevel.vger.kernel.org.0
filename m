Return-Path: <linux-fsdevel+bounces-5462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B805B80C775
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 11:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D20F2B20FAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 10:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAC42D622;
	Mon, 11 Dec 2023 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9th9gm8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40D5D6
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 02:57:29 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-dbc55ebb312so2284732276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 02:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702292249; x=1702897049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exFdgcqF12XHKKKq7lDY5P3ELj5EUdVdPg/Brad9x3U=;
        b=G9th9gm8u/OIBLgA+ekAMT/9mJa18/6wfWzEbyKN58gbeJDhccFvTjGvQkocK4QVgw
         OwG6Jzr4tl5zWbSGsgr3s9fdF8ePMH5SOaZnvQFNV432OxIuUdKrLJxr+EDWv4yFhPp4
         M9aEO1NqMjxS6a2R+7NZ7YV8preLViL2+XxNCVupI7poqEEmWFKrz74ajws9tnG8nwFB
         HlL1AMnsehDdmbzAE86usJyXweY8VB8p5nL6MjJQMKyHqppK8wtKPmXVvm81KfQxxs+Q
         e0kb6+JIdRWWyzNF6YHpSJSJkdKud8jRvh/pks7WgFyBkz0kRcYR5ZqteQY6coqC7DA1
         VXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702292249; x=1702897049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exFdgcqF12XHKKKq7lDY5P3ELj5EUdVdPg/Brad9x3U=;
        b=hlSbMfxmvwt5qgocpvghApHDAqw3U23itrR8PmSRlZWqQQVeTADEGpj5PJNZMNi/Aa
         I2OKtu2TMhR/M/i3yes6L2dHeA7jGcuGwIFNykje8DMETPsEbea6iqb6F+nlr/YYN4Tc
         zRjs7bAzuRrjhsXBkYyK3WF4g1NDDEQfeuBZ8Fi/v9R58ybRFq6RBS9R2LBb3uZgkGsu
         UtEVPD9RCBvNCZ38BhuykcZpt0GDBg1YnmxJ8/3m4L6eA4n18txF/8hOophWelOlFXdU
         t7yQUrnNoSKZGAPF80BQdeJpp2zK/Wc8dF/Q0kJ10luoA4kEVEizyvQregnSRLkJwKaC
         mLCg==
X-Gm-Message-State: AOJu0YzgqVK9I7Z1Rp1W7o5BKxdMDhh0DDm+N/TllkdalwaEEo5A5IPN
	JLCsOdlq+y4Jw7sb8hZf014M+UPufw514tWqJ2pO9GJ5NgM=
X-Google-Smtp-Source: AGHT+IGnE7UfcCu2h6cK4aR3Ol4lcBxlaSx4rnxNhuOixsGNSdqQxC3cV+6P6Kc8RB4bP91zNboEYPBunUXrcj028vI=
X-Received: by 2002:a25:9290:0:b0:db7:dacf:621c with SMTP id
 y16-20020a259290000000b00db7dacf621cmr2254410ybl.110.1702292249050; Mon, 11
 Dec 2023 02:57:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207123825.4011620-1-amir73il@gmail.com> <20231207123825.4011620-4-amir73il@gmail.com>
 <20231208184608.n5fcrkj3peancy3u@quack3> <CAOQ4uxgHNBSBenADnMkqZWmb3t2qzfhG-E722-0KJ=Cwzf2UYw@mail.gmail.com>
 <20231211103033.v52qhc5h7o36fym3@quack3>
In-Reply-To: <20231211103033.v52qhc5h7o36fym3@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 11 Dec 2023 12:57:17 +0200
Message-ID: <CAOQ4uxi-KCZChkN9FbXeGupuCUJ6OEd++n1H2zbCaP4TXpv4+g@mail.gmail.com>
Subject: Re: [PATCH 3/4] fsnotify: assert that file_start_write() is not held
 in permission hooks
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, David Howells <dhowells@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 12:30=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 08-12-23 23:02:35, Amir Goldstein wrote:
> > On Fri, Dec 8, 2023 at 8:46=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Thu 07-12-23 14:38:24, Amir Goldstein wrote:
> > > > filesystem may be modified in the context of fanotify permission ev=
ents
> > > > (e.g. by HSM service), so assert that sb freeze protection is not h=
eld.
> > > >
> > > > If the assertion fails, then the following deadlock would be possib=
le:
> > > >
> > > > CPU0                          CPU1                    CPU2
> > > > -------------------------------------------------------------------=
------
> > > > file_start_write()#0
> > > > ...
> > > >   fsnotify_perm()
> > > >     fanotify_get_response() =3D>        (read event and fill file)
> > > >                               ...
> > > >                               ...                     freeze_super(=
)
> > > >                               ...                       sb_wait_wri=
te()
> > > >                               ...
> > > >                               vfs_write()
> > > >                                 file_start_write()#1
> > > >
> > > > This example demonstrates a use case of an hierarchical storage man=
agement
> > > > (HSM) service that uses fanotify permission events to fill the cont=
ent of
> > > > a file before access, while a 3rd process starts fsfreeze.
> > > >
> > > > This creates a circular dependeny:
> > > >   file_start_write()#0 =3D> fanotify_get_response =3D>
> > > >     file_start_write()#1 =3D>
> > > >       sb_wait_write() =3D>
> > > >         file_end_write()#0
> > > >
> > > > Where file_end_write()#0 can never be called and none of the thread=
s can
> > > > make progress.
> > > >
> > > > The assertion is checked for both MAY_READ and MAY_WRITE permission
> > > > hooks in preparation for a pre-modify permission event.
> > > >
> > > > The assertion is not checked for an open permission event, because
> > > > do_open() takes mnt_want_write() in O_TRUNC case, meaning that it i=
s not
> > > > safe to write to filesystem in the content of an open permission ev=
ent.
> > >                                      ^^^^^ context
> > >
> > > BTW, isn't this a bit inconvenient? I mean filling file contents on o=
pen
> > > looks quite natural... Do you plan to fill files only on individual r=
ead /
> > > write events? I was under the impression simple HSM handlers would be=
 doing
> > > it on open.
> > >
> >
> > Naive HSMs perhaps... The problem with filling on open is that the patt=
ern
> > open();fstat();close() is quite common with applications and we found o=
pen()
> > to be a sub-optimal predicate for near future read().
> >
> > Filling the file on first read() access or directory on first
> > readdir() access does
> > a better job in "swapping in" the correct files.
> > A simple HSM would just fill the entire file/dir on the first PRE_ACCES=
S event.
> > that's not any more or less simple than filling it on an OPEN_PERM even=
t.
> >
> > Another point that could get lost when reading to above deadlock is tha=
t
> > filling the file content before open(O_TRUNC) would be really dumb,
> > because swap in is costly and you are going to throw away the data.
> > If we really wanted to provide HSM with a safe way to fill files on ope=
n,
> > we would probably need to report the open flags with the open event.
> > I actually think that reporting the open flags would be nice even with
> > an async open event.
>
> OK, thanks for explanation!

Anyway, I will try to find a solution also for the OPEN_PERM deadlock.
I have some sketches, but ->atomic_open() complicates things...

Thanks,
Amir.

