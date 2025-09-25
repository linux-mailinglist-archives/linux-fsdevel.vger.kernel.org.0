Return-Path: <linux-fsdevel+bounces-62782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F29BA0B44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 18:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC1D3A44F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 16:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E4F307AE1;
	Thu, 25 Sep 2025 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQY23nqm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD6502BE;
	Thu, 25 Sep 2025 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819157; cv=none; b=D3+F1S7Ldnc6kN2kyxewef0wl40JdHU9fvZM8QBSIIt3PeZR1HARbDdC4wsE4mAJMFOh2Zt9BMu0uV0D70SO6oxaBVVKsYy1e/ksPj68RVjNmH9TxEyacXYGyV4oXRzC49iAhZNhL9LB1B0IC0XnY93eXIrfg/X1lAlH85UcTYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819157; c=relaxed/simple;
	bh=5+rHDwE9Z0JHu+1+8KwTTteIm1WSIP9vhsm0etHWnw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFwrV/Yctoj9KQHagbsuLpFYm8pnJ4du8NIDiGH5oD5Zotv4R0Py0UgmuxucGeDU9lZziUfzCne+SdbWXItDj+qGUV8og65BQcmSKoQPl1L1DPVUdSsmceyDvfF0dZYCsDEdG9hMLOBg77msN09FM49jlvIJ2lxf1XOxv8OrgHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQY23nqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3802C4CEF0;
	Thu, 25 Sep 2025 16:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758819156;
	bh=5+rHDwE9Z0JHu+1+8KwTTteIm1WSIP9vhsm0etHWnw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eQY23nqmdocDy5mc8OUJkscBEokjauccN6uXf+QYKWIF6Ihrac0YjZssra44CGbOO
	 9r341lHQ5w8VkPKaH2xpJkt8FCz1t1Vj5HkcIMkY1tVyHpqWodZ1O5vXQNwVT6UjiP
	 TBmnoWK7I3dkXwOfGUlmltAmQO6NMKufAufgZFvhhnrWTDj5l/+0bx+Sa1oyXEegcS
	 ETdAqo+oeLZqFXYdivQYwPKPQG2tcUaIjcpkAb8kob4dSYI0V6Kc9kM65DAjaU8WzR
	 D589924zX3bh371xa5slUsPVNqUz+DfiLsq/AcU02RNQ46VTxUNaDvEj4+xEbPZNos
	 KXN5F13FkGa8w==
Date: Thu, 25 Sep 2025 18:52:28 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5 3/8] man/man2/fsconfig.2: document "new" mount API
Message-ID: <6yohe3iuycygxvwwxa3rkwcfqe7pe7z4x7g7enmyacjrthg6se@jw7cujrai2ht>
References: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>
 <20250925-new-mount-api-v5-3-028fb88023f2@cyphar.com>
 <brqynohvpwo4hqdepvqks3hluq3jng6bnd7xtensee5adgtxem@3ughtcvv57si>
 <2025-09-25-azure-rubber-flair-menus-42bRw8@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="77tbv3jcbebrhxmc"
Content-Disposition: inline
In-Reply-To: <2025-09-25-azure-rubber-flair-menus-42bRw8@cyphar.com>


--77tbv3jcbebrhxmc
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
Subject: Re: [PATCH v5 3/8] man/man2/fsconfig.2: document "new" mount API
Message-ID: <6yohe3iuycygxvwwxa3rkwcfqe7pe7z4x7g7enmyacjrthg6se@jw7cujrai2ht>
References: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>
 <20250925-new-mount-api-v5-3-028fb88023f2@cyphar.com>
 <brqynohvpwo4hqdepvqks3hluq3jng6bnd7xtensee5adgtxem@3ughtcvv57si>
 <2025-09-25-azure-rubber-flair-menus-42bRw8@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <2025-09-25-azure-rubber-flair-menus-42bRw8@cyphar.com>

On Fri, Sep 26, 2025 at 01:15:14AM +1000, Aleksa Sarai wrote:
> > > +.TP
> > > +.B ENOTBLK
> > > +The parameter named by
> > > +.I name
> >=20
> > There's no such parameter.  (I guess you meant 'key'?)
>=20
> Ah yes, I did mean "key". The same mistake was repeated for two EINVAL
> cases above as well:

Thanks!

>=20
>     EINVAL One of the values of *name*, value, and/or aux were set to a
>            non-zero value when cmd required that they be zero (or NULL).
>=20
>     EINVAL The parameter named by *name* cannot be set using the type
>            specified with cmd.
>=20
> Do you want me to send another version or would you able to fix it when
> you apply?

I can fix it.

Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--77tbv3jcbebrhxmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjVc0wACgkQ64mZXMKQ
wqk/gw//f7pBPVJBqklCrSLPBh3CVterkUO1bMxlzsPi43dy6GpeWNgQZQUmW0Ar
2ihji1PN96HLnHxsqjFVGKr37AL0jt/5MKMlxNGd3ee3vPwts/VezqmPe0KPACic
Jp2rs77e98wjfXdTc/h9GUZ8hYlMqCAL9GUIIA0FU9B/E/C93i2uJdDhocGPBl1w
NQf2uXV+dM7up3VSWoOEq75YddhsyXK8GBaXLN9AHPnzSrXVc7U4d+y15Madybcv
JeW0CWpuUazXj1mkLTvxYbYgelXXDxH+wxH8cbB9Hno120dixAynevjT6Pq2pPI5
dIhHOxqc7uO8by50516gwiDJ4TbsgkOfP4U8OremPDwPphghpZLEHpIFc+aKyOQP
C32zZvdSrtXlyeIZ+e9sxEyv+LNgycaCkRNXNZ5QDB4vtAEbtE+o6zcJICwiDvCQ
L4JtBci7tg2ObLDZkevP6dLjLcaf/MT6tGcwYnjbyTCGhO+knB/bkkxvRVFvCi2+
PI4DKT81GkNhot3ajV+jTCBbUbqBCvwnrOdMs7f9EIll2T4Uu3qNxAGkF36oztvk
ZNZhG0UamF8waovFpNungKK2Y+Ag0Ktt9spaiSzWv99JGzDRC++QepBTYhoCDzMU
G14xV85LLUt6nLSf8mzUBe+5i8N4HKMvH175PaURHCB+wWgq5NM=
=TrVs
-----END PGP SIGNATURE-----

--77tbv3jcbebrhxmc--

