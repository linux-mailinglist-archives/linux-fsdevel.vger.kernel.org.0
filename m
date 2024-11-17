Return-Path: <linux-fsdevel+bounces-35031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32369D01CA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 02:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C26DB22345
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 01:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808759454;
	Sun, 17 Nov 2024 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rb5Cs9wi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC76B28F1;
	Sun, 17 Nov 2024 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731805239; cv=none; b=YDpv+gSfpLwTQkngo04YMeU0RkzKucEAn8PewK4aFqmEG43Vi3n0yTtNeDPHM5cH7xJy3NEgzE9CvBuGiRUXrPLblVWOgNX213mJh/cFHQBWiKRtSoFyaw972cfFG+2SfNmhhFfEV/wtChITK9QiZrs85WtwcFcghQhsrbKsTws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731805239; c=relaxed/simple;
	bh=LxFsBW9EzS4AdrmKfiT61fNOtOkzSDFQcqphwJea91M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXqIHGm09MX02mSaIP8EUPLDoTZl9727rMYu9Fl4WJilZdk8kyntv4RsR2MWaY5WUwE6w6LqSt7eTORFswh9Uzyevu/qzLl/A2ewCGoPx9V2imZQPDOnRs/wsw/Fd367yy5FTjnu7mibBfyuxL7jhwx/lLupZZ2O0LKYAfqHU5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rb5Cs9wi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6621DC4CEC3;
	Sun, 17 Nov 2024 01:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731805238;
	bh=LxFsBW9EzS4AdrmKfiT61fNOtOkzSDFQcqphwJea91M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rb5Cs9wiEmfeJkriK8DDXlpMi/1uye+sGjMHpPt4R8i6fIx8pWUc20T7MatTTKZNd
	 48bRcmurJDQ/o2JbsjO4W7pa4Bw2SJifEDtjLStgZwr6feVRg6Rn5QzGqBgFjArJlS
	 dW8qRswB9gR0bRR7OpVz8lKlMAIkCLb/cVCYKbIqGwVMkBqyDocA58IBmUtxNFhFsZ
	 otVl4Gk3fMMMtGq9VKd8d9/cXSXTtTMDz5IIzETp0OwWYWqjlfG624qbHKwZv3J/fH
	 3e7X5ZD6Di6uwRHFbi/8lmMr8JfsM147WudV3mhy/mLbO6zbcP+9Zx9lVo0vgoknqY
	 3OZcA055tXleg==
Date: Sun, 17 Nov 2024 02:00:35 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH manpages] listmount.2: fix verbiage about continuing the
 iteration
Message-ID: <rsxj2szyx5ottzfspk4z5ikvzm3g37gffx5irn42csrypyccku@lg3ymevslyee>
References: <20241113-main-v1-1-a6b738d56e55@kernel.org>
 <ofoedlcmowbhd6asd6yhp6jhetv2n5s6xsmzmu2qf2nnh2o22b@5nozhjvjbpvm>
 <74e518a304101cc5ee076b183b651b9cf100d3f9.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="up5fakmjywm2aids"
Content-Disposition: inline
In-Reply-To: <74e518a304101cc5ee076b183b651b9cf100d3f9.camel@kernel.org>


--up5fakmjywm2aids
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH manpages] listmount.2: fix verbiage about continuing the
 iteration
References: <20241113-main-v1-1-a6b738d56e55@kernel.org>
 <ofoedlcmowbhd6asd6yhp6jhetv2n5s6xsmzmu2qf2nnh2o22b@5nozhjvjbpvm>
 <74e518a304101cc5ee076b183b651b9cf100d3f9.camel@kernel.org>
MIME-Version: 1.0
In-Reply-To: <74e518a304101cc5ee076b183b651b9cf100d3f9.camel@kernel.org>

Hi Jeff,

