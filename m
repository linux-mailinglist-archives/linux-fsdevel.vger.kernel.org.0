Return-Path: <linux-fsdevel+bounces-46843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E1AA95749
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 22:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8921892170
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 20:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EE71F0987;
	Mon, 21 Apr 2025 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5wAK1qF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53AF1F03FD;
	Mon, 21 Apr 2025 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745266891; cv=none; b=hhLJhn+m1o5ZPapOxvzCI+0R0O9nRnPIsMLMGwP2rXNyZrnMM5Pv5sXyTbdtc0dGRLL/ib1ai0U+n4MUmTGuL0r/HJ9D3hFTDZ1td6ScD1pqitaC7FrdhNvwSWD9orJrD+BBifh/L3XorEQc3x94MHybNvnDKusLLX+XHznL2Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745266891; c=relaxed/simple;
	bh=a/uy4obNcdi0tq9zv4uHUvXvxyb3WKWOb8RycThBiX4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iVCtZtdx5OHBtJ2um+ythCK12E1AH0AkBIPvWD8efB3UtM+leVZS/rQIQVMdeHyzGfj/QcVGHA7bJFL41b06Q9l2tz0mLs27e1gsgSRFaJ97N19sKGqXzjzmdbZlLJAB3qhJ8B/bWxl0yFQYlaua9WiY007UJGqpStD4GrnEwe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5wAK1qF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB02C4CEE4;
	Mon, 21 Apr 2025 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745266891;
	bh=a/uy4obNcdi0tq9zv4uHUvXvxyb3WKWOb8RycThBiX4=;
	h=Date:From:To:Cc:Subject:From;
	b=D5wAK1qFnQcOfSzdhe1l469qJ5vtW8aV6tjcbs+gpdYZXRZvUPgy5yjn4QkFWTvHF
	 MCxtCuRpB5MkAXB9FPm+j8eckiItRsry2u8m8DxfyhJ2RYiM2Tol3Buwqq5YavqTj8
	 8bb5sX5xG6RTKuJr5bz0steg12hcfQvlKdPgOlb9ekgpH95+bVXTHq+4ETbXVg23CI
	 KIie7ww1MKOn/4Qrk+vsuYlm6Fs1ctB6bsFAMCj7SQJhI8yMmVkcmLAtdZaFD/aEHk
	 Ir6cJxaV60kkH7kpcj/VekA66SbkKj/4Wwm8aXNYgBKySyc36PZCm+dejST/J8klJS
	 dLMA6ebmdl29w==
Date: Mon, 21 Apr 2025 22:21:26 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org
Cc: linux-man@vger.kernel.org
Subject: {FD,O,...}_CLOFORK have been added by POSIX.1-2024
Message-ID: <e2t4obcqeflajygu365ktxnsha5okemawuwl32mximp5ovdo53@2pq2f46wfdkg>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="64c45ak4bbihape7"
Content-Disposition: inline


--64c45ak4bbihape7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org
Cc: linux-man@vger.kernel.org
Subject: {FD,O,...}_CLOFORK have been added by POSIX.1-2024
MIME-Version: 1.0

Hi Jeff, Chuck,

I'm updating the Linux man-pages for POSIX.1-2024, and I noticed that
POSIX.1-2024 has added *_CLOFORK flags (with the obvious behavior).
This is just to let you know about it, and also ask if there's any work
in adding these flags.  I'll note something about the existence of
these flags, and that they're unsupported by Linux, at least for now.
Is that okay?


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es/>

--64c45ak4bbihape7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmgGqMAACgkQ64mZXMKQ
wqm/lA/+IrtjmbravQWb+VVO5fKSNiMZi3IbTHLzTY5nkDfFxpC+AxrQGU0N2aC7
sLyp8LA2PE881WLKKOmnMjlf81lHYUq5Aygl6e8d5i56hi+8E916kaa+Oo1EaY5/
KD8fYNMzfzepdgkmS3naThGolNCmfedWRILOFJKCAZrGaymFf3OWC0tdlVyF9hHe
e+U+wMNWl3dgTO/IxJZ+vbRNzkW+JMaW+btVbL15iNA8FUVXMdoKuRGzQmlfhZs3
NrAaqC6N0HWGk7k2RJKrciMy+vuQ0AqPyRpNTE1VMjVEsRJAIm58IHspnl/ijotd
hIhbcuqcm+964I62hxOYadgeFA+MbuiKwz1iZHqdxTtsWU0Ia1gUUCQI8Z5XnFHi
O/OKP8nD0b+48FuSIphhnbK6Jmx5ughoKUG8VSuEqzLHUc4U39fw1UZCkPvthecI
Sk6qhHujU1uNNO2X9cbI0dRbL/XFX2a8cHouPHiZPEjQW8M2p4NLco0HQu9sq5PK
KUnWkV/5uXLgWTBCy/sD1cYdQI3eQMGutxObMEiPvbVeQGwG40nzFNCoanMeC0f5
fs3FD7t34o0fNDeCaG5NOwmlOp9MvSYnRiaE0Eugv2vMaInj0jjiIRuYdh6JxXFo
H7EZXZ+MJOvqAzEWPeB3szBbbMKEEGoBT5cPf64LNpimxqgLZck=
=RwXv
-----END PGP SIGNATURE-----

--64c45ak4bbihape7--

