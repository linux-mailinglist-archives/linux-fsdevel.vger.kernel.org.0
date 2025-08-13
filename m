Return-Path: <linux-fsdevel+bounces-57789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21BDB25470
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 22:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6608882D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 20:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9012A299947;
	Wed, 13 Aug 2025 20:12:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C632FD7B9;
	Wed, 13 Aug 2025 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115925; cv=none; b=C5GjDD4/Pq/KOcrV+wPeKDvyX/iAC0mIiSdUBD0pvuB6sKvvaWIW5IPAIvSh/Ej8GiKd9sQV7Xj32DQbLXzhsq1im7Jtz9AYn+ssNYj2Pm7ilvs6JFJf+xxqVTEaeNQ8vrEa8Vk/NrgSx8KRVFffG6JrOCc9hB35oAI2Idv6kXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115925; c=relaxed/simple;
	bh=Juf1ZTnx/FB2vFj4STFZmefBih8aOZWA68hdzIY4NFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JB5AJSzkOAuoNNWpWM6/mxFcqW4DWDAa05IPPI8B6A+k1q8f82MTGOPHrGPwH8WFxwza2Z62Q8i5PUMxFqiBseCBszGY1Y8l290CpEWaGDltftg5jdoJ+1caSUCrMFD06smVfCPrFhl6E8oj2NHZ8BLE+XYFtbilzDyOaUK8Lgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4096C4CEEF;
	Wed, 13 Aug 2025 20:11:53 +0000 (UTC)
Date: Wed, 13 Aug 2025 21:11:51 +0100
From: Mark Brown <broonie@debian.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/19] rust: replace `kernel::c_str!` with C-Strings
Message-ID: <34d384af-6123-4602-bde0-85ca3d14fe09@sirena.org.uk>
References: <20250813-core-cstr-cstrings-v2-0-00be80fc541b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6FVk2V0LrGBjdKpm"
Content-Disposition: inline
In-Reply-To: <20250813-core-cstr-cstrings-v2-0-00be80fc541b@gmail.com>
X-Cookie: Turn the other cheek.


--6FVk2V0LrGBjdKpm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 11:59:10AM -0400, Tamir Duberstein wrote:
> This series depends on step 3[0] which depends on steps 2a[1] and 2b[2]
> which both depend on step 1[3].
>=20
> This series also has a minor merge conflict with a small change[4] that
> was taken through driver-core-testing. This series is marked as
> depending on that change; as such it contains the post-conflict patch.
>=20
> Subsystem maintainers: I would appreciate your `Acked-by`s so that this
> can be taken through Miguel's tree (where the previous series must go).

Something seems to have gone wrong with your posting, both my mail
server and the mail archives stop at patch 15.  If it were just rate
limiting or greylisting I'd have expected things to have sorted
themselves out by now for one or the other.

--6FVk2V0LrGBjdKpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmic8YYACgkQJNaLcl1U
h9Cumwf/YkCiNa2FUFyl0xap34GT0uNu8Xh2QH5gQa+2jI19lL8u1OybvUdzWI8N
dryQmdo4BgnkEFiIeCiAWIUh8fHachIQqfAZfj8yJRexfSk3R0S/Nrg8CfGa9myh
jkwom0F4sUSvZpsacG1c/oCya64UwN/bCgC+Yw2fivCPjjw/vz1JE5gtarpJEQly
EJBbiexaSe0XYdtZ3cIT4wm0YElZqekk8U953MglLhWOOLXzt59bkslAam/8fori
si1u/uVgWv1vyziB8dYHRa26Gsgy9OkgjCD0P64YWkoAV/uSnxsEo5wtWBx2ys1n
pZ4kmgo8dh16iRQ7pqHeV2g3wE9HiQ==
=xgNk
-----END PGP SIGNATURE-----

--6FVk2V0LrGBjdKpm--

