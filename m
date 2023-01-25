Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5A067BA8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 20:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbjAYTS4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 14:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjAYTSz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:18:55 -0500
X-Greylist: delayed 932 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Jan 2023 11:18:51 PST
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF637A84;
        Wed, 25 Jan 2023 11:18:51 -0800 (PST)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1pKkjm-0002iB-37;
        Wed, 25 Jan 2023 13:43:10 -0500
Message-ID: <4fe0e2eb6a3e2d7e0838f177706f1be13d61375c.camel@surriel.com>
Subject: Re: [RESEND RFC PATCH v1 00/20] mm: process/cgroup ksm support
From:   Rik van Riel <riel@surriel.com>
To:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Stefan Roesch <shr@devkernel.io>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, CGEL <cgel.zte@gmail.com>,
        Jann Horn <jannh@google.com>
Date:   Wed, 25 Jan 2023 13:43:09 -0500
In-Reply-To: <Y9EoJ0jlXMeuJzuY@dhcp22.suse.cz>
References: <20230123173748.1734238-1-shr@devkernel.io>
         <5844ee9f-1992-a62a-2141-3b694a1e1915@redhat.com>
         <qvqwbkmnj014.fsf@dev0134.prn3.facebook.com>
         <a391e98c-88af-886c-0426-c41c9980afa1@redhat.com>
         <Y9EoJ0jlXMeuJzuY@dhcp22.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-fHtooTLBHokjrlt3AOkT"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-fHtooTLBHokjrlt3AOkT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2023-01-25 at 14:01 +0100, Michal Hocko wrote:
>=20
> I have read through your cover letter and it talks about the
> interface
> but it doesn't really talk about usecases and how they are supposed
> to
> use this feature - except the prctl based flag gets inherited. So
> could
> you elaborate some more about those usecases please?

I can explain a little about the use case. There are people
who use forked (rather than threaded) servers for certain
workloads, from a garbage collected language without pointers,
which means madvise simply cannot be made available in that
language.

The people running that workload have experimented with uKSM
in the past, and seen about a 20% capacity increase from
doing that.

Because madvise is not possible in that programming language,
and the addresses of data keep moving around as things get
garbage collected, KSM sharing needs to be enabled "from the
outside" for that workload.

prctl seems like a good way to do that.

--=20
All Rights Reversed.

--=-fHtooTLBHokjrlt3AOkT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmPReD0ACgkQznnekoTE
3oOf6Qf+OZdpabz5qPJU/62BiPgM4Iz1Ih3vwmzqU4gPC6zRlgHsqxQ9unGulcc5
u9IIstoDUDaZRtbvJas1YO3wlaBgyIag+J0yR0Vflg6KWnBrYz+AKa0f8rfi4I0H
MPavada+vlPdaIM/duOza4Je/nUkKenXaknZ3ng/j17JfWTPDNbtF/0Qne0t4nnf
pM0i49ZgGNPAAqeT6FI1jf07BN+01QVjDKellwxGx5s8MjNKkEsmvpXT2ePTJQhK
YXhsdf1sP3C9ftRKOBBzp0izIjvwnSuKcauOdhckdmX69SLbVSgxUgaTVxBUa2Ur
RUUcMqJMaSgPERS3K+TdPHAaIJYY8Q==
=k7TU
-----END PGP SIGNATURE-----

--=-fHtooTLBHokjrlt3AOkT--
