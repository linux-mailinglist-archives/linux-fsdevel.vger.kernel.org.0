Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D25D3071E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 05:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfEaDuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 May 2019 23:50:21 -0400
Received: from ozlabs.org ([203.11.71.1]:59571 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfEaDuV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 May 2019 23:50:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45FVpJ4c70z9sB8;
        Fri, 31 May 2019 13:50:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559274618;
        bh=3Jn9dbpUQuW69rISQSqXh57RfRI00oNjkHZ1rVQBavo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PlRRvQZBtSGz+xAA6PBxyynY6UWNDGViQ7MbZq6/FlimXvcCQ03/is6ipsf8Av8DQ
         +4+2SYR0etZ/u5XhkJBzaOkVTbLRxSHsqb5qTnJApYXbLv6UzT0QkMhK5nXUwoP5XO
         1cOmZSs9we13FahymyPyxHr32ukL6DTUq0p2NZv/Kc9pJNLzG32OClppN40l8llGeb
         KGDJb9vkJAXWaRNWoZDPjc9BVN3aXJhSb1gtgV8d2V0635kLyizvhseymPS6UpbfoT
         z4dxvRdSiZtvutmKQkB7h9k+Ov+TvkRmXkY7ceq4fvSkPRUmWGilspvl889p7wINTx
         5fqvOujgUBdpg==
Date:   Fri, 31 May 2019 13:50:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luigi Semenzato <semenzato@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-next@vger.kernel.org, Michal Hocko <mhocko@suse.cz>,
        mm-commits@vger.kernel.org
Subject: Re: mmotm 2019-05-29-20-52 uploaded
Message-ID: <20190531135015.6a898d26@canb.auug.org.au>
In-Reply-To: <CAA25o9RFhS=qm=B_mYAdQeAUAi7pLbXttWJfw7yKMWQQAXhhAw@mail.gmail.com>
References: <20190530035339.hJr4GziBa%akpm@linux-foundation.org>
        <CAA25o9RFhS=qm=B_mYAdQeAUAi7pLbXttWJfw7yKMWQQAXhhAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1ISJy/USqL3uKe+N6QGnZgM"; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/1ISJy/USqL3uKe+N6QGnZgM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 29 May 2019 21:43:36 -0700 Luigi Semenzato <semenzato@google.com> w=
rote:
>
> My apologies but the patch
>=20
> mm-smaps-split-pss-into-components.patch
>=20
> has a bug (does not update private_clean and private_dirty).  Please
> do not include it.  I will resubmit a corrected version.

I have dropped that from linux-next today.

P.S. in the future please trim your replies to relevant bits, thanks.
--=20
Cheers,
Stephen Rothwell

--Sig_/1ISJy/USqL3uKe+N6QGnZgM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzwpHcACgkQAVBC80lX
0GzTMwf+P79ZCniPZu4298eDmJPDDV5hrSNugRpBpF7wLOr72Nm/RbueUfGnpM7e
JlSehMtkCyaJkCW7uW+N6Ior1ep747lrkVCtg95G/yB6vrIu5oUlLG2sGxlWlh1D
pAXCHg3T1BB0/8dRvJXr7YmDOLakwpKf+4nN6V0PZwwEctN4ZvcuCWuHnj2lGTnR
BVlrJe4EDfB/sDUSm9i1gd3Dgx5ClUSk7gG8RrYRezNlOS7pCPEOwEgmQ62KUaeD
qncMOV1g6xhllddSxA97HEyf8C6eA+5tDR2kj1EmDu9hZNR+gLHXgyGUg7QWSGEW
dtHgXURwm3m/7VmP4N+fqpqyzkMF2g==
=ImAe
-----END PGP SIGNATURE-----

--Sig_/1ISJy/USqL3uKe+N6QGnZgM--
