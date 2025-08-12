Return-Path: <linux-fsdevel+bounces-57527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2C3B22D43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 18:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C28C1884AC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F3D2F28F3;
	Tue, 12 Aug 2025 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="pvvZbkIe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59C322258E;
	Tue, 12 Aug 2025 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015526; cv=none; b=CsGb7ib45jzh6VHgbLb7Um3OZZHjxy5iFJoyKJ0rAUfFxvGAGXKeAb5hHJoXgzghCvqwe+PjWCV3r0q1wlvdVBpjB5LkAE+CkpLyCU4dsl+tpsFDjSJMnLwHXr/VUVtqKu85qIpxUCf5UAQPA9UWKoCpVbBCD9k+7Y8LTigtihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015526; c=relaxed/simple;
	bh=spJ73E3azRRLP0APZIMbXjQ4eFEgwmohNJL+DmMKHQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyWjEdF6eJaa2oJjSt9T3IVZJ6kGa163yh1veUVlETI0MIlUbIqcb28qYQt5sk7Gf1ifycvl2plC4gAxrn9xfFuRSSjwpIRmaOheXScJYfSman9LXit2xEOYiQBNjUvXgroqOhpVpIsCri4uNiUTmp1d/Va8DlooD6VyOsG33Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=pvvZbkIe; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c1cBS5x3jz9tDR;
	Tue, 12 Aug 2025 18:18:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755015520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r727c+VOKE2O+bnsJIQQ9NfCCm6FcRN1h1NolDowTnI=;
	b=pvvZbkIef/xg933iNThIw7ULH7Duatpe7h0FcJTQkVS8VaHWt3Mxgn5vfZGFWScecAOiO9
	4ZsbdnTMP7VlgfkCs7BtjhNLUSs346emspHSnbRUTLyXrnRe019iu3RHoBzbEQhka1U2no
	r9emdhDm52xpRVvR+i9CHWJE5gP6jsAj2Me+VbOM6b9TX5X2jfJGkCwcrLxu+4yeJdlPLx
	gN3OWsZ3n8o+81yPkVHJV1KCjIxOaY247E0lIQsfypvWXLca770wo+8oHacy6TQB7R3Q37
	T9a7foz4RH5TOdhUzgxzzBAG5Yu1FEdqFxj8R4sk2+UJkXo0WbzhJjwkR8yL0g==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Wed, 13 Aug 2025 02:18:29 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 07/12] man/man2/fsmount.2: document "new" mount API
Message-ID: <2025-08-12.1755015449-muddy-stained-shallot-pony-LEystn@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <20250809-new-mount-api-v3-7-f61405c80f34@cyphar.com>
 <1989d90de76.d3b8b3cc73065.2447955224950374755@zohomail.com>
 <2025-08-12.1755007445-rural-feudal-spacebar-forehead-28QkCN@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="62jodbrdp76ulwnd"
Content-Disposition: inline
In-Reply-To: <2025-08-12.1755007445-rural-feudal-spacebar-forehead-28QkCN@cyphar.com>
X-Rspamd-Queue-Id: 4c1cBS5x3jz9tDR


--62jodbrdp76ulwnd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 07/12] man/man2/fsmount.2: document "new" mount API
MIME-Version: 1.0

On 2025-08-13, Aleksa Sarai <cyphar@cyphar.com> wrote:
> But yeah, "filesystem context" is more accurate here, so probably just:

Oops, I meant to include

>   Unlike open_tree(2) with OPEN_TREE_CLONE, fsmount() can only be called
>   once in the lifetime of a filesystem context.
                                                 to create a mount object.

at the end.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--62jodbrdp76ulwnd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJtpVRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG80dwD/b/Vj/2Snas4bINkmFMrn
Nh0Tkl7IX/L1/dd5iXaDDgoA/2F5R+9BEMfmh7ZlEtOtcbrRGTT8MlMY92A3nOu2
NvQM
=hk26
-----END PGP SIGNATURE-----

--62jodbrdp76ulwnd--

