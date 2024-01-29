Return-Path: <linux-fsdevel+bounces-9372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC1384056D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 13:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4463E28158C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 12:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A1E6281C;
	Mon, 29 Jan 2024 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b="Y44hyiBD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3F76280A
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532405; cv=none; b=CI29jzinuLpMbeDVdDns/S971R2zFXVgkjSXlfoW18OvRXAAgCNe9iXDSYtNCgAOENEa2g025dfFSrMDYxR5HAIbiXKnUAs+CoXfUwBfHUR+komvPSVMqNUS4n9lmP+USxmTAzVq7JKNcNC1XA5mu8KjAL+Ab38GgRNaktx8q58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532405; c=relaxed/simple;
	bh=e3tRepqaqAq0gFn1a6V9/8QSIPa33zv53P0dDrZrCkA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/Alvpay9295oh/JM5wvji1+7hpcCvB+3PBz2u9nkxTfUY5fE7pxWOAu2BHLED1pnvxepsKjP8oTpHJCvbakyGyhkqEaMVhXXvM2T+41y/oOOhOi4ASObrPckiWbRdHx91H/AGEad3D1hMKyWnQiN4hFrUaDimjqwDTvYvPOEGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link; spf=pass smtp.mailfrom=spawn.link; dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b=Y44hyiBD; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spawn.link
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
	s=protonmail3; t=1706532392; x=1706791592;
	bh=e3tRepqaqAq0gFn1a6V9/8QSIPa33zv53P0dDrZrCkA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Y44hyiBDfLMDfE9EKSaIb3cpNJzJ4/Dmn7L8Vg7ct2U4q2azWu1IFH9HV76WeJxtJ
	 P6isQhQTsfyYSRX7PokVW0jHmk1vfaa3v48WiEPphfrKnjpUcIatSobpNYQ6HvEfI6
	 xP7K6s++IH7jYLAdOO9fHtasrgnEEuw8hQgo68CNa0ITO1BFG/veW6GfNbx0VyZQcg
	 RdjXqCXKfD5nsQ2YfyMfeXfhzilJWAMXxV/gNcckx6Vh/tcMQCdW2xMyoWK4tVwLyM
	 9xyhOfak9kGY7WBY/GO6cxQd6hyZeEUtB3uejZEr2Qvaq8bgvmsvLauLKVxJTMjwqM
	 DogQpsgK9oanw==
Date: Mon, 29 Jan 2024 12:46:27 +0000
To: Bernd Schubert <bernd.schubert@fastmail.fm>, Nikolaus Rath <nikolaus@rath.org>, Martin Kaspar via fuse-devel <fuse-devel@lists.sourceforge.net>, Linux FS Devel <linux-fsdevel@vger.kernel.org>
From: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: Future of libfuse maintenance
Message-ID: <92efd760-a08c-4cb1-90ab-d1d5ddb42807@spawn.link>
In-Reply-To: <9ed27532-41fd-4818-8420-7b7118ce5c62@fastmail.fm>
References: <b1603752-5f5b-458f-a77b-2cc678c75dfb@app.fastmail.com> <9ed27532-41fd-4818-8420-7b7118ce5c62@fastmail.fm>
Feedback-ID: 55718373:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/29/24 03:22, Bernd Schubert wrote:
> Hi Nikolaus,
>=20
> On 1/29/24 09:56, Nikolaus Rath wrote:
>> [Resend as text/plain so it doesn't bounce from linux-fsdevel@]
>>
>> Hello everyone,
>>
>> The time that I have availability for libfuse maintenance is a lot less =
today than it was a few years ago, and I don't expect that to change.
>=20
> firstly. thanks a lot for your great work over the last years!
>=20
>>
>> For a while, it has worked reasonably well for other people to submit pu=
ll requests that I can review and merge, and for me to make regular release=
s based on that.
>>
>> Recently, I've become increasingly uncomfortable with this. My familiari=
ty with the code and context is getting smaller and smaller, so it takes me=
 more and more time to review pull requests and the quality of my reviews a=
nd understanding is decreasing.
>>
>> Therefore, I don't think this trajectory is sustainable. It takes too mu=
ch of my time while adding too little value, and also gives the misleading =
impression of the state of affairs.
>>
>> If anyone has ideas for how libfuse could be maintained, please let me k=
now.
>>
>> Currently I see these options:
>>
>> 1. Fully automate merge requests and releases, i.e. merge anything that =
passes unit tests and release every x months (or, more likely, just ask peo=
ple to download current Git head).
>=20
> Please not, that is quite dangerous. I don't think the tests are
> perfect, especially with compatibility tests are missing. In principle
> we would need to get github to run tests on different kernel versions -
> no idea how to do that.
>=20
>=20
>>
>> 2. Declare it as unmaintained and archive the Github project
>>
>> 3. Someone else takes over my role. I'd like this to be someone with a h=
istory of contributions though, because libfuse is a perfect target for sup=
ply chain attacks and I don't want to make this too easy.
>=20
> I'm maintaining our DDN internal version anyway - I think I can help to
> maintain libfuse / take it over.
>=20
> Btw, I also think that kernel fuse needs a maintenance team - I think
> currently patches are getting forgotten about - I'm planning to set up
> my own fuse-bernd-next branch with patches, which I think should be
> considered - I just didn't get to that yet.
>=20
>=20
> Thanks,
> Bernd

+1 for Bernd's maintenance *team* idea. But perhaps extended to libfuse=20
as well? There are a number of us who are familiar with the code and at=20
least semi-active in the space. Help spread the load.

I could help out at least on the libfuse side.



