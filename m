Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F13E1D5EF5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 May 2020 07:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgEPFyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 May 2020 01:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725803AbgEPFyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 May 2020 01:54:03 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A70C061A0C;
        Fri, 15 May 2020 22:54:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49PDx33qpWz9sTD;
        Sat, 16 May 2020 15:53:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1589608440;
        bh=/Xv1K0V8e5x1o5N7rHUJncIKDE5SDukl2Jj+ad1XTxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HDFvJlXGRRNvzpM6wxWhGBzTVl8geEicWIbeExTC5eFN5NGn7rBit0s+Tbij65QFg
         LObZcmOuXxSuaAjLQY3ZY0o7XBDQCyRgdLgS24CtPn53Sako9ozuQwpsbEqtyQYBXR
         G5CXdnsO2B/qn9rqMXoYOKzBRsj+AHiKZZym+VXw5+YVFCVr3xXRrb8IDvkdgq5XRq
         Y8jTiIgBsNVkDA1OLnYK1JqKwWr5FuaRKfR51oyyrbk1DY4+2vi7+NbIz7oqwNI8pI
         tUaRIg40Gg/1IuAbYVPK36seNIVDFbAqFQMPBLIhWo8r3ieR+BOqr34SNB51oVG1cd
         3NkanHIL2WgIg==
Date:   Sat, 16 May 2020 15:53:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org
Subject: Re: mmotm 2020-05-15-16-29 uploaded
Message-ID: <20200516155358.3683f11e@canb.auug.org.au>
In-Reply-To: <20200515233018.ScdtkUJMA%akpm@linux-foundation.org>
References: <20200513175005.1f4839360c18c0238df292d1@linux-foundation.org>
        <20200515233018.ScdtkUJMA%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6.ECiSJ2jczuaYFAUa6=kZA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/6.ECiSJ2jczuaYFAUa6=kZA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, 15 May 2020 16:30:18 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> * mm-introduce-external-memory-hinting-api.patch

The above patch should have

#define __NR_process_madvise 443

not 442, in arch/arm64/include/asm/unistd32.h

and

 442    common  fsinfo                          sys_fsinfo
+443    common  process_madvise                 sys_process_madvise

in arch/microblaze/kernel/syscalls/syscall.tbl

> * mm-introduce-external-memory-hinting-api-fix.patch

The above patch should have

#define __NR_process_madvise 443

not 442

> * mm-support-vector-address-ranges-for-process_madvise-fix.patch

The above patch should have

#define __NR_process_madvise 443

not 442 in arch/arm64/include/asm/unistd32.h

--=20
Cheers,
Stephen Rothwell

--Sig_/6.ECiSJ2jczuaYFAUa6=kZA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6/f/YACgkQAVBC80lX
0Gx1Jwf/eRWBhmLSqpgnXUM0UQDqPab5/Kay6/R+98MSWQmlkhm/0d5z8Dw/GSDc
LcETLKrcnCbZ/TGJuICVH3AkMm/wMWS4WD0IQbcUaPfCMzhyJWj7LXG8pTuWQY9v
yl096HQroXUQvXj8OzXPuSnnFj1nmD8LitksoGkcUu+G4q3pkNwExtQP4q6OKlXF
STkz92gDLQYUozFVg5z+eAgj+P2ViQFeUNlB2DBuwN6mYszScul6jnPMJS4Sl36J
YFDTOgakQBI3xzWlWmnhHLUL6K/jF6iQfVbF3nFU14WKU2xcGJG7oT3kheQ7/Rs6
/npruo5vlN0mwIXTf8qwo1g3eDV8og==
=lUKJ
-----END PGP SIGNATURE-----

--Sig_/6.ECiSJ2jczuaYFAUa6=kZA--
