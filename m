Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA4C5B630B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 23:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiILVt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 17:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiILVtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:49:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D6FB7CF;
        Mon, 12 Sep 2022 14:49:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MRKy22vMMz4xFt;
        Tue, 13 Sep 2022 07:49:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663019388;
        bh=CHb/HFS/YBUK6LYyCv0Ig6t6CoCQ9NnN9We46PpcpMM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gcuL+UE4DAC44wpK3nXAbvF2+K8mwss7m6RSNWaj8Mh8awM2Wt/FiEQf2vI9qPrnY
         h/5aGQBKy+bfc0BS8MEjgJAHhu/shzbvce0n2hpOsptgWcxJTQNKx0F2N2FV/FLIX6
         SpOIdzVbwdR2CAbCf35ZlU9hH8uoI9CBJiK1auFJZ1qFAmdHTLKQFFVg89Kc6/niwL
         IlOLw8YTX9/eppj7U8UoqKtkLMot+bqQ6uYXyp+oVE9NWmlAIfgPhpcJ83VDjIpTS2
         AUlCCsqj86uQnYPR07+4K1Fi+TPku0C2oWOxWOynty4hjlmoB9cqwzwOQjpkVRGxpz
         C0++lys4Fdl6w==
Date:   Tue, 13 Sep 2022 06:30:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v5 0/8] make statx() return DIO alignment information
Message-ID: <20220913063025.4815466c@canb.auug.org.au>
In-Reply-To: <Yx6DNIorJ86IWk5q@quark>
References: <20220827065851.135710-1-ebiggers@kernel.org>
        <YxfE8zjqkT6Zn+Vn@quark>
        <Yx6DNIorJ86IWk5q@quark>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ySqoajbBqbhy0s/Yyi/jEcM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/ySqoajbBqbhy0s/Yyi/jEcM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Sun, 11 Sep 2022 19:54:12 -0500 Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Sep 06, 2022 at 03:08:51PM -0700, Eric Biggers wrote:
> > On Fri, Aug 26, 2022 at 11:58:43PM -0700, Eric Biggers wrote: =20
> > > This patchset makes the statx() system call return direct I/O (DIO)
> > > alignment information.  This allows userspace to easily determine
> > > whether a file supports DIO, and if so with what alignment restrictio=
ns. =20
> >=20
> > Al, any thoughts on this patchset, and do you plan to apply it for 6.1?=
  Ideally
> > this would go through the VFS tree.  If not, I suppose I'll need to hav=
e it
> > added to linux-next and send the pull request myself.
> >=20
> > - Eric =20
>=20
> Seems that it's up to me, then.
>=20
> Stephen, can you add my git branch for this patchset to linux-next?
>=20
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
> Branch: statx-dioalign
>=20
> This is targeting the 6.1 merge window with a pull request to Linus.

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
sfr@canb.auug.org.au

--Sig_/ySqoajbBqbhy0s/Yyi/jEcM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMfluEACgkQAVBC80lX
0GzrXAf9ESId1RmQujmRO/suIb7p60bPOkr5l/1EmdjlqHgMfXoP0bDKsbHNd3Do
ZOf+Qj8BPc1KuPXgGEqZ8bWxEMOu5NtVl82bbhQwaMZbaObcE+CW34aaenRKRBCq
kPAHrUAe3SGkuyVjQJFX0I0PdGe7WYoar4MhO3ULl1USnIEF0p6GCXXe1DvR2LRA
6ZMdZbx+g9cPc2ya5lzpHLIkTaDSjjjE/blGA0UFuUYAyRUVEw0rGig1iPnQA+EP
dr+aQ+9vZ1OICIy2tSpsplEl2Otk4rTA0EAB/BVYTDOBgMQQ6CLZN9o+1tHnmsuK
/BZ7ql3uk0XzQR2n0awIeOjS13b5Sg==
=u95+
-----END PGP SIGNATURE-----

--Sig_/ySqoajbBqbhy0s/Yyi/jEcM--
