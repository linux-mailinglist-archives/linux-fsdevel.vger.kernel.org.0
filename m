Return-Path: <linux-fsdevel+bounces-2589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E04B7E6E19
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 868BBB20DDF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3614F20B17;
	Thu,  9 Nov 2023 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="S3d2MWEG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rZA0qJ9+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07184208B7
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:57:09 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1D12736
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:57:09 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 99AFF5C04EC;
	Thu,  9 Nov 2023 10:57:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 09 Nov 2023 10:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1699545428; x=1699631828; bh=OP
	qfphzFlOWozNWgkvj5rB9cotlNPHSeIvSKKShElKA=; b=S3d2MWEGDmtnmKZkJa
	xvpHK/l239XnWhpjRMtHU5YGpgBMO8ijMx93pIWx8eRZ/KYGk3uLxzz1YO5/upla
	PFaGSllkDMGDxIkBNpLAfPfWYyi9bXT0+964K3Zjqy/gYizFfP+vws6cX4GzCLtg
	c/1hJZUBG2kYJGrvFP+zoAVKJyRGshca8o8ODz452a2oe/1kv9Y1JU5vOcmDZyxb
	vIG9NKapIb6XBk9t43aGrCdrFF1k0lAxOCv1HCzZ/54N5uWTBC/9xrRzk1ul+1bT
	vsNegDYFPDmjFHtBhBgYyiITIG7sJz1TC5gBDfn8Z7/VyD7omoPL0ujfsU4pSAUm
	292w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699545428; x=1699631828; bh=OPqfphzFlOWoz
	NWgkvj5rB9cotlNPHSeIvSKKShElKA=; b=rZA0qJ9+NiM8JVty434TJvSmC5XVs
	sLACq6AlMyWg7oj2rLmAg5PDuBWxBxNHDMsM02rSgk5+XblRrT7sI4HV8/YpbCqd
	2Au76HBe2LXmzDDXp6TMvGeuUWSnv3oh14O9mH+ORsD/ciwnSTMH5Dr2eR6fRmwc
	/fQzHXDGnM13s5EFO9D4sxE8W4cBz8XN9Qx7h+iGe06OtL1w1QVQK/AcDDo8pJZS
	3iz0lA9V2VXBeC/qyfW576MunwiB/JaUO1xY9bGGdPEpssYaPomSQYlqsrcUbaYB
	qk8Vb3vnmQ0myRZFcjPYOk0SGVVLwFnjPw+zNS6WbmzTOqaJvc5tyx9qw==
X-ME-Sender: <xms:UwFNZRAVqItMmCFUIgKa_IgE1iMrwHMvgbcL07MEMyvleQQHICfNfA>
    <xme:UwFNZfhzMwyHkvAYypLJ8y_SuVHzDQ5CJvkSv_x1jGGunPx71UiBnPpehADwXCV7J
    wJg_zg5pa3e858RKg>
X-ME-Received: <xmr:UwFNZcmIGVxzQfaFJpysxq1vdmaKrQ2bgGSuPOj3VD7RT0eyfVb5PT_wd9SQnjdUU2D1_ieObsrse_z6yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvuddgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefujghffffkgggtsehgtderredttdejnecuhfhrohhmpeetlhihshhs
    rgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeeuhf
    eijeejudefleejvdegheffledvveelveejgfetjeeijeegtdeiuedvveekueenucffohhm
    rghinhepfhhilhgvrdgtrghtpdhushgvugdrtggrthenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhish
X-ME-Proxy: <xmx:VAFNZbw_89M0-QEY1HZ0FsuNBEpubWRwtDLrE1FaOlxyv9tL2rbk2Q>
    <xmx:VAFNZWTPaM86RRDnEfK1vub4iFMi1DdPVIHLGA0zQPj7-yU3vlW26w>
    <xmx:VAFNZebBCuOSho13WEG0Eeqm7zD8kGJ3bmkDeyckFRm8VM8zLV6a7Q>
    <xmx:VAFNZTJkD0CMoVd04i6Z6sA7b2F7SN7oWy4H5mBOXEUYr3mProEK2A>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 10:57:07 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 032693F14; Thu,  9 Nov 2023 16:57:05 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Vivek Goyal <vgoyal@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com, miklos@szeredi.hu,
 stefanha@redhat.com, mzxreary@0pointer.de, gmaglione@redhat.com
Subject: Re: [PATCH] virtiofs: Export filesystem tags through sysfs
In-Reply-To: <ZUv56DRM/aiBRspd@redhat.com>
References: <20231005203030.223489-1-vgoyal@redhat.com>
 <zdor636rec2ni6oxuic3x55khtr4bkcpqazu3xjdhvlbemsylr@pwjyz2qfa4mm>
 <ZUv56DRM/aiBRspd@redhat.com>
