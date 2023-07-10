Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4A774D769
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 15:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjGJNWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 09:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjGJNWg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:22:36 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E82BFA;
        Mon, 10 Jul 2023 06:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1688995347;
        bh=S42i91srJauPHv7nLTKa96Nt33BGWfPrr0AmwrhyPgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bsGRzJft09o0RYEMCirnoIy1WrdBam0Rfv/R7FPmtRneollNJULiv/kf8RsQkIIwz
         1xS44c0uuW0xjqwJLYZSDOWVWHr8Xa5HlpduTRhVERORQkoyu8OQRECFzW6y/0ryBN
         dMdVairKLsTwy1PQjW1hidwNdCBTdv2hFAcsFZVVdhyrKPXohnFZ5xDqE6jvhidxi7
         PybZqhxcGJHUtpeg1AZoaxXjOnqfl5ODNnOubwn+bCyLi17pIVS+xODeTy4mE5u3c6
         9aK10vVQcSFS8eBJq4oq0Jdta0pRpUb+IMVCTOOSkRtCUt3KWPxgmZlhCDRtEc0f6d
         /d5T01obWU9Dw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 688D12CCA;
        Mon, 10 Jul 2023 15:22:27 +0200 (CEST)
Date:   Mon, 10 Jul 2023 15:22:26 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Pending splice(file -> FIFO) excludes all other FIFO operations
 forever (was: ... always blocks read(FIFO), regardless of O_NONBLOCK on read
 side?)
Message-ID: <5osglsw36dla3mubtpsmdwdid4fsdacplyd6acx2igo4atogdg@yur3idyim3cc>
References: <qyohloajo5pvnql3iadez4fzgiuztmx7hgokizp546lrqw3axt@ui5s6kfizj3j>
 <CAHk-=wgmLd78uSLU9A9NspXyTM9s6C23OVDiN2YjA-d8_S0zRg@mail.gmail.com>
 <20230707-konsens-ruckartig-211a4fb24e27@brauner>
 <CAHk-=whHXogGiPkGFwQQBtn364M4caVNcBTs7hLNfa_X67ouzA@mail.gmail.com>
 <zu7gnignulf7qqnoblpzjbu6cx5xtk2qum2uqr7q52ahxjbtdx@4ergovgpfuxt>
 <CAHk-=wjEC_Rh8+-rtEi8C45upO-Ffw=M_i1211qS_3AvWZCbOg@mail.gmail.com>
 <ltbgocygx4unco6ssoiszwsgjmztyuxkqja3omvvyqvpii6dac@5abamn33galn>
 <CAHk-=wimmqG_wvSRtMiKPeGGDL816n65u=Mq2+H3-=uM2U6FmA@mail.gmail.com>
 <ayhdkedfibrhqrqi7bhzvkwz4yj44cmpcnzeop3dfqiujeheq3@dmgcirri46ut>
 <gnj4drf7llod4voaaasoh5jdlq545gduishrbc3ql3665pw7qy@ytd5ykxc4gsr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xal4bth6dik3niji"
Content-Disposition: inline
In-Reply-To: <gnj4drf7llod4voaaasoh5jdlq545gduishrbc3ql3665pw7qy@ytd5ykxc4gsr>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--xal4bth6dik3niji
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 12:33:07AM +0200, Ahelenia Ziemia=C5=84ska wrote:
> On Sun, Jul 09, 2023 at 03:03:22AM +0200, Ahelenia Ziemia=C5=84ska wrote:
> > On Sat, Jul 08, 2023 at 01:06:56PM -0700, Linus Torvalds wrote:
> > > I guess combined with something like
> > >=20
> > >         if (!(in->f_mode & FMODE_NOWAIT))
> > >                 return -EINVAL;
> > >=20
> > > it might all work.
> > Yes, that makes the splice instantly -EINVAL for ttys, but doesn't
> > affect the socketpair() case above, which still blocks forever.
> This also triggers for regular file -> pipe splices,
> which is probably a no-go.
Actually, that's only the case for regular files on some filesystems?
I originally tested on tmpfs, and now on vfat, ramfs, procfs, and sysfs,
and none have FMODE_NOWAIT set.

Conversely, ext4 and XFS files both have FMODE_NOWAIT set,
and behave like blockdevs incl. the filemap_splice_read() oddities below.

Indeed, it looks like Some filesystems
(btrfs/ext4/f2fs/ocfs2/xfs, blockdevs, /dev/{null,zero,random,urandom},
 pipes, tun/tap)
set FMODE_NOWAIT, but that's by far not All of them, so maybe
  /* File is capable of returning -EAGAIN if I/O will block */
is not the right check for regular files.

> filemap_get_pages() does use and inspect IOCB_NOWAIT if set in
> filemap_splice_read(), but it appears to not really make much sense,
> inasmuch it returns EAGAIN for the first splice() from a
> blockdev and then instantly return with data on the next go-around.
Indeed, this is inconsistent to both:
  * readv2(off=3D-1, RWF_NOWAIT), which always returns EAGAIN, and
  * fcntl(0, F_SETFL, O_NONBLOCK), read(), which always reads.

Thus,
> This doesn't really make much sense =E2=80=92 and open(2) says blockdevs
> don't have O_NONBLOCK semantics, so I'm assuming this is not supposed
> to be exposed to userspace =E2=80=92 so I'm not setting it in the diff.
not specifying IOCB_NOWAIT in filemap_splice_read() provides consistent
semantics to "file is read as-if it had O_NONBLOCK set".


I've tentatively updated the check to
		if (!((in->f_mode & FMODE_NOWAIT) || S_ISREG(in->f_inode->i_mode)))
(with the reasoning, as previously, that regular files don't /have/ a
 distinct O_NONBLOCK mode, because they always behave non-blockingly)
and with that
> I've tested this for:
  * regular file: works as expected

--xal4bth6dik3niji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSsBg8ACgkQvP0LAY0m
WPFELBAAsKXo6ppXGhW9vySYaO+M2PtLSXb5TV5WswRFexjAKdmhOk8HxN8y9Gsl
Mn06eqPLgNwnnn7+LiLCmx3HpvTU3tRICDlDjHeuaunW7ILXyLbHNB2D6GQPb0zf
QzkYohRuPmZllG3IG/7OceHEHHNtMHy23/IwzA+EbYBblTjGFjQLWh4nZxf5jQEt
ZcJxg+D8tcR+xydWIRx3r8E8dhv7esm357mDi/r8Kyelx+fKTzQGTDxmgqpCi0ps
FJqgLNzJC+q/2C+zPUQ9dAqmM6qGM39c/csVBNcAn9z3QoOmB1vXaDFe+Arfo9Er
M0kqoT2r+zUksP67vU2e0w3ypbEWgx23zU87Diz4Y43ig9yiMmtZeGuC6kNF+AWp
qj3rxBYW6d41YWSyTU7tSfK18mg+owfp9TyamKya6YE5xfSxKLkESOF+zkZMr+7y
Naqahbm5WFTGgcl6k50dKF81dXWBKij3s3QBai53sXYZrKUv0is9ObEO489aSAYk
mlQCeFIVPYnUM/aj79tYBkk8zKmpNRZDbwMg5EatQsaUfd8v2xotU0alSYWsjmli
YrUQDo7OzyA7U6GPwtrx9LLyRh4IrSPdvkpnymjvR0V/rOujGeD1MmAqjRQnbLKL
Jo0CtS0NC9iaY7c/xKK9i4kNTkUgtypuOmk2mLuab5mOwCBpzAk=
=65Ez
-----END PGP SIGNATURE-----

--xal4bth6dik3niji--
