Return-Path: <linux-fsdevel+bounces-59367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 745C0B3838F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 15:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32534981064
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 13:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6C42F9C39;
	Wed, 27 Aug 2025 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="YAcxn6Wn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876039478;
	Wed, 27 Aug 2025 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756300589; cv=none; b=jEv/Z16llZx69TcHY1EE8tkBr4wcLMTVXAz1xyPJPfxFmBQpOtE3K/N8JeUP54JpNaqVQG43pbZnTyilzQrwx5bNNrzEpvaEfaUTQuk7LZutHaujrlPH0sA/4cjyuyW9R6SbNKEkNTJ4m6C6/LG8v1QVnIFAhKuyqnyLNib+OIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756300589; c=relaxed/simple;
	bh=YPiuLA14z0ZSDSFR+J6rNXav5UJ6t5uKuX5kD58OoVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKPLTRBL0gDOsLSjZTvado5f4rLizLLYQFv9Ua31CdkIDF9MrfL3xAr+xfZWTUGjaF8SJGXdV9UYAkEeG/oyRbiHYRup7vAWa1kYK08SNl6wTdsGp19gYU8542Yp8n/xCe3uXtKrr86n3Z/xlaOYgL5BghCY75LyB8hoJaPw0TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=YAcxn6Wn; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cBlR55sfgz9tPP;
	Wed, 27 Aug 2025 15:16:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1756300577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YPiuLA14z0ZSDSFR+J6rNXav5UJ6t5uKuX5kD58OoVg=;
	b=YAcxn6WnfLlwSotgQNvMvzmosiG0s8iOJvnEqKGz8/DkjNmxgtkBVC3Gb/55UHlAZ1t8VC
	vzh4IOxVc0B8vad4By06gd9ZwgzL6Eqj6rJbxfVIkN+FpHAME0rUbtQaZZACeJ1qqM6gvJ
	Rjgo8Tp4nV6WmuZXHsUIw037W9huPD1V8Z4FD/2ya1qC/RC6oKsYYkm21W3tzjofHPgJjx
	WjTxMr3sDLTqRSDuUHP83GuXyJVzHpwUzPYVzDWh+lGHZ4T4rgb2ixbiGXzI6l/sXh36Gc
	OtJu2QLNjEKnnwkkx4yAjeDa+xLugB5eCDagh3f2Q1mqFIZzRLa/7hzKaVV9mQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Wed, 27 Aug 2025 23:16:06 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: ETXTBSY window in __fput
Message-ID: <2025-08-27-powered-crazy-arcade-jack-Ajr33h@cyphar.com>
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru>
 <20250826220033.GW39973@ZenIV>
 <0a372029-9a31-54c3-4d8a-8a9597361955@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="adc5k7wdm2kkekxj"
Content-Disposition: inline
In-Reply-To: <0a372029-9a31-54c3-4d8a-8a9597361955@ispras.ru>
X-Rspamd-Queue-Id: 4cBlR55sfgz9tPP


--adc5k7wdm2kkekxj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: ETXTBSY window in __fput
MIME-Version: 1.0

On 2025-08-27, Alexander Monakov <amonakov@ispras.ru> wrote:
> > Frankly, in such situation I would spawn a thread for that, did unshare=
(CLONE_FILES)
> > in it, replaced the binary and buggered off, with parent waiting for it=
 to complete.
>=20
> Good to know, but it doesn't sound very efficient (and like something tha=
t could be
> integrated in Go runtime).

Can't you create a goroutine, runtime.LockOSThread,
unshare(CLONE_FILES), do the work, and then return -- without
runtime.UnlockOSThread (to kill the thread and stop it from being used
by other Go code)? Or does that not work in stdlib?

We have to do this a lot in runc and other Go programs that mess around
with unshare() or other per-thread attributes that don't play well with
Go's process model.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--adc5k7wdm2kkekxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaK8FFhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG/uMgD+Nw2Bw0J2ry4G4708EGkU
QlS2QqJQUDfkqcdDW49kSakBAIOVgA9M4tjroGlKNYHsCFlsjENagqUIu7d+tFUD
TL0C
=3vVZ
-----END PGP SIGNATURE-----

--adc5k7wdm2kkekxj--

