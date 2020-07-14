Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FBC21E67B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 05:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgGNDqQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 23:46:16 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46807 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbgGNDqQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:46:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B5RJN5wSbz9sRK;
        Tue, 14 Jul 2020 13:46:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594698374;
        bh=Qw7YnurS9X7mYF//AOPfy9vNeNoTKWc5cdcLkBaxxcI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QAdMbtUZmaq4l1wlPNz+4Utr2+7Sb1Gnz4o+8H5Z3syrV/DLniJP4AVx2p6mtedNn
         Pt3L/QZPZ0EOeYh5s2qsnwyztRmLWsV2zZ3bUBNz7bImfwbIDRSyV+EG14IMXLS9GQ
         00omS06gErezBuO9yHe4uJ4PPxQ1xz+9pGjYEWLr4RnntnU3gps1OldLXPtuqGkmBe
         XXt8QU3FTAn0mFXDW/xWYdwzgoL0UQqbCl8TgTQ4mVbHoBouUQpT9VrEhhw9PeGRLj
         nBKCmErYwk9ga+FcMCIepshX+Rmuz3g+bLLKBwpD4KLaiK7YsbASqGm15PAv01qL1b
         bS1yoUgkQOXrA==
Date:   Tue, 14 Jul 2020 13:46:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        paulmck@kernel.org, rcu@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: Null-ptr-deref due to "vfs, fsinfo: Add an RCU safe per-ns
 mount list"
Message-ID: <20200714134610.1268402f@canb.auug.org.au>
In-Reply-To: <20200625112517.4cf8f3a9@canb.auug.org.au>
References: <31941725-BEB0-4839-945A-4952C2B5ADC7@lca.pw>
        <2961585.1589326192@warthog.procyon.org.uk>
        <20200624155707.GA1259@lca.pw>
        <20200625112517.4cf8f3a9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fpv0od1joaNWLrVRZrg+VM7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/fpv0od1joaNWLrVRZrg+VM7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi sll,

On Thu, 25 Jun 2020 11:25:17 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Wed, 24 Jun 2020 11:57:07 -0400 Qian Cai <cai@lca.pw> wrote:
> >
> > On Wed, May 13, 2020 at 12:29:52AM +0100, David Howells wrote: =20
> > > Qian Cai <cai@lca.pw> wrote:
> > >    =20
> > > > Reverted the linux-next commit ee8ad8190cb1 (=E2=80=9Cvfs, fsinfo: =
Add an RCU safe per-ns mount list=E2=80=9D) fixed the null-ptr-deref.   =20
> > >=20
> > > Okay, I'm dropping this commit for now.   =20
> >=20
> > What's the point of re-adding this buggy patch to linux-next again since
> > 0621 without fixing the previous reported issue at all? Reverting the
> > commit will still fix the crash below immediately, i.e.,
> >=20
> > dbc87e74d022 ("vfs, fsinfo: Add an RCU safe per-ns mount list") =20
>=20
> I have added a revert of that commit to linux-next today.

I am still reverting that commit ...

--=20
Cheers,
Stephen Rothwell

--Sig_/fpv0od1joaNWLrVRZrg+VM7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8NKoIACgkQAVBC80lX
0GybYggAmWxmQ1SfgeqUuK++jhLBzDwkzBn6NEkRSXUXI1NdoC0Nco5Hm9KlPcKP
HnihB3LKzg4lfEMwnK1ydDVODycwPKY/q5H+HAO95/dNy0AuDngiljSJRvmEqiA9
xSzDgvieiZH58lkkI+YcBdn13sFkn24lLGI1tyCV7t4+loHcPIlbjl8XMXhQej7E
aGGQm2VPHbX42OQ59OQSkFDTVeHeKFmg2wUHuXubpK8GkXwUy6md2CgxcWqV2j9q
UvRCtxC9QsTBR3lkETWJ5UGu/KKJx9vpvk/BxgOGUOFFIFRV0KArCczZllEnOlLG
WvNN03Ql4QPdrP4rpWbtc5p0MjxkyQ==
=Zr0Z
-----END PGP SIGNATURE-----

--Sig_/fpv0od1joaNWLrVRZrg+VM7--
