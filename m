Return-Path: <linux-fsdevel+bounces-5376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E89FA80AE7A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 22:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC5F1F2150E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 21:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F09157304;
	Fri,  8 Dec 2023 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3ylv2gq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44E1BD
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 13:02:47 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-67ad032559fso13706906d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Dec 2023 13:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702069367; x=1702674167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gmu7Whm+M872lG9n9kNHf3H6hdB3DhfCYuxiMiYMkFE=;
        b=g3ylv2gq8l3m57jy9WtFr+oF9Qb3JFmxrHqx/g2boUDlwPCGiySUopDqKV1tEGOzDc
         GKf5bVJ7E+rhIKjzqHgD8yA4r2M9VgV4eqKM48oCvPvd8zd3zkNrggmn7MXJVKTHB3ZY
         +4B6Bo9hfnxekXkJRaZQ7z9cQk9g8I/GEdqs169fYeQ2p73way7dGcvTOmGFGEYfeq/h
         2ZtmwX1NMGhSysFEVgBE/26cnhN4GkNSU32RiArtwVXT27yGl1A+c+soryRqRlyGDHz5
         diZYs0X3ro8S1EaTTFuM4H9LgngSblxduHN3S8aPkz5jrKiw3D5vrnt75vW+sPeyI9+i
         HfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069367; x=1702674167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gmu7Whm+M872lG9n9kNHf3H6hdB3DhfCYuxiMiYMkFE=;
        b=AnNv9j2yfcNwgxc5CPH8bj0226hc6RCK9EbMgq63dk/a+uRpJ0vNhd2P1jm0DGH9sh
         Q93samyC3V0Tpb427Sz2KSbayaEggFA+FY9uw7PdRwkRzmOw8nBeQmexgOYvBxh9ht21
         c3THBrWv2DyQ4MPNTLc8ursWfP/fnmnf8SgSVt3254mAAouxM0L758rrR4/Ewm0384C1
         ec7g2BalEVVdivYlXHnAsgoRr6n8nyWNN4gf7+UnXROmPR+dhBgvgoXPocm+GwVkmc+J
         23SSQj6Gx3g2OtDtcvDJ9Pcd3e0y/pKbynR7Xvxy1TZYpmkxG/FR+tFe4yLwPLotoP0J
         w6cA==
X-Gm-Message-State: AOJu0Yy5ib2TLGCkyJQ4FFshdMycbPKO3ih72V78hubQFrOrLfzfjTyu
	ZSwvH8zeD5sxalYz0KTHFSj6r8gzZAxy0KVu5BU=
X-Google-Smtp-Source: AGHT+IEm7vBjijLWz/RA2LZZf709QTEg6x/wZUcE/3JO0aVJfn6+Z/szStG8Cq2Qpic5XAxqvAjg7AMJ+CoLEcdokS4=
X-Received: by 2002:a0c:cd83:0:b0:67a:6472:d693 with SMTP id
 v3-20020a0ccd83000000b0067a6472d693mr623513qvm.32.1702069366833; Fri, 08 Dec
 2023 13:02:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207123825.4011620-1-amir73il@gmail.com> <20231207123825.4011620-4-amir73il@gmail.com>
 <20231208184608.n5fcrkj3peancy3u@quack3>
In-Reply-To: <20231208184608.n5fcrkj3peancy3u@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 8 Dec 2023 23:02:35 +0200
Message-ID: <CAOQ4uxgHNBSBenADnMkqZWmb3t2qzfhG-E722-0KJ=Cwzf2UYw@mail.gmail.com>
Subject: Re: [PATCH 3/4] fsnotify: assert that file_start_write() is not held
 in permission hooks
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, David Howells <dhowells@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 8:46=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 07-12-23 14:38:24, Amir Goldstein wrote:
> > filesystem may be modified in the context of fanotify permission events
> > (e.g. by HSM service), so assert that sb freeze protection is not held.
> >
> > If the assertion fails, then the following deadlock would be possible:
> >
> > CPU0                          CPU1                    CPU2
> > -----------------------------------------------------------------------=
--
> > file_start_write()#0
> > ...
> >   fsnotify_perm()
> >     fanotify_get_response() =3D>        (read event and fill file)
> >                               ...
> >                               ...                     freeze_super()
> >                               ...                       sb_wait_write()
> >                               ...
> >                               vfs_write()
> >                                 file_start_write()#1
> >
> > This example demonstrates a use case of an hierarchical storage managem=
ent
> > (HSM) service that uses fanotify permission events to fill the content =
of
> > a file before access, while a 3rd process starts fsfreeze.
> >
> > This creates a circular dependeny:
> >   file_start_write()#0 =3D> fanotify_get_response =3D>
> >     file_start_write()#1 =3D>
> >       sb_wait_write() =3D>
> >         file_end_write()#0
> >
> > Where file_end_write()#0 can never be called and none of the threads ca=
n
> > make progress.
> >
> > The assertion is checked for both MAY_READ and MAY_WRITE permission
> > hooks in preparation for a pre-modify permission event.
> >
> > The assertion is not checked for an open permission event, because
> > do_open() takes mnt_want_write() in O_TRUNC case, meaning that it is no=
t
> > safe to write to filesystem in the content of an open permission event.
>                                      ^^^^^ context
>
> BTW, isn't this a bit inconvenient? I mean filling file contents on open
> looks quite natural... Do you plan to fill files only on individual read =
/
> write events? I was under the impression simple HSM handlers would be doi=
ng
> it on open.
>

Naive HSMs perhaps... The problem with filling on open is that the pattern
open();fstat();close() is quite common with applications and we found open(=
)
to be a sub-optimal predicate for near future read().

Filling the file on first read() access or directory on first
readdir() access does
a better job in "swapping in" the correct files.
A simple HSM would just fill the entire file/dir on the first PRE_ACCESS ev=
ent.
that's not any more or less simple than filling it on an OPEN_PERM event.

Another point that could get lost when reading to above deadlock is that
filling the file content before open(O_TRUNC) would be really dumb,
because swap in is costly and you are going to throw away the data.
If we really wanted to provide HSM with a safe way to fill files on open,
we would probably need to report the open flags with the open event.
I actually think that reporting the open flags would be nice even with
an async open event.

Thanks,
Amir.

