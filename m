Return-Path: <linux-fsdevel+bounces-5473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B89A180C9B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 13:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C251F216BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 12:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB873B2AB;
	Mon, 11 Dec 2023 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilAFsElu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E1539AE5;
	Mon, 11 Dec 2023 12:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80982C433C8;
	Mon, 11 Dec 2023 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702297494;
	bh=84WZ4ewsgmNR6/ZEW1MIf+TUOxBr41z/0ezXIVDNlCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ilAFsEluKCHN7JQF683UHoaAPdr3aQNU9wUM/86e2jGy5Lw+g1sufCi36ER71lb28
	 IV3JUmJPzp0iLxUNt5NKysTnwDcg9lG5IZe0Shq4T5c81NCk3xy5AKv6Bojhof3wI4
	 4xGSRRz2MLvaaHkhmd/YCurLS2ZKAyEZErJPT/FaBklhFmMI+Z+US4fVghYw5acFTe
	 sSEmYrgg3VsPUDUk7SxhNlgpt2upZ1diZusBAjUJ4V9ihREC/RY1Dm5jw2Mb/HhhiN
	 duZ2vyRwAY0SgqkMNwqsISFiGcgEx2VxFG69IxIHYRzoh4kwKP3PHwLGwTuMYuyygR
	 reKVHlBPLxb5A==
Date: Mon, 11 Dec 2023 12:24:46 +0000
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
	ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com,
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
	jdduke@google.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Message-ID: <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
References: <20231206103702.3873743-1-surenb@google.com>
 <20231206103702.3873743-6-surenb@google.com>
 <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
 <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
 <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7/hbqtGcYo57an8M"
Content-Disposition: inline
In-Reply-To: <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
X-Cookie: Better dead than mellow.


--7/hbqtGcYo57an8M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 11, 2023 at 01:03:27PM +0100, David Hildenbrand wrote:
> On 11.12.23 12:15, Mark Brown wrote:

> > This is linux-next.  I pasted the commands used to build and sent links
> > to a full build log in the original report.

> Probably also related to "make headers-install":

> https://lkml.kernel.org/r/20231209020144.244759-1-jhubbard@nvidia.com

> The general problem is that some mm selftests are currently not written in
> way that allows them to compile with old linux headers. That's why the build
> fails if "make headers-install" was not executed, but it does not fail if
> "make headers-install" was once upon a time executed, but the headers are
> outdated.

Oh, it's obviously the new headers not being installed.  The builds
where I'm seeing the problem (my own and KernelCI's) are all fresh
containers so there shouldn't be any stale headers lying around.

--7/hbqtGcYo57an8M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV2/40ACgkQJNaLcl1U
h9AYhgf+IwDyqx/YzY9a574RrlQwU81b5BOxu2o1hAwwT6vCfeujk8u7w16UtJiZ
z3PAPhFvqNlDM0hyEQ44r4HFLlplsauO1zJH0lygThC0wnc0MEd3PGe+8Qu2hJsj
+LCnpWR3+f5rJtTP9OImUOnWUCiVLjcphPpgICFoomrKmL/IAMKvao8Nq4mlMOey
DmnS71xdBnZLHEizsj9BRJmHQpsddXUsKKiTXgYDln7sCo423sPSNnDzS/HOg4aj
8NJekG0uFkF6e8NcJGq9PA+D8RWBNMFHiv9TActmsSFMGR7HAcYz8fOaT6yFZmZY
/zZ6acLUvhqjyGPCdx8npVgRedNb9Q==
=WaDf
-----END PGP SIGNATURE-----

--7/hbqtGcYo57an8M--

