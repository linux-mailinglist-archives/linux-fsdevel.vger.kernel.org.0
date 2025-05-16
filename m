Return-Path: <linux-fsdevel+bounces-49251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6935AB9BAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 14:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552DB50370C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 12:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EED23A989;
	Fri, 16 May 2025 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGfB309H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D71B1361;
	Fri, 16 May 2025 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747397508; cv=none; b=sZTR55mYImSV6JzGRj0v/o+gzj7TV3zkzKUKWTelft8+1vd3WNUPkonKFgRUjsDbwZR1UdZ9aaPwKXGBCLBSV3ks4yArZKzyuxBLAl270SXQ+JShwtMSgIX4UrSk02vQenw3+MsDWjbwFGD2oKm+GGAuV3lop53756OE/Lfh6lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747397508; c=relaxed/simple;
	bh=w5VgJfHdvLOLFdVKDZsVc50s15u5u2RRfMppTcSzW4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3maZofWxG5dsbHqFgHsta98h/+O4wr+et/B1iJdIuFBBrNcotoBoxHR4TRFuRTvxPZo3TRTHkhS1cp9ELHYXv2MBCnbVAU43DVU3utNC++a0bUdB9oCwCrXTErUM9QstKIiZr6vzNF3cvpP3c+Gu0jpXTYB+ScTbYblANcJxFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGfB309H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7B0C4CEE4;
	Fri, 16 May 2025 12:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747397507;
	bh=w5VgJfHdvLOLFdVKDZsVc50s15u5u2RRfMppTcSzW4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZGfB309HXlwdhTgMLm7FtERG6ibOmZUsBlCf7fpKlmT5Guy8Du8FqBy+1OuXSGY5O
	 8pTZ9Iuu2dYijcHWK9CM33kQVqcDVgtRUBu9NIF208KFuwjY8EYzk5GBjjZCdOwfXf
	 HGfzVNifKXGomH2bsLwyOwsxfYhtUiD1f7t0BqGJKsqg4gtszbVQ2uBPisWu5szC/Q
	 QuFAnTJi2kPDnsXeglxIvU4+FR5aYC2WyVwpoEJlTMFQQgoyFq7KlTQTiCko4YN9rD
	 1GALB41a39Q0saKcA6Qv+k8Fhlm+FHnofr/n4lBt9jaMTloV5imb5IC7QG2Emfe3R2
	 Enw+qJrVC1PWA==
Date: Fri, 16 May 2025 14:11:42 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org
Subject: Re: close(2) with EINTR has been changed by POSIX.1-2024
Message-ID: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
References: <fskxqmcszalz6dmoak6de4c7bxt4juvc5zrpboae4dqw4y6aih@lskezjrbnsws>
 <ddqmhjc2rpzk2jjvunbt3l3eukcn4xzkocqzdg3j4msihdhzko@fizekvxndg2d>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qux5m2kzxfgc3m6d"
Content-Disposition: inline
In-Reply-To: <ddqmhjc2rpzk2jjvunbt3l3eukcn4xzkocqzdg3j4msihdhzko@fizekvxndg2d>


--qux5m2kzxfgc3m6d
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org
Subject: Re: close(2) with EINTR has been changed by POSIX.1-2024
References: <fskxqmcszalz6dmoak6de4c7bxt4juvc5zrpboae4dqw4y6aih@lskezjrbnsws>
 <ddqmhjc2rpzk2jjvunbt3l3eukcn4xzkocqzdg3j4msihdhzko@fizekvxndg2d>
MIME-Version: 1.0
In-Reply-To: <ddqmhjc2rpzk2jjvunbt3l3eukcn4xzkocqzdg3j4msihdhzko@fizekvxndg2d>

Hi Jan!

On Fri, May 16, 2025 at 12:48:56PM +0200, Jan Kara wrote:
> > <https://pubs.opengroup.org/onlinepubs/9799919799/functions/close.html>
> >=20
> > Which seems to bless HP-UX and screw all the others, requiring them to
> > report EINPROGRESS.
> >=20
> > Was there any discussion about what to do in the Linux kernel?
>=20
> I'm not aware of any discussions but indeed we are returning EINTR while
> closing the fd. Frankly, changing the error code we return in that case is
> really asking for userspace regressions so I'm of the opinion we just
> ignore the standard as in my opinion it goes against a long established
> reality.

Yep, sounds like what I was expecting.  I'll document that we'll ignore
the new POSIX for close(2) on purpose.  Thanks!


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--qux5m2kzxfgc3m6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmgnK3cACgkQ64mZXMKQ
wqmQ7g/+Jip34/yVDRBD957zQNTawehf+GH1nGUBERi6dC65xYAkmz+61RVd2hFj
pbtXcv2L+SVhfKBCAVCwCTGBR7vM8AK7xD2C7WayT/GQ6sCjLPVIS7wXPWn5HLHJ
WBT8ywVaHmfJb/sYqF0qONCNxQ4/uorEdwgu+EGLKXmNGrCqO413Ls0UrAFC6ByE
nuZ6U6M/tDKkuj6zrimcn512a0ZT+Hz9FQOT2RBg9AW47PD4am9NDo2MQ599Y6/m
p1zjXa2JeGMVRl+4w5cV2A8SztL6zDueVqR5jyaS+Anhjo/wIuktQQ5cC4mO3jZ0
JwX5IfEJtoPN4u6mGhE6lkwIyT+30F7Dw/m+jKe5kNXE2V9q9L9H89EYxQsRa8al
sMB92K85daplhV5UHlnxajh5gLWVdy7U/jacWQw45sv9ilnh1LYnRP87zvBml+6m
gQ6i/241dkuoQnJiZ15NjfvN+H2Fu4hiF2H69hd4xGIxcP9rUxWTeiWFuIoi8GNb
IMTXb/yWoxs8EEug0a/kZ0YmUfzNeo9u+OemuysG4lvsOdybSOg5/ZN7EPbbcIVK
vPgGsd4E5byz46Fc/gFd8NlRoYh0bzSXnxPAExaLdq72fUQ/2DyZOpgxUqByl95W
+l2N5ckA90XOFuMuQIDoXLdrK97e5Z041VGb9e1xZGgDJbi8BJU=
=0zbF
-----END PGP SIGNATURE-----

--qux5m2kzxfgc3m6d--

