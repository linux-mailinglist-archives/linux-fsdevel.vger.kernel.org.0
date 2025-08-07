Return-Path: <linux-fsdevel+bounces-56992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EA3B1D941
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 15:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3D116E537
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 13:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5680E214813;
	Thu,  7 Aug 2025 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEWLYMxH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB122242D84;
	Thu,  7 Aug 2025 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754574168; cv=none; b=SaIND0iHXNKmSStJbQI3X89satVCUoQvIPlPyI1dxX0KS8QC7FHcoGK1K+WHDPFUy5RL7E7iPvAvcrfX4+Syi5Pd2+WwKVSXQUyZ3SOB2h7hnQtuZ4R5uhAGvOgloRmxOX6VIjWvLDluHPprdF3sNXkDH6BUrrVlYMJELpjSilE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754574168; c=relaxed/simple;
	bh=dhX65AbgfS/KR4PaiEOOQpG6AstcgDk1GMb4f5SARWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOb1Y+fYxqLb8sffP1Mjh8xOgXGKCE/RMDbG5yhwvGkMaUP9KlOBcpV95IZszB1OhpAQOmPPHkzZ4Lj824zIl9b9B4gRCeKA2WfUkQRMfhyp0C22F1Mh2sr8XjmF3d079XkX0KsfDypqsZX1lSAYpM6Zu1DFWfD4CUY00fwsDEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEWLYMxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EB7C4CEF6;
	Thu,  7 Aug 2025 13:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754574168;
	bh=dhX65AbgfS/KR4PaiEOOQpG6AstcgDk1GMb4f5SARWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEWLYMxHcH2jizGyY/SFgN5uigtWAiTuKXTIcPw3oMNicxwhx7UQQy/ECp6kPCBRz
	 Q+a4BU9bTXkObP4c4MgyD53iy8bgZSrveG3zzbKFYdxHKgDgBaHkZrxfuxeEhpGx9B
	 ayQpfQineK/u17uTenDsF6t6ZSWlacb839OtcnoeUSc1u2vsPVepZmUgrKZYbwx/sp
	 KwjFJ3vfM7YoauRiKlKG13yrwBD1y7f2m8wY+voQpUH1dr/tEtTbB25+BzWtkSiYK1
	 mA2DqWTTZ4SLB3LXsRQJ1l1Fp3S+RLfRUPZGxmfiuRHABuDuC9MIqJZZ30iSnloPtL
	 pmACWhnM4CCtg==
Date: Thu, 7 Aug 2025 15:42:39 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 03/11] fsopen.2: document 'new' mount api
Message-ID: <3u44qtys5a6k7hspgs6syhhuuicwjtdzdsdhe65j3kilacmfuj@pqsaofcc4lul>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-3-558a27b8068c@cyphar.com>
 <afty6mfpowwj3kzzbn3p7s4j4ovmput34dtqfzzwa57ocaita4@2jj4qandbnw3>
 <2025-08-07.1754570381-dill-stub-postwar-mowers-wrinkly-pacifism-hYIHTB@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qkuodxlnnepjp6wv"
Content-Disposition: inline
In-Reply-To: <2025-08-07.1754570381-dill-stub-postwar-mowers-wrinkly-pacifism-hYIHTB@cyphar.com>


--qkuodxlnnepjp6wv
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
Subject: Re: [PATCH v2 03/11] fsopen.2: document 'new' mount api
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-3-558a27b8068c@cyphar.com>
 <afty6mfpowwj3kzzbn3p7s4j4ovmput34dtqfzzwa57ocaita4@2jj4qandbnw3>
 <2025-08-07.1754570381-dill-stub-postwar-mowers-wrinkly-pacifism-hYIHTB@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <2025-08-07.1754570381-dill-stub-postwar-mowers-wrinkly-pacifism-hYIHTB@cyphar.com>

Hi Aleksa,

On Thu, Aug 07, 2025 at 10:50:17PM +1000, Aleksa Sarai wrote:
> > > +A filesystem configuration context is an in-kernel representation of=
 a pending
