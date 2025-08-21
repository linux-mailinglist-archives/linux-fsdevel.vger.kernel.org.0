Return-Path: <linux-fsdevel+bounces-58603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA979B2F701
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 13:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A821BA407C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 11:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDC238F91;
	Thu, 21 Aug 2025 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="o5bTOXrb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D5C30DD36;
	Thu, 21 Aug 2025 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776701; cv=none; b=R6mchQm2lg8lXWN72LVH7vki3T5qOITVnLkiWcITSnNHEBiIep74H3avbD48qmsOIrttequFQWzvESXdDAnCYqyzwhwvkFQN5vHK/zAZYJJGAvaPHhXvYSixC0ZNw2X3+ZnXNPnjfsKUU6GAQ/FNDB2xz4X4jph+AH0zC6JeID0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776701; c=relaxed/simple;
	bh=1S99ESvvxHr4R2p5YJ7/kHTWQdnuna6LZoGHNue+FOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frVu9x6TKoiJU/P+J6VBLxEgWYXk0wzGQL3HPstCYw0fkYY3jrYct+Q7+pJrz+n7iS0u6lSz1Qd6X+BkoKzNnrQzDngrzJeDKa/bylOGMkZbGpCTZn4Qmdp7IOfwBj0FNlkb+vJ4cGUTRsv56KuZePPMhLjjovNWh5/iM97XDYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=o5bTOXrb; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c71hR3q55z9tSS;
	Thu, 21 Aug 2025 13:44:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755776695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+dwjoyao+Z5Y6dQ5j/hpjRmGQifGGUb4ioIFN9Zo5Ic=;
	b=o5bTOXrbFJ+TbjDAytVTHspl/R7SNHvgDSgScsHAIJMWDsxcnw6SOcGu2fNyoeJK61wfb7
	Aoh9Lr2NvMejwpJ/fc00NidOQN0UrhS3rPdlCFGcMeXCowOv/1RV1Q7Brwphue0ia5ySyX
	PhPRLiZWR6L79PtGhu2CSs+JSArxiCCSgH2iXHh0bXiaH6/5ow0nhOdgYz334N4QLGjNku
	ZL3cXmA8IXTvPzPj4tG/TCJYsYOEumoN0kK/XRN920QGtgtfZTyme6Y4xbVsGzimWbv0aF
	Hu0Q0pj1a4LAr8gTSqIKhNE4aNoT4eDXAQ4q9P5Ro/ciF4Dp3T2vyZ7BdYer+g==
Date: Thu, 21 Aug 2025 21:44:42 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 06/12] man/man2/fsconfig.2: document "new" mount API
Message-ID: <2025-08-21.1755776485-stony-another-giggle-rodent-9HLjPO@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <20250809-new-mount-api-v3-6-f61405c80f34@cyphar.com>
 <2025-08-12.1755022847-yummy-native-bandage-dorm-8U46ME@cyphar.com>
 <198cc025823.ea44e3f585444.6907980660506284461@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s3uimmdp5ba4wr4b"
Content-Disposition: inline
In-Reply-To: <198cc025823.ea44e3f585444.6907980660506284461@zohomail.com>


--s3uimmdp5ba4wr4b
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 06/12] man/man2/fsconfig.2: document "new" mount API
MIME-Version: 1.0

On 2025-08-21, Askar Safin <safinaskar@zohomail.com> wrote:
>  ---- On Tue, 12 Aug 2025 22:25:40 +0400  Aleksa Sarai <cyphar@cyphar.com=
> wrote ---=20
>  > On 2025-08-09, Aleksa Sarai <cyphar@cyphar.com> wrote:
>  > > +Note that the Linux kernel reuses filesystem instances
>  > > +for many filesystems,
>  > > +so (depending on the filesystem being configured and parameters use=
d)
>  > > +it is possible for the filesystem instance "created" by
>  > > +.B \%FSCONFIG_CMD_CREATE
>  > > +to, in fact, be a reference
>  > > +to an existing filesystem instance in the kernel.
>  > > +The kernel will attempt to merge the specified parameters
>  > > +of this filesystem configuration context
>  > > +with those of the filesystem instance being reused,
>  > > +but some parameters may be
>  > > +.IR "silently ignored" .
>  >=20
>  > While looking at this again, I realised this explanation is almost
>  > certainly incorrect in a few places (and was based on a misunderstandi=
ng
>  > of how sget_fc() works and how it interacts with vfs_get_tree()).
>  >=20
>  > I'll rewrite this in the next version.
>=20
> This recent patch seems to be relevant:
> https://lore.kernel.org/all/20250816-debugfs-mount-opts-v3-1-d271dad57b5b=
@posteo.net/

I'm aware of that, I was in one of the previous threads. There are some
deeper consistency issues that I'm writing patches for at the moment.

I'm of two minds whether I should fix the behaviour and then re-send
man-pages with updated text (delaying the next round of man-page reviews
by a month) or just reduce the specificity of this text and then add
more details after it has been fixed.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--s3uimmdp5ba4wr4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaKcGqRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG81TQEAsJKx2FJwlcpvis+ehby7
QarSer5LRSEzqRvw4plOn/oBANGkgxjrrjy3uXaE7UWnBBgbVsSU8AZwn4o98Yrt
ARMC
=QMee
-----END PGP SIGNATURE-----

--s3uimmdp5ba4wr4b--

