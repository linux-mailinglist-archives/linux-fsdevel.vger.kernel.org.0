Return-Path: <linux-fsdevel+bounces-23422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7C492C1FD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 19:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67512938EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D6D185636;
	Tue,  9 Jul 2024 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nemjk8lQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369F218784F;
	Tue,  9 Jul 2024 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720544027; cv=none; b=A2l8cC15pz/KFh8ZFBr9Pw3dQuai+2+xsXMhS+6C26N2a/vLk5K9k3xr5OhY7EClRhOfhtcZg+SKSmmGY16CWL1lz3//OLpKAhPxMHkwrGrZFKeY9Hhx9822fXlOwhOiGBVw3q3n2nke1jYVew/fGwpLIDup+BMLOqhRLxwHiRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720544027; c=relaxed/simple;
	bh=wCt2eVwPycseHZNsJj3m1b7qQmWG0ZjcLaXsCpaRkg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LT0wdQAB25u4pSWPJ09IGWxiP0LokSe9rAY66wEK2BbVwSNb8ClBIKqoCq6jHaawd1quCeBoR7LnY108qDBB+bC6pZvgjhZvN++ea6QC6ShWLPSGAcPpOKKKzEIurEbhK49dxbbYpVu7majLmIA5WC7XBbIWG48mzkDRj40swRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nemjk8lQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DAA8C3277B;
	Tue,  9 Jul 2024 16:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720544026;
	bh=wCt2eVwPycseHZNsJj3m1b7qQmWG0ZjcLaXsCpaRkg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nemjk8lQNUoUZcrW8krv9XOTNcTO2GhzCB+jR6WfdAaJgF0coKZ88e9oCvUkIor73
	 Ndkx7AKwxkG3W9oQmWUu3OBCplYCKOdighW96VfCM1RX6WbcAItdDXCc9DIJHU+rQE
	 SiGa6myxbDgeDeskYTOQd84ZmoaqZGPsSvfmpeIypUjdsCjC6gO14+SmIWRXqLb82A
	 3NCOq8Ivix0vQ4Amh89VxeHXK6WJTYZHJZxdQ9BLlBSqQ63btMh9Z98pBLoGXE8xkT
	 Z9+c6Y1UX1T7I3zun2LYcHNQeO745WEEqzLN6qs6vuH67Zs7cnaJORDbFxtIncjZNi
	 DrM1ilO9OdSsw==
Date: Tue, 9 Jul 2024 18:53:43 +0200
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	axboe@kernel.dk, hch@lst.de, djwong@kernel.org, dchinner@redhat.com, 
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 3/3] io_submit.2: Document RWF_ATOMIC
Message-ID: <zonwu3dsyz6fk5unic2rgxqpvrceqrtj4k5epb6hdj44fbzxkm@vbfqorsyw7te>
References: <20240708114227.211195-1-john.g.garry@oracle.com>
 <20240708114227.211195-4-john.g.garry@oracle.com>
 <yyqi4f6pphnpjhhlwnbvsdyaxsronpfumg4bjp4eig6rh2d4ka@uyy5y37waxbd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7hziuibpn4rmxahs"
Content-Disposition: inline
In-Reply-To: <yyqi4f6pphnpjhhlwnbvsdyaxsronpfumg4bjp4eig6rh2d4ka@uyy5y37waxbd>


--7hziuibpn4rmxahs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	axboe@kernel.dk, hch@lst.de, djwong@kernel.org, dchinner@redhat.com, 
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 3/3] io_submit.2: Document RWF_ATOMIC
References: <20240708114227.211195-1-john.g.garry@oracle.com>
 <20240708114227.211195-4-john.g.garry@oracle.com>
 <yyqi4f6pphnpjhhlwnbvsdyaxsronpfumg4bjp4eig6rh2d4ka@uyy5y37waxbd>
MIME-Version: 1.0
In-Reply-To: <yyqi4f6pphnpjhhlwnbvsdyaxsronpfumg4bjp4eig6rh2d4ka@uyy5y37waxbd>

On Tue, Jul 09, 2024 at 06:53:03PM GMT, Alejandro Colomar wrote:
> On Mon, Jul 08, 2024 at 11:42:27AM GMT, John Garry wrote:
> > Document RWF_ATOMIC for asynchronous I/O.
> >=20
> > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > ---
> >  man/man2/io_submit.2 | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >=20
> > diff --git a/man/man2/io_submit.2 b/man/man2/io_submit.2
> > index c53ae9aaf..ef6414d24 100644
> > --- a/man/man2/io_submit.2
> > +++ b/man/man2/io_submit.2
> > @@ -140,6 +140,23 @@ as well the description of
> >  .B O_SYNC
> >  in
> >  .BR open (2).
> > +.TP
> > +.BR RWF_ATOMIC " (since Linux 6.11)"
> > +Write a block of data such that a write will never be
> > +torn from power fail or similar. See the description
> > +of the flag of the same name in
>=20
> Maybe?:
>=20
> of this same flag in

Or just to be less ambiguous:

See the description of
=2EB RWF_ATOMIC
in

>=20
> > +.BR pwritev2 (2).
> > +For usage with
> > +.BR IOCB_CMD_PWRITEV,
> > +the upper vector limit is in
> > +.I stx_atomic_write_segments_max.
> > +See
> > +.B STATX_WRITE_ATOMIC
> > +and
> > +.I stx_atomic_write_segments_max
> > +description
> > +in
> > +.BR statx (2).
> >  .RE
> >  .TP
> >  .I aio_lio_opcode
> > --=20
> > 2.31.1
> >=20
>=20
> --=20
> <https://www.alejandro-colomar.es/>



--=20
<https://www.alejandro-colomar.es/>

--7hziuibpn4rmxahs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaNaxYACgkQnowa+77/
2zK5Rg//UQFQV+OIHAFO0JjJae9DMb1zgWo2PtUv8TaKGQJHOXyBYboMII32h5ir
yVM2nkIYTAEu+mKR9AqN6Hsg2QrTpmSMMURYXt+QMG1uaktmkbjPWnwpA/RjANiQ
aAw5uIRr4n8e4p7V9p9PcUIoeeumF3k5WDEF/Vk8IPjr/iY4Y7DbWvqhYvOZpxSi
2gDlJuvHQ8+9xQ7ZRqEWysSVGJlkFbb0VtuldUTKwbGAJdLXL6bQRTj2IrApXuOZ
vlHwQtJj0Etfsfp8w04EPdazI5jG5tx+hFa6Zm8qTeuOOZMB+kdhNxTcoATGdY31
5+mNDUW6EbvR1GMFLsIVJFDOZ+HNPe7kCRjzrzjk0r1Iyp072maqv8ygrjG+cbgr
taYGxOyq8PSXfl5AiGId/gR/+XHapgbIqp95jG1qVSNVndGAhqkf7qon1YOG48dY
/6MHU81vn0nPzxU0g20bsebti9upQe/ZhfNxw7XlRM5/Yo3+5Ic9vwmSyZKoqe6B
evWteINnhrNdVaCB/rantzYCx2QwfuaB5f5iThYyB7k9BL4vE7euG0eKcf9AgDR7
SAocXJ8Oe8iqAEskswh9w1pW56j8ZyiaK0s05DZGL2ci2bA7CAxuppunSePbzs2x
jJ5HsyFKOi0j9DVg8WK4idsOwNLFjtUgZxtI93yepCRkixIV6HQ=
=Ncu7
-----END PGP SIGNATURE-----

--7hziuibpn4rmxahs--

