Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0149C468871
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Dec 2021 00:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhLEACf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Dec 2021 19:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbhLEAB3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Dec 2021 19:01:29 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C58C061751;
        Sat,  4 Dec 2021 15:58:03 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J668324Fvz4xcM;
        Sun,  5 Dec 2021 10:57:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638662278;
        bh=X6WeDTc3Ct7VorixcarZ9kQ33I1FYmvGgfpE7zVoA08=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HnyHbw5BeEkgtcO7l6Qafg4tAljBiy22VbAXarT8OttC6jzqaBGH69eypCd5x8xZa
         wAP9+hJlnTrBeGmj+WWT0eNNAkbz1T8yzwbVTQVfBl3Gwqn7MTd4XEWB1NZMwjR67G
         rXzLJ60ghBL347HMiQA46at7rUjwkyYhvANjVBaWHw/feQoYxfbq+8FbciXeIcVFo6
         iBr06u1ij4sjkEzhzoDfUmrhAbZPpzRGpsLZf4UCtK+DmLCGncADC6+6XMxN/fYqVo
         m8Xbbzr7NBAokGz5XeAcTtvRxyMNslgmy3Z7F72YHmpqJbqz2BLYZZli7w0yQnCzjD
         FChQtJcPGtzqg==
Date:   Sun, 5 Dec 2021 10:57:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Peter Xu <peterx@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Colin Cross <ccross@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: split out anon_vma declarations to separate header
Message-ID: <20211205105752.2098963d@canb.auug.org.au>
In-Reply-To: <20211204174417.1025328-1-arnd@kernel.org>
References: <20211204174417.1025328-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZBpG8PmE8HzHV.TPtvI/DCm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/ZBpG8PmE8HzHV.TPtvI/DCm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Sat,  4 Dec 2021 18:42:17 +0100 Arnd Bergmann <arnd@kernel.org> wrote:
>

> diff --git a/include/linux/anon_vma.h b/include/linux/anon_vma.h
> new file mode 100644
> index 000000000000..5ce8b5be31ae
> --- /dev/null
> +++ b/include/linux/anon_vma.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_ANON_VMA_H
> +#define _LINUX_ANON_VMA_H
> +
> +#include <linux/mm_types.h>
> +

Shouldn't this also include string.h to fix the original problem?

--=20
Cheers,
Stephen Rothwell

--Sig_/ZBpG8PmE8HzHV.TPtvI/DCm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGsAIAACgkQAVBC80lX
0GzBTwf+Lt5PsU8PxWqIob4oCOkUuS3cZ/Zs8ANWuzjQRH6yfYjzA1lhq73cSFSg
ONb7Xb1f2f9/ew45Dcv8hjLi4b6MNtcAqyJN0gE8gq2otc+mw4YkoG/ZsE6FE5UK
+nWx6ZD0Nea2J+Wq9GMrdB24jCC69MOfpgRHySxaisxHjGT/Q9Kl9IkR1+KWw2o/
z1TIDJy79hP7DgGcEzWH1mOFj0Acn3jYVtv0JYB7ZBS4jReBGDIKt/+j8+DlW8MK
tpzqDZcIvJ6nZgsMxsz4XuHn6EIBy8GypheXHy2R2nsDydU0m3gN3cUk95W1U7bU
lAqlhPv73T8wiYGxArG55RJtH2v/9g==
=Ebnu
-----END PGP SIGNATURE-----

--Sig_/ZBpG8PmE8HzHV.TPtvI/DCm--
