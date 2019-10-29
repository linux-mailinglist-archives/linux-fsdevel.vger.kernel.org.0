Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C134E7F6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 06:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbfJ2FHj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 01:07:39 -0400
Received: from ozlabs.org ([203.11.71.1]:50809 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731547AbfJ2FHi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 01:07:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 472KMp2YvRz9sPV;
        Tue, 29 Oct 2019 16:07:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1572325656;
        bh=cjVSQ2LeMyLilTOrYL1B1Dp8AyZuyPWwP4ayARVor8M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NrkxL5DNaqn/fFPvdXlvKguLF+D5zjiI7p+g88YE9sqP78SRoWgA614JHSEjxujlo
         mulVx26SU8rT0Ox7178eD1fsvm+WbIGLwRskp7evaKug6mtD8q0kGWkG0t7K+1NjHZ
         Bs52PB1LHiyc9xMFgNaEfIcWRRwgStyKEQJLKehGWDr1gXUHoDsQx0J6dzW7BTLCij
         qWBx+M5Zl292rAn3U/v5cNXMda03Q7d0ZxCmEOjbE84dp3soqBIoEd1VOadyJbGqh6
         xUVELfHbZuA2Sgip3SFAWOVbmemTP80AsGLaGnekmHu+6KUp8FergJBQbFHWRhkOwH
         k9gaf91CUoH8Q==
Date:   Tue, 29 Oct 2019 16:07:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Boaz Harrosh <boaz@plexistor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Please add the zuf tree to linux-next
Message-ID: <20191029160733.298c6539@canb.auug.org.au>
In-Reply-To: <20191024023606.GA1884@infradead.org>
References: <1b192a85-e1da-0925-ef26-178b93d0aa45@plexistor.com>
        <20191024023606.GA1884@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DNRAmrpHoq6Pd+umJSouVY0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/DNRAmrpHoq6Pd+umJSouVY0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Wed, 23 Oct 2019 19:36:06 -0700 Christoph Hellwig <hch@infradead.org> wr=
ote:
>
> On Thu, Oct 24, 2019 at 03:34:29AM +0300, Boaz Harrosh wrote:
> > Hello Stephen
> >=20
> > Please add the zuf tree below to the linux-next tree.
> > 	[https://github.com/NetApp/zufs-zuf zuf] =20
>=20
> I don't remember us coming to the conclusion that this actually is
> useful doesn't just badly duplicate the fuse functionality.

So is that a hard Nak on inclusion in linux-next at this time?

--=20
Cheers,
Stephen Rothwell

--Sig_/DNRAmrpHoq6Pd+umJSouVY0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl23yRUACgkQAVBC80lX
0GwIiAgAoL3ldh/i+LtJQynaMn2qgEcke4R5IfGsrq08bxO9xczz48rlUAwwGY3i
Xre4GQ/G4jZSiNcHHXnBtgA9habyNVb4yqmhJnQav/x6m+wQmE3lxlp6FaIWV4TJ
eOWY3XUiNyYGPQVzVgpNvor8oIz1vTYodw2NbpoakoTYnbdz5S3mwMWAbLK/i8V5
MZ12qTE8QrMxAGqPWZeEXW7tpPMvNvyJh3wqWF8dNETWQ9SSfMfeVA/Kc162eGYT
t++EuUdmMcLXpjhUDjeoN0cW+Equ3E5JZ+jNbBQ/UIBBAYj7gDdns/jRSrXp++54
RtlRL2TApKLbNKRisNddCuCOO+bF+w==
=Jukb
-----END PGP SIGNATURE-----

--Sig_/DNRAmrpHoq6Pd+umJSouVY0--
