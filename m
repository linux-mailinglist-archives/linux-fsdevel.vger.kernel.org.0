Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C40E4AE410
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Feb 2022 23:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386904AbiBHW0n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Feb 2022 17:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386996AbiBHVkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:40:06 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4342C0612B8;
        Tue,  8 Feb 2022 13:40:02 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JtbyK0wyjz4xRB;
        Wed,  9 Feb 2022 08:39:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644356394;
        bh=L/2+KL4slFn3h7XVyVPi1fXM5yrDz6XKaSCyv0AgyZs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Eajr3NvbTXK/cKVGfyuxkYYJFHTFCYgjkI7nEWK40dvicG45ks1JGpYzuEpLRL8ez
         t6TpK6psBF13mLa7qFF0046YRjG6LirdYy0cgM/dVB3emYlA9OCfMbNxKJaJFN1K9F
         h/0vS2Ma/0AFDmaLUYjXt5mrSAWfindlztAK1hg8LGUIeOtl+G5pnDfFKBuop/HQE3
         EAjbMdZF2ERAOXtNR1u+xXOGqEdTUu/m07Qk92AGoQ1s2B9h+4ONGIQtQ2OItyx/Yk
         I5lkvm5gr9LDoURuSxnIeK22wQo6RkKYsEpU0UdaBQxj/BWYBiq2Vczt/zOJk+EbzH
         qeV7zLc9vuQwQ==
Date:   Wed, 9 Feb 2022 08:39:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, feng.tang@intel.com,
        siglesias@igalia.com, kernel@gpiccoli.net
Subject: Re: [PATCH 3/3] panic: Allow printing extra panic information on
 kdump
Message-ID: <20220209083951.50060e15@canb.auug.org.au>
In-Reply-To: <c10fc4fc-58c9-0b3f-5f1e-6f44b0c190d2@igalia.com>
References: <20211109202848.610874-1-gpiccoli@igalia.com>
        <20211109202848.610874-4-gpiccoli@igalia.com>
        <Yd/qmyz+qSuoUwbs@alley>
        <7c516696-be5b-c280-7f4e-554834f5e472@igalia.com>
        <c10fc4fc-58c9-0b3f-5f1e-6f44b0c190d2@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2S9iO=1tekDTW=LNkTUhFnG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/2S9iO=1tekDTW=LNkTUhFnG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guilherme,

On Tue, 8 Feb 2022 15:12:04 -0300 "Guilherme G. Piccoli" <gpiccoli@igalia.c=
om> wrote:
>
> Hi Stephen / Andrew, sorry for the annoyance, but can you please remove
> this patch from linux-next?
>=20
> Today it shows as commit
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/?id=3Dd691651735f1
> - this commit is subject to concern from Baoquan and we are discussing
> better ways to achieve that, through a refactor.

Dropped from linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/2S9iO=1tekDTW=LNkTUhFnG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIC4ycACgkQAVBC80lX
0GwSwwf+JE8SL1N+w657zkhaYBJCgiGKyRLRRH9OgbfbD6Ao0SLlcgn7+SNgnxwl
V1G8cTt6iD/635fZdXM0XfoVs9i178O6YtnqmaWuld0WhQKvC7wL1Fe/1cFvwcj9
t5KKDrbICID+xjQDDU+tgudZoRxWotbSKE1uQiInEohM3bikoVgBzgdN5eDIpq3e
KZb5hY3ZY8YgsyJjoz77BZyPWAzb1A3SMXb5LVYSA/s3tV4l0dXM6paKwQR1s+mG
u8PPxGvIzOECffU220pjBbvcyMEQfRG1KET6iE+sdoLViIfd4WH8ldyRr2Mk5EWN
QEMVQV5rgtFOGli9lmsqK76Wu60VWA==
=y3Ph
-----END PGP SIGNATURE-----

--Sig_/2S9iO=1tekDTW=LNkTUhFnG--
