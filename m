Return-Path: <linux-fsdevel+bounces-36089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 840929DB805
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 13:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11850B21436
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 12:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A369C1A2C04;
	Thu, 28 Nov 2024 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="w9GAH5iZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374F319F127
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798559; cv=none; b=STgP9bKxdTHe48LUGUaY7xuI8B4VQIfVRHAhyUzszo5IZ+u7CP/FaSvsET/2WL99TwGSsT8xNlTGw1sHScw5Qs2i2IDyYhPvwduEu2qrF0KZdcF5HV+ihQta6pqpV8Psgt/pT56QsWPpWKstXHP0dZOFG/JKbVUz5pvsAOZwojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798559; c=relaxed/simple;
	bh=F+F1O+2xp5yPSB2suDMDLml7ERto8lgniFtXwEg5xwM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nZQZRmZAIE6dPn1hNmMN8Qh077u/ZoUclCo7tWOjH6cf7R6VBVvS4i97qXFFwpU7di9d9OF+pRsh+Fm8fDBH8hIhVDcC+XcgBwkWwzMKD/tWnXexQWHZ8oLWwbBQIsRR03dh8hOpO7gWKNONkxin1wwBgocjEOpmSS+bq5/ItKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=w9GAH5iZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1fdMBII0YIecx9BgjS6+RL2RExw4PaItvLvWv4UXsTU=;
	t=1732798557; x=1734008157; b=w9GAH5iZ9zaD7ubAxCh2hvKJEftsLFOhHsIrG6wqx4OPiOy
	bZ5mzhHhj298s8iooWxiRBOHJsN3U2Cyry9bYlmj4oXUOOY5DUjun8REnpl2NXE2L/wVj1BO6PqRd
	VAAKtDIPoeaLMX+O4U3Ot4AzOrafBlJOs7JPS9KrEFmJv9rwNhdRF94DrSgN0FsCIBnEilqHfmKvD
	XJKDThO9sBxLssHGLpeCD2Alwet1DjOLjBJwGWOWCuATbSXlvYiGi8p/UxgpJF06JkGVzKSRNjI4i
	YQnu4ABTmmMStyCL8TO/C6Z2jLS/jp2en/7dy9Dz+ggzK+p9tmsSjxh0jwQ6h+ag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tGe3g-00000000D12-1x0E;
	Thu, 28 Nov 2024 13:55:48 +0100
Message-ID: <2fb819b00563afbeb69c156b463dd41335c430b6.camel@sipsolutions.net>
Subject: Re: UML mount failure with Linux 6.11
From: Johannes Berg <johannes@sipsolutions.net>
To: Karel Zak <kzak@redhat.com>
Cc: Hongbo Li <lihongbo22@huawei.com>, linux-um@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
 Benjamin Berg <benjamin@sipsolutions.net>, rrs@debian.org
Date: Thu, 28 Nov 2024 13:55:47 +0100
In-Reply-To: <c7hrptra3k6g6jwemz3h5gp4syyz4bttpnepdhpa33htnrltxu@iuusct5yzaso>
References: 
	<ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
	 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
	 <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
	 <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com>
	 <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
	 <ykwlncqgbsv7xilipxjs2xoxjpkdhss4gb5tssah7pjd76iqxf@o2vkkrjh2mgd>
	 <6e6ccc76005d8c53370d8bdcb0e520e10b2b7193.camel@sipsolutions.net>
	 <5e5e465e-0380-4fbf-915d-69be5a8e0b65@huawei.com>
	 <uppzc2p5bn6fhrdlzzkbdrkoigurkii5ockigngknm4waewl5z@z2a6c6iivu7s>
	 <f565e434afc84090ffd7bff69ce9cf5643302233.camel@sipsolutions.net>
	 <c7hrptra3k6g6jwemz3h5gp4syyz4bttpnepdhpa33htnrltxu@iuusct5yzaso>
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

Hi,

> > I'd argue though that this doesn't count as fixing the regression, sinc=
e
> > the kernel was fine before the changes there (even before porting hostf=
s
> > to the new API) with _any_ version of userspace. Except perhaps for whe=
n
> > there's a comma in the path, which I suppose would've broken one way or
> > the other by mount(8) moving to the new API?
>=20
> Another option is to hardcode a libmount exception that, for hostfs,
> the default behavior should be to use the classic mount(2) syscall if
> the hostfs=3D option is not present.

I'm not sure using the old mount API would work because the kernel
converted internally to the new one now. Anyway it'd still be a kernel
regression if we have to fix it in userspace, no? :)

> > Assuming no commas, would mount(8) today send the path as the key to a
> > flag option?=20
>=20
>  Yes, (I have no hostfs here, so example with ext4):
>=20
>  # strace -e fsconfig mount -t ext4 -o /home/hostfs none /mnt/test
>=20
>  fsconfig(3, FSCONFIG_SET_STRING, "source", "none", 0) =3D 0
>  fsconfig(3, FSCONFIG_SET_FLAG, "/home/hostfs", NULL, 0) =3D -1 EINVAL (I=
nvalid argument)

So I guess that means for paths without comma (almost certainly the
overwhelming majority) we could somehow work around it in the kernel.
Hongbo, what do you think?

> > We could perhaps find a way to handle that in the kernel,
> > and then just do the longer-term plan of moving users to hostfs=3D"..."
> > (by documentation/warning) in the future?
>=20
> The question is whether investing time in using the path-as-key
> approach makes sense. Perhaps it would be better to stick with the old
> mount(2)

I think it's a matter of not regressing for users, if they just update
the kernel and have old or existing mount tools. And I'm not convinced
using the old API will actually fix the issue, I think maybe the kernel
itself would break that too by parsing it now for the new API?

> and focus on developing a new API that does not have any
> legacy issues. Users who choose to use the hostfs=3D option and the new
> kernel will be able to utilize the new API.

Right, but we already have that - you can specify hostfs=3D"quoted path"
when everything is new and it'll work just fine?

Question is more around the regression, to me.

johannes

