Return-Path: <linux-fsdevel+bounces-20073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227808CDB05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 21:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4531F23398
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 19:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417DD84A58;
	Thu, 23 May 2024 19:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="gnqzY1q2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792B18061B;
	Thu, 23 May 2024 19:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716493550; cv=none; b=pw5btizX7bnl9+GOEDqtanEtCSlFBrGInCkcm0dFmvclflLWAsl8boFGK39DbHUGuCPVti53jSM25yo5595H6n7q/gX1KVeGh2PeLd7dsMbiMJX2PNQ1j8WttKaL9QE40lmarb1sn5xJTdo6fyVdTxzSO6G+f01RSKhigZfOhm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716493550; c=relaxed/simple;
	bh=suW3GGRHrjJIcAY7OW7Ok5VFj60O4sU6Cm3t0FyJG/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ec/BgClSRyqG7FT0eZhkBPzgQ8Baq6Npjfj5UTwu5qyCV8jftzrCoZGxvJOUXfaOHZBXt6kHPZL8gOfRInT9QAQiGgV7GnqHWrFMCl+7sn8hph4VLdIxVsdI3pfgONTxiz2+ho0NabNT/TVNzG6MoqajuAgubWt/JxrY1qP8k2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=gnqzY1q2; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 102131C0093; Thu, 23 May 2024 21:45:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1716493544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5bgmiF1OU1Nbz7ymvjKqnLxWQ/rqAzYMDHgcf+JIeIo=;
	b=gnqzY1q2qxuY04uz4lhAFpzGKfBhzyoCNZswDSWL7JTPNGCkGwRRiP2C2iOIYzGFKk02h3
	zICksWzbKD2PbrkaXkha+Hp6oLPHsnHe68aoZHLEofvjs6Tuq7osJSwDb4R1yqgKGDdHwP
	Enbo1nY19hwC0WFcisGawecfK3SfgTA=
Date: Thu, 23 May 2024 21:45:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/2] Improve dmesg output for swapfile+hibernation
Message-ID: <Zk+c532nfSCcjx+u@duo.ucw.cz>
References: <20240522074658.2420468-1-Sukrit.Bhatnagar@sony.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2vHzQoJ74uUpPseM"
Content-Disposition: inline
In-Reply-To: <20240522074658.2420468-1-Sukrit.Bhatnagar@sony.com>


--2vHzQoJ74uUpPseM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> While trying to use a swapfile for hibernation, I noticed that the suspend
> process was failing when it tried to search for the swap to use for snaps=
hot.
> I had created the swapfile on ext4 and got the starting physical block of=
fset
> using the filefrag command.

How is swapfile for hibernation supposed to work? I'm afraid that
can't work, and we should just not allow hibernation if there's
anything else than just one swap partition.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--2vHzQoJ74uUpPseM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZk+c5wAKCRAw5/Bqldv6
8tcBAKCDy74KhiOm4q60gSEHa8GDlI+zgQCfb5XaPSZ5oKNmTg/9KAjVG3czEZY=
=6unp
-----END PGP SIGNATURE-----

--2vHzQoJ74uUpPseM--

