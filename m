Return-Path: <linux-fsdevel+bounces-71538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DDBCC69EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 09:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64A42302E2F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 08:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBB33451CF;
	Wed, 17 Dec 2025 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+EmRpnG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F1B3451AE;
	Wed, 17 Dec 2025 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765958998; cv=none; b=ktBBsk4brhERr57mJb+DeRzh0kCaP0CqxOEJhsEakEKO3CGBZbQcbqiP+WczLfjiYAp5yYyynVdrgkZTMznNCGUBJMcLy3o1wTbHW9rEO11sxLFYbyNQZOOIuGjVKdw+SlwXS2blkyqZNlkYo3wBKu0E6ukyqXlpSa3GIL2agzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765958998; c=relaxed/simple;
	bh=roVrOnD3wsTR191f9+dWaeUkFT2LXxx+cL6PaDxqjq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Su1dZicX1jpD9gBXy/KlofI47hA4+q6iVtczrIf9saFecb5IMvJbXz3kVppqI7wLrsRRam5DB8rf48/Mc7mjxXx/rnWb7BjH5CG5wbMadyP6BB299vTBlfw0PYDwDldv/TQliZjY0UOZS8IdH5t/X5crpCLtGJxFL3ks6u6y+WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+EmRpnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEFAC4CEF5;
	Wed, 17 Dec 2025 08:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765958997;
	bh=roVrOnD3wsTR191f9+dWaeUkFT2LXxx+cL6PaDxqjq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j+EmRpnG9GpPjT4c7Ff5KzfuF8lAn1MTM1yeHslvFDAMUO+5o5MuPB2PtNmIfnLUc
	 P4lNmPmY1kRgazPPzPa27kWXEkTaHYmM2+XH282/JDR0biLEeN4shxWRmCTYoGPsQi
	 SjEs/mMzt1wxvF6fC76EXPZwWvSIVVZ4J3JM6XDT99toE5dMEzagc2tJIgL2ysPNeL
	 3MOhk8qekIcyXygaOHgNO+P+bQVTZfBUB4PwWnXnHKFlliyonIsJP/xPhZIzMXzbCm
	 QuVgWpXg5wXQOSfUeKxSOPfeTzGlMwk1jVQt0zfqP05rogyEycftyKqqmK4/V9Okb0
	 2bbEfIoAOzsaA==
Date: Wed, 17 Dec 2025 09:08:56 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Add missing kernel-doc for proc_dointvec_conv
Message-ID: <yehblrvzw35ivlvzn45ar5zmqjwq2flrjwlru7rr5jwkbpizpv@pbrcw2xr76ro>
References: <20251215-jag-sysctl-doc-v1-1-2099a2dcd894@kernel.org>
 <202512160038.2C7DAA20@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gd2rx42r3mpexyzh"
Content-Disposition: inline
In-Reply-To: <202512160038.2C7DAA20@keescook>


--gd2rx42r3mpexyzh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 12:40:15AM -0800, Kees Cook wrote:
> On Mon, Dec 15, 2025 at 04:52:58PM +0100, Joel Granados wrote:
> > Add kernel-doc documentation for the proc_dointvec_conv function to
> > describe its parameters and return value.
> >=20
> > Signed-off-by: Joel Granados <joel.granados@kernel.org>
> > ---
> >  kernel/sysctl.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >=20
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 2cd767b9680eb696efeae06f436548777b1b6844..b589f50d62854985c4c0632=
32c95bd7590434738 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -862,6 +862,22 @@ int proc_doulongvec_minmax(const struct ctl_table =
*table, int dir,
> >  	return proc_doulongvec_minmax_conv(table, dir, buffer, lenp, ppos, 1l=
, 1l);
> >  }
> > =20
> > +/**
> > + * proc_dointvec_conv - read a vector of ints with a custom converter
> > + * @table: the sysctl table
> > + * @dir: %TRUE if this is a write to the sysctl file
> > + * @buffer: the user buffer
> > + * @lenp: the size of the user buffer
> > + * @ppos: file position
> > + * @conv: Custom converter call back
> > + *
> > + * Reads/writes up to table->maxlen/sizeof(unsigned int) unsigned inte=
ger
> > + * values from/to the user buffer, treated as an ASCII string. Negative
> > + * strings are not allowed.
> > + *
> > + * Returns 0 on success
>=20
> I think kern-doc expects "Returns:" rather than "Returns". But
> otherwise, yes! :)
Will change locally. I wont resend as the change is trivial.

Thx
>=20
> Reviewed-by: Kees Cook <kees@kernel.org>
>=20
> -Kees
>=20
> > + */
> > +
> >  int proc_dointvec_conv(const struct ctl_table *table, int dir, void *b=
uffer,
> >  		       size_t *lenp, loff_t *ppos,
> >  		       int (*conv)(bool *negp, unsigned long *u_ptr, int *k_ptr,
> >=20
> > ---
> > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > change-id: 20251215-jag-sysctl-doc-d3cb5bd14699
> >=20
> > Best regards,
> > --=20
> > Joel Granados <joel.granados@kernel.org>
> >=20
> >=20
>=20
> --=20
> Kees Cook

--=20

Joel Granados

--gd2rx42r3mpexyzh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmlCZRcACgkQupfNUreW
QU+sJQv/eeGoIohr9jfKTzEex6lPQZ2mnMVyeghOFTx7Id6r6bCrltj99u4VfAs+
PLQWOkF3nAZKbeqY98e5ncdciBqPfoTLaA+QcNR5EOZrpYZTRYwSzZBx1OHaduO2
eNmMUf2xcCaagWifSs6glrB7sckJcaRAYlC5db6XRCQYa4Tkuo+kEmMjg3oPjKNA
lfKuFbV0pLeno7JfDja9Z5ElhZcMKNw2WtgaphtcvQPwf/yPDMNR2VLFS3mmeUSs
YIN/LQ82S0FxDWS7YEK3gJD/sB3OgBCg9ONV4vbI+WxfyeamU+9nul396agyQbs6
PYVfRPROaI5VQivwL5xxd8faRqqyooCzB+KD264fxZs5adudwtVRrYGh5Arvr9sq
QUPaSOgHwgHE+8+HcYZ7dOaMMYDvAoSAE05LsniseD16sabbgHfdL53GH5s2yfS7
NNyem5E+VktnGeLUEPK/TC2HMBQAXBRgO4N1Fv9a/qWsxeyyMv0FG0FtxIbypPk/
yKPzCkxO
=hTQf
-----END PGP SIGNATURE-----

--gd2rx42r3mpexyzh--

