Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206D6252925
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 10:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgHZIYZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 04:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgHZIYX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:24:23 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DB7C061574;
        Wed, 26 Aug 2020 01:24:19 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4BbzRN02wmzQlKH;
        Wed, 26 Aug 2020 10:24:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id V2qe8rw4qZV0; Wed, 26 Aug 2020 10:24:12 +0200 (CEST)
Date:   Wed, 26 Aug 2020 18:24:01 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     Will Deacon <will@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Boqun Feng <boqun.feng@gmail.com>,
        Yuqi Jin <jinyuqi@huawei.com>
Subject: Re: [PATCH RESEND] fs: Move @f_count to different cacheline with
 @f_mode
Message-ID: <20200826082401.c6j5fwrbhl7vgmhj@yavin.dot.cyphar.com>
References: <1592987548-8653-1-git-send-email-zhangshaokun@hisilicon.com>
 <20200821160252.GC21517@willie-the-truck>
 <a75e514c-7e2d-54ed-45d4-327b2a514e67@hisilicon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kbfyuz6nl7vvspl3"
Content-Disposition: inline
In-Reply-To: <a75e514c-7e2d-54ed-45d4-327b2a514e67@hisilicon.com>
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.72 / 15.00 / 15.00
X-Rspamd-Queue-Id: 8C01A5FE
X-Rspamd-UID: 64bef2
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--kbfyuz6nl7vvspl3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-26, Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:
> =E5=9C=A8 2020/8/22 0:02, Will Deacon =E5=86=99=E9=81=93:
> >   - This thing is tagged with __randomize_layout, so it doesn't help an=
ybody
> >     using that crazy plugin
>=20
> This patch isolated the @f_count with @f_mode absolutely and we don't car=
e the
> base address of the structure, or I may miss something what you said.

__randomize_layout randomises the order of fields in a structure on each
kernel rebuild (to make attacks against sensitive kernel structures
theoretically harder because the offset of a field is per-build). It is
separate to ASLR or other base-related randomisation. However it depends
on having CONFIG_GCC_PLUGIN_RANDSTRUCT=3Dy and I believe (at least for
distribution kernels) this isn't a widely-used configuration.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--kbfyuz6nl7vvspl3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCX0YcHgAKCRCdlLljIbnQ
EtTmAP0f9PQv9kGhoVe77BZM2Ob0AmjDyWJYpBkweQblDV8lWQD/VaLp9ZsNI3MB
n+B7BruquMTrgoeUTCv70+QkPxpZAAM=
=glhN
-----END PGP SIGNATURE-----

--kbfyuz6nl7vvspl3--
