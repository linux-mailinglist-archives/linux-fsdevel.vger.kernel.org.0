Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A27D6B7D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 10:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfGQIE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 04:04:29 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49131 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfGQIE3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:04:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45pVCt0PSTz9s3Z;
        Wed, 17 Jul 2019 18:04:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563350666;
        bh=a/uLJPoZ87Fx3PgnBNv0eSPgO1nYx3akKRZuuGtEZ4w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dy2fEZZcIJo2wBbj48S2iAkFUtNWMBRzr2Qk5c31yIes15jKezc0d19Yn2/nRunzV
         T1+S0H7OR7aHrKKKfbAOEZM2j9tzSMuDCIAzKPvxAZKfzsiMCFMHk4HObiMN90K8N+
         S8Uu9ixLhg6VfIcwPaPs9hID7D1mng/bMyfjmUF50Q/4MF5SRul/Ql70xwsXlxrMUN
         pXuNzIErv4teLLvuAL79D7vCZf08q837HJVZ56KudCeDZWAl9UxX4SGlMni0xO391k
         NX51YN+3PNwSo2vBOl3v7z/Ti6wP/C7Std+ngJLmUAHSm68Lr+BQtueMxk9Xcqc9JM
         PbRWBpf7N/1dg==
Date:   Wed, 17 Jul 2019 18:04:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject: Re: mmotm 2019-07-16-17-14 uploaded
Message-ID: <20190717180424.320fecea@canb.auug.org.au>
In-Reply-To: <072ca048-493c-a079-f931-17517663bc09@infradead.org>
References: <20190717001534.83sL1%akpm@linux-foundation.org>
        <8165e113-6da1-c4c0-69eb-37b2d63ceed9@infradead.org>
        <20190717143830.7f7c3097@canb.auug.org.au>
        <a9d0f937-ef61-1d25-f539-96a20b7f8037@infradead.org>
        <072ca048-493c-a079-f931-17517663bc09@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0xDDOA42emBhMWNDZGG8_SB"; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/0xDDOA42emBhMWNDZGG8_SB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Tue, 16 Jul 2019 23:21:48 -0700 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> drivers/dma-buf/dma-buf.c:
> <<<<<<< HEAD
> =3D=3D=3D=3D=3D=3D=3D
> #include <linux/pseudo_fs.h>
> >>>>>>> linux-next/akpm-base =20

I can't imagine what went wrong, but you can stop now :-)

$ grep '<<< HEAD' linux-next.patch | wc -l
1473

I must try to find the emails where Andrew and I discussed the
methodology used to produce the linux-next.patch from a previous
linux-next tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/0xDDOA42emBhMWNDZGG8_SB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0u1ogACgkQAVBC80lX
0GxzaggAoE9HdBJS5ZBRVSngMC4N2eSP3jr4MoEmIdRyK55EvCn9XYaNbFiKAQ5D
Tj17ooVhZnrDecRYnpn/weZ1Q2y7s4mzOAhwdsOeFdNuuMk9R5u1igEo/7vgW0Wm
4ea+V5cvGhW6ZDIx14oz/pa/YpY2DXf4SC8wxMJZwTccK44jtc5gYsA2QK1vBI5O
tQwdkr+jRUswKGosxoKxsXEX27PZXThwrxyjdrEDlyb+Y9Ef6MxNTiEOo/qkYMQM
M2hPMNpQ14lIt7jiTQpmlSaWIqPFN2AnyEkLNuEFDVAIaw6tUcK1mApYTsSWbh3o
LeNHaYdOMs6PRoyrsie0Kl1GSM52cQ==
=PNdR
-----END PGP SIGNATURE-----

--Sig_/0xDDOA42emBhMWNDZGG8_SB--
