Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D9473E2FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 17:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjFZPP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 11:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjFZPP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:15:27 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5C6510CC;
        Mon, 26 Jun 2023 08:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687792524;
        bh=dK4AKC1Fb5bvHwBamv1jG0anv/0r51d9fw3Gj5lpCG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZoMmXk2TydUP/hBZyR5wY8hzqbBxQLHj2tcWHUYx8uCgf6FyHFWpV08Nv8MDlwng6
         GFNIuEbraFndyQVKLtVYcWyq6kq/04ul/Y2/RDnIp3DJJTupiSraSD+TEv9o1z5ZIy
         bMaVlBlD2hTwCNjZ9/mWui5LqfxFQ1C/R0/ZLPaKnM4LseCiEqjkcZByVzcOlhDg6k
         a+xnB0Z++CKjsVeTjDFkiOzXnu2AJZpzSyZbAd6tC3cqee0//pqH0RZHtNPTaVFBkF
         3Zx0Fpsrf/g1MFF7yua/npx+Zdsc+JOl8kdnxkfOVTMAwfkMDcrvkUzrCLdIpcQ4eZ
         i38QvF9b5aDEw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id E0588180E;
        Mon, 26 Jun 2023 17:15:24 +0200 (CEST)
Date:   Mon, 26 Jun 2023 17:15:23 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: splice(-> FIFO) never wakes up inotify IN_MODIFY?
Message-ID: <sw26o55ax3cfaaqhlbd2qxkdroujnfxtbxrmt2rpjztmedz3mn@uauqn6hexwdq>
References: <jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux>
 <CAOQ4uxhut2NHc+MY-XOJay5B-OKXU2X5Fe0-6-RCMKt584ft5A@mail.gmail.com>
 <ndm45oojyc5swspfxejfq4nd635xnx5m35otsireckxp6heduh@2opifgi3b3cw>
 <vlzqpije6ltf2jga7btkccraxxnucxrcsqbskdnk6s2sarkitb@5huvtml62a5c>
 <20230626135159.wzbtjgo6qryfet4e@quack3>
 <bngangrplbxesizu5kbi442fw2et5dzh723nzxsqj2b2p5ikze@dtnajlktfc2g>
 <20230626150001.rl7m7ngjsus4hzcs@quack3>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ubfwuid2dhrghilf"
Content-Disposition: inline
In-Reply-To: <20230626150001.rl7m7ngjsus4hzcs@quack3>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ubfwuid2dhrghilf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 05:00:01PM +0200, Jan Kara wrote:
> On Mon 26-06-23 16:25:41, Ahelenia Ziemia=C5=84ska wrote:
> > On Mon, Jun 26, 2023 at 03:51:59PM +0200, Jan Kara wrote:
> > > On Mon 26-06-23 14:57:55, Ahelenia Ziemia=C5=84ska wrote:
> > > > On Mon, Jun 26, 2023 at 02:19:42PM +0200, Ahelenia Ziemia=C5=84ska =
wrote:
> > > > > > splice(2) differentiates three different cases:
> > > > > >         if (ipipe && opipe) {
> > > > > > ...
> > > > > >         if (ipipe) {
> > > > > > ...
> > > > > >         if (opipe) {
> > > > > > ...
> > > > > >=20
> > > > > > IN_ACCESS will only be generated for non-pipe input
> > > > > > IN_MODIFY will only be generated for non-pipe output
> > > > > >
> > > > > > Similarly FAN_ACCESS_PERM fanotify permission events
> > > > > > will only be generated for non-pipe input.
> > > > Sorry, I must've misunderstood this as "splicing to a pipe generates
> > > > *ACCESS". Testing reveals this is not the case. So is it really true
> > > > that the only way to poll a pipe is a sleep()/read(O_NONBLOCK) loop?
> > > So why doesn't poll(3) work? AFAIK it should...
> > poll returns instantly with revents=3DPOLLHUP for pipes that were closed
> > by the last writer.
> >=20
> > Thus, you're either in a hot loop or you have to explicitly detect this
> > and fall back to sleeping, which defeats the point of polling:
> I see. There are two ways around this:
>=20
> a) open the file descriptor with O_RDWR (so there's always at least one
> writer).
Not allowed in the general case, since you need to be able to tail -f
files you can't write to.

> b) when you get POLLHUP, just close the fd and open it again.
Not allowed semantically, since tail -f follows the file, not the name.

> In these cases poll(3) will behave as you need (tested)...
Alas, those are not applicable to the standard use-case.
If only linux exposed a way to see if a file was written to!

For reference with other implementations,
this just works and is guaranteed to work under kqueue(2) EVFILT_READ
(admittedly, kqueue(2) is an epoll(7)-style system and not an
 inotify(7)-style one, but it solves the issue,
 and that's what NetBSD tail -f uses).

Maybe this is short-sighted but I don't actually really see why inotify
is... expected? To only generate file-was-written events only for some
writes?

--ubfwuid2dhrghilf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSZq4sACgkQvP0LAY0m
WPE6RQ//U1X3lkjqeC6XPN5pGQOzT8Fuyn3qjRdOPw3UdFFGRpoY6Yo3DrnsxXZD
ubn/7v7cyMoA5ZQQcuCl+GUKzdXFx98ap+1d70i/eRrzQLzVN+gHi3n6SW2D+Pav
NJFMB8UtIdGkegWL5kybDBGdUD9/S2SWVoIC2V9O9Zb/AeKf4UgSWf5lFxJWDRPV
8KA6aNOBkLR0mQTzk39tTjZw7LnF2VV2Cu3ZJ6zjDUtuPgSlDEyNOOlk4WjZC+B1
uv2dlRvW5SeMSuUxGkARdi5DzSiPmPaVlgypYd5FGTvwsuYvYB02Ci6r107WCpbB
iz98V7dyL16VZjSvpL7N25vKYqjxMOXtuswbZ3yhJyGjt13289Pw5dlxvZ+rWK11
Ui5G0wtbMCMdvV1mJinFH+08eefrK7aJ/CUxvXe88e/l3HZaUt6sLgIgUGxTZXbz
ftGxpSWglTLXlTjD0EhVcbioUABkS/wtk1SEA7fZGXY6FycWXoZlzp0WzFM59lKB
yChvaV94GsL/+EMgTn2/qQ1o4Y9wYj49mj2TPEaWUuV+keL2Sy6Rqsfq1jSClJMO
mhc9HFycsDccCBcvHQLVD5lSiKkKJmih1otmhQe/uUfCQTNW6N2jLsGVV2tzVdpv
sVLFsnnWtzQ8uHslhXIZSJkKDY5nStzkoMoOrxvHr1enYsNE1ZA=
=rXDh
-----END PGP SIGNATURE-----

--ubfwuid2dhrghilf--
