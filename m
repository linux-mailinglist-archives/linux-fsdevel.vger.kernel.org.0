Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412B973E2ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 17:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjFZPMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 11:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjFZPMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:12:51 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B19AD191;
        Mon, 26 Jun 2023 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687792367;
        bh=kGDGl8d/NtOUzNS4kz09HsZ1PAtr9zSUnhGHz+Tg83g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kCxU12SqMWZKgWtJFvVpoAU43xTs8qgADeTwSHMh36RYs2DQBLM7d1NwdilJ+7T5O
         9ZgRJv4MHMSUsSgdcvAVBZfn4MBbnd+Ab3QLuRMDuFHurLsEX7l9zX7k54K+T1rm6D
         hjGGUVjngkJN4xUQm01o6JwKFMTJ95Km9xrqkdVtqc4CUGwp2dHeAijCW6bYx3G/I6
         bd5m/L00ADU5v/FAKNCsIUbifd9lLV/IVa4ya9V5jV6TRmNfyZgGXkUua1TXsYETdB
         LWuzZbV3f4bfek4VD7aLP/wsb4xKwZYRZdcAhLmId8LtXk1+WvFgEfRtgq0nwxsBP9
         B9Uc9pYiZJWxw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id C5FDFEE2;
        Mon, 26 Jun 2023 17:12:47 +0200 (CEST)
Date:   Mon, 26 Jun 2023 17:12:46 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: splice(-> FIFO) never wakes up inotify IN_MODIFY?
Message-ID: <jbg6kfxwniksrgnmnxr7go5kml2iw3tucnnbe4pqhvi4in6wlo@z6m4tcanewmk>
References: <jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux>
 <CAOQ4uxhut2NHc+MY-XOJay5B-OKXU2X5Fe0-6-RCMKt584ft5A@mail.gmail.com>
 <ndm45oojyc5swspfxejfq4nd635xnx5m35otsireckxp6heduh@2opifgi3b3cw>
 <CAOQ4uxgCrxMKO7ZgAriMkKU-aKnShN+CG0XqP-yYFiyR=Os82A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4262ouftleju4mv3"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgCrxMKO7ZgAriMkKU-aKnShN+CG0XqP-yYFiyR=Os82A@mail.gmail.com>
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


--4262ouftleju4mv3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 26, 2023 at 05:53:46PM +0300, Amir Goldstein wrote:
> > So is it really true that the only way to poll a pipe is a
> > sleep()/read(O_NONBLOCK) loop?
> I don't think so, but inotify is not the way.
So what is? What do the kernel developers recommend as a way to see if a
file is written to, and that file happens to be a pipe?

FTR, I've opened the symmetric Debian#1039488:
  https://bugs.debian.org/1039488
against coreutils, since, if this is expected, and writing to a pipe
should not generate write events on that pipe, then tail -f is currently
broken on most systems.

--4262ouftleju4mv3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSZqu4ACgkQvP0LAY0m
WPFzhBAAtraMjYl5wD7wo1KcX8HzPzhZ7Nipp3okNIWFts57AujFG3TsZmE0RYMk
z1EiYu4GinBZj91uCY1Qy5WZIWJUoodn7eRe9SnO0O1gbWNGi0cEJHlT78CW7lz+
lqWaw1ucQkgGekwR7ZriYQaonCoEWDsopHYNV2i2wAwt7p+t3vfQgfcEkq60Tnzh
auSJvV0HcvE/N1dduX2QCuf6a5hWjdcKFP7GLAIeh+kqLRT+j6phL29JslvG8tCw
Y2zsMcC4uHMRv/qPlC7efTiXLpxQgaoKO2ioO0i3fB7piNGfBthiQwkJzupa3Nft
EVMxOMh62wrqMIIZHBQvo/vaSATJlKacvELW9A8yl124OI2dEPUStiIpRk/FMtfj
CnU3Jby0OF8CO3RVA4z/yX6fS8PxIoBPByJEs3bP/sValymNa1ghgiH17XaXIt0n
Iu+2QHdIgHhqzwCeNxd7XXpiq0IaHOBqRa8NepZpmoqNb9ZeifhHrr+MjoEqJ35O
3HU4IMT2PMwrHZNjr6o3/xI3n1zoMI5/P+cm5Lz9Bb/cvwih3NpVXW6EappRIlja
66oATckB5570/D+lMQEnDL2kKa5fcooBjIM+abCzCxmgtizbREJMzOzIwf+rjQE3
FM5dwGEsA8K17CPm0lRVVwdPeFdxf0bgI36KJrGuQjLYLt+fS4k=
=fp5P
-----END PGP SIGNATURE-----

--4262ouftleju4mv3--
