Return-Path: <linux-fsdevel+bounces-22191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25127913739
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 03:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D579D2830C9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 01:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F486FB0;
	Sun, 23 Jun 2024 01:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="P/uiCNBi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E141653;
	Sun, 23 Jun 2024 01:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719105740; cv=none; b=iDkRuvNqeJTbOV51Olk9z4mcXdblwLkp3UWu38YtUFm2MOGgHNCEB6KK4+Dvlk9Vvo3yjdgATKRPnmUP35tzS6ykogdUUW843YE1HlDJKLvQOJ0Lyrv8HfbExJpQ9VVQs3l6en1fH2RhIPr+sfppR3uHDMTVkol2FnfbNP/D4Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719105740; c=relaxed/simple;
	bh=zJrCU0HMltCUz/Z9hg1i/O0kuqVa0crvZfJ+FwzyTvc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nt/m7mS11VrgTGG4TTIWxETS4Ay9/SrpGhpPJt5wF0lvIW3BLrU/w+y35Wxg3YaCJsLLzxA/lOZ0VuGVwe4fpybg9i4mX+SMqQLcls7Bd9RKbHuxJJVW1vuW9KBuco4Kyn2fEXEPDs/2UcwQpn9WtIuLrT7qfM+QbJxMDPhOmKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=P/uiCNBi; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1719105736;
	bh=zJrCU0HMltCUz/Z9hg1i/O0kuqVa0crvZfJ+FwzyTvc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=P/uiCNBi6YzryE+9xTnBKptRIEphr8teb84fMs4WQ28aBLNd97EZVVGWWyTxT90bz
	 SNwu7ZkSZroOZ+S7q7QAs6xYsw35VevULWKC+1yDJ4NVhHr469iK+ygdME8GdrPzJT
	 CAdrf0c0MiqmlvZ2cRvrL+CbDGFXwnbxwKFozgNw=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 05AC6677E3;
	Sat, 22 Jun 2024 21:22:13 -0400 (EDT)
Message-ID: <9d1512b57683a68a7176ae8221562657fb0231a3.camel@xry111.site>
Subject: Re: [PATCH] vfs: Add AT_EMPTY_PATH_NOCHECK as unchecked
 AT_EMPTY_PATH
From: Xi Ruoyao <xry111@xry111.site>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner
	 <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara
	 <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	 <mhiramat@kernel.org>, Alejandro Colomar <alx@kernel.org>, Arnd Bergmann
	 <arnd@arndb.de>, Huacai Chen <chenhuacai@loongson.cn>, Xuerui Wang
	 <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Icenowy Zheng
	 <uwu@icenowy.me>, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Sun, 23 Jun 2024 09:22:12 +0800
In-Reply-To: <CAGudoHFofUZ0Nb9UtV=Q3uQ0K+JnBHPrgLxNYuj7nSLF-=ue8g@mail.gmail.com>
References: <20240622105621.7922-1-xry111@xry111.site>
	 <kslf3yc7wnwhxzv5cejaqf52bdr6yxqaqphtjl7d4iaph23y6v@ssyq7vrdwx56>
	 <CAHk-=wgj6h97Ro6oQcOq5YTG0JcKRLN0CtXgYCW_Ci6OSzL5NA@mail.gmail.com>
	 <eeb7e9895aca92fa5a8d11d9f37b283428185278.camel@xry111.site>
	 <CAGudoHFofUZ0Nb9UtV=Q3uQ0K+JnBHPrgLxNYuj7nSLF-=ue8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-06-23 at 03:07 +0200, Mateusz Guzik wrote:
> On Sun, Jun 23, 2024 at 2:59=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> wr=
ote:
> >=20
> > On Sat, 2024-06-22 at 15:41 -0700, Linus Torvalds wrote:
> >=20
> > > I do think that we should make AT_EMPTY_PATH with a NULL path
> > > "JustWork(tm)", because the stupid "look if the pathname is empty" is
> > > horrible.
> > >=20
> > > But moving that check into getname() is *NOT* the right answer,
> > > because by the time you get to getname(), you have already lost.
> >=20
> > Oops.=C2=A0 I'll try to get around of getname() too...
> >=20
> > > So the short-cut in vfs_fstatat() to never get a pathname is
> > > disgusting - people should have used 'fstat()' - but it's _important_
> > > disgusting.
> >=20
> > The problem is we don't have fstat() for LoongArch, and it'll be
> > unusable on all 32-bit arch after 2037.
> >=20
> > And Arnd hates the idea adding fstat() for LoongArch because there woul=
d
> > be one more 32-bit arch broken in 2037.
> >=20
> > Or should we just add something like "fstat_2037()"?
> >=20
>=20
> In that case fstat is out of the question, but no problem.
>=20
> It was suggested to make AT_EMPTY_PATH + NULL pathname do the right
> thing and have the syscalls short-circuit as needed.
>=20
> for statx it would look like this (except you are going to have
> implement do_statx_by_fd):
>=20
> diff --git a/fs/stat.c b/fs/stat.c
> index 16aa1f5ceec4..0afe72b320cc 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -710,6 +710,9 @@ SYSCALL_DEFINE5(statx,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct filename *name;
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (flags =3D=3D AT_EMPTY_PATH && f=
ilename =3D=3D NULL)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return do_statx_by_fd(...);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D getname_flags(filenam=
e, getname_statx_lookup_flags(flags));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D do_statx(dfd, name, fl=
ags, mask, buffer);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 putname(name);
>=20
> and so on
>=20
> Personally I would prefer if fstatx was added instead, fwiw most
> massaging in the area will be the same regardless.

I do agree.  But if we do it *now* would it be "breaking the userspace"
if some stupid program relies on fstatx() to return some error when the
path is NULL?  The "stupid programs" may just exist in the wild...

I remember recently we have to pretend pidfd is stupid to please some
stupid programs...

https://lore.kernel.org/all/20240521-girlanden-zehnfach-1bff7eb9218c@braune=
r/

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

