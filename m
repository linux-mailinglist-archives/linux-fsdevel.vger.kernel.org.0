Return-Path: <linux-fsdevel+bounces-5516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 342EE80D192
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 17:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289631C20754
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 16:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8078B4CDF6;
	Mon, 11 Dec 2023 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/uBz2x6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D714CB23;
	Mon, 11 Dec 2023 16:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACBAC433C9;
	Mon, 11 Dec 2023 16:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702311917;
	bh=5VUtPEObv1k4HyoW81TUZrv+otVImpOxaDuyZvueRhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/uBz2x6V1NU3xu0hbAiKeSdan0rMuzodmG/dwdCNrl9ASic7EEISnumquAvXsm6Y
	 OGrWbRW3FnHEf+5yPKJccN+CF37jE86XRB3vbxa35N28rIL8s0M4A1TnS16bOidIET
	 Yx0SjDxGyreAWZqL3vbpd2OmPa/yQOSLTuXAVG4Aev+nd8dSwVwVAf1aWggEtr/vsc
	 qXiGLsWmGmLN98/HxpUCZkHT8FYN8JekzLaI0DsmVG5kxb8nA52tMK7T1/TQcQ9Sbd
	 O2IlJJeGIKFB8HUkM/pV08Z1E2AHzfPBfi9KrizSA1/8fftWmc7fBrxhs7VISfLiJt
	 WPbcvaWRNPiZA==
Date: Mon, 11 Dec 2023 16:25:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
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
Message-ID: <9d06d7c1-24ae-4495-803d-5aec28058e68@sirena.org.uk>
References: <20231206103702.3873743-1-surenb@google.com>
 <20231206103702.3873743-6-surenb@google.com>
 <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
 <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
 <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
 <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a14/VOM0XN/MVGE5"
Content-Disposition: inline
In-Reply-To: <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
X-Cookie: Better dead than mellow.


--a14/VOM0XN/MVGE5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 08:15:11AM -0800, Suren Baghdasaryan wrote:
> On Mon, Dec 11, 2023 at 4:24=E2=80=AFAM Mark Brown <broonie@kernel.org> w=
rote:

> > Oh, it's obviously the new headers not being installed.  The builds
> > where I'm seeing the problem (my own and KernelCI's) are all fresh
> > containers so there shouldn't be any stale headers lying around.

> Ok, I was updating my headers and that's why I could not reproduce it.
> David, should the test be modified to handle old linux headers
> (disable the new tests #ifndef _UFFDIO_MOVE or some other way)?

Are you sure we're not just missing an updated to the list of headers to
copy (under include/uapi IIRC)?

--a14/VOM0XN/MVGE5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV3N+QACgkQJNaLcl1U
h9DmTgf/ZPoo+zAKy67uOdK6qaJ/A+GrpqV4AOPXrGlU7nbi7AM5C5FOn8wMMp0k
/AJVtwdjktT+xmTOA1dHbrVZgpQRNzcvbY7D+I/Tw/xbKGRAbuJHm1Zn5KEAUeqf
Zd3xowB71LxQpNFxbSOfQFzEgWK7IzMES6M7OiZwu/hGgfJ1ag5OJLpYt49PK78C
FJ+tOXU0OM+zX/sbpYAojruD36irqu1S3Fo/+25wjnov/sWTDHNDZ+JG7Qd9i1XR
DhT+isRqW2Jil5QqGraHhOjLyYnPiGHziTMxlM/JKlratqRVng/dVHGGBn4pNjbN
mwVuVNeCPcTJrAtP8nygBu/wT2H/dA==
=U2vX
-----END PGP SIGNATURE-----

--a14/VOM0XN/MVGE5--

