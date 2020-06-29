Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEF420E103
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 23:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389693AbgF2Uvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 16:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731388AbgF2TN1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:27 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D295AC014A45;
        Mon, 29 Jun 2020 01:10:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49wKsz3Ldfz9sQt;
        Mon, 29 Jun 2020 18:10:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1593418216;
        bh=crWSNNu528LAfdEMbW7KUH2pWweNYViIJO8WxsWa4Tg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gtPgUF8F34Ded9aBpbOEfWwctqu5d+tOBBKJlXtDhz8JMTTPXSq+uEvPSdBn7KKUT
         bmaQ6MtpVIKTRe66ARLKx1zUgwYpHkjC3OrYo+TxOLHDHhObDYeYO0T8QkQBgODIAu
         oh2VqKR6ex1ZL8Fb90YQuxmvhSoqQj40bqtgdTNyP4eF1JczGAEdXaZY9vPcRYAyXH
         x2ZQfocM5NtmJRCpYY359kDoWbibNM8lroymr0q3d/xhnTa17iomgdmPR0hXZ3tovF
         UWrw6WJlmfVs9rzf+KldX6fLpa8lWJ02r1ZKsxNsdn0Oo+OcCYeb+ogRNl7jyE1bsO
         qFJkl3sfKPHQQ==
Date:   Mon, 29 Jun 2020 18:10:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, Randy Dunlap <rdunlap@infradead.org>,
        broonie@kernel.org, mhocko@suse.cz, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Subject: Re: [PATCH] slab: Fix misplaced __free_one()
Message-ID: <20200629181014.02f2022d@canb.auug.org.au>
In-Reply-To: <202006261306.0D82A2B@keescook>
References: <202006261306.0D82A2B@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Dyu5QPdDe/MilO+Q7TeeL45";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/Dyu5QPdDe/MilO+Q7TeeL45
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Fri, 26 Jun 2020 13:07:53 -0700 Kees Cook <keescook@chromium.org> wrote:
>
> The implementation of __free_one() was accidentally placed inside a
> CONFIG_NUMA #ifdef. Move it above.
>=20
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/lkml/7ff248c7-d447-340c-a8e2-8c02972aca70@i=
nfradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

I added that to linux-next for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Dyu5QPdDe/MilO+Q7TeeL45
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl75oeYACgkQAVBC80lX
0Gw23Af9G6llJx86wM9f653I6RddIKgNYCd1+ZQBm0e3vsDC982acrw12+AxRXyy
Yk4Gv8seQChMrSjgw9AXifoxKsoYrHncHeM1QerK8B9xtvvWxlMrCYwca9jVdhqQ
d6CHpFvQWxLRjJRFkTgFHQJVrt8GUrsbDuIJ477V3ipJ/91jG18Z/tbF1zidhU7d
KOXO0J/BsASSac4czoLQnSj/jC9+K+cADlIL5dvfwNn6iVRwSYRpJmGSv/ZyHoGO
O5jpNs0c5AVaHXtq4FzwkDvY9KsTMxnWEGx+wUypYxuszAx+U9rm6wytDvbcPsFS
A1nE5D5dEnbiZbH6jLRoyeTJep6bIw==
=1SDg
-----END PGP SIGNATURE-----

--Sig_/Dyu5QPdDe/MilO+Q7TeeL45--
