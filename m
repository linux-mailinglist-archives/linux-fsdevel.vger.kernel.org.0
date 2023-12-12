Return-Path: <linux-fsdevel+bounces-5739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2E480F704
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 20:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7A51C20DE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 19:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC556356F;
	Tue, 12 Dec 2023 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCtjlTaU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E463567;
	Tue, 12 Dec 2023 19:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA9EC433C8;
	Tue, 12 Dec 2023 19:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702410000;
	bh=XYzJ5VYogiTqPObmWUe/wKCpLEETTZjB1aB4bDGVTq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCtjlTaU2O00+gdYtzr9CBKSleBRK77fote3pL5kFzSHPolg3IdVpxTLVjMTah6qq
	 wED0/6SyyNWMbqn4i15mNafnp9HhPlc5epRU1miXYYovarce9F5a/T+gTA1xJKVPN1
	 LyWitF+BJbfQWWwTwprX5fC+8flmEHIzX1LK7gXV7SMQpl/fb9iisQWnHnPW+UYrZ5
	 5FMZyEhAAs+a1sm+dW8pG/BFw7UOriHfMuclS93xYNF1v76J9+5NstthV0GJfO1UPo
	 wGQD7zxM8XpdF6YhiNpN3jR/cdeP6jDyVgE5/dfYvMNT81GxIdjJJdpSkQbMGgV95U
	 GaDHTDq1tDOTw==
Date: Tue, 12 Dec 2023 19:39:51 +0000
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
	ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com,
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
	jdduke@google.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Message-ID: <5e99796a-c489-4405-9d20-89d5ad117391@sirena.org.uk>
References: <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
 <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <3240f4b5-081b-4075-851a-7d1cd86f4333@redhat.com>
 <1368c558-c58c-4574-907e-36b07dee31bb@sirena.org.uk>
 <6ee5d68a-fa54-4ed6-bc41-2bff0d9eb12f@redhat.com>
 <052dc756-cc05-4aa8-9724-14d42853089c@sirena.org.uk>
 <8a2ce635-58f4-44e1-a646-6527936c5836@redhat.com>
 <400c0342-bb28-4dd2-b132-9927c7babec4@sirena.org.uk>
 <f3081d52-8bbc-4bc7-96d4-b086ca91975a@nvidia.com>
 <daf9f834-c79d-4f8c-9248-b0b232017732@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bmbARan2FdQC/igT"
Content-Disposition: inline
In-Reply-To: <daf9f834-c79d-4f8c-9248-b0b232017732@redhat.com>
X-Cookie: If rash develops, discontinue use.


--bmbARan2FdQC/igT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 12, 2023 at 04:27:12PM +0100, David Hildenbrand wrote:

> I usually build my stuff in-tree, so I don't really have a lot of experience
> with out-of-tree selftest builds and the whole kernel header inclusion (and
> how we could avoid the "make headers" and place the headers somewhere else).

It's generally something along the lines of (from tuxmake):

   make --silent --keep-going --jobs=15 O=/build/stage/build-work INSTALL_PATH=/build/stage/build-work/kselftest_install ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- kselftest-install

possibly with a -C in there to find the kernel source (from KernelCI):

   make KBUILD_BUILD_USER=KernelCI FORMAT=.xz ARCH=arm64 HOSTCC=gcc CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- CC="ccache aarch64-linux-gnu-gcc" O=/tmp/kci/linux/build -C/tmp/kci/linux -j10 kselftest-gen_tar

--bmbARan2FdQC/igT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV4twYACgkQJNaLcl1U
h9Di+ggAhFcVWNuwSylsTaqHlie7XylBqMvgn8gEUhFEuCgc61gt6bfC8ibnBnov
pfKHGUM1aNIXWwda2PGSLzFYRSugiDOnDQNjrxRR7FKBsjvrUF+2Z5HOdqmH6t9O
3XPDBbLr2gCXRxwEzebbqjPPRH0OyLUCX9zC70CPsXJniNGemo5bf22YIDwVhYV+
WDoXwthEBK7GJtMLXZwHooueKztpVWshDrGabeeiseLmKoQ/P1tpnPywfOd4P5rc
O346V5TFghUnjG0b/CXCkZqTlmHbLz5ckpMJsZHv0LLj7+/V+rw0th//EdbXjUXh
67R937mSIXO2RLCkdhFI+b6/qRU+5Q==
=dcFi
-----END PGP SIGNATURE-----

--bmbARan2FdQC/igT--

