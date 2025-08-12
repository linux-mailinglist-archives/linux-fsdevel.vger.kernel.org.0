Return-Path: <linux-fsdevel+bounces-57510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A554B22AC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 16:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D89C1895FA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 14:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5642EBBA6;
	Tue, 12 Aug 2025 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="hEGmOT2F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEEB2EACE2;
	Tue, 12 Aug 2025 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009205; cv=none; b=RtMJ0TJTu1xcRf+aSNjcHNHvGZEH7YJXiytuXuCzkJ8uNuXBsEFhsSa6849i75mDc5e+n9DfPemvt5342hDWEJC/i0dekIUSjeCkbaJ/868tj+RUfj8mnbHWVwfZE+WG/WMdvlqMfgFB3MisVbSeKXdIl3eIq7CTI8Kd/fEWrHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009205; c=relaxed/simple;
	bh=Z4YpjWDFsTisTYRrs6dwdNxnd1Rfd901xv2zPPVlSzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xw967hWEcJ63ngk8JW8hyZ+aV3sM6/2c796MqUlFdiyUkJB5ADBO3kqKFjgy6b/tBJWJPPdYwUV6coS3mNxmeXGpuhWwXI7DkXmpOvDzd1uryeh1wHFY5k4ATIZOQBRtGsegJ/Ov6Cd8QJluvfV6F2EDcRuGZ/5+fCah2COETUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=hEGmOT2F; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c1Yrt6cZ5z9t89;
	Tue, 12 Aug 2025 16:33:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755009199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G85S6yN/jpAxYJYn22nLde2onQJqpGZG2EjZVAKSCR0=;
	b=hEGmOT2FM06uSJI210uoGwYT8ijebX66XoYQNfd/oNGtB/w9zAZAxcoOnwZMmcBUrUtSAu
	ZK4YCfAPOX/nML2b3iCyiEJhrXE+MVtaUN/VW8vnpQlqfTte4bts9Gzixp8VJqI9BqxLVe
	MNfaTgwl1ApZXQrQowjWIy9eLjD61dFs4J4zYZwPxmAs1E2u1t1bKtYJaHemd+FcmtpWtd
	PRxqo5sHx527p8Kl4mA+Hfue5WIBEucH7Nf/Tfhf0Gz+AVmKMvs31uU8h3K11EFEOumR5E
	BD1ZipHmbK4jOrC9k0s22kri0Uq2hUNYaGVUpATd7VIz8tWEBANMJF7LmtlIRA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Wed, 13 Aug 2025 00:33:04 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 07/12] man/man2/fsmount.2: document "new" mount API
Message-ID: <2025-08-12.1755007445-rural-feudal-spacebar-forehead-28QkCN@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <20250809-new-mount-api-v3-7-f61405c80f34@cyphar.com>
 <1989d90de76.d3b8b3cc73065.2447955224950374755@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b2zuzbzu2rwnxtze"
Content-Disposition: inline
In-Reply-To: <1989d90de76.d3b8b3cc73065.2447955224950374755@zohomail.com>
X-Rspamd-Queue-Id: 4c1Yrt6cZ5z9t89


--b2zuzbzu2rwnxtze
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 07/12] man/man2/fsmount.2: document "new" mount API
MIME-Version: 1.0

On 2025-08-12, Askar Safin <safinaskar@zohomail.com> wrote:
> fsmount:
> > Unlike open_tree(2) with OPEN_TREE_CLONE, fsmount() can only be called =
once in the lifetime of a filesystem instance to produce a mount object.
>
> I don't understand what you meant here. This phrase in its current form i=
s wrong.
> Consider this scenario: we did this:
> fsopen(...)
> fsconfig(..., FSCONFIG_SET_STRING, "source", ...)
> fsconfig(..., FSCONFIG_CMD_CREATE, ...)
> fsmount(...)
> fsopen(...)
> fsconfig(..., FSCONFIG_SET_STRING, "source", ...)
> fsconfig(..., FSCONFIG_CMD_CREATE, ...)
> fsmount(...)
>=20
> We used FSCONFIG_CMD_CREATE here as opposed to FSCONFIG_CMD_CREATE_EXCL, =
thus
> it is possible that second fsmount will return mount for the same superbl=
ock.
> Thus that statement "fsmount() can only be called once in the lifetime of=
 a filesystem instance to produce a mount object"
> is not true.

Yeah, the superblock reuse behaviour makes this description less
coherent than what I was going for. My thinking was that a reused
superblock is (to userspace) conceptually a new filesystem instance
because they create it the same way as any other filesystem instance.
(In fact, the rest of the VFS treats them the same way too -- only
sget_fc() knows about superblock reuse.)

But yeah, "filesystem context" is more accurate here, so probably just:

  Unlike open_tree(2) with OPEN_TREE_CLONE, fsmount() can only be called
  once in the lifetime of a filesystem context.

Though maybe we should mention that it's fsopen(2)-only (even though
it's mentioned earlier in the DESCRIPTION)? If you read the sentence in
isolation you might get the wrong impression. Do you have any
alternative suggestions?

FWIW, superblock reuse is one of those things that is a fairly hairy
implementation detail of the VFS, and as such it has quite odd
semantics. I probably wouldn't have documented it as heavily if it
wasn't for the addition of FSCONFIG_CMD_CREATE_EXCL (maybe an entry in
BUGS or CAVEATS at most -- this behaviour has an even worse impact on
mount(2) but it's completely undocumented there).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--b2zuzbzu2rwnxtze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJtQmRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG/UwAD+MwnSuB2nUpF6VN+lG6Sk
ahtWU9Ut5x9w1cljgw+oql0BAPzwUVFsh5FWVEt9gyvDxhFsVMHokKdK4FubSZ9L
TmEO
=CcEX
-----END PGP SIGNATURE-----

--b2zuzbzu2rwnxtze--

