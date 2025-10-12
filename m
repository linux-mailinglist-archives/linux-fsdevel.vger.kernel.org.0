Return-Path: <linux-fsdevel+bounces-63861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2966BD0475
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 16:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93471896650
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 14:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895BB28E571;
	Sun, 12 Oct 2025 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd5zu8y9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D7027CB0A;
	Sun, 12 Oct 2025 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760281047; cv=none; b=h3JEfx02AeW7v6Gr15us6FSZKQKjnStL1NMD1n+Z48r/VT/QGteHJzYQVCEDIaeNwsskt5RoDMygKAUyDZBfNZAaotYOrWJSkGfNWHM8V2yrjiXFYpXy60s0GxS/lusdAs54m+yVTYEENSmuxjf5La/Wx1ujzmeU2yOP2Ul94b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760281047; c=relaxed/simple;
	bh=SNO2sxi300LjsZ7V6Hj0V5Sw6kaewzPVDPH5waDAPpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZsKkzJK6TYNNf7QFhNUzWg3S7/C0c86t+TCqbCptYsW/ret44YW7oR1U4e4SRfqlE6FgT8Oum+ofsN7nwPnjaUBEY0v0UDSH8tBEXCBtBx2b9vtB+ArqqZoBUNvfbwEMFwq5MydcYfQFFA/kSvm5+PNyfYrUJ6NCVg2rCftsIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd5zu8y9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22796C4CEE7;
	Sun, 12 Oct 2025 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760281046;
	bh=SNO2sxi300LjsZ7V6Hj0V5Sw6kaewzPVDPH5waDAPpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xd5zu8y9NZk3jmfEw3P0Ovsp+70/Pfwp74732S4TxG5Q7Lo1Itsu7WXV/DTLhyDu0
	 JWQiKhLG5E7xknlUKfiPjRMqSX8mPbSZ8JERsnVe8rXrlv+aYWCe4bIGw7jIcuY2SH
	 Gh93WURNc045FfkNiOqWEI19HZ+2JJ53FAtma7UsbMXjoalUMj46mqfxqk5Ry/UhSp
	 s7TkV+zHUWCdCY+CVL8xiyMFAZd6g2MCcXuBXGssiPeokos5+wiD49dWAksL8/aOAI
	 dcjGGJ4rGnvHD0Bajp0ffnZ4hFkaxxbY8tpP3RiGEIJxY0C/ulcNanX/RqThGNFp9s
	 75CR51ku78wWw==
Date: Sun, 12 Oct 2025 16:57:22 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: Askar Safin <safinaskar@gmail.com>, brauner@kernel.org, 
	cyphar@cyphar.com, linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH] man/man2/move_mount.2: document EINVAL on multiple
 instances
Message-ID: <bc7w4t422bvpcylsagpsagl3orryepdbz4qimkuttd3ehtdsfu@thng5d5wn567>
References: <CAMw=ZnSBMpQsuTu9Gv7T3JhrBQMgJQxhR7OP9H_cuF=St=SeMg@mail.gmail.com>
 <20251012125819.136942-1-safinaskar@gmail.com>
 <CAMw=ZnTuK=ZijDbhrMOXmiGjs=8i2qyQUwwtM9tcvTSP0k6H4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u74vvf5ztar4rsjm"
Content-Disposition: inline
In-Reply-To: <CAMw=ZnTuK=ZijDbhrMOXmiGjs=8i2qyQUwwtM9tcvTSP0k6H4g@mail.gmail.com>


--u74vvf5ztar4rsjm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: Askar Safin <safinaskar@gmail.com>, brauner@kernel.org, 
	cyphar@cyphar.com, linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH] man/man2/move_mount.2: document EINVAL on multiple
 instances