> > > +transaction,
> >=20
> > This page still needs semantic newlines.  (Please review all pages
> > regarding that.)  (In this specific sentence, I'd break after 'is'.)
>=20
> I did try adding them to this page (and all of the other pages -- I
> suspect the pages later in the patchset have more aggressive newlining).
> If you compare the newline placement between v1 and v2 you'll see that I
> have added a lot of newlines in all of the man-pages, but it's possible
> I missed a couple of sentences like this one.

Yup, it's quite better.  Thanks!

> To be honest I feel quite lost where the "semantic newlines" school
> would deem appropriate to place newlines, and man-pages(7) is very terse
> on the topic. Outside of very obvious examples,
> it just feels wrong
> to have such choppy
> line break usage.
> I understand
> the argument that
> this helps
> with reviewing diffs,
> but I really find it
> incredibly unnatural.
> (And this tongue-in-cheek example
> is probably wrong too.)

I understand.  The guidelines I use are:

	If there's punctuation, break.
	If there isn't punctuation, but the sentence would go past the
	80-char right margin, try to find the best point to break (this
	is sometimes hard or subjective).
	Other than that, there's no need to break.

Does that seem reasonable?  (I can always amend a few cases that you
don't know where to split.)

>=20
> > > +containing a set of configuration parameters that are to be applied
> > > +when creating a new instance of a filesystem
> > > +(or modifying the configuration of an existing filesystem instance,
> > > +such as when using
> > > +.BR fspick (2)).
> > > +.P
> > > +After obtaining a filesystem configuration context with
> > > +.BR fsopen (),
> > > +the general workflow for operating on the context looks like the fol=
lowing:
> > > +.IP (1) 5
> > > +Pass the filesystem context file descriptor to
> > > +.BR fsconfig (2)
> > > +to specify any desired filesystem parameters.
> > > +This may be done as many times as necessary.
> > > +.IP (2)
> > > +Pass the same filesystem context file descriptor to
> >=20
> > Do we need to say "same"?  I guess it's obvious.  Or do you expect
> > any confusion if we don't?
>=20
> The first time I saw this interface I was confused when you pass
> which file descriptor (especially around the FSCONFIG_CMD_CREATE stage),
> so I felt it better to make it clear which file descriptor we are
> talking about.

Okay.

> > > +.EX
> > > +int fsfd, mntfd;
> > > +\&
> > > +fsfd =3D fsopen("ext4", FSOPEN_CLOEXEC);
> > > +fsconfig(fsfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
> > > +fsconfig(fsfd, FSCONFIG_SET_PATH, "source", "/dev/sdb1", AT_FDCWD);
> > > +fsconfig(fsfd, FSCONFIG_SET_FLAG, "noatime", NULL, 0);
> > > +fsconfig(fsfd, FSCONFIG_SET_FLAG, "acl", NULL, 0);
> > > +fsconfig(fsfd, FSCONFIG_SET_FLAG, "user_xattr", NULL, 0);
> > > +fsconfig(fsfd, FSCONFIG_SET_FLAG, "iversion", NULL, 0)
> > > +fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> > > +mntfd =3D fsmount(fsfd, FSMOUNT_CLOEXEC, MOUNT_ATTR_RELATIME);
> > > +move_mount(mntfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> > > +.EE
> > > +.in
> > > +.P
> > > +First, an ext4 configuration context is created and attached to the =
file
> >=20
> > Here, I'd break after the ',', and if you need to break again, after
> > 'created'.
>=20
> Okay, I wanted to avoid having lines with single words due to semantic
> newlines, but if that's what you prefer I can update that everywhere...

I don't have a strong opinion on that.  I sometimes avoid the break if
the rest of the sentence is short and all fits in one line, but if you
already need to break, that'd be the first obvious place to look at.
Other times, I have a more pedantic day, and split at every comma, even
unnecessarily.


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--qkuodxlnnepjp6wv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmiUrU4ACgkQ64mZXMKQ
wqnTaA/+O7z7oj6Sv67u8mhwvcsgbLALqTTvBca9IqwAMeJnEV7a9X5PKUGQty3B
Hc6L+Zsfdm2kDSU42TxeI2hqDelup+jKCwmzWJpQMGgOoiI4XcnXgf1YobvEXhhT
riLc9i2PQT/Bd6U5C+6zzuntBVjHxaRCfTzqDrSolQinZYAGIRztEqWrdI0C+hXy
cGbRE3dXFt2sTcLP4MftPuvV6hWm6keeOvDYaBtH9fprE777obJhVHMxdZZQMY83
ZwtJKT27dVlm6LAVHGKddaBOydZkCIjHVAW1me0nRxW5ZYFZelWXuh/9dO0MW4lF
bXPVL09qeDA/s7sPacOYpcHguKAQ4NAngPd2RMtm0YG+INoSx3RuY9wUxfudcYbU
YVJspezm0+VaUv1zS10venuv1swWpSiJjjL9kohopGe9PXctxzze9OwCHhU8i6WB
HafuQtrQV/0jPsnNmcU0vk8vjRHFedvVDO7KGDs+8YcILsBdspuqGHniqPPJfeWk
4Vf1V5SnOHvSJPWJ/LJXy6C/vvaV5zmjGYuvtZPcV/GuJgFV0y0d6yFKf/C4nHeu
EsyzNEhqhficSws6eslw6RerjrvjUWLdYIGUBNzvni5u/PfZToFpBxI5thKPluXH
aPoYsZDPJWot38955MK4LIETF783alrCL8xJXESg239BCZ513j0=
=QzCX
-----END PGP SIGNATURE-----

--qkuodxlnnepjp6wv--

