Return-Path: <linux-fsdevel+bounces-62548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FB9B98FC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 10:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66233A72A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 08:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F202C327E;
	Wed, 24 Sep 2025 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kq3EnQsE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0E9DF49;
	Wed, 24 Sep 2025 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703985; cv=none; b=Uf4/bHe1J13aPDh1k/xFszU2Ug7oIVBc076Fib5iT2sCFWHkLup6rLvlVJJ8ETo5bUkmpPKpo/4rr/d88BeTUY4XP9x6ionA9dTohWvTm/VfjxKRNwfr8gsSJqrTpwqAktkE6euzOUwRlmJDLJF5jQZbG249J1n+cgX3zdKdOZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703985; c=relaxed/simple;
	bh=E6zulzZVYmkbKjQcXuz2AElMWJpbS2jzN2vn6lDDjec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGziGoKisyPdVSVJZqbUfxUVEqXNFxd9i8jdH8CznmdLyx1c1Iuu/i0f1cv2ircckj6rBC5Ri35a8jXAFu+H/0FxU8X/Q2ZALVAtHxxlMcAM69jj/LEah2KbOdPeS3eO9aKZrM8jXS4pPRv789riJo6tw2Ff/HJCYVWW85R42Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kq3EnQsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D35C113CF;
	Wed, 24 Sep 2025 08:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758703984;
	bh=E6zulzZVYmkbKjQcXuz2AElMWJpbS2jzN2vn6lDDjec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kq3EnQsERpwcKloItJUo75aeetvZ4zYU7Oh6StYoNsi8L3C5W4Koic3xqdgepj5/9
	 PgF9uqcu6UkDN1GQ7x4CV3ec56DrjQjEtZo5hFqfFsBNHrCC2ch4YjqXGxZa7uYBWK
	 PhPGm8LmsPvhbkkBh2+r6thexlDFOJ5D1Ll0SKM8s46psdtTn5Uir/kwrIarXymfgu
	 lOxmZGgt0k+265h9gBCpTiA8+xLIcX6qG77YK3bYby436L2qd6gikBE9C627+m2wzC
	 WW+7DIdJG+D0W6eeeSJqaBeMkPP0GrgZncjaJFBR86y1dzF+5Dr3AvWs0LhAJPWPXc
	 KXEB7nc3B7N2w==
Date: Wed, 24 Sep 2025 10:52:57 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 04/10] man/man2/fsconfig.2: document "new" mount API
Message-ID: <rvnb5wxpu2emzbs7iprqzxqom4yioguxsiyl4gfxcyr6hjfs3v@kqrfrrfsoa7s>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-4-1261201ab562@cyphar.com>
 <e4jtqbymqguq64zup5qr6rnppwjyveqdzvqdbnz3c7v55zplbs@6bpdfbv6sh7d>
 <2025-09-24-sterile-elderly-drone-sum-LHA7Fs@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wuex7qtg3b57oloz"
Content-Disposition: inline
In-Reply-To: <2025-09-24-sterile-elderly-drone-sum-LHA7Fs@cyphar.com>


--wuex7qtg3b57oloz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 04/10] man/man2/fsconfig.2: document "new" mount API
Message-ID: <rvnb5wxpu2emzbs7iprqzxqom4yioguxsiyl4gfxcyr6hjfs3v@kqrfrrfsoa7s>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-4-1261201ab562@cyphar.com>
 <e4jtqbymqguq64zup5qr6rnppwjyveqdzvqdbnz3c7v55zplbs@6bpdfbv6sh7d>
 <2025-09-24-sterile-elderly-drone-sum-LHA7Fs@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <2025-09-24-sterile-elderly-drone-sum-LHA7Fs@cyphar.com>

Hi Aleksa,

On Wed, Sep 24, 2025 at 04:41:16PM +1000, Aleksa Sarai wrote:
> On 2025-09-21, Alejandro Colomar <alx@kernel.org> wrote:
> > On Fri, Sep 19, 2025 at 11:59:45AM +1000, Aleksa Sarai wrote:
> > > +The list of valid
> > > +.I cmd
> > > +values are:
> >=20
> > I think I would have this page split into one page per command.
> >=20
> > I would keep an overview in this page, of the main system call, and the
> > descriptions of each subcommand would go into each separate page.
> >=20
> > You could have a look at fcntl(2), which has been the most recent page
> > split, and let me know what you think.
>=20
> To be honest, I think this makes the page less useful to most readers.
>=20
> I get that you want to try to improve the "wall of text" problem but as
> a very regular reader of man-pages, I find indirections annoying every
> time I have to do deal with them. Maybe there is an argument for
> fcntl(2) to undergo this treatment (as it has a menagerie of disparate
> commands) but this applies even less to fsconfig(2) in my view.
>=20
> If you feel strongly that fsconfig(2) needs this treatment, it would
> probably be better for you to do it instead. In particular, I would've
> expected to only have two extra pages if we went that route (one for
> FSCONFIG_SET_* commands and one for FSCONFIG_CMD_* commands) so I'm not
> quite sure what you'd like the copy to look like for 10 man-pages...

Okay, let's keep it as a single page for now.


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--wuex7qtg3b57oloz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjTsWkACgkQ64mZXMKQ
wqlFeQ//cy2MCwmXluXXdK1X4kpuKpgRfVUpH5H5qraqVKVY9UOELUGSAe5KMSU8
cj8s5Pg7979lgXPcaAG1k5+cTIESWj4D78DIOQE1/f28Rp5tZa69YxqcNtvY9gAM
UkNxghxzeu0iPMna3di90bfiepu9IBqrduHUDRcwOkQKPaYN1YngIBJXJivq2mLv
q3JhPpmhx9LY4BtMs/wO4ycdy4umbeB6rZ2OriUlGZDh6jeYLfuJwxbjTFFIG1i+
7eWcm/ZEeTZU2trzXV6hUkwuxGkW08EqvaWTOvY/QjcZDJtwQ+WwGGtDE2VApCcb
tIEbywnJJLGkqMGu7ljSRZW9ns5qTRQPwYJyouoArIj6pHQ3nEOVe7+maB3ZpDPI
v8N4lu6CHbWdpdxh+2WCFTLNUVdN13Ppo7KUmBYp8jiXD+Cph1MBWeBh51eE7jdc
wDH5ceZ89PnIfI/Mi/vmwl51Z1AEsrvNuXAoMCjcP4+j3Mqi0ornnTbKg165l9T1
72ndSideCquiuZdDKtOLau4CgmnlFYGxL1k40mPW3aKqn1b55hNWtwzAs9HcNpo3
5CzFKeMjis1Olekcu4e3Er05wv64vpyjeDU0KJdta5qNiMtz9ktADPteTgjAEb2X
1ZW28V8toGcdZqJy8Ylz3EIoi/Jl6fqk3yZrv4h7MrUuXXPHqEg=
=tW1A
-----END PGP SIGNATURE-----

--wuex7qtg3b57oloz--

