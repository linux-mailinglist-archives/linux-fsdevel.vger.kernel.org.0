Return-Path: <linux-fsdevel+bounces-63859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E493BD0293
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 15:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47EC03B7BAE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 13:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8F3257834;
	Sun, 12 Oct 2025 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/FXu9wE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889AB17A2E1;
	Sun, 12 Oct 2025 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760275023; cv=none; b=JYiOJ4JKj8MZjSQiYea3w1QTJGvtl6c7Bd+77y4EWB/M+r4o/Yg4t4WVgSmV7q/12p3hoVVKMPgIAWAj2mE8aXrT2abB2zmSCm+eeg/oTvJbAlxBIFLX+PXOzMhH2pGwqm6v7U/ZVJjsQKUe9qCrqlUxlmUSgjpvl/eCpeO4VvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760275023; c=relaxed/simple;
	bh=BkYwbqr8hP5sgdtVFHqbNO7xt3qb4rWPMb4PslaLdMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdcAte27xnZsbDge9gM+8RMn+1VRQtRgRK0dWClfJTWnQVyixG60Wbr+UiIJOqDueFA+zU+kxPC0BovWzyesszI/fWcDkdQoh0yIr9jF5EYDLqu7DG6A6Ns6mD27i87jHCus82jy0ivGEn0cXnRSL4fZ1byFm+8aIPCuHf8XLlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/FXu9wE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CB2C4CEE7;
	Sun, 12 Oct 2025 13:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760275022;
	bh=BkYwbqr8hP5sgdtVFHqbNO7xt3qb4rWPMb4PslaLdMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/FXu9wEMlzZ/fi2LZXJbOTqhlIPGzImvq6D8tAZuaAaYuG8nesNaAjfSueeNImla
	 pA77uAPis9yk7uBGSO6Jnq9Y5H6DSZhxpCnbkcyOk6QugR89pAGSGMSR57H9zp5Sun
	 I6KdkjiXFozcJhLC9Tn/4lNlAoVdn29gnGXXy3kdjNMqMYKITtrLHtJji0+0sJ5btH
	 wjzA6mnmq5SMYF19upwd2UwZBFGreXNBjc9gVYlq2tBSdQSehPXBGuGNTDcYUa4H+0
	 UYYVHjAhemsyC9m242nwJkNPfxdyDlA4am/ICgmeunTSGtT/HfeUYj6l0/8Z5oivKf
	 J/fdA8lKVI+ng==
Date: Sun, 12 Oct 2025 15:16:58 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Askar Safin <safinaskar@gmail.com>
Cc: luca.boccassi@gmail.com, brauner@kernel.org, cyphar@cyphar.com, 
	linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH] man/man2/move_mount.2: document EINVAL on multiple
 instances
Message-ID: <wk3t24r7dr5kdgb5uy4hz2ahwsd5vkkuwjch3y7kwwybemlmg4@lb2ewcanzf3m>
References: <CAMw=ZnSBMpQsuTu9Gv7T3JhrBQMgJQxhR7OP9H_cuF=St=SeMg@mail.gmail.com>
 <20251012125819.136942-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ro5fxcm446dfrknp"
Content-Disposition: inline
In-Reply-To: <20251012125819.136942-1-safinaskar@gmail.com>


--ro5fxcm446dfrknp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Askar Safin <safinaskar@gmail.com>
Cc: luca.boccassi@gmail.com, brauner@kernel.org, cyphar@cyphar.com, 
	linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH] man/man2/move_mount.2: document EINVAL on multiple
 instances
Message-ID: <wk3t24r7dr5kdgb5uy4hz2ahwsd5vkkuwjch3y7kwwybemlmg4@lb2ewcanzf3m>
References: <CAMw=ZnSBMpQsuTu9Gv7T3JhrBQMgJQxhR7OP9H_cuF=St=SeMg@mail.gmail.com>
 <20251012125819.136942-1-safinaskar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20251012125819.136942-1-safinaskar@gmail.com>

Hi Askar,

On Sun, Oct 12, 2025 at 03:58:02PM +0300, Askar Safin wrote:
> Okay, I spent some more time researching this.
>=20
> By default move_mount should work in your case.
>=20
> But if we try to move mount, residing under shared mount, then move_mount
> will not work. This is documented here:
>=20
> https://elixir.bootlin.com/linux/v6.17/source/Documentation/filesystems/s=
haredsubtree.rst#L497
>=20
> "/" is shared by default if we booted using systemd. This is why
> you observing EINVAL.
>=20
> I just found that this is already documented in move_mount(2):
>=20
>     EINVAL The  source  mount  object's  parent  mount  has  shared  moun=
t propagation, and thus cannot be moved (as described in mount_name=E2=80=90
>     spaces(7)).
>=20
> So everything is working as intended, and no changes to manual pages are
> needed.
>=20
> On the other hand, this is a good idea to add a bigger warning to
> move_mount(2) (and to mount(2), it is affected, too). I. e. to add someth=
ing
> like this to main text of move_mount (as opposed to "ERRORS"):
> "Note that systemd makes "/" shared by default. Moving mounts residing
> under shared mounts is prohibited, so attempting to move attached
> mount using move_mount likely will not work".

Maybe under a CAVEATS section?


Have a lovely day!
Alex

> (I personally don't have plans to submit this as a patch.)
>=20
> --=20
> Askar Safin

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--ro5fxcm446dfrknp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjrqkQACgkQ64mZXMKQ
wqnBMA/+PazY/RMbkLN+Xb8TXm10BGceTr106LJXopiwsPQHrKUyJBLYjvHnk95x
WCwiiRZSfTCWRAA4iQczrYFP1BjhRZHuOaiPP4dQxEbf12ZIKhYibt3YChqVjGvE
4l63/7A6GMqiZa0N8mO9affOfzqkby5++9ya1AdUHhPYKlABKUt70D/mJZAc/HCf
fNrXH2HaQVrlSDrD8N0n4xnKm4dnRxX0YXU58ot1+Nz0SdcRQ9vXW3fn4QcF115i
AX1EsUZ15pM7SQeSv0YlJiUil4glsCWj1/TPFD5JJN5xFmcVrw2Lq7874JcxkFJ0
Zub7p/RPsWcPIDvanCmbbtPRafKYWN3mH4E1xZUItQVV5GUhQWvKxXFz/POkq7T3
8DemfPpih2GkFgOWTdCtK47FckjKkgFxHkOqxvxb0RlR0tb34d8Q8BukjzG18o8H
+JfQa2qd+gQFkKkIi9y3OHYQuT2+PuxA2qlhALgn/oxryjgDeEAkN+rS2+YgIzmW
anN1QzB3oYH7KARmP/yM7ZRr3ELk3q0IkgkoRnQxtCHxO/HFDS4997nfAZijKpeb
c6VyQs6+Z+nphOe423SuM5MJ4Kujg4lRV0nd0PS+E+sxUgU208N6ob2Vp2CDwXew
7ZDFGy5g913jzbhiXAA9i490H6cNlA5zP3/w/Zq0yqI4ukg14MA=
=UJqW
-----END PGP SIGNATURE-----

--ro5fxcm446dfrknp--

