Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6A7231577
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 00:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbgG1WU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 18:20:57 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55419 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729491AbgG1WU5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:20:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BGWN61YVXz9sRW;
        Wed, 29 Jul 2020 08:20:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1595974855;
        bh=ZVLGAg/BfNIQdaEOdEl4wWM/s0iM0lz1SCngCBK6O70=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lVzc1QF1xnSZWt2r1pjb0L7yu540u93SYMBxJGu5/LREONtpMoRZJJpwVYZC8PGsl
         8sg/DMxp3YNR9e3Tkt+00CXp3SwZm5abA3swvQ+2kA+QTtaps2lFE+WwbDmkVgMnbz
         loDk/v8/pEqKHWIknMAloWe9fXIm2LFbZbw+p8qgYKyJTlGArEsj5JOzq0Y0BnFSW9
         DdqeArEd991ZkCEzigf3tmQh2CKUBsQTTVK4LrxP03+RYMX/lr6ql2kBwlgpBMc0JX
         cPe0492rb8mO0Xad20AiDjy9UWIezdHFvtxcgyN84glQ0NtVJ9QyImYjD021f5SYHS
         mUKHqPzZTpgYQ==
Date:   Wed, 29 Jul 2020 08:20:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org
Subject: Re: mmotm 2020-07-27-18-18 uploaded (mm/page_alloc.c)
Message-ID: <20200729082053.6c2fb654@canb.auug.org.au>
In-Reply-To: <20200728145553.2a69fa2080de01922b3a74e0@linux-foundation.org>
References: <20200728011914.S-8vAYUK0%akpm@linux-foundation.org>
        <ae87385b-f830-dbdf-ebc7-1afb82a7fed0@infradead.org>
        <20200728145553.2a69fa2080de01922b3a74e0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rT8WB0UAOgwnA+IPIfD1zSv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/rT8WB0UAOgwnA+IPIfD1zSv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, 28 Jul 2020 14:55:53 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
> config CONTIG_ALLOC
>         def_bool (MEMORY_ISOLATION && COMPACTION) || CMA
>=20
> says this is an improper combination.  And `make oldconfig' fixes it up.
>=20
> What's happening here?

CONFIG_VIRTIO_MEM selects CONFIG_CONTIG_ALLOC ...

--=20
Cheers,
Stephen Rothwell

--Sig_/rT8WB0UAOgwnA+IPIfD1zSv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8gpMUACgkQAVBC80lX
0GwNKQf/QX7KlFtaGxTQ0s5RqFpgwyRGQnYGg5hoPCMo4nb2H3LgAFkUHxcFBZba
pNPoRwFf4/rfAECAjQ63okrk1C8A6W/cf8et+TkZ2Kk9mXjC6iQue8OCeX1DY55o
8kf68mr/1NbWhnDSgQrGUZLbatUNfMPWpXCBlusib0gIfExxPqw8vi4qlMg5weRN
ewL0RRK8ob0RxDxRSxNzdlajmrgKSkliGHI+5GLG14ESrAxriI3riJQS/q+3BGQ9
jFa41W4+wuBuhb0EOj1f83W8KrNR2ntDmzGQOOq2xqOYDQg+5ifgybDH+vDfOKEk
hUHhXVYc9rNRoTmO2lWQ4bAd2qzReg==
=lqYF
-----END PGP SIGNATURE-----

--Sig_/rT8WB0UAOgwnA+IPIfD1zSv--
