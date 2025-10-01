Return-Path: <linux-fsdevel+bounces-63147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D47BAF708
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 09:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B17E1926300
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 07:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31255274650;
	Wed,  1 Oct 2025 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="X93cyzzS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062F927144E;
	Wed,  1 Oct 2025 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759304256; cv=none; b=bAsxgb775UMhyy0gSh06ZXz0svC34EjZpz1HZR5qoxvQ9aklkmueGPT4IIdE1HxKdeB9qjRp0g2ek6qnvtA6V/87jBQ/RAXjOUBR4VJ+WlzBxzjDa7bwiw0/Rq3yzHy7pywEbk1LmiEMzOa+WZY0bIIpsbjDIaCQu0yHCXi8I/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759304256; c=relaxed/simple;
	bh=M64w/pDEvADN1mehooynEyuws25UFxw99ROSM8tSyYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHztHABHkChVfvUfwjlM4SepU0sb6sIh6wgBE1Ks7/vHouD92W1BivOawCntfgGjUZ3WOsX66Y/YRAB5NaXhFShKdXA9+EXvR4UtVUlwaYl/lFy95JP/HLnoIMLlD9D2gaZsPwen+ZZBqTrPykb/SAIUGrJZv/Cj/RWW7+DYpn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=X93cyzzS; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cc6G272ldz9tgJ;
	Wed,  1 Oct 2025 09:37:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1759304251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dd7uskzlvD2GozS91cMY5hcU9KGJPm0ZAirw5RBfOCA=;
	b=X93cyzzSYQPovqnqrMCQFWG448zRgGWqGH8IQC0JOc05gM5XZehYrRujaK4d4L2jPGinJV
	lSNEUaW+kLuh189HNDBuB6p6bvMbGongZwsXJuoePaE6tTzIJQwlkaF4b+ku7u/D4X8mp4
	IxZgmTSBP+qMtXJOGv2pm64wN88E42xqWGyXapSJkSTSaEpsr+MWhkqVBFJ4BeqxCiiFgr
	QS8niQI7uuWJ//RRBSpWPlMaX9OdkcYGUSzWS66ObcB9LRBNQZ3E8BQSdFiVteDCqzUEDl
	PQvsrV8GQLq91EXLKUFMqNm9tFN8WiAGGn0f8HTXTW39zVWlCDRFnmktxWUuSg==
Date: Wed, 1 Oct 2025 17:37:21 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Askar Safin <safinaskar@gmail.com>, brauner@kernel.org, 
	dhowells@redhat.com, g.branden.robinson@gmail.com, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-man@vger.kernel.org, mtk.manpages@gmail.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 7/8] man/man2/open_tree{,_attr}.2: document new
 open_tree_attr() API
Message-ID: <2025-10-01-frayed-minty-deputy-nag-zwy8se@cyphar.com>
References: <20250925-new-mount-api-v5-7-028fb88023f2@cyphar.com>
 <20251001003841.510494-1-safinaskar@gmail.com>
 <ugko3x7tuqrmbyb326aw3dvtvmdozvtps6hc6ff3lmtsijoube@aem2acyk6t2q>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bjfaxxsualgnnev5"
Content-Disposition: inline
In-Reply-To: <ugko3x7tuqrmbyb326aw3dvtvmdozvtps6hc6ff3lmtsijoube@aem2acyk6t2q>


--bjfaxxsualgnnev5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 7/8] man/man2/open_tree{,_attr}.2: document new
 open_tree_attr() API
MIME-Version: 1.0

On 2025-10-01, Alejandro Colomar <alx@kernel.org> wrote:
> Hi Askar,
>=20
> On Wed, Oct 01, 2025 at 03:38:41AM +0300, Askar Safin wrote:
> > Aleksa Sarai <cyphar@cyphar.com>:
> > > +mntfd2 =3D open_tree(mntfd1, "", OPEN_TREE_CLONE,
> > > +                   &attr, sizeof(attr));
> >=20
> > Your whole so-called "open_tree_attr example" doesn't contain any open_=
tree_attr
> > calls. :)
> >=20
> > I think you meant open_tree_attr here.
>=20
> I'll wait for Aleksa to confirm before applying and amending.

Yeah, Askar is right, they were a copy-paste snafu.

> > > +\&
> > > +/* Create a new copy with the id-mapping cleared */
> > > +memset(&attr, 0, sizeof(attr));
> > > +attr.attr_clr =3D MOUNT_ATTR_IDMAP;
> > > +mntfd3 =3D open_tree(mntfd1, "", OPEN_TREE_CLONE,
> > > +                   &attr, sizeof(attr));
> >=20
> > And here.
> >=20
> > Otherwise your whole patchset looks good. Add to whole patchset:
> > Reviewed-by: Askar Safin <safinaskar@gmail.com>
>=20
> Thanks!  I'll retro-fit that to the commits I've aplied already too, as
> I haven't pushed them to master yet.
>=20
>=20
> Have a lovely day!
> Alex
>=20
> --=20
> <https://www.alejandro-colomar.es>
> Use port 80 (that is, <...:80/>).



--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--bjfaxxsualgnnev5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaNzaMRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG/mhQEA0oDF6+zCdx1rUEQg4/ZR
f9Aaff27Wa3bPMPUwXmIuegBAIXTQXB3dEihimHf3fuNuxDotSLU5q4xNJhTZ2GE
gKMJ
=8AaQ
-----END PGP SIGNATURE-----

--bjfaxxsualgnnev5--

