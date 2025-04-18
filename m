Return-Path: <linux-fsdevel+bounces-46679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872F5A93B7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 18:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507FA1B63317
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 16:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BF5218AC7;
	Fri, 18 Apr 2025 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="cIVL3/qM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AED1A8F68;
	Fri, 18 Apr 2025 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995460; cv=none; b=ueQUV6z3+av6EqYl3iSYS1LrooE7AR+uR46csU3qsng4Z7qsVCPzwAfz+hj6j4EWrLWa2G7FBAgv+NUlF7TwwqKWeATPLcz0d5bhxkRaS4XYImADFHFQhq8nPTpt88b1ezSMX0sNJaOez3H+LtSFeDFmaNTQfWnNvdlH8cQ3tzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995460; c=relaxed/simple;
	bh=oMUnQpA3i8Z6l1WvnRE2YkrR/PCt4Rv+k/8Npl7LEHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Soys9FCxodHoYuAOeYXe7BhRMqnOP20bQY3TwPPoDQFNcBRmyuzHW4sTCuEcqOd84duLKaq6FhU/VlvQshVZN+LbNqZ6pLSBUzewBB0pqHW2ZIuTCvbmj/uL7jWAkl3ekbDsIgTDooUcBQVJNeKdAscIOkRhOHpvglXNTeZWHZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=cIVL3/qM; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A40091C00B2; Fri, 18 Apr 2025 18:51:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1744995098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PSbe1n/k0ulYtGbIXI96CO1VrCv/UaM1rOskyi49O2s=;
	b=cIVL3/qMttdCGnkI3NL7gUW1Aii+xIXKQlu+Jek5MvBLY6ydcrFrlqT4Ue5CCsoac2cCnB
	iHtXGV20tgwSl5izXQJp+I4Ti6t+1MlUjbiBbAd5F+pfSwQ9osFGUkhwKEjmxk/imNvPg4
	Xel9S8KHEQU4/S5N/eYEo/2ihftbRpQ=
Date: Fri, 18 Apr 2025 18:51:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10] umount: Allow superblock owners to force
 umount
Message-ID: <aAKDGmxq/snqaYhQ@duo.ucw.cz>
References: <20250331143234.1667913-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hXfHA1BSXmrE6BXK"
Content-Disposition: inline
In-Reply-To: <20250331143234.1667913-1-sashal@kernel.org>


--hXfHA1BSXmrE6BXK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> [ Upstream commit e1ff7aa34dec7e650159fd7ca8ec6af7cc428d9f ]
>=20
> Loosen the permission check on forced umount to allow users holding
> CAP_SYS_ADMIN privileges in namespaces that are privileged with respect
> to the userns that originally mounted the filesystem.

Should we be tweaking permissions in -stable?

Best regards,
								Pavel

--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--hXfHA1BSXmrE6BXK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAKDGgAKCRAw5/Bqldv6
8hXYAJ0VzMdgdBf7hf3v5zp6JfimQyBy2QCdGT8OJNHhSAJADySZcsjEl500YVc=
=DNza
-----END PGP SIGNATURE-----

--hXfHA1BSXmrE6BXK--

