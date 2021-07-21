Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7333D0810
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 07:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhGUEYl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 00:24:41 -0400
Received: from ozlabs.org ([203.11.71.1]:49843 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232900AbhGUEYU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 00:24:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GV3RV40ZBz9sSs;
        Wed, 21 Jul 2021 15:04:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1626843895;
        bh=kXwg2yU4EaNsIIueeR8GovNFTK0nmHx4aTXTq88AaOA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZuH7xAgld4AvfNLY5ez6iq8OKKlGZjBrcmWdAcuWgTJfs3ISQJ9IAfRm6RX1huEtg
         r/YSZwvuWX5C7f0QVxPNZsy0RLmIjAzSfSJXU48FQuQGPCvs29b0mrSitudwWNwvn4
         c9QP08vH94c5Or5UJTuaKDrApBKby+ISnHbtTbIr4Icfnlvq95aI6XIZg+avuCosyx
         iNcBowSgY15jcQo/CSZdPk1u4NsWsC0qD1dezmtTTY/QC5DRPyVkL77PgtdTbEskbE
         albs/g42Lhx5mBZuyMJDDaKKcgcdfp5z8WT2BiRZosDQHHaxLZ5wsPN4l1Ls+lK/WK
         TRk/fxsiHckQg==
Date:   Wed, 21 Jul 2021 15:04:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Folio tree for next
Message-ID: <20210721150453.266d0b25@canb.auug.org.au>
In-Reply-To: <YPTu+xHa+0Qz0cOu@casper.infradead.org>
References: <YPTu+xHa+0Qz0cOu@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4eqt7ccmom_Xpmx2/pyOMn8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/4eqt7ccmom_Xpmx2/pyOMn8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Mon, 19 Jul 2021 04:18:19 +0100 Matthew Wilcox <willy@infradead.org> wro=
te:
>
> Please include a new tree in linux-next:
>=20
> https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/f=
or-next
> aka
> git://git.infradead.org/users/willy/pagecache.git for-next

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20

--Sig_/4eqt7ccmom_Xpmx2/pyOMn8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmD3qvUACgkQAVBC80lX
0GzLtQf/ZNKcpSSKD2fEjkP9fcnL+w+grMgP+K2xTcQ1ap99iRQDuq3uprhvfbfL
38+sJCmmoZkh+VjgMhPHj+AnVu53fFLxS0pC/ZdUbll1YRubEsGjEb8aoScXwVVg
tp6NQ/X2crsmSNbF1kKRHvhoMKEuLRYfnBYtlLleJwHdyvOgm5wfAYdwxDhPHeKK
eWkj2KBiyP8JJVvEf9itb3AJoAbkJgBizlxmpJxk7bZuAW8TO/EnVU4DHU1ZCzIF
krpym8k1tO7f45ci6ZXkddKCAtuxDq4z7ojC16oq3aTz6FD3gKAwS2JHdWqkzYnb
QMwGdhcPV0SPqeIszZjWP8vSI21ueg==
=eHku
-----END PGP SIGNATURE-----

--Sig_/4eqt7ccmom_Xpmx2/pyOMn8--
