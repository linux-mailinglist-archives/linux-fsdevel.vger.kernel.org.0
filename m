Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB773CF0D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 02:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348096AbhGSXx5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 19:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355272AbhGSX1b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 19:27:31 -0400
X-Greylist: delayed 490 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Jul 2021 16:59:58 PDT
Received: from gimli.rothwell.id.au (gimli.rothwell.id.au [IPv6:2404:9400:2:0:216:3eff:fee1:997a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DA5C05BD30
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jul 2021 16:59:58 -0700 (PDT)
Received: from authenticated.rothwell.id.au (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.rothwell.id.au (Postfix) with ESMTPSA id 4GTJXX4zlPzykD;
        Tue, 20 Jul 2021 09:51:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rothwell.id.au;
        s=201702; t=1626738701;
        bh=1WO9k5eI6bGdzlIKCTJhZj9/sUgG0e1cD2+T+Sp0pmc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AcLHHd2gQzK1ZLfycbqUVskRkCBOgMtqGNHQBr6VpTcamC76eiELQ8qaX9lC5KpxI
         uYko4eyhnHbY99gMafFiI4FRxxjmF7TIxKttyFwOHHsuPZ4sZX5lpPNdXXJqxVLhOR
         r8QgHB3NaU38j4G03nIdEKWGC2fif/VnSPlDOrfVrbStwMsE6//ChnCX4P9dHMIzgL
         ZjeK7fAQ+4OGjcENhEfuhKuttW0591kpZ33lgyUJ0eYREzR7jdtMhbdQtoH/nITEkC
         tCImhaU0cJnUQ0ojUo6gDeNFFSLEf53q07WtlpeW48oBzOErWQ7DUG4J+JO3QZ3N+H
         G6YdrhJjJzg5A==
Date:   Tue, 20 Jul 2021 09:51:37 +1000
From:   Stephen Rothwell <sfr@rothwell.id.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Folio tree for next
Message-ID: <20210720095137.65702810@elm.ozlabs.ibm.com>
In-Reply-To: <20210720094033.46b34168@canb.auug.org.au>
References: <YPTu+xHa+0Qz0cOu@casper.infradead.org>
        <20210718205758.65254408be0b2a17cfad7809@linux-foundation.org>
        <20210720094033.46b34168@canb.auug.org.au>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/r+a3h9RBW5C+1eFlQhlnRx7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/r+a3h9RBW5C+1eFlQhlnRx7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, 20 Jul 2021 09:40:33 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Sun, 18 Jul 2021 20:57:58 -0700 Andrew Morton <akpm@linux-foundation.o=
rg> wrote:
> >
> > On Mon, 19 Jul 2021 04:18:19 +0100 Matthew Wilcox <willy@infradead.org>=
 wrote:
> >  =20
> > > Please include a new tree in linux-next:
> > >=20
> > > https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/hea=
ds/for-next
> > > aka
> > > git://git.infradead.org/users/willy/pagecache.git for-next
> > >=20
> > > There are some minor conflicts with mmotm.  I resolved some of them by
> > > pulling in three patches from mmotm and rebasing on top of them.
> > > These conflicts (or near-misses) still remain, and I'm showing my
> > > resolution:   =20
> >=20
> > I'm thinking that it would be better if I were to base all of the -mm
> > MM patches on linux-next.  Otherwise Stephen is going to have a pretty
> > miserable two months... =20
>=20
> If they are only minor conflicts, then please leave them to me (and
> Linus).  That way if Linus decides not to take the folio tree or the
> mmotm changes (or they get radically changed), then they are not
> contaminated by each other ... hints (or example resolutions) are
> always welcome.

Also, I prefer to have less, not more, of the mmotm patch set depending
on the rest of linux-next since fixing conflicts while rebasing is
often more pain than while merging.

--=20
Cheers,
Stephen Rothwell

--Sig_/r+a3h9RBW5C+1eFlQhlnRx7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmD2EAoACgkQAVBC80lX
0GwYnggAmdaNrN1vJU6cuGReiBkw9zM49IBrvcZX/zhUwjXTKzkTfnH/CfyqnYHT
f6q/UPYrVFeH8Jto9g1sMs4u56yHaRogNmPie4VJDXWjqa7N5JO3FPtz3YtGcMVH
zHyBQoNRShKFeMfz5Uadh+LjMwtFdrJEtK/DS7s5FYVmKGdp8o44cPL0HxsUTiTC
Huc4OMvMrch7q5aYoh+3NAG1xcjvIFfdAhx9nx9p+5Az+0Br0aQPC4DgPGLkgmlU
Zs1+ljEG2JgLj05XpFCfsO69eYCu0K03/zMhSjfcGp1pEiu/KzzBnIOFYLKC6ABp
S55UPNpClvtHTDBJw5URUuJ0hRSTeQ==
=hVBl
-----END PGP SIGNATURE-----

--Sig_/r+a3h9RBW5C+1eFlQhlnRx7--
