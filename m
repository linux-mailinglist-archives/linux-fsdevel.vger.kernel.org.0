Return-Path: <linux-fsdevel+bounces-62547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4D1B98FB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 10:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4174C4A5B46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 08:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016172C026C;
	Wed, 24 Sep 2025 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+nXYfeT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5298B29E0E5;
	Wed, 24 Sep 2025 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703883; cv=none; b=nPktfB0QQZP4TaJ9UPbReN4ccHTddHaeUgFslEfEAwSWg/eNJc2TObZqYyedaeiiJyOiL9dIYdXpZBudH6t03c36MI9FgcHZTnG2/W8A9otiMj/RgdRlTZd//4JFJitOalYSzyUr8ukCd8b50qfMnNjrzI/bYbffrUFm71EpqMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703883; c=relaxed/simple;
	bh=swWhRzwxWwIDowEWS+M6n2E1h9sDSR3qkPXRp6QsC/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpyZbD5s+3Nsn1XItaqHGqfzD212uSGoIKNQmYegHXqGYmucLcjcUvqe0VIc7WBOmg34+kq28AuJbOJk/JaDpjqKWDrEqy8slgeY8q0K6fgneBHj5OoE23l0DgFvIInY8zGJlbQ7tVOX9bp0EzUXjJ3PSI9JeXyroZOGLeRzHhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+nXYfeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E5EC4CEE7;
	Wed, 24 Sep 2025 08:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758703882;
	bh=swWhRzwxWwIDowEWS+M6n2E1h9sDSR3qkPXRp6QsC/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+nXYfeTdWT1OUmmpPNrxHo3tHzi7HNgGr8P8o0SmS1GOcs1jcaP9AcLb/MNtTZlI
	 41AQ1tMtBbR22AvX+Kj7BseByGQ53+Uxb7H5fXD9BDxmqYkKhGty5vWrI6K+LAPBoq
	 u4BbJmYu5UFRlOR9j8NI8NiB3c5lcH6y7yBW8Md6N1gjVEHRuH2FPI2QuyrLefzUe3
	 rZUu6Tp/64H0G3IIsF33q7JSse0gyjPkDlveUTkG1ZqaHGi0iB0evjAPdbMu3lJSrq
	 7Ql5vAoS/tvR2t62IRZTSGSRZhmqv7LAhISJFc3HRlcEfGLmjCxOZPdDKGwBzXnWMe
	 U+4PMhkskv1YA==
Date: Wed, 24 Sep 2025 10:51:16 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 09/10] man/man2/open_tree{,_attr}.2: document new
 open_tree_attr() API
Message-ID: <3c3pxgxomljpwouzrl2tnycal2soox2j6aypk4pb23c63kv366@z7bxgctoukg6>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-9-1261201ab562@cyphar.com>
 <vc2xa2tuqqnkuoyg4hrgt6akt23ap6hxho5qs5hfcbc5nsaosv@idi6hwvyo7r5>
 <2025-09-24-unsafe-movable-perms-actress-zoAIgs@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jvig5ndc7pvxuonl"
Content-Disposition: inline
In-Reply-To: <2025-09-24-unsafe-movable-perms-actress-zoAIgs@cyphar.com>


--jvig5ndc7pvxuonl
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
Subject: Re: [PATCH v4 09/10] man/man2/open_tree{,_attr}.2: document new
 open_tree_attr() API
Message-ID: <3c3pxgxomljpwouzrl2tnycal2soox2j6aypk4pb23c63kv366@z7bxgctoukg6>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-9-1261201ab562@cyphar.com>
 <vc2xa2tuqqnkuoyg4hrgt6akt23ap6hxho5qs5hfcbc5nsaosv@idi6hwvyo7r5>
 <2025-09-24-unsafe-movable-perms-actress-zoAIgs@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <2025-09-24-unsafe-movable-perms-actress-zoAIgs@cyphar.com>

Hi Aleksa,

On Wed, Sep 24, 2025 at 04:31:15PM +1000, Aleksa Sarai wrote:
> On 2025-09-21, Alejandro Colomar <alx@kernel.org> wrote:
> > On Fri, Sep 19, 2025 at 11:59:50AM +1000, Aleksa Sarai wrote:
> > > diff --git a/man/man2/open_tree.2 b/man/man2/open_tree.2
> > > index 7f85df08b43c7b48a9d021dbbeb2c60092a2b2d4..60de4313a9d5be4ef3ff1=
217051f252506a2ade9 100644
> > > --- a/man/man2/open_tree.2
> > > +++ b/man/man2/open_tree.2
> > > @@ -15,7 +15,19 @@ .SH SYNOPSIS
> > >  .B #include <sys/mount.h>
> > >  .P
> > >  .BI "int open_tree(int " dirfd ", const char *" path ", unsigned int=
 " flags );
> > > +.P
> > > +.BR "#include <sys/syscall.h>" "    /* Definition of " SYS_* " const=
ants */"
> > > +.P
> > > +.BI "int syscall(SYS_open_tree_attr, int " dirfd ", const char *" pa=
th ,
> > > +.BI "            unsigned int " flags ", struct mount_attr *_Nullabl=
e " attr ", \
> > > +size_t " size );
> >=20
> > Do we maybe want to move this to its own separate page?
> >=20
> > The separate page could perfectly contain the same exact text you're
> > adding here; you don't need to repeat open_tree() descriptions.
> >=20
> > In general, I feel that while this improves discoverability of related
> > functions, it produces more complex pages.
>=20
> I tried it and I don't think it is a better experience as a reader when
> split into two pages because of the huge overlap between the two
> syscalls.

Okay.  Thanks!


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--jvig5ndc7pvxuonl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjTsQMACgkQ64mZXMKQ
wqkXxQ/+NaF79nh1DhLU3assTjDV4eziliCQAbS/fAF81drWeRcukrtPfI8johse
NsJNtLA1lhpp8oNN55TF3tRtYLo37ygjSywl6lEdvBfOer6xzROKszd6HvlOlGkg
H1i6mJe1aOd8AhCQYMrN8FtAaimdpPt1rbP3A0FC/XgoglJHCE+ibcpc1tqSu2rD
pm/5biUo1Oa9y9cvcWLJHn9TfxICKe7xlyvS3n+VQypSGe9q+ZKPGuv5mRIgBNvv
g28m107vqMVHwWSteLuqoGeXTFd41H5D5EoRh5PEXCDJ/4/Ur4AcP9Fbih5zL33q
EZTnn+B6aevDk8YsDBUE1OyDddLZq2VvTLBK8+o2XESZtyaEkTzP93IoU7onDBS1
L8/VhSs6vCxumJI70ZZoIM7ZaiE+f7zES0oSP+SzR4+Ul5Kl36YauU2p7gwQx/so
UkzBta/7acjz93U/r8wlTZ/Pa9iXrYhl6VBQ3iEYlhJ/oiUKjL648HOGUjuirLob
NdARVALPdK2dYGDVQyN6QoI4h/FiuHi3tquCqste2F33xnYeGiMPJQWWTAq5zt1U
u1d0QYQ4Tf3OLeYqPIXv5Ba6KkyFxRl2xNrbgx1jS6bWyvDU1iVs76CB2ZjHNNSR
oNP4TfrbbAmkBnocVrwErbbJoxf2K7lPqPAP4a1iO5hP65Ri8QI=
=3R+H
-----END PGP SIGNATURE-----

--jvig5ndc7pvxuonl--