Message-ID: <bc7w4t422bvpcylsagpsagl3orryepdbz4qimkuttd3ehtdsfu@thng5d5wn567>
References: <CAMw=ZnSBMpQsuTu9Gv7T3JhrBQMgJQxhR7OP9H_cuF=St=SeMg@mail.gmail.com>
 <20251012125819.136942-1-safinaskar@gmail.com>
 <CAMw=ZnTuK=ZijDbhrMOXmiGjs=8i2qyQUwwtM9tcvTSP0k6H4g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMw=ZnTuK=ZijDbhrMOXmiGjs=8i2qyQUwwtM9tcvTSP0k6H4g@mail.gmail.com>

Hi Luca,

On Sun, Oct 12, 2025 at 03:25:37PM +0100, Luca Boccassi wrote:
> On Sun, 12 Oct 2025 at 13:58, Askar Safin <safinaskar@gmail.com> wrote:
> >
> > Okay, I spent some more time researching this.
> >
> > By default move_mount should work in your case.
> >
> > But if we try to move mount, residing under shared mount, then move_mou=
nt
> > will not work. This is documented here:
> >
> > https://elixir.bootlin.com/linux/v6.17/source/Documentation/filesystems=
/sharedsubtree.rst#L497
> >
> > "/" is shared by default if we booted using systemd. This is why
> > you observing EINVAL.
> >
> > I just found that this is already documented in move_mount(2):
> >
> >     EINVAL The  source  mount  object's  parent  mount  has  shared  mo=
unt propagation, and thus cannot be moved (as described in mount_name=E2=80=
=90
> >     spaces(7)).
> >
> > So everything is working as intended, and no changes to manual pages are
> > needed.
>=20
> I don't think so. This was in a mount namespace, so it was not shared,
> it was a new image, so not shared either, and '/' was not involved at
> all. It's probably because you tried with a tmpfs instead of an actual
> image.
>=20
> But it really doesn't matter, I just wanted to save some time for
> other people by documenting this, but it's really not worth having a
> discussion over it, feel free to just disregard it. Thanks.

I appreciate you wanting to save time for other people by documenting
it.  But we should also make sure we understand it fully before
documenting it.  I'd like us to continue this discussion, to be able to
understand it and thus document it.  I appreciate Aleksa and Askar's
efforts in understanding this, and the discussion too, which helps me
understand it too.  I can't blindly take patches without review, and
this discussion helps a lot.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--u74vvf5ztar4rsjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjrwcwACgkQ64mZXMKQ
wqlhCw//YfJg+RA7uVHjtnCwPaEoTm9QPEBSUVAxS7fm6bW1lsVmvnaTKxulLi0N
WI227k/tBHtbAPLvOz8h6wFHJXRHKRW31Pn5ZyZiK+zY2URXXV3hM0dXUfe3tGSj
qXMtOZjrbvHnOGfh7nnofuXBZJ7SLq824HiJ98yYfah0mDdps96HphDUh0ApDGc1
2QnOvAujJ8VBHan+jusF2Sl9Y+Yutg9k2rmo2GHFctV7C2djOQ2jBsIHFgPDMm0l
gNwddheuzCI0ne+7pwVF0GztRR+Y8hr95mxdrpnnRypfCD3P4OpkVyIIytg3AiYe
mbqvuvMdWgj9QiVpoabY0pslvNSe2tHOHxgua7Vmpa9QuHjsIrEIjSl3reJdyZQD
3XVL1NwM1bgE6gkg1smmsfVPX7aA7Xh99MaTezqRLd764KDgtjoTgGAPSoJpOJUn
cgvyU6V/HhRLXArRbGC5z85OOsEayeNYjF+6xEnXmNwo81bP/Vt4ukj17nTNnzSX
VLf0prhk59t7ArHi6W0NcupZN0niln4hB2Udpttw9ZlgVYMEQXk4/UhaOz1eKhtl
A1olH6kFwiBXakjWvDPQvY0mN3GBvyNFcYQDDq2uMg4oNzAzPA7DEciFva3o8rrg
ptOTDfyH0yvqVKZy79A85CQBLS2jXSyBkN2R0L12CCiXJPMlYkI=
=IKkv
-----END PGP SIGNATURE-----

--u74vvf5ztar4rsjm--

