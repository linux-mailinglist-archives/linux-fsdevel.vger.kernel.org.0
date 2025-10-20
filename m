Return-Path: <linux-fsdevel+bounces-64700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82A4BF1359
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A293BD3A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 12:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31413128C5;
	Mon, 20 Oct 2025 12:28:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137242EC55D;
	Mon, 20 Oct 2025 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963301; cv=none; b=f4+Bw9EuDcpGYS5QxHunMaZTdpu9ysF6POAKv3L78ECLWMKmjvHCvg8Euo/81wOY2HHSMM2CNWQLmL1g92A9Dbk2nA0KlF8gT8sc7YDnWQBicWFgj+IOcgeECKivG2JsJ4XuCAiNv8LwGrT/N7bv5g4PNN9deh/7LKIS6u600Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963301; c=relaxed/simple;
	bh=a2Bw7tcfrdZdUhoJuqfjgYw3asav4XDAi4BcHpQfOnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZEMBtnPYFoxNfIwTZez6p+DcmWSbnqA62y4gTJAmTDDzXk7JbUw0RAWt77G6vBSSPOx2aAkuZ3IuqoF/g12gjFGy2YdMQ2nXe7UYcyl895tozOvT/XL6nBFHrDTgGQIfJN9gJL+N2k195YS/nMsW6EmuOIB/oUE2MkxPE3tH8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048CAC4CEF9;
	Mon, 20 Oct 2025 12:28:09 +0000 (UTC)
Date: Mon, 20 Oct 2025 13:28:07 +0100
From: Mark Brown <broonie@debian.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Tamir Duberstein <tamird@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>,
	Michael Turquette <mturquette@baylibre.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
	llvm@lists.linux.dev, Tamir Duberstein <tamird@gmail.com>
Subject: Re: [RESEND PATCH v18 13/16] rust: regulator: use `CStr::as_char_ptr`
Message-ID: <3c31c76c-0df5-4630-b18e-c6eab419a8a6@sirena.org.uk>
References: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com>
 <20251018-cstr-core-v18-13-9378a54385f8@gmail.com>
 <CANiq72mpmO2fyfHmkipYZmirRg-x90Hi3Ly+2mriuGX96bOuew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0uN06CPCQnMKQjYF"
Content-Disposition: inline
In-Reply-To: <CANiq72mpmO2fyfHmkipYZmirRg-x90Hi3Ly+2mriuGX96bOuew@mail.gmail.com>
X-Cookie: I doubt, therefore I might be.


--0uN06CPCQnMKQjYF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 11:25:16PM +0200, Miguel Ojeda wrote:
> On Sat, Oct 18, 2025 at 9:17=E2=80=AFPM Tamir Duberstein <tamird@kernel.o=
rg> wrote:
> > From: Tamir Duberstein <tamird@gmail.com>

> > Replace the use of `as_ptr` which works through `<CStr as
> > Deref<Target=3D&[u8]>::deref()` in preparation for replacing
> > `kernel::str::CStr` with `core::ffi::CStr` as the latter does not
> > implement `Deref<Target=3D&[u8]>`.

> Liam, Mark: I will apply this since it would be nice to try to get the
> flag day patch in this series finally done -- please shout if you have
> a problem with this.

Acked-by: Mark Brown <broonie@kernel.org>

--0uN06CPCQnMKQjYF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj2KtYACgkQJNaLcl1U
h9D41Qf+Ltkk2+JN4tBSzvUarUp6eE2D4QOWAyqVy87q+zcocSKDaFrrEgX0C0yp
52vEvZtJflTt7XIxB9TkWesjbQO7dzdeFWW+18b2BU6A1nXcDMEBn66QRWbEOXru
XOwNAbeIQDR63w0Wec+AXgNFt5vg2wly5e1Ht7UGAufGvqdiKfxE06yCToKWzh3n
475HYOCkvV3CIc1QgSFNsiX1DjCKwiB5bSH3kktTU9Z7xLUYTaizUeOU/b2aiaYJ
HMcw8OJrCDaG/UqqK+PX3VACQEAWrwmpljXr+OpqgztP9tRIQ7zTNMMt6HSAdXRm
GV0zx2kVMXs4pom/lsT8Nf+N2E6prA==
=Yihi
-----END PGP SIGNATURE-----

--0uN06CPCQnMKQjYF--

