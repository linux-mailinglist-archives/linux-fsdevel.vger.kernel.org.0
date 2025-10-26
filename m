Return-Path: <linux-fsdevel+bounces-65642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B2FC0AEB1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 18:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72911189AEA2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 17:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10792DF128;
	Sun, 26 Oct 2025 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7dR/cFS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1F8205E26;
	Sun, 26 Oct 2025 17:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761499661; cv=none; b=X4NYPc1dBGk0e4o13C/SIl5qsMLkYyf7Fi17nLbLuHaaciy0zC/BVC0FVuCxaMkdw81CmU2NGv82vNMtc9jfzlVdCUbfu4Loj9SQoG/I9Cy0RhvQcuuYhvlMB0v35R95Er6MfGqzPvxmYNyBhF3tIUz+c+SVIdpMsREwADtr8Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761499661; c=relaxed/simple;
	bh=ojMKD630vCvaxyVc4ANcWJgQ82Xcn/ry9tixOPvqfaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDwBHHKXNEf1sNm/K5CyN9XVEoSFf7zMLXUJY1jQjqaMNiBr+5wdqdPbge1nAFVbrLOGLMDsuIu3RF7+kAvo+M+dLE+aE/s7RCySa4NBMDmqa0ruBvKC8HvO8UccQSguxps1NvTtFaYoGBO+e48cxZW93rBezZXwpvlNUcDfppg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7dR/cFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB12DC4CEE7;
	Sun, 26 Oct 2025 17:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761499660;
	bh=ojMKD630vCvaxyVc4ANcWJgQ82Xcn/ry9tixOPvqfaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D7dR/cFSC4iWlihjR6+jdiVgcLq9yPP0qHXB3fogNjF5KJEIjLjeGUuHIFVvdHqeZ
	 hq6yb7g9VDWed7505L3Hzgb9/JtA074FSBkexLXLYQu4aD/ntNAAatt6uiJUyWyS1w
	 QQCx8gYod0ga67iXjRse8C4yQDL4E0xTaRW2CHNj+8UJ/yPG3dkSoLcmUMGdZwit+U
	 6DfeUXf5YrmJ04JKBiwRB4JlqCVRdnni9hxDQap+wyLEiKSKAxqTQHNZO8PYRjtA4O
	 MXS7zh9NWqkK3n7ZLYWW+pvba4ua5eEnYNzenS8dXrFavp54mXFXhkR5fQ/soZ1a/d
	 9T5RNNAmB95Zg==
Date: Sun, 26 Oct 2025 18:27:32 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Askar Safin <safinaskar@gmail.com>
Cc: brauner@kernel.org, cyphar@cyphar.com, dhowells@redhat.com, 
	g.branden.robinson@gmail.com, jack@suse.cz, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-man@vger.kernel.org, 
	mtk.manpages@gmail.com, safinaskar@zohomail.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 0/8] man2: document "new" mount API
Message-ID: <tfy2f45ah23b65gdlitiaffwy6nltevmo3z2akwnc3nbpkfh6w@ihzheoumkysn>
References: <hk5kr2fbrpalyggobuz3zpqeekzqv7qlhfh6sjfifb6p5n5bjs@gjowkgi776ey>
 <20251026122742.960661-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u7izvt4jolxhgk5l"
Content-Disposition: inline
In-Reply-To: <20251026122742.960661-1-safinaskar@gmail.com>


--u7izvt4jolxhgk5l
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Askar Safin <safinaskar@gmail.com>
Cc: brauner@kernel.org, cyphar@cyphar.com, dhowells@redhat.com, 
	g.branden.robinson@gmail.com, jack@suse.cz, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-man@vger.kernel.org, 
	mtk.manpages@gmail.com, safinaskar@zohomail.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 0/8] man2: document "new" mount API
Message-ID: <tfy2f45ah23b65gdlitiaffwy6nltevmo3z2akwnc3nbpkfh6w@ihzheoumkysn>
References: <hk5kr2fbrpalyggobuz3zpqeekzqv7qlhfh6sjfifb6p5n5bjs@gjowkgi776ey>
 <20251026122742.960661-1-safinaskar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20251026122742.960661-1-safinaskar@gmail.com>

Hi Askar,

On Sun, Oct 26, 2025 at 03:27:42PM +0300, Askar Safin wrote:
> Alejandro Colomar <alx@kernel.org>:
> > The full patch set has been merged now.  I've done a merge commit where
>=20
> Alejandro, I still don't see manpages for "new" mount API here:
> https://man7.org/linux/man-pages/dir_section_2.html

<man7.org> is not official.  It's Michael Kerrisk's (previous
maintainer) website.  He usually publishes new pages shortly-ish after
each new release, and I haven't issued a new release yet.

I have plans to release soon-ish, but have internet issues at home (the
cable in the street is broken, so I'm connecting on cell internet from
the laptop).  Hopefully, I'll be able to release this month.


Have a lovely day!
Alex

>=20
> Please, publish.
>=20
> --=20
> Askar Safin
>=20

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--u7izvt4jolxhgk5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmj+WgQACgkQ64mZXMKQ
wqkeVxAAhVvnync+BnWREmvpRHx2InmUvxBQFNSS8P4y7gFTW6KFP25hSxhNrg40
i4GhHEBpu9Ub0NCdNlgW83bKhy6U11w/eCgfxx3rSmbucn6e+aC8smgiv5tpI3CV
sD7/0GNsTIgwQyDC1OSewjah49Dx9jCBdR0ncOWrS10Ya2WieXJ+1teyfLpw5a7l
PfRTiREwMsIWGuPvVXbpnzSUWGXvi9Mq5NQ1u1XVcxbAlCQ74Tra4ZpBUpjZ0Gn9
pxgAnJ/PWIYq18Atem/7zT8i52dOHO8TYL/d1b5i7xXQn5GlcqgceESkpet8Zxv0
+Y9jPDRTJxXbYfVEd1593KZ1gy+ucQBU2KCmPw2ql4++4ETKnl3mlOHosydfVrTV
hakjNGhQSU0lW8oKNeTa/13dNiDpe+NbGlDFTiFEdlvPQWX/17OLLiJ7MDYTzvgb
R5x6fHjesq2dbMD2XRSZ+dMj6yAndnl+kXEsQgneSPvrcrxje+6Mc0Wt9uDnvKPG
Yr/+IDSWQZh0QpNwXC+8h/PRrGPl/T3NWwPHeyHPVKNZIBRGQU3As6hpOhxF3MLH
XomgOw5wwg+G5NjTmYWobxX4NtxpBosyITGeeYTz0Er+1GXowRjpya9xin9Ba9AL
fH9lTpYFHsnHGrocVyMaJVzYPaokjnI0jm7IKiHDl+vh945nHWo=
=Dmul
-----END PGP SIGNATURE-----

--u7izvt4jolxhgk5l--

