Return-Path: <linux-fsdevel+bounces-62335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0130B8D903
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 11:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28D224E151E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 09:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF0E2571C7;
	Sun, 21 Sep 2025 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="pOxPsOgn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86628F5B;
	Sun, 21 Sep 2025 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758448718; cv=none; b=Up63YHKUechL4gxw+mEYKebaIDAcgPnjpRYM7pYGNAD8Vrk5TWPqYrcuy0RFJPEDtNAPiOLdpHYg4WYVk8JVpq7fAuUm4PnyfS2Gf10KWUP0GHO8W4lIqplQWxSnJwXUYZ4x/G10103U4xAWnLzZXiqT5M11hyxcotiTiCFA6cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758448718; c=relaxed/simple;
	bh=hFLAkPTLl3Y3vgNyACfiEOeKWG1+nP6DEWhga3YUjL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3qGbXxd7dcyWLy1PM3EcbkqSsged1iqKxnuXyG/vxAp/dDSiUidTFXyXbqXZXvxyvgwesB+eb0mfmVNjQi/IoW7NE7eDiX+e/DlDJJL62p7gxvX3wzf1efsqd9WdG8vO88VGRnOGchU7EbPSaX7rK5Ahrmkpbh2l8w1rVaz6W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=pOxPsOgn; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cV1sG66Clz9tG4;
	Sun, 21 Sep 2025 11:58:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758448706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hFLAkPTLl3Y3vgNyACfiEOeKWG1+nP6DEWhga3YUjL0=;
	b=pOxPsOgnulkr7sntoW1aXiN1Hq1JFKjQTfY8ekeoKvYhr5ShougFVwXnAPurVx1+GqPs7v
	tM8Ff2DSuLthrXoK2PdaY9s0fhN6DtqyIPSwxNyuNA2Cm29xblWmyfYtoJFAIuo7uLKqny
	lAiIQDRnh0ueU81nWfyLaMTNk/vGKfjGkWBOs5oaND3ERL5laFnd+zP9q/EDzp6Do7nFrB
	Wv3HO4rij0CyUgWJSquseGEcRNS1IS8471cZv1qeZXPV3qqcJdeq3bqplD7YQvS9krHmc0
	BD73lFbLgp6JUBWW2VMBSAT0ZA6e7G23deOVBte1wyK+ZEQpkAu6Vju1p8YQng==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Sun, 21 Sep 2025 19:58:12 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@gmail.com>
Cc: alx@kernel.org, brauner@kernel.org, dhowells@redhat.com, 
	g.branden.robinson@gmail.com, jack@suse.cz, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-man@vger.kernel.org, 
	mtk.manpages@gmail.com, safinaskar@zohomail.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 00/10] man2: document "new" mount API
Message-ID: <2025-09-21-eldest-expert-wrists-cuddle-CQWTLx@cyphar.com>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250921024310.80511-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4dnv264kpqx2kfe4"
Content-Disposition: inline
In-Reply-To: <20250921024310.80511-1-safinaskar@gmail.com>
X-Rspamd-Queue-Id: 4cV1sG66Clz9tG4


--4dnv264kpqx2kfe4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 00/10] man2: document "new" mount API
MIME-Version: 1.0

On 2025-09-21, Askar Safin <safinaskar@gmail.com> wrote:
> Aleksa, thank you! Don't give up. We all need these manpages.
>=20
> I see you didn't address some my previous notes.
>=20
> * move_mount(2) still says "Mount objects cannot be attached beneath the =
filesystem root".
> I suggest saying "root directory" or "root" or "root directory of the pro=
cess" or just "/"
> instead. But you may keep this phrase as is, of course.
>=20
> * Docs for FSPICK_NO_AUTOMOUNT in fspick(2) are still wrong. They say tha=
t FSPICK_NO_AUTOMOUNT
> affects all components of path. Similar thing applies to mount_setattr(2)=
 and move_mount(2)

Sorry, I last read through your review comments a month ago, I must've
forgotten to make these changes back then. I'll include them in v5.
(It seems I remembered to change the open_tree(2) automount one but
forgot to do it for the others, oops!)

> * open_tree(2) still says:
> > If flags does not contain OPEN_TREE_CLONE, open_tree() returns a file d=
escriptor
> > that is exactly equivalent to one produced by openat(2) when called wit=
h the same dirfd and path.
>=20
> This is not true if automounts are involved. I suggest adding "modulo aut=
omounts". But you may
> keep everything, of course.

Hmmm. As we discussed last time, this sentence is more intended to
indicate that the file descriptor is just a regular open file (with no
dissolve_on_fput() + FMODE_NEED_UNMOUNT magic) rather than the exact
behaviour you get with regards to path lookup.

I would honestly prefer to remove "when called with the same dirfd and
path" rather than add caveats, but I think it makes the sentence less
readable... I'll think about it and try to fix this wording up somehow
for v5.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--4dnv264kpqx2kfe4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaM/MNBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG8ePAEAzWN7V9yxdrrDpBwF1qCd
ink4L3RES+kXoYX2Rm9rXxUBALiWgOaP1EArKgxDEQX382jCZhENZYBEyA7FDpcI
cmUJ
=8953
-----END PGP SIGNATURE-----

--4dnv264kpqx2kfe4--

