Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A4B3ECAF2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Aug 2021 22:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhHOUdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 16:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhHOUdE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 16:33:04 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D017EC061764;
        Sun, 15 Aug 2021 13:32:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GnprD250wz9sT6;
        Mon, 16 Aug 2021 06:32:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1629059550;
        bh=klHHQ9z9GKs3lX1MqIe6u7DuwKvRYcvA7swPOyG2u3Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TpCl9Nx8G2SExc9Qp9MEF6XRZ83Gg2nvrKTjNHOaJWkUw6rozloTK+GivG/GLzr8g
         AT8eEyj7ZocYZ/AnBDMW3UTy56Dff9fCEfhO1EV0KmIcfFIU/L0b2ePL2y3o4R6Vuk
         DAEuyBC42zalBn+gPDTUcgA/lon0YGV5AN7/iBZMuy1v2hCdfVHaN+FaiJ9ZKEVoAR
         7N+tiLJd9qRxFdq+3ZNpgxP8rS4XVN0t2KkvVGy6x5OG5mvy0ilcxhjiLqZC6A7UPR
         cwjSGSWshHCy8BwnfKnXzjlF7Jvd5HDpPFo/WpvogvkryabJLGjNxDGqV5KC9UuYLw
         HyifnjzpRqrOQ==
Date:   Mon, 16 Aug 2021 06:32:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        "zajec5@gmail.com" <zajec5@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Matthew Wilcox" <willy@infradead.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>
Subject: Re: Paragon NTFSv3 (was Re: [GIT PULL] vboxsf fixes for 5.14-1)
Message-ID: <20210816063225.22d992ff@canb.auug.org.au>
In-Reply-To: <a9114805f777461eac6fbb0e8e5c46f6@paragon-software.com>
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
        <20210716114635.14797-1-papadakospan@gmail.com>
        <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
        <afd62ae457034c3fbc4f2d38408d359d@paragon-software.com>
        <CAHk-=wjn4W-7ZbHrw08cWy=12DgheFUKLO5YLgG6in5TA5HxqQ@mail.gmail.com>
        <a9114805f777461eac6fbb0e8e5c46f6@paragon-software.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/K=b9Pf+l2P0E7k_xtah2jkH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/K=b9Pf+l2P0E7k_xtah2jkH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Konstantin,

On Fri, 13 Aug 2021 16:11:10 +0000 Konstantin Komarov <almaz.alexandrovich@=
paragon-software.com> wrote:
>
> > From: Linus Torvalds <torvalds@linux-foundation.org>
> > Sent: Friday, July 30, 2021 8:24 PM
> > To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>; Step=
hen Rothwell <sfr@canb.auug.org.au>
> > Cc: Leonidas P. Papadakos <papadakospan@gmail.com>; zajec5@gmail.com; D=
arrick J. Wong <djwong@kernel.org>; Greg Kroah-
> > Hartman <gregkh@linuxfoundation.org>; Hans de Goede <hdegoede@redhat.co=
m>; linux-fsdevel <linux-fsdevel@vger.kernel.org>;
> > Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Al Viro <viro=
@zeniv.linux.org.uk>; Matthew Wilcox <willy@infradead.org>
> > Subject: Paragon NTFSv3 (was Re: [GIT PULL] vboxsf fixes for 5.14-1)
> >=20
> > On Fri, Jul 30, 2021 at 8:55 AM Konstantin Komarov
> > <almaz.alexandrovich@paragon-software.com> wrote: =20
> > >
> > > We've just sent the 27th patch series which fixes to the buildability=
 against
> > > current linux-next. And we'll need several days to prepare a proper p=
ull request
> > > before sending it to you. =20
> >=20
> > Well, I won't pull until the next merge window opens anyway (about a
> > month away). But it would be good to have your tree in linux-next for
> > at least a couple of weeks before that happens.
> >=20
> > Added Stephen to the participants list as a heads-up for him - letting
> > him know where to fetch the git tree from will allow that to happen if
> > you haven't done so already.
> >  =20
>=20
> Thanks for this clarification, Linus!
> Stephen, please find the tree here:
> https://github.com/Paragon-Software-Group/linux-ntfs3.git
> It is the fork from 5.14-rc5 tag with ntfs3 patches applied.
> Also, the latest changes
> - fix some generic/XYZ xfstests, which were discussed
> with Theodore, Darrick and others
> - updates the MAINTAINERS with mailing list (also added to CC here) and s=
cm tree link.
>=20
> Please let me know if additional changes requred to get fetched into linu=
x-next.

Added from today.  It looks good, we will see how it goes when integrated/b=
uilt.

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
sfr@canb.auug.org.au

--=20
Cheers,
Stephen Rothwell

--Sig_/K=b9Pf+l2P0E7k_xtah2jkH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmEZedkACgkQAVBC80lX
0GxprAf/SBzaK8sX8zNMX6JSgph/ESO9fU4/kwPPZ8MrhayR7+1nI433dLmDb3xO
MU3o+3/o4tkyoZkasyMzgJPRPeXP0xLlr7hA1rvQfwN9IZvgUiXiv8IDUVymZiGn
+xn8fedA3/XEpHcSpOarVVo7SAcEbPbY1M18dRTXX2ok84GjLR5aUQvsR3yYZOWI
pb9m2u8xdWMz4Zxr3A5tvon56apfeX7fX9dLaI8k7/Wv1VKqZfVmW3YeVIxYkfsM
fEJATxBXPeWeuF47MFWzW1zfSAyXCA7AvQE/gFtWogODLwpwMgcZhcdA5xOVIYfR
VlNH7G0udZ+LJDvlf44Y3UVl/PWWrQ==
=cB5h
-----END PGP SIGNATURE-----

--Sig_/K=b9Pf+l2P0E7k_xtah2jkH--