On Wed, Nov 13, 2024 at 12:12:22PM GMT, Jeff Layton wrote:
> On Wed, 2024-11-13 at 16:59 +0100, Alejandro Colomar wrote:
> > Hi Jeff,
> >=20
> > On Wed, Nov 13, 2024 at 09:49:02AM GMT, Jeff Layton wrote:
> > > The "+1" is wrong, since the kernel already increments the last_id. F=
ix
> > > the manpage verbiage.
> >=20
> > If it's not too difficult, could you show a small example program that
> > shows this?  Thanks!
> >=20
> > Have a lovely day!
> > Alex
> >=20
>=20
> It's not too small, but I proposed this program as a sample for the
> kernel:
>=20
>     https://lore.kernel.org/linux-fsdevel/20241112-statmount-v1-1-d98090c=
4c8be@kernel.org/
>=20
> It has a bug though that Miklos pointed out, since I followed the
> manpage. I'll be fixing that soon.

Thanks!

> > > Cc: Josef Bacik <josef@toxicpanda.com>
> > > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>

I've applied the patch, with some tweaks to the commit message.
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3Ddfa492a21fd01e36c1858b9f8d66323e49011a96>

Have a lovely night!
Alex

> > > ---
> > >  man/man2/listmount.2 | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/man/man2/listmount.2 b/man/man2/listmount.2
> > > index 717581b85e12dc172b7c478b4608665e9da74933..00ac6a60c0cfead5c462f=
cac44e61647d841ffe5 100644
> > > --- a/man/man2/listmount.2
> > > +++ b/man/man2/listmount.2
> > > @@ -67,7 +67,7 @@ is used to tell the kernel what mount ID to start t=
he list from.
> > >  This is useful if multiple calls to
> > >  .BR listmount (2)
> > >  are required.
> > > -This can be set to the last mount ID returned + 1 in order to
> > > +This can be set to the last mount ID returned in order to
> > >  resume from a previous spot in the list.
> > >  .SH RETURN VALUE
> > >  On success, the number of entries filled into

--=20
<https://www.alejandro-colomar.es/>

--up5fakmjywm2aids
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmc5QDMACgkQnowa+77/
2zKgXg//e6xppiAbqIyNAm+I7iNSTw9/m7WT02dRdQzHrxqhp/XcDt7+YeY0p/rz
O7iOgqNyML41+WT0s0z7AjchVtR9sYl3sp3d7DZ7Tf0GZkpsJizsCrIGlu+154Xl
d/nIcrb5/sCVm/tAK6+QEk7Q3XY2B4bv0Gki7sJDSjupmC4F3lhzdFsXF6l59le5
u975IkUfifTMhLyFBNxGUd0fsYA3UKboqXO2TnKsmysJAHTGRre4Mrsyv95278mQ
Zh1E13qHh103JaqHY3IJJn+DUB+k+a8nX3dBfh3GMJWzOLMHCit4j5UyzwtNm7EW
O0F9anizn12hKq0UecOiYZNZwxrQEjmfHIu0NY9u3GYjrhDGbxngcRVuwhCJO0hN
/cPH8W58eoXxZO6n+NlcJogfaNdFUlxWPF6h6ZKKLhjxrQxe8ZAxoRplovTiNBYr
0ZOv+eRtPusrkP+ErKcbH2LEVZ0YIGwF5Ff2NgrZPF7LWzmaAtnBoDjVzNd4iYbg
3zTVrs4IFLgtIpSXq8tXQiwvB/UJ9Z8zMR3yOK02IMuDGFn3bKBH1PyhnWgtOsol
wTnBLXVYvfZwesjYb/T3O5PoGPypd29IDQdhSrTAVbZY8CVfuSkBSdNNFLRYbFlm
BPCF2BSEWvigXeGJ3P1XrBA9bhWGHUfyr65rn5sNMS7X0k32knc=
=l/tX
-----END PGP SIGNATURE-----

--up5fakmjywm2aids--

