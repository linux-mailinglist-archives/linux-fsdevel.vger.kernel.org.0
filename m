Return-Path: <linux-fsdevel+bounces-2930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7767EDA98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 05:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDFFB1C208E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 04:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD4BC2D4;
	Thu, 16 Nov 2023 04:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
X-Greylist: delayed 493 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Nov 2023 20:08:23 PST
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8511A4;
	Wed, 15 Nov 2023 20:08:23 -0800 (PST)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 1BF32160B3E;
	Thu, 16 Nov 2023 04:00:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 028B46000A;
	Thu, 16 Nov 2023 04:00:00 +0000 (UTC)
Message-ID: <2d5db599144596bdc12533a366d5d2d8f375014e.camel@perches.com>
Subject: Re: [PATCH v3 01/10] iov_iter: Fix some checkpatch complaints in
 kunit tests
From: Joe Perches <joe@perches.com>
To: David Howells <dhowells@redhat.com>, Christian Brauner
	 <christian@brauner.io>
Cc: Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>, Linus
 Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 David Laight <David.Laight@ACULAB.COM>, Matthew Wilcox
 <willy@infradead.org>, Brendan Higgins <brendanhiggins@google.com>, David
 Gow <davidgow@google.com>,  linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org,  netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org,  kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, Johannes Thumshirn
 <Johannes.Thumshirn@wdc.com>, Christian Brauner <brauner@kernel.org>, David
 Hildenbrand <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>
Date: Wed, 15 Nov 2023 20:00:00 -0800
In-Reply-To: <20231115154946.3933808-2-dhowells@redhat.com>
References: <20231115154946.3933808-1-dhowells@redhat.com>
	 <20231115154946.3933808-2-dhowells@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: 351xofsuni5kanig7iiz4sjma1jzxkft
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 028B46000A
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18a7JS4BL8h7HLIdDXMm2YCe3xiJn/hEoo=
X-HE-Tag: 1700107200-315216
X-HE-Meta: U2FsdGVkX18LEi6bPNImGq+TG8DpnNDiieNtyzLyawftOGFa1xnL3e2LfgJJyTLmLwogrMHbv17rz+M/8vJb8yVNQ1eCzPPOqKmiLWnXkWH0Z4A9nMD1IG6Np+PP3yRiu6HzLDt5vFNdyg6DurWOPJlIDfPWoBPm7Ey6IGQrJB9nzzek/4SHhy/NFXArWdJKtMpL5kSDR4003ihhuhR+s+TvBzrKMZcNgv7yMLgzT5KBcOkBLwkUfhN4pz6HD8ADTd57MGw8Q0+siSvVmwP7pkzt/Zvq1GRUig7ERppizdBVNRIz92TiEZDE+AHJ9Ti8

On Wed, 2023-11-15 at 15:49 +0000, David Howells wrote:
> Fix some checkpatch complaints in the new iov_iter kunit tests:
>=20
>  (1) Some lines had eight spaces instead of a tab at the start.
>=20
>  (2) Checkpatch doesn't like (void*)(unsigned long)0xnnnnnULL, so switch =
to
>      using POISON_POINTER_DELTA plus an offset instead.

That's because checkpatch is fundamentally stupid and
that's a false positive.

> diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
[]
> @@ -548,7 +548,7 @@ static void __init iov_kunit_extract_pages_kvec(struc=
t kunit *test)
>  		size_t offset0 =3D LONG_MAX;
> =20
>  		for (i =3D 0; i < ARRAY_SIZE(pagelist); i++)
> -			pagelist[i] =3D (void *)(unsigned long)0xaa55aa55aa55aa55ULL;
> +			pagelist[i] =3D (void *)POISON_POINTER_DELTA + 0x5a;

I think the original is easier to understand
or would best be replaced by a single #define
without the addition.

> @@ -626,7 +626,7 @@ static void __init iov_kunit_extract_pages_bvec(struc=
t kunit *test)
>  		size_t offset0 =3D LONG_MAX;
> =20
>  		for (i =3D 0; i < ARRAY_SIZE(pagelist); i++)
> -			pagelist[i] =3D (void *)(unsigned long)0xaa55aa55aa55aa55ULL;
> +			pagelist[i] =3D (void *)POISON_POINTER_DELTA + 0x5a;

etc...


