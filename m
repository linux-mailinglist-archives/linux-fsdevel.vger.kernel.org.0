Return-Path: <linux-fsdevel+bounces-63564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B98A6BC26AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 20:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC343B86B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 18:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7B22E9753;
	Tue,  7 Oct 2025 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Y9k6BXIv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98E32E92D9;
	Tue,  7 Oct 2025 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862471; cv=none; b=FYEjCkeIMo62Z1ulGnGjaoUKH3ac72ExqklAm1gh8tf3Ei/gte/AeVAIaTwjN3XvaroZwPEYBviu4m4MvduSWRFPSCNEy9Nu6xcKs5y1qleJTbUBM1VJU8iND3Sdb4cybxQlVOrwMGa7ps0Bg0NkYRuaUKr3Y5JCrCbA1fq3T2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862471; c=relaxed/simple;
	bh=3BPYNWejbNzEdHtU6gCjyzKR4oTYGTDZsekgiv/b7mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpWMhC4ket+vN+owJh1dV9DdY2t3rlMlVbdxbfQImIbmU00TUAg1gso2HTrHjP8QvWH4NjcbDHYVT142p5uLGxmkV3ccT9esQELDbBh9fJSt/iAUbAFvR+sRU1lTQ52xHFE3AZZqF+JyQxk0KCQRLx0uXIy1pu44P8ghndoPb1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Y9k6BXIv; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ch4hv6V2kz9tJ0;
	Tue,  7 Oct 2025 20:41:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1759862463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3BPYNWejbNzEdHtU6gCjyzKR4oTYGTDZsekgiv/b7mY=;
	b=Y9k6BXIvoHkkiTF7WNU7xBlSkbRfqcs8x29jG46Z5UguLyYVKbDSiXqYx8FtCVPSiIHV3I
	pd9CVkO/K0QepHoU5c9XY958uozNjpTIpwaAQBtyCC/YIX5tiXCYvaJA7tDeH4xxrkLflT
	/kkRwtWcf7dSVvXY/8F6mg7eIvCKAvdQb2qMasABa1fIh62VcgKcpU99Gli4dS38zgKTUM
	/bl3PCPyYpw84faIW/1zfn/+9m11K86L+vMkz9EEkc44mc0REhII5tbBwHtcvfPLutSWrw
	+NhfCUYLJbhWaLOGU8f9Ok/NoFNW8OA0GXTvq0NwYgyIrVPAqaYfzDI2BZxV0g==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Wed, 8 Oct 2025 05:40:52 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Bhavik Sachdev <b.sachdev1904@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	John Garry <john.g.garry@oracle.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Andrei Vagin <avagin@gmail.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH 2/4] fs/namespace: add umounted mounts to umount_mnt_ns
Message-ID: <2025-10-07-lavish-refried-navy-journey-EqHk9K@cyphar.com>
References: <20251002125422.203598-1-b.sachdev1904@gmail.com>
 <20251002125422.203598-3-b.sachdev1904@gmail.com>
 <20251002163427.GN39973@ZenIV>
 <7e4d9eb5-6dde-4c59-8ee3-358233f082d0@virtuozzo.com>
 <20251006-erlesen-anlagen-9af59899a969@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ht56qcraadiit3fr"
Content-Disposition: inline
In-Reply-To: <20251006-erlesen-anlagen-9af59899a969@brauner>
X-Rspamd-Queue-Id: 4ch4hv6V2kz9tJ0


--ht56qcraadiit3fr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/4] fs/namespace: add umounted mounts to umount_mnt_ns
MIME-Version: 1.0

On 2025-10-06, Christian Brauner <brauner@kernel.org> wrote:
> On Fri, Oct 03, 2025 at 01:03:46PM +0800, Pavel Tikhomirov wrote:
> > 3) We had an alternative approach to make unmounted mounts mountinfo vi=
sible
> > for the user, by allowing fd-based statmount() https://github.com/bsach=
64/linux/commit/ac0c03d44fb1e6f0745aec81079fca075e75b354
> >=20
> > But we also recognize a problem with it that it would require getting
> > mountinfo from fd which is not root dentry of the mount, but any dentry=
 (as
> > we (CRIU) don't really have an option to choose which fd will be given =
to
> > us).
>=20
> The part about this just using an fd is - supresses gag reflex - fine.
> We do that with the mount namespaces for listmount() already via
> mnt_req->spare.
>=20
> The part that I dislike is exactly the one you pointed out: using an
> arbitrary fd to retrieve information about the mount but it's probably
> something we can live with since the alternative is complicating the
> lifetime rules of the mount and namespace interaction.

Well, to be fair this is basically the fstatfs(2) API so while it is
kind of funky it's not without precedence. open_by_handle_at(2) has
something similar if you don't mind incredibly funky API comparisons. ;)

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--ht56qcraadiit3fr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaOVetBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG9+AQD/WHnOXkgXTKCnd2HpOreL
PQhpLx/56P04enlRC0potQkBAKXUuzTwr3ihexolvjDxof9mYkdZ1WqIRmgMlKSd
kSkI
=XeB8
-----END PGP SIGNATURE-----

--ht56qcraadiit3fr--

