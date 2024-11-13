Return-Path: <linux-fsdevel+bounces-34672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 263F39C7805
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 16:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B601F24E75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCF31531DC;
	Wed, 13 Nov 2024 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4VQImlR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C38813D24D;
	Wed, 13 Nov 2024 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513558; cv=none; b=Cj8BKhsrIinrfFf8hZ8+giHoax635i0cPIpPqP6+1xknlRyZ6MLAULjAjC8pKx+oDBQdpL6PZC5l3CLc5VGcyWq/L5oIfEk1hk44TxDHSaN2t23XUxtna0u7fqHcP5CjeojpeMYPD7UNNpa9qOB2S9CqQbIRzX1Un3D/1mumBOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513558; c=relaxed/simple;
	bh=hqZyRsogYpMQZ4NB3j2amF/q+twR3uBKKDpWVppb0dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcgLCfMUDfACcxMZhL/YATgKpcJRHRaQCHRxSMw+mzo4SX+FuuHooFQKslnZ1/Es+EHnsO4QspQ6hROManDnAk0kqgwDgwTXb5fWsRCxvtdZJX70E0s1jcmhHomQgIx/st/jb9coVMWIhrT7q/oHokvNLJc7rYxP0oLRMRpTgqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4VQImlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0428C4CEC3;
	Wed, 13 Nov 2024 15:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731513558;
	bh=hqZyRsogYpMQZ4NB3j2amF/q+twR3uBKKDpWVppb0dQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A4VQImlR73FJJBPytqbGdQfmcS00LILHEZ01p80q7JdrQ5J9CQ/Bdbk0Hsm85sAUT
	 avuUM+DnxaTF2dO+QRboFwJrhTnp+rb6p078M2QtkXbkaa/5jWDk6lmbCKPLoY6I0s
	 5jMo9keVlonT2CZP/U2+ufAV3HEc8bpBb8jIfC3dQs/XGdMenRuRaNgafhi+SYOYGN
	 GgMzog6dnqQkn+f9S1bKPGL3738pB1hL0sI+P58m1hIsztkCBGNO91qHjifptDqjZr
	 co1JMEaKyjXWMP1TtoXtxptJFnnVq8tkZSMY/NFQb2ocyFiQQxz7vzBy44bAjefMjK
	 mMM8QFPLmbV8A==
Date: Wed, 13 Nov 2024 16:59:14 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH manpages] listmount.2: fix verbiage about continuing the
 iteration
Message-ID: <ofoedlcmowbhd6asd6yhp6jhetv2n5s6xsmzmu2qf2nnh2o22b@5nozhjvjbpvm>
References: <20241113-main-v1-1-a6b738d56e55@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4nljuu3txwk3t47p"
Content-Disposition: inline
In-Reply-To: <20241113-main-v1-1-a6b738d56e55@kernel.org>


--4nljuu3txwk3t47p
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH manpages] listmount.2: fix verbiage about continuing the
 iteration
References: <20241113-main-v1-1-a6b738d56e55@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241113-main-v1-1-a6b738d56e55@kernel.org>

Hi Jeff,

On Wed, Nov 13, 2024 at 09:49:02AM GMT, Jeff Layton wrote:
> The "+1" is wrong, since the kernel already increments the last_id. Fix
> the manpage verbiage.

If it's not too difficult, could you show a small example program that
shows this?  Thanks!

Have a lovely day!
Alex

>=20
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  man/man2/listmount.2 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/man/man2/listmount.2 b/man/man2/listmount.2
> index 717581b85e12dc172b7c478b4608665e9da74933..00ac6a60c0cfead5c462fcac4=
4e61647d841ffe5 100644
> --- a/man/man2/listmount.2
> +++ b/man/man2/listmount.2
> @@ -67,7 +67,7 @@ is used to tell the kernel what mount ID to start the l=
ist from.
>  This is useful if multiple calls to
>  .BR listmount (2)
>  are required.
> -This can be set to the last mount ID returned + 1 in order to
> +This can be set to the last mount ID returned in order to
>  resume from a previous spot in the list.
>  .SH RETURN VALUE
>  On success, the number of entries filled into
>=20
> ---
> base-commit: df69651a5c1abb61bd0d7ba0791f65f427923f75
> change-id: 20241113-main-192abec3348e
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20

--=20
<https://www.alejandro-colomar.es/>

--4nljuu3txwk3t47p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmc0zNIACgkQnowa+77/
2zIgHw//VSXzEkgoyJGcTumIdnqml/juu1Tzv96NgdOzcixCvUs1tIOcTATUPLMG
56Lnt1Elrk+6AXtFHBOYSGyJRHDTMYztnjau9hpa2mU2diRXRD5YV6GoVmq+Ysca
soxhcVC4YgEh0+l6ozCRCMJY/wuUHeAVgkzj1sK7UKUwGM9kDjJ1c7AJJ4Jbh5r1
AUsJIltanJg7WJqXjQmKTuNb9yFEBJEwong1qpwmnddVtp1SorrZVhvdcqDhCrCQ
KVjp3YoVouPqJOiuwD24KKRPUJZz56RSkQ5aG+GBeFUdPDJsa9PIOVXTRFG2nfmL
vhl4RvcI8qI680o4td3ny678u89aD422q/uAlaZJ8NBtVNpNiXHr5+WdSNw6dMvn
//9fyQWhyTG0dubcLt9yI4ipsDWFzdOFdmvIA5Lj9GSpkN18GUXfOt3DE037iyEp
hTacFOyU8tNDUG4yw6FLX9U602J3KbaJQQm26JmCbP+Q1JQ3ApwgYIMzdEcy7uij
oA7dH4NYGGYNYEKXSwU32ekYli1K/B6fvvjHsFUkYa7D3mPI6uT6UXm707TNJlwC
Ot143iGhRDG5F5FF5ZLEW7mZ5yI0UJD6TWY8h5ufER5ivPLd7lB1i97S7kUEhEdZ
DQbR+qkUsS+C8Fi1QGXii6kxFJoHM6a290woflGRmH0lY2ql+To=
=gik2
-----END PGP SIGNATURE-----

--4nljuu3txwk3t47p--