Date: Thu, 09 Nov 2023 16:57:01 +0100
Message-ID: <87r0ky538y.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Vivek Goyal <vgoyal@redhat.com> writes:

> On Sat, Oct 21, 2023 at 04:10:21PM +0000, Alyssa Ross wrote:
>> Are you still thinking about exposing this in the uevent as well?
>> That would be much more convenient for me, because with this approach
>> by the time the "remove" uevent arrives, it's no longer possible to
>> check what tag was associated with the device =E2=80=94 you have to stor=
e it
>> somewhere when the device appears, so you can look it up again when the
>> device is removed.  (Not everybody uses udev.)
>
> Looks like systemd + udev combination can already take care of it. I just
> had to specify "StopWhenUnneeded=3Dtrue" in my systemd .mount unit file. =
And
> that made sure that when device goes away, virtiofs is unmounted and
> service is deactivated.

My point is that, if it's not exposed in the uevent, the tag information
has to be tracked somehow.  systemd/udev may do that already, but every
other system people might be using (mine uses mdevd) also has to track
that state.  Whereas if the uevent did contain that information,
userspace would be able to do the unmount directly, without needing to
look up some information it has previously saved.

Relying on tracking state from previous events also introduces potential
reliability problems =E2=80=94 it's possible to miss uevents if the netlink
queue fills up.  Suppose I have a system where virtiofs filesystems
should always be unmounted when the device goes away.  I miss the uevent
for the device being added, the user mounts the filesystem anyway, and
then when the device removal uevent comes in, unless that uevent
contains the filesystem tag, I'm not going to know which filesystem to
unmount.

> Following is my mount unit file.
>
> $ cat /etc/systemd/system/mnt-virtiofs.mount
>
> [Unit]
> Description=3DVirtiofs mount myfs
> DefaultDependencies=3Dno
> ConditionPathExists=3D/mnt/virtiofs
> ConditionCapability=3DCAP_SYS_ADMIN
> Before=3Dsysinit.target
> StopWhenUnneeded=3Dtrue=20
>
> [Mount]
> What=3Dmyfs
> Where=3D/mnt/virtiofs
> Type=3Dvirtiofs
>
> And following is the udev rule I used.
>
> $ cat /etc/udev/rules.d/80-local.rules
> SUBSYSTEM=3D=3D"virtio", DRIVER=3D=3D"virtiofs", ATTR{tag}=3D=3D"myfs", T=
AG+=3D"systemd", ENV{SYSTEMD_WANTS}+=3D"mnt-virtiofs.mount"
>
> And a combination of above two seems to work. virtiofs is automatically
> mounted when device is hotplugged and it is unmounted when device is
> hot unplugged.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmVNAU4ACgkQ+dvtSFmy
ccBjPw//WYFh5sCAPbd1+pYOjIO4A6ddjGoY6nch3XI9QamBxXgTMcKZZsHZ3/bi
o/kOQG3XnCt2yRGtqCSrL1FfsaQsLbQRbf+PyukQ1AYEgiHnYJByBeBpJlLG5I/W
Y636uFTM4CdE8zaJzYc7+GHXClablKjiQ6WVZpBrs84E1oWaTswQJMwKd/qVzHNN
eq6oy60U1SvKZ/gZFg3jgcHFrMaGffIlD6J5rxvcqnLjutxpe5rhGyZbdZbx+e9c
zr3naUxdqi95bcpsJ6z0BDoEHty5TVxMO0W64LEBRaOi/2VcKseaDl+IXFbrQudl
yZl11k74Z95wDimIdyNmvlZVyJ637bZDZ0bdrYghb/SqtK9bbq3ZKtCvZs2hnaA2
3dP0DB37EEuVZAn8QSr+W99hTuiv7VoZPbY3Dghj01xrf9nweWjPAx4Ljb9ifh80
SMXICgcqVVUqivOx88QSRaOAjyFRYXwLI79wY/QtAdQtGpyNM49FsPR9cOHAXXAs
hju5irkcl72rTK/AsgUZFZmCaRpqXhQEkQDZa/0s5XdNLL6CmRT+8Pq/A2qz6ygM
zHOUSC8RSJxYXszsIeCEgGXpqtikgas7uX1pQLi1M4RZs2ucvTBXUdBJvmyaqpD9
BqKlVlw5Q/jxW1r/zp0sgSQ7/RR3jormzCAt8N3bZFxc+IPuloA=
=Il4G
-----END PGP SIGNATURE-----
--=-=-=--

