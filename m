Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4AB4AE787
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 04:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245267AbiBIDDX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Feb 2022 22:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344407AbiBICxm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:53:42 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E4CC0613CC;
        Tue,  8 Feb 2022 18:53:41 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JtkwH2kS8z4xcp;
        Wed,  9 Feb 2022 13:53:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644375217;
        bh=IhVwFVJZTPguna2PmdUzRBNG0sppu5V6lowxE+6pGgI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KW4UqPzoR5ny9Kp9n31arzSuUqPsZM/i/VB8F2eZjzctKcKxPz+aN2TnCPaJTXzJk
         NO7/1roj73VCajqiXXETQLweurcaM9yh3g3x/MrsoWbYduqRpnGXygqsuoRDlqlcco
         d3GIz/3qv1+rdm8OQFtGiwV5pUie7WxQCRZSWW/1H6D5zO7EPS1He+cZMkjHdz3UAS
         8m5M3u7NOiT8G8HkBu3TgbwDIl3C6ADS7zPGOkkAWDDyRaoT1Y6qXXuxENdoQ1QK0R
         Wrm8MYrzN41CRCJykKR+WNPd0h8EgVxWX5eJbbULRW4fnPejXVqzLr7299dkypYgGf
         Y08OGre6UNnbg==
Date:   Wed, 9 Feb 2022 13:53:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Colin Cross <ccross@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/proc: task_mmu.c: Fix the error-unused variable
 'migration'
Message-ID: <20220209135333.7975a407@canb.auug.org.au>
In-Reply-To: <20220209023602.21929-1-cai.huoqing@linux.dev>
References: <20220209023602.21929-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ct2dtmhrD2S_HM39xGlFpg/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/ct2dtmhrD2S_HM39xGlFpg/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Cai,

On Wed,  9 Feb 2022 10:35:59 +0800 Cai Huoqing <cai.huoqing@linux.dev> wrot=
e:
>
> Avoid the error-unused variable 'migration' when
> CONFIG_TRANSPARENT_HUGEPAGE and CONFIG_ARCH_ENABLE_THP_MIGRATION
> are not enabled.
>=20
> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> ---
>  fs/proc/task_mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index bc2f46033231..b055ff29204d 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1441,7 +1441,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned =
long addr, unsigned long end,
>  	spinlock_t *ptl;
>  	pte_t *pte, *orig_pte;
>  	int err =3D 0;
> -	bool migration =3D false;
> +	bool migration __maybe_unused =3D false;
> =20
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	ptl =3D pmd_trans_huge_lock(pmdp, vma);
> --=20
> 2.25.1
>=20

This has already been fixed in Andrew's patch set by moving the "#ifdef
CONFIG_TRANSPARENT_HUGEPAGE" above the "migration" declaration.

--=20
Cheers,
Stephen Rothwell

--Sig_/ct2dtmhrD2S_HM39xGlFpg/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIDLK0ACgkQAVBC80lX
0Gzc1Qf+KFKl4xD6pf9RgHcnKZv9WZMpWCxraz+jBHwPdu6UeGwT+kKOoF3xQECD
j75xvG8h5nYScNPmNH5k6rY0h8eCMqGvydOp4sy6geBhSwrNG6PqnjYLFg1aeIuG
rQ2Y11Bss4R307M8TVs6ESYzYEMVpLjfy6lI58j78eYZ8gfIrWabm+bNYLjfaJIx
FO3wrQnUaBkewfWzt0u+0HrEYlX6X0cjryxV9V3B0KOT16N9kAbv7mOsiBqh+SyC
Mi+fDLw4bz3xqwE+Y75KBKG6UPdPCiFNM4MW7Tsjc8vXwSGqZcSRF9eEzORWE+wY
xZMJU4HlYP101pXZOKHnxpamk561xg==
=XpWC
-----END PGP SIGNATURE-----

--Sig_/ct2dtmhrD2S_HM39xGlFpg/--
