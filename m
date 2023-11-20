Return-Path: <linux-fsdevel+bounces-3177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3361C7F0A19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 01:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E861C2082E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 00:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5CC185B;
	Mon, 20 Nov 2023 00:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IwoGJJY9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F496A4
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Nov 2023 16:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1700440409;
	bh=sgQFBCKAyWzKop7H04C028d0IDr8SAuOo/ohe71BTGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IwoGJJY9LEykvsVfcTCZPf5cUhuLgeqC21eAF3wAAQ/PkVvoyAFJajashz6RRj6jj
	 KhdLVLaVckmmJCB6vPqI/pMYB8zm+UTEXFTrGkb8M0zxkKD9GvNr3cPal6LBABuEZN
	 214w/atVVIFKLX5byQTWzyucpPJdhHgqdcFiV0SYCrcDR10j5V3cE6DUTHZ/ppTsqX
	 pUqTf7PtoEj1hR36HNn7IQ4YMTMVQ6HUz3XEK8mZ355YumqenontutYaGSlda1bquU
	 BfYcfmUhPEF4XvMltBaLvVgefRQa2aIjWhArbg4bmHk9WFgP3zwR/Yq5tn5xaAK7DM
	 Zgj2SzdzMYmEw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SYT544Sdtz4wch;
	Mon, 20 Nov 2023 11:33:28 +1100 (AEDT)
Date: Mon, 20 Nov 2023 11:33:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Naoya Horiguchi
 <naoya.horiguchi@nec.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6/6] fs: Convert error_remove_page to error_remove_folio
Message-ID: <20231120113303.7d6d5e61@canb.auug.org.au>
In-Reply-To: <20231117092833.f143fa4bbf0abfbd2e58661d@linux-foundation.org>
References: <20231117161447.2461643-1-willy@infradead.org>
	<20231117161447.2461643-7-willy@infradead.org>
	<20231117092833.f143fa4bbf0abfbd2e58661d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Wv6GC21ZjF2CBpd3riHXR43";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Wv6GC21ZjF2CBpd3riHXR43
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, 17 Nov 2023 09:28:33 -0800 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> virt/kvm/guest_memfd.c exists only in the KVM tree (and hence
> linux-next).  So I assume Stephen will use the change from this patch
> when doing his resolution.

Thanks for the heads up and the resolution.
--=20
Cheers,
Stephen Rothwell

--Sig_/Wv6GC21ZjF2CBpd3riHXR43
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVaqT8ACgkQAVBC80lX
0GxZ3wgAh52uTxB0QcpV2aSIcOXhFYkicvz/vGkEsCegVdTuE/dDVvWkz4JsDklT
oIQ5hGj8LHV2hhvcAR4uQwE13hLKKWDiczxqR9x8szemdsC64viL+SMAKUQTGzUa
Pm28nmxOHCCzZeEaTAJXPopDmMWoVGe09K6YAp1/7FFXqWDyYoJZUr3RaQIkzNW6
Q/TUcgsXkPM3Ci2vYEE+9OvefgnTJ2UVhCqSWd2gvlay7kyzrJoYqnDcQo3aR3hH
FXPp36v3R3CJX47SXaaLIb6FbwJNhzuJkg2/PedxEGpxeF0Rnt4m9Fv0btAQu5OU
Vs8cElw4pzEaz5O8AKLi0M6ICkFSnA==
=cwVM
-----END PGP SIGNATURE-----

--Sig_/Wv6GC21ZjF2CBpd3riHXR43--

