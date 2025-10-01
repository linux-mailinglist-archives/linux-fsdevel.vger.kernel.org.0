Return-Path: <linux-fsdevel+bounces-63146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D03BAF6ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 09:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D3E17BEFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 07:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC2D2741AC;
	Wed,  1 Oct 2025 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="vwmsyiQO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A71271A6D;
	Wed,  1 Oct 2025 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759304170; cv=none; b=dfx0Cfo4FuPMaRW/UPiOKUJL+fdFgFSgXmhIca5eK/8O+kN772+CkJLIaT+HQFCT+ZQKRswF64s1UGfW/kgJZGlvhvxBqPNoUn4u9oKxd109rnGoP9C4oephl88rX9FU5ZvQd/GgD//LzAMuMfEfwJdHPW8sluqjPHgSdD/cVF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759304170; c=relaxed/simple;
	bh=UsMNIjvGJVyJ7tDDftxNgWMz1WD7mTq1TrKVNfRAicc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gImdw3PTYV69lZV4JeW0hE5XU5RSSnlXIDuX39bjfuXFqVM9nBqUjKWEZg2R9wP8VJD/KAFgxKWH7hY0FaxUVR3qd/4NDGdbx0/MQxHVHRFn4GZ1EENhpzM+aMrbg6Dru4yHxDOdRZWqwb0O9hWLJIZBIaNrQF7AU+eBkgwg+RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=vwmsyiQO; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cc6DH3VL1z9sNr;
	Wed,  1 Oct 2025 09:35:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1759304159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hcrsTh+hEPackjWv/9APJh7H0cTIxXTrQiTVJGyI2tg=;
	b=vwmsyiQOwf8iOVBO0MmRrXqkCGzaMCJypcSlCaEyCN8oHLb88utiZtLR8uqfCkbajJCbnc
	4dW5AqMcVR43OShY9zmuY6VE9+tAJsjZXWP5SSy2+fH/8U+uvmPEVhagyjmPnhy1KBTdFs
	hP/1JTSipCHJnMQmGHsWWCHUpjd09euuI+Mp+qDZV3cYW7Q3aFJItnf/P+0TFZ/HA4LCfP
	twP/LmbcGFi/FRiQcgNnAhWYGl27A0Gl4Z5dexJ2gNgjm37Ajq0L0q7Ms8FVIst9VcXVtr
	Qfd9H9mlktM6gHfoJKbXaTm6/BjB37QqtVhEi4tgAJ8md4FzHt3IzlUf5Ef+yg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Wed, 1 Oct 2025 17:35:45 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@gmail.com>
Cc: alx@kernel.org, brauner@kernel.org, dhowells@redhat.com, 
	g.branden.robinson@gmail.com, jack@suse.cz, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-man@vger.kernel.org, 
	mtk.manpages@gmail.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 7/8] man/man2/open_tree{,_attr}.2: document new
 open_tree_attr() API
Message-ID: <2025-10-01-brawny-bronze-taste-mounds-zp8G2b@cyphar.com>
References: <20250925-new-mount-api-v5-7-028fb88023f2@cyphar.com>
 <20251001003841.510494-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q6bi4f7rvsmlajn7"
Content-Disposition: inline
In-Reply-To: <20251001003841.510494-1-safinaskar@gmail.com>
X-Rspamd-Queue-Id: 4cc6DH3VL1z9sNr


--q6bi4f7rvsmlajn7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 7/8] man/man2/open_tree{,_attr}.2: document new
 open_tree_attr() API
MIME-Version: 1.0

On 2025-10-01, Askar Safin <safinaskar@gmail.com> wrote:
> Aleksa Sarai <cyphar@cyphar.com>:
> > +mntfd2 =3D open_tree(mntfd1, "", OPEN_TREE_CLONE,
> > +                   &attr, sizeof(attr));
>=20
> Your whole so-called "open_tree_attr example" doesn't contain any open_tr=
ee_attr
> calls. :)
>=20
> I think you meant open_tree_attr here.

Oops.

>=20
> > +\&
> > +/* Create a new copy with the id-mapping cleared */
> > +memset(&attr, 0, sizeof(attr));
> > +attr.attr_clr =3D MOUNT_ATTR_IDMAP;
> > +mntfd3 =3D open_tree(mntfd1, "", OPEN_TREE_CLONE,
> > +                   &attr, sizeof(attr));
>=20
> And here.

Oops x2.

> Otherwise your whole patchset looks good. Add to whole patchset:
> Reviewed-by: Askar Safin <safinaskar@gmail.com>

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--q6bi4f7rvsmlajn7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaNzZ0RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG/BEAEA6OtNrlmi0mI2ASXOWxjz
PKAfbnGtZ1VdIfPzn0PtX4cA/jr8mhDIqP2v6TGtzHEo+O1PYFC3Oxg5LxdeT9G5
VE8F
=Dvsc
-----END PGP SIGNATURE-----

--q6bi4f7rvsmlajn7--

