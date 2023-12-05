Return-Path: <linux-fsdevel+bounces-4858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46E880505B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 11:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F96D1C20BAE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 10:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F55459E25
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHoLdny8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF2E129;
	Tue,  5 Dec 2023 01:03:47 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6cb74a527ceso3968702b3a.2;
        Tue, 05 Dec 2023 01:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701767027; x=1702371827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uuqJlk+qVY+Wc9oKYrd/mbxMA65gWD6hxqKNzb73E34=;
        b=ZHoLdny87t+SbDXrt8xRBvNs0QLvGeQcfHeKnO0fpqQBr6SEP2xvO0sg8NP83k6B40
         DeUiAMMPiRTRX9I8GoXoKjes9XtKEdOOMSWcR5rX+q6Sv2qvqT4yg56xAcZWTYXAec9q
         frE/JAnkyTBVKtFpM21qPMFKtM2h3tT0/R+TkPkscoKiSFRBCgOUj4ziDxXr3YCptieN
         CBiTvHe/mi0Sz1hAEBBCqXmeUWDmsXGM9u7x7Q7m1zD2kYP1uhPa0Dl4Hpf1bNMUqgu6
         2Xo10Wc4DFMaaJLKbpk0obZNz3V4z8eFbvM53LUfO4HYIyXSvwRNDT9uA8KNv9ek9p5M
         32Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701767027; x=1702371827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuqJlk+qVY+Wc9oKYrd/mbxMA65gWD6hxqKNzb73E34=;
        b=Gml0WoYQQsIQxjvF4poZVpHuKvo/nrApBGeveWHWNyVqACZzGSDyKeqHGfGgpLiip/
         7B1087ZG6LJ7aASCzlRpI/JJx3OuE3A96bzPkIBSma3OODcftiS/JtTVf9VGLPcG+ihs
         TT1LMZHk7ADNfzldK5/fsYN/Jnbb5EF+1BDhQJFPfctcGV10TEZISMbaVDE12YIvuE54
         O5j+umFITedf9TiOLDawaeUi6GEGOw6VaMV92n6o/ws23tchWOpVxFaVCvJCXIotnWw8
         1muLnUBOz91dD6uAwpvguXZUSK2YKKWeX2EatD2h3C+CJkTA7D5pnN/0N+WJVr525Rm5
         WX1Q==
X-Gm-Message-State: AOJu0YwTIvYuquxLZset6TNfcsu497B89vJwNmzRnK7zQutn4tbtf9tq
	81E4lWGyB+A9Ef1b+4XTa5lYHX06tgsxxQ==
X-Google-Smtp-Source: AGHT+IFSFXr5JF/D6v/iBfItZ1g0WlH2ln1ZAumoVYwdY/a/2VZMOLi15rZYioEPIbDnX9P0FXaoTg==
X-Received: by 2002:aa7:9816:0:b0:6cb:db73:a6db with SMTP id e22-20020aa79816000000b006cbdb73a6dbmr618971pfl.21.1701767026752;
        Tue, 05 Dec 2023 01:03:46 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id m18-20020a056a00081200b006ce64ebd2a0sm816505pfk.99.2023.12.05.01.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:03:45 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id B13FC1110115A; Tue,  5 Dec 2023 16:03:39 +0700 (WIB)
Date: Tue, 5 Dec 2023 16:03:39 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Seamus de Mora <seamusdemora@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Cc: Linux Manual Pages <linux-man@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
	Alejandro Colomar <alx@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>
Subject: Re: Add sub-topic on 'exFAT' in man mount
Message-ID: <ZW7nawirNIAAm_vL@archie.me>
References: <CAJ8C1XPdyVKuq=cL4CqOi2+ag-=tEbaC=0a3Zro9ZZU5Xw1cjw@mail.gmail.com>
 <ZVxUXZrlIaRJKghT@archie.me>
 <CAKYAXd_WFKXt1GqzFyfrJo6KHf6iaDwp-n3Qb1Hu63wokNhO9g@mail.gmail.com>
 <CAJ8C1XOzdscAUGCBh9Mbu9cm-oAqRA4mBoGjSFCxydJSCkzkUw@mail.gmail.com>
 <CAJ8C1XNThwLi-kxwkLfmecc0FETNNMdHKqWkBDYw4uSZdheuRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iAs65og+PAuB8jsg"
