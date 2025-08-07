Return-Path: <linux-fsdevel+bounces-56991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8498EB1D923
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 15:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F521AA4BE2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 13:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B4025C711;
	Thu,  7 Aug 2025 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4h3RIxD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB5679F5;
	Thu,  7 Aug 2025 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573619; cv=none; b=UfKdgYKhny6yOpXtABTq64eYWykJr6P70g2VsNBYYDp0BbGLVyoTgoUT5W0vL6P73KhMaqmwXGKRb3j+0Yc7kpQMoPkpI6V6MKsiLoMYbWKANytNW9W6jog9Zw6bYRhMof+BZV1C+x8KosSGXhjJ2MlbJhO6DcZiIWKaN9zYA5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573619; c=relaxed/simple;
	bh=C+m41Sxvs2J9cP2hrThqL8yu6FEllFdE5iFu8nqgbqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKVTQkWe3E0VzImQKD4j2fnLFgqB/x3uTbv+cZnQWX5euVEffEAD84IzpI3qC9P3eNrHxU2htjkb/pZP3jhkNaRBef+IdvLuaRzRD+HGqhpNSKpfvanRsP7tTD0GVgaTa9Xjq/IQtdVdi7HHXonYYDL3tjyDnr+W4Noxyv+r5Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4h3RIxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F65EC4CEEB;
	Thu,  7 Aug 2025 13:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754573619;
	bh=C+m41Sxvs2J9cP2hrThqL8yu6FEllFdE5iFu8nqgbqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G4h3RIxDa5i/vOU7X8qLKhoxfuweduPC7xndg3evrKhJ18CaO27VYtOgIXd67KtSX
	 vzSnZFU2VCoEbfUHUIZumnuw4dCyRw+oxZxDDRgmG5e3Ibt4r4Sn1tuxZfAo8iPT2E
	 dQ5WmrdvpjOnmWKGBQqM1ZcYhJqdZkeWoxsHbGKJPYJe+qDbKd66+0ogCd5t9tur1R
	 MnU2JtVgPZx8qSLzef/tD7TYEoSZm2agBxiUGsFgNAq/wE7d4y8kYs9NEPLFiWH6un
	 V08nVEV3fWO66aOXZeY/x6hCGz+p1Wjd2a0g9oO8Y3bIk9m+oCcCaqIWI+yIyO0Y10
	 ZyHDB3ldpiZdQ==
Date: Thu, 7 Aug 2025 15:33:29 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 02/11] mount_setattr.2: move mount_attr struct to
 mount_attr.2type
Message-ID: <jyzhaxy4htdmqijbxdbzivdlktwkpmbop7kcmqqdvtzb423wgx@sdbqwmmofkqa>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-2-558a27b8068c@cyphar.com>
 <cselxzuadkkf4cfx45fm3cm77mkq7gxrbzg7idr5726p52w5qa@sarhby7scgp6>
 <2025-08-07.1754570250-rented-dazzler-furry-proton-robust-diamonds-Kgpe2w@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g4eqyz2xnmynvagq"
Content-Disposition: inline
In-Reply-To: <2025-08-07.1754570250-rented-dazzler-furry-proton-robust-diamonds-Kgpe2w@cyphar.com>


--g4eqyz2xnmynvagq
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
Subject: Re: [PATCH v2 02/11] mount_setattr.2: move mount_attr struct to
 mount_attr.2type
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-2-558a27b8068c@cyphar.com>
 <cselxzuadkkf4cfx45fm3cm77mkq7gxrbzg7idr5726p52w5qa@sarhby7scgp6>
 <2025-08-07.1754570250-rented-dazzler-furry-proton-robust-diamonds-Kgpe2w@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <2025-08-07.1754570250-rented-dazzler-furry-proton-robust-diamonds-Kgpe2w@cyphar.com>

Hi Aleksa,

On Thu, Aug 07, 2025 at 10:38:36PM +1000, Aleksa Sarai wrote:
> On 2025-08-07, Alejandro Colomar <alx@kernel.org> wrote:
> > > +.SH VERSIONS
> > > +Extra fields may be appended to the structure,
> > > +with a zero value in a new field resulting in
> > > +the kernel behaving as though that extension field was not present.
> > > +Therefore, a user
> > > +.I must
> > > +zero-fill this structure on initialization.
> >=20
> > I think this would be more appropriate for HISTORY.  In VERSIONS, we
> > usually document differences with the BSDs or other systems.
> >=20
> > While moving this to HISTORY, it would also be useful to mention the
> > glibc version that added the structure.  In the future, we'd document
> > the versions of glibc and Linux that have added members.
>=20
> Sure, though I just copied this section from open_how(2type).

Thanks!  I should fix that.


Cheers,
Alex

>=20
> > > +.SH STANDARDS
> > > +Linux.
> > > +.SH SEE ALSO
> > > +.BR mount_setattr (2)
> >=20
> > Have a lovely day!
> > Alex
> >=20
> > --=20
> > <https://www.alejandro-colomar.es/>
>=20
>=20
>=20
> --=20
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> https://www.cyphar.com/



--=20
<https://www.alejandro-colomar.es/>

--g4eqyz2xnmynvagq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmiUqygACgkQ64mZXMKQ
wqlwpRAAjjX7Pf1H7oPcZt4gFLMb3IUa3YzMoWSRYwJJO13sAmuQRilMq1xxjOww
m+x3ksXkam9FdQnM1wl82cX+exj0H7QrFd/6QCCh8VTmE6virPTWZhJzl+ACWM4x
d4B+MBXsanhjiMc4rozHUhAKlCCVE7hBQg32NxQxjIVbZ/ZBBFcgTUHRLSP28zLS
YHCsZcbu4QfQkHMU+FeiEplaycDwfFiHNKKHwaCSTTLO+xezJslW1YQ/l4y6cdnJ
seZnFFzutIJZWksqMbCyx3vTLLDze/rLOsUNJS2IqY1KKA65FhRShUI5OfczqmFq
QK36tqlHnP1Uu+ow8rEmZjHEIic3Wr2XV8LCzdvRkXuia08Eh0WSg1SGG/z04Fr5
oVyDOlCVHRc4SlJ0jlJUPIhIFpIfYScujeG/3O8qEz9jYFrpc3jMDhxuhl3tpCmK
PWSuQhgrE0l5cKiC5G6Cw883HTp2lys6VXnTeoJeNKTH4IcXTDHYWopwfO4TVwk+
IZkYgvKznDtLVLjJOOr4xwaIaiS7wOPWSSpx7YQq0JEtqvBSDLvJBQLkGzEPeK18
QXD0E4XXmFXccEP2PKBQeBLWLMLm+e4ZqN+GVwHalHIUSkr8LSQJV3kPw2eNt7Od
EMvVsrLeTH93eYzEdSA+7OcQeQJaJdEDccuy+oe4A7tLY5fdQiE=
=FPho
-----END PGP SIGNATURE-----

--g4eqyz2xnmynvagq--

