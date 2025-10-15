Return-Path: <linux-fsdevel+bounces-64224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD3CBDDD25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 11:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15DC73A5D78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5CC31B107;
	Wed, 15 Oct 2025 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="ay/6kJRV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FECD31A812;
	Wed, 15 Oct 2025 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521224; cv=none; b=ekpBgleCK0SQJRTEFSq0L2FrayqYlBvWXlGIvSp5PiXShRtpdJvbCf0UMDkKwojrJaquEU++mgbcl5FdK3/Uqokd7z4JqJ143zoiMSWrPr2RsRYTMjqG4xmTjaDVxVCV4z3O/3wTqgAY6KZuTuFL/xRf0jjAwvsKwi3KLbuxLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521224; c=relaxed/simple;
	bh=nhTg113RJazH5EQZAAMIMSjHEMha8gXoEsgVXX8RmN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bjs0aoGT6rt0YoMa0uRrEL4VPe+7L38scCEn3CU3mXQ8E9V3wit2niWA9LeR5lHnyiQKwdGPjRhY0I9S4xEhhH/FmxqgR9VGukj/mw9njfHYPC2pQhrTpnWwugdzvYGYauMyy4ktkimMf5G9zbRF9le09nq5AsuvPOqYJ9A0/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=ay/6kJRV; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4cmmK45JdWzB0Gg;
	Wed, 15 Oct 2025 11:40:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1760521208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lrhw6J3BmlfJs8eKJNlNHXHbstYWFJvdWpyxma0Iulg=;
	b=ay/6kJRVRkHZRSDyh1CzJxAIChS4ZDBOGDXHrNNgJ0E4Ku30Uyew2adH8oyFw0a1oKu2zt
	D/Lw8yorw812MD2Xyq+91Vet+4oq3TnABKE4b6a7bfyOIlyoFORmlmp4ds7OMvJQl8rgT8
	oBdnqJzeabOYpb/NJYo1gOir6ft2KetKuc52UQJO4A9Rou9RybP6NEek8OiTBpdrqLUi/5
	XZjdDIDqKYNUQhCXAKYxMeSCPKzIfWJ0lfNPn/RKfAZIM6Mwnna4k5lyJKGjmP2pUI01Pf
	XvNWYnl04gWKZdYTI7SVdy19HRFHJ8a/IoJ0lBw3YEx5Wm9rBA0kiU5iR4oY7w==
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: linux-fsdevel@vger.kernel.org
Cc: miklos@szeredi.hu,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] fs: fuse: use strscpy instead of strcpy
In-Reply-To: <20250929130246.107478-1-mssola@mssola.com> ("Miquel
 =?utf-8?Q?Sabat=C3=A9=09Sol=C3=A0=22's?= message of "Mon, 29 Sep 2025
 15:02:44 +0200")
References: <20250929130246.107478-1-mssola@mssola.com>
Date: Wed, 15 Oct 2025 11:40:03 +0200
Message-ID: <87wm4wbj0s.fsf@>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

Miquel Sabat=C3=A9 Sol=C3=A0 @ 2025-09-29 15:02 +02:

> Changes in v2:
>   - Add a commit to rename 'namelen' to 'namesize', as suggested by Miklos
>     Szeredi.
>
> Miquel Sabat=C3=A9 Sol=C3=A0 (2):
>   fs: fuse: Use strscpy instead of strcpy
>   fs: fuse: rename 'namelen' to 'namesize'
>
>  fs/fuse/dir.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Gently ping :)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjva/MbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZdpGD/4uNhw1K/qoS0aMWWW3AYouNZZf0gb3hh4U0WZGr4359TIxaG7omzgp24h5
USEvR5TWUWcBLD8rSi+aefj3W4hHv6BtkhcwDJ11HxEThtjbJ5Zn/6423poADJFq
EZKTJ+Qha446B+z8wEjGFpVg+yMi4PLZbkl/s7/IbLMGZptN+W3ARvc79xNPfAeR
+0IslCogGdS55tLjby4tEdeEko3ZDcAb+NZchWhuW5DRxgOOZQ4dCDlISVZFMjOj
NySL5SzzWzW2w3Pme+VaA3t5sNnA994jWrataRCNy7IVj4W8sRAkuqVTgUy285h6
8PfOFmapYr7OQ/FVsnq0TIuYV8Le4KXinSw7cZ/A3Rq+cE2pTYcUu95FXKA/82og
JoMK6xvgEpAvdf74ui9K6KliZFFNQ23EVPfuf4rcQC2AeMh6NRTgyQlBLCgJT1yN
X21JS00CmLNZPTTGaLWyvhlbMvkRHTImRfoOYzkPAPmapk7k71SB+JApvmCODv6h
3YDvhn3t28rD+ycLHbe+j3kB6oINzovUDA1ehKt4NrdySpj47QVtKjnjmPj926fP
7to8L0WhUO9kjHLinGp/BZfyLH6X4ryQYr2tOiRE5m7V/RE3XjCYIQguv/3np/a9
DVog9WkkycwBqJup70TA7W357odk6zMDKCtnZdpFNqcujPa/4g==
=/L/q
-----END PGP SIGNATURE-----
--=-=-=--