Content-Disposition: inline
In-Reply-To: <CAJ8C1XNThwLi-kxwkLfmecc0FETNNMdHKqWkBDYw4uSZdheuRA@mail.gmail.com>


--iAs65og+PAuB8jsg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 01:49:42AM -0600, Seamus de Mora wrote:
> On Mon, Nov 27, 2023 at 4:43=E2=80=AFPM Seamus de Mora <seamusdemora@gmai=
l.com> wrote:
> >
> > On Sun, Nov 26, 2023 at 5:59=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.=
org> wrote:
> > >
> > > 2023-11-21 15:55 GMT+09:00, Bagas Sanjaya <bagasdotme@gmail.com>:
> > > > On Mon, Nov 20, 2023 at 04:55:18PM -0600, Seamus de Mora wrote:
> > > >> I'd like to volunteer to add some information to the mount manual.
> > > >>
> > > >> I'm told that exFAT was added to the kernel about 4 years ago, but
> > > >> last I checked, there was nothing about it in man mount.  I feel t=
his
> > > >> could be addressed best by adding a sub-topic on exFAT under the t=
opic
> > > >> `FILESYSTEM-SPECIFIC MOUNT OPTIONS`.
> > > >>
> > > >> If my application is of interest, please let me know what steps I =
need
> > > >> to take - or how to approach this task.
> > > >>
> > > >
> > > > I'm adding from Alejandro's reply.
> > > >
> > > > You can start reading the source in fs/exfat in linux.git tree [1].
> > > > Then you can write the documentation for exfat in Documentation/exf=
at.rst
> > > > (currently doesn't exist yet), at the same time of your manpage
> > > > contribution.
> > > >
> > > > Cc'ing exfat maintainers for better treatment.
> > > Thanks Bagas for forwarding this to us!
> > >
> > > Hi Seamus,
> > >
> > > Some of mount options are same with fatfs's ones. You can refer the
> > > descriptions of fatfs
> > > documentation(Documentation/filesystems/vfat.rst).
> > > If you have any questions about other options or documentation for
> > > exfat, please give an email me.
> > >
> > > Thanks!
> > > >
> > > > Thanks.
> > > >
> > > > [1]:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/fs/exfat
> >
> > Thanks for the offer Namjae; I'm sure I'll take you up on that when I
> > get ready to actually produce something. For now, I am reading and
> > trying to get myself up to speed to tackle this. So far, the going has
> > been a bit slow as I have a couple of commitments I need to finish.
>=20
> I've read a bit about the mechanics & markup for creating/editing man
> pages. Now all I need is something useful to say :)
>=20
> In that regard, I **guess** the best place to look for the details I
> need is in the source code. Without access to the author or
> maintainers, I don't see how else to get at the details needed for a
> decent piece of documentation. I think that is what Bagas (?)
> suggested, but how/where do I find "fs/exfat in linux.git tree" ??

That's simple. First, you need to clone Linus's tree:

```
$ git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git linux-kernel
$ cd linux-kernel/
```

You can now browse exfat sources in fs/exfat.

To get maintainers list that you should Cc: when submitting patches, do
=66rom cloned repo:

```
$ scripts/get_maintainer.pl fs/exfat/
```

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--iAs65og+PAuB8jsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZW7nZwAKCRD2uYlJVVFO
o2WeAPwICH6Le2iaGKJqwS9x0swecz1+B29ctGML7PDWyOfwHwD9F46chB8S176E
baRpN2ILoEo/1qNQFSbQ7q/xiU3BRAQ=
=PqkT
-----END PGP SIGNATURE-----

--iAs65og+PAuB8jsg--

