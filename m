Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EB179A0CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Sep 2023 02:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjIKAic (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Sep 2023 20:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjIKAib (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Sep 2023 20:38:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1293312D;
        Sun, 10 Sep 2023 17:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694392700;
        bh=ANfA5L7JPBnRQNkXFKOzlsKc4BVTTyeB/dwlNRzdJsQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lcskjcVOQ5Xnw2vHYL3gDT78c4YstoHwQu7/73boSWOlKtN8S+H6V16zer5RxF6/p
         Og59DnJ/5n0mVicyL7TloY1QaSudgD1qqn2l66OAEa8S+ZUbl9xXIUumYlIQi52gUI
         hW5EjCIiPiolNOiSDKUJxnBd6yyTTnaj60daFHp7LahcFNJIYbcO+5ECMb4H3Q71Y8
         wqoU7llGgNuhnWc/v8BwNZjJo9YO6F5wKbf11bCalRezgnmWuAW14gkR5dsCCSzAj/
         WPrB9+l70+GUNPVp50NZyZV0bWdhPNDy3oLyUCR3zVYODAxkJMleJYTSHRRkmSHKVY
         RwlGl5nqZPPRw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RkSW01Xlwz4xNs;
        Mon, 11 Sep 2023 10:38:20 +1000 (AEST)
Date:   Mon, 11 Sep 2023 10:38:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: bcachefs tree for next
Message-ID: <20230911103818.30272bd6@canb.auug.org.au>
In-Reply-To: <20230910043118.6xf6jgeffj5es572@moria.home.lan>
References: <20230910043118.6xf6jgeffj5es572@moria.home.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NuXFXjSSRn17H09M1KLPAaV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/NuXFXjSSRn17H09M1KLPAaV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kent,

On Sun, 10 Sep 2023 00:31:18 -0400 Kent Overstreet <kent.overstreet@linux.d=
ev> wrote:
>
> Please include a new tree in linux-next:
>=20
> http://evilpiepirate.org/git/bcachefs.git for-next
>=20
> I don't see any merge conflicts with the linux-next master branch

I will include this from tomorrow as I don't normally add branches
during the merge window (which Linus has closed this morning (my time)).

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

--Sig_/NuXFXjSSRn17H09M1KLPAaV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT+YXoACgkQAVBC80lX
0GwYsgf/W0PSE8KZD6gytc0kFgaWk0Vjbf6MuszmDjhqa2vIM5bfZ/t9AQBvKCH/
AEWH5nzVcf2zBWfQitDGUp0wN28Ac5s4B6vnp8ijdKjx4HJCe1aUD3kRKl8ZauX+
oDlsFIJ1puyC6S9jwC63dZbuQhu1bER/jbW7bdrIYcqU50UuW/UJI02lHDjqwjnl
0hGiA2vRPTNQxfL+z2EOSnZ7JBYzMcDuBn/4M686+LNiq8BImvJBS+AchLy+9LZe
zTSKZNZzp+UtYXK4Dp1HsA9vadPd0mOXIyFE0DZxbUFU5X2w3dVccGdHa2aw4ons
ZkDI0AkNV34Je6o3SVfnytpbNjszzw==
=Ft0s
-----END PGP SIGNATURE-----

--Sig_/NuXFXjSSRn17H09M1KLPAaV--
