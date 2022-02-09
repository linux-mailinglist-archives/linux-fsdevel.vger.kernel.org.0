Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37B34B0132
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 00:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiBIX1P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 18:27:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiBIX1O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:27:14 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3DFE06C41A;
        Wed,  9 Feb 2022 15:27:10 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JvGGm6Mm6z4xcq;
        Thu, 10 Feb 2022 10:26:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644449186;
        bh=B3OOE+3clEH8ZbTR1cvV2XvU/8PhpUu3S16wIF9m4Ho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WtApO4zjM6W9Rmha9gS+coobGCR2F02AHJwCzOH1SNwPdLUS84TvTJ1Cn1lp3GzbE
         2y8mPQ3H05DpaSRV8T5QYsCYJ45Y5LNyW3gy+VhhnIBv89n1YMv1AjfchgirE4zKKX
         Fi8skESVaNyGcD7FjHnj1kr09AnLoLkt2tyoD6QoODc8qs6x/FshuwYu74TejwsOaD
         z/aE56tnCJ+Ys8uDW0IMF0Ff0EZPXLVBQHsGx3QXM6Y1DunqCkKO9FOkb7cxw4tvux
         sRjIjd5M2cQQYv7V95lRAFQlthQbfrPV4IewI5fjDPyokZ6jxCltYjHDEQ0FHL+knz
         g6vw7L0aKUrzQ==
Date:   Thu, 10 Feb 2022 10:26:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     akpm@linux-foundation.org, Petr Mladek <pmladek@suse.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, feng.tang@intel.com,
        siglesias@igalia.com, kernel@gpiccoli.net
Subject: Re: [PATCH 3/3] panic: Allow printing extra panic information on
 kdump
Message-ID: <20220210102621.250d6741@canb.auug.org.au>
In-Reply-To: <c4f0c53e-cfe4-b693-6af2-df827bc94fa8@igalia.com>
References: <20211109202848.610874-1-gpiccoli@igalia.com>
        <20211109202848.610874-4-gpiccoli@igalia.com>
        <Yd/qmyz+qSuoUwbs@alley>
        <7c516696-be5b-c280-7f4e-554834f5e472@igalia.com>
        <c10fc4fc-58c9-0b3f-5f1e-6f44b0c190d2@igalia.com>
        <20220209083951.50060e15@canb.auug.org.au>
        <c4f0c53e-cfe4-b693-6af2-df827bc94fa8@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/g0P093p_nq_KNn68dYnAKHn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/g0P093p_nq_KNn68dYnAKHn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guilherme,

On Wed, 9 Feb 2022 12:06:03 -0300 "Guilherme G. Piccoli" <gpiccoli@igalia.c=
om> wrote:
>
> On 08/02/2022 18:39, Stephen Rothwell wrote:
> > Hi Guilherme,
> > [...]=20
> > Dropped from linux-next today.
> >  =20
>=20
> Hi Stephen, thanks! I'm still seeing this patch over there, though - I'm
> not sure if takes a while to show up in the tree...

Andrew did another mmotm release which put it back in.  I have removed
it again for today.

> Notice this request is only for patch 3/3 in this series - patches 1 and
> 2 are fine, were reviewed and accepted =3D)

Understood.

--=20
Cheers,
Stephen Rothwell

--Sig_/g0P093p_nq_KNn68dYnAKHn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIETZ0ACgkQAVBC80lX
0GwR2Af/ULU1MyVDLgxV13ILryhuxlTd7bfH6hvQNAjleryvZvq8KFQVaMmv4SeF
GXIOX0LlCJ82SC5mDCJfJ0GXr9efTZjOlJxyUJeWxMAAPNtYliB7qhHKXPWy+tAu
Hp+H9OfDV8bGvGm5V9Nim0pN7jTG5JS64OKvgikGMG6M6snZ74QUSNtCIB66QMv4
UVN31B2D8CKU4paPhU7Kez0TTN4wLmnGJDq014gg9B4Y08jMh1xvix8w7r3MhguI
txFlYuTxn15vYTZt9k+WFisNKFKj5H240q2bXjdxliE3smc4KNHw0+Jk9+nvnLj5
SKP/axBSRkxDCEuhcMFhNcUR1483zA==
=maXw
-----END PGP SIGNATURE-----

--Sig_/g0P093p_nq_KNn68dYnAKHn--
