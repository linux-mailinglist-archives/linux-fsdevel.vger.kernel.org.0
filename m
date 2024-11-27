Return-Path: <linux-fsdevel+bounces-35986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CE29DA84D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 14:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190E016059E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 13:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C5E1FA254;
	Wed, 27 Nov 2024 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="T0+rA6c8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954161E51D
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732713370; cv=none; b=NEiYwoLOrA1G5RHjd0gbGbFE8xFtF0MhiaTlm9dHPsY1c24os8VHrqUCuiYAm8Xw1e1NmQ9dEsjyWx2PA7SUdBZjuMSgXobLicd4FpjxNhj68HIoymYfEtaqfcasd3E9mQSGacPBgyen0cypJB+X/a8bl3jLSRQYF4q4qSdYy2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732713370; c=relaxed/simple;
	bh=cDO6hRBvXOzKRTng99NaLS5Y1vb9ftp/HktUzI73lYw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DzNbIQruooFSIYrjAZBtVLbrgW4YlDc65FGcrOSl1j/hB8z5bxoPrBNJG8hxaCGj6BAPfc3gk2pWBt6ku9tUxCGDSafMniIbMZnbHwiYCd+ij/IhRsVjjhnMqatDHVIrg9C4JEKxSm0zY2D1d1X9/6npFL7XjjiuUOnGBtXGtbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=T0+rA6c8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pkTk3XHy13zAGY9taqN3APN+Punlp6wKTidyILus54Y=;
	t=1732713367; x=1733922967; b=T0+rA6c8d6B+c0JWukzYzaYRNC+WHsWEU0mylNXc1Nn0xgJ
	qIcH5vKVEbGR3zqj7DMgvVoH3NBSp528vap7BQ3PNB8P1+m2BqxaUfZQY91BuFHyd9+PsUsFydErK
	S948mgO/DIgKupi3wMa/fQAAWRtYGbItem4IaArJcCI7SKfy28ZFgtWYFwDJVTOVdb/tnshP6lhg2
	Dux5eOFXerHvBo4lrSV8bi2B9Urln4RcOmyMV0RQMkf+Rvtl4K9y7f1uzoQbGep2US5Pf1caXjEia
	GZ1SGJy5ylYuOakgOxMVCgPZ9mFuuj1YmLsjx/dArNuclDfNOhTMlFHOPOYEn5pQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tGHta-0000000Ge8T-3zNq;
	Wed, 27 Nov 2024 14:15:55 +0100
Message-ID: <f565e434afc84090ffd7bff69ce9cf5643302233.camel@sipsolutions.net>
Subject: Re: UML mount failure with Linux 6.11
From: Johannes Berg <johannes@sipsolutions.net>
To: Karel Zak <kzak@redhat.com>, Hongbo Li <lihongbo22@huawei.com>
Cc: linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, Christian
 Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>,
 rrs@debian.org
Date: Wed, 27 Nov 2024 14:15:54 +0100
In-Reply-To: <uppzc2p5bn6fhrdlzzkbdrkoigurkii5ockigngknm4waewl5z@z2a6c6iivu7s>
References: 
	<420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
	 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
	 <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
	 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
	 <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
	 <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com>
	 <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
	 <ykwlncqgbsv7xilipxjs2xoxjpkdhss4gb5tssah7pjd76iqxf@o2vkkrjh2mgd>
	 <6e6ccc76005d8c53370d8bdcb0e520e10b2b7193.camel@sipsolutions.net>
	 <5e5e465e-0380-4fbf-915d-69be5a8e0b65@huawei.com>
	 <uppzc2p5bn6fhrdlzzkbdrkoigurkii5ockigngknm4waewl5z@z2a6c6iivu7s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Let me try to unify the threads, and perhaps further my understanding -
you seem to already have much more of that than me :)

> > > But this is still a regression, so we need to figure out what to do
> > > short term?
> > >=20
> > So for short term, even long term, can we consider handling the hostfs
> > situation specially within libmount?
>=20
> Yes (see reply to Johannes ).

I'd argue though that this doesn't count as fixing the regression, since
the kernel was fine before the changes there (even before porting hostfs
to the new API) with _any_ version of userspace. Except perhaps for when
there's a comma in the path, which I suppose would've broken one way or
the other by mount(8) moving to the new API?

I'd kind of prefer we fixed the immediate regression, at least without
the comma, in the kernel. But I guess you can do whatever you can get
away with ;-) And it's already broken for two kernel releases now ...
but I guess those haven't percolated through the ecosystem *that* much.

[from the other email]
> I can add a temporary workaround to libmount for hostfs, which will
> automatically add the hostfs=3D key for unnamed paths. This will allow
> you to receive the expected fsconfig() data from userspace.

so I'm not sure this makes too much sense - kernel upgrade broke it, I
guess kernel upgrade should try to fix it?

Assuming no commas, would mount(8) today send the path as the key to a
flag option? We could perhaps find a way to handle that in the kernel,
and then just do the longer-term plan of moving users to hostfs=3D"..."
(by documentation/warning) in the future?


> > Such as treat the whole option as one
> > key(also may be with comma, even with equal)
>=20
> There could be userspace specific options, VFS flags, etc.
>=20
>   -o /home/hostfs,ro,noexec
>=20
> Is it one path or path and two options?

Yeah but there _aren't_ in hostfs, right now. So without the mount API
we'd not even be asking that question since the parsing was in the fs
and hostfs would just never have done it, I guess?

> We can automatically add a key (e.g. hostfs=3D) and use FSCONFIG_SET_FLAG=
.
> The goal should be to get the path as a value, because key is limited to
> 256 bytes.

Right, we can do that going forward, but it doesn't really address the
regression?

johannes

