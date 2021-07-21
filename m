Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CE33D06AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 04:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhGUBk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 21:40:28 -0400
Received: from ozlabs.org ([203.11.71.1]:53475 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229903AbhGUBk1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 21:40:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GTzpR63C1z9sRN;
        Wed, 21 Jul 2021 12:21:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1626834064;
        bh=/P29ow745AujQiZkSeZoK7whI62U6sSRgOiLwELppuE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pyG8rwhBEMtKuidAPBTsLJSNrWEOoFHg5MxYBFcPrjMXH6NCBSZJ4RHmOa1yyv+br
         bAQuanJnWupnu3brJ907Yv04B09IMDAmX0nC315iOLAlda0aIb8VZu/O97+uAuXmUq
         xod36Up8ys7eUtW8AzGudA1R7aVX2UL8q5lowdgParuUAaLUafqVBaq6CAiBmlTxNi
         mpa7mTh+39GFyHYUz8mw4M/Ub1kR+GsS6CiBcGRMPz/LUUYBVPsi2fZIeYwjZHoQCp
         GindKpVNvXXPFC4BVYgs5a1H4d1lgtvepYWL3HRgNJSMtOqoMFTnRHcgfV2r7ckP1y
         3GfvGSK87Fy4g==
Date:   Wed, 21 Jul 2021 12:21:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Folio tree for next
Message-ID: <20210721122102.38c80140@canb.auug.org.au>
In-Reply-To: <YPY7MPs1zcBClw79@casper.infradead.org>
References: <YPTu+xHa+0Qz0cOu@casper.infradead.org>
        <20210718205758.65254408be0b2a17cfad7809@linux-foundation.org>
        <20210720094033.46b34168@canb.auug.org.au>
        <YPY7MPs1zcBClw79@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yW+AOr5SLgbIwGoBWgQMQ5A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/yW+AOr5SLgbIwGoBWgQMQ5A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Tue, 20 Jul 2021 03:55:44 +0100 Matthew Wilcox <willy@infradead.org> wro=
te:
>
> I think conceptually, the folio for-next tree is part of mmotm for this
> cycle.  I would have asked Andrew to carry these patches, but there are
> people (eg Dave Howells) who want to develop against them.  And that's
> hard to do with patches that are in mmotm.
>=20
> So if Andrew bases mmotm on the folio tree for this cycle, does that
> make sense?

Sure.  I will have a little pain the first day it appears, but it
should be OK after that.  I am on leave starting Saturday, so if you
could get me a tree without the mmotm patches for tomorrow that would
be good.

--=20
Cheers,
Stephen Rothwell

--Sig_/yW+AOr5SLgbIwGoBWgQMQ5A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmD3hI4ACgkQAVBC80lX
0GyYxQf/apurJIIsUNs20TCAtdW63wAnUlcqPaik9wBEa+bEFyrcndHuheESOgsI
nZrGREv/PT2/yRfRJF86Tma3KPPyn+nWsENtuoOIsXeMFWVmGFh0ppoBJi1gglOG
WEqDhQ3skOsYLevBJ+6elVlA0rECaMcBNCmxh76RUmBs+LDyv6tzP+qzUdxV3JG9
PWB/cIhbeXeLnDrqwRpnOS0JMrmMLIOMXkpmNIsvcrWs9TVPh+bHKlj9jRMTQ/Bp
4hyeme3QhgPRxZaKpW81zO3BfJj9c5awKPs27O8ETmdvmrIVjF5cRqisg41I4+zq
awaGj1E61xGglPZwraUVKKD7nIU4SQ==
=ENjb
-----END PGP SIGNATURE-----

--Sig_/yW+AOr5SLgbIwGoBWgQMQ5A--
