Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F422FAF31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 04:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbhASDox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 22:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbhASDor (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 22:44:47 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC0FC061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 19:44:07 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id m6so11418288pfm.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 19:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=/q04Qijbrtl7abjswNGUBJoouDR9KZ4AGaHH4rlP2KY=;
        b=r5bPJWvRlFSKgksrAIbNf93/4kv/hO8kdTSG8UHzD2y8CtPRHkub6TAIv5DUTIjEeL
         6Wly1efHI5tItuz3le41iA0Hi1hJ5QK7BUQ6uTp/E25J26ikBqncTDAteD9Lh/slyiNZ
         bWpbJTVQiQ55rgJZm7mTBeEOPfbQB5RLa1lt1q7Gh1HzruL8im1M1Y077BHS50aS1GHm
         lpHRm/icNGRh/VCuq4MLVyfuW0UBuwxa1Nb9LGMTJTtRB5LAXHbxymXm81T0sFCdSBk8
         pFgN7HoEdpYNFxK/yA817w9NUcsi2gg+MY80fmN/4kdMwpBkpn9bnN435IrwCl2oiqbN
         3pUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=/q04Qijbrtl7abjswNGUBJoouDR9KZ4AGaHH4rlP2KY=;
        b=eMb9Yn2cnbCdIQeIN3iemjoJ03jWiF9K+VUGZintLQAhaGLlmuqq1KksoP/7UzfkRt
         DBbKG9/SieykgKKlo9epdiDejY8tthVgfZRN9qoGh2IDa6gh8GKOTx9WPABwzHBy02Gd
         9JfM73F/lmvyLlLfNLPhuQrGYFIp3q6E/QS98PyHdR/LaXlnqFOGfKV5SwAXIplgx8xa
         exkVjLZePRUawcr+hk2m4RIG9clnVQ1kXaE9PsJgA6KNvf0XIUfgOBLfsDFsltwYpeFz
         EfHxazAPkJfTRWqXczw1NNVid0xY+boSh1IkgSoGkwNbyASNEgpIINC5YxKLGuQ7pzIj
         +6Iw==
X-Gm-Message-State: AOAM531dRrnoCumgu9hAFnpGIqM9q1ZP7YNE1YZNqnt3wPHTs8CZZrtn
        MrfbV4X+SRB4BVPtmksnVx7jbA==
X-Google-Smtp-Source: ABdhPJxsLd7xSWR3cUMbggUmXRw0HDCJ8gzKN5LVt3Rrnv3wsTZ+Fe+eALrsKl74cOEWjp4xgNVZsw==
X-Received: by 2002:a63:1c13:: with SMTP id c19mr2563638pgc.359.1611027846835;
        Mon, 18 Jan 2021 19:44:06 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id f29sm16822840pgm.76.2021.01.18.19.44.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 19:44:05 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <6D9D9B4D-65E5-4993-AC08-080B677BA78E@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_CF7582DE-2906-4EF2-9ED9-35596B0D02B6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: fallocate(FALLOC_FL_ZERO_RANGE_BUT_REALLY) to avoid unwritten
 extents?
Date:   Mon, 18 Jan 2021 20:44:04 -0700
In-Reply-To: <6d982635-d978-e044-4cca-c140401eb0d3@scylladb.com>
Cc:     Andres Freund <andres@anarazel.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
To:     Avi Kivity <avi@scylladb.com>
References: <20201230062819.yinrrp6uwfegsqo3@alap3.anarazel.de>
 <20210104181958.GE6908@magnolia>
 <20210104191058.sryksqjnjjnn5raa@alap3.anarazel.de>
 <f6f75f11-5d5b-ae63-d584-4b6f09ff401e@scylladb.com>
 <20210112181600.GA1228497@infradead.org>
 <C8811877-48A9-4199-9F28-20F5B071AE36@dilger.ca>
 <20210112184339.GA1238746@infradead.org>
 <1C33DEE4-8BE9-4BF3-A589-E11532382B36@dilger.ca>
 <20210112211445.GC1164248@magnolia>
 <20210112213633.fb4tjlgvo6tznfr4@alap3.anarazel.de>
 <6d982635-d978-e044-4cca-c140401eb0d3@scylladb.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_CF7582DE-2906-4EF2-9ED9-35596B0D02B6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 13, 2021, at 12:44 AM, Avi Kivity <avi@scylladb.com> wrote:
>=20
> On 1/12/21 11:36 PM, Andres Freund wrote:
>> Hi,
>>=20
>> On 2021-01-12 13:14:45 -0800, Darrick J. Wong wrote:
>>> ALLOCSP64 can only allocate pre-zeroed blocks as part of extending =
EOF,
>>> whereas a new FZERO flag means that we can pre-zero an arbitrary =
range
>>> of bytes in a file.  I don't know if Avi or Andres' usecases demand =
that
>>> kind of flexibilty but I know I'd rather go for the more powerful
>>> interface.
>> Postgres/I don't at the moment have a need to allocate "written" =
zeroed
>> space anywhere but EOF. I can see some potential uses for more =
flexible
>> pre-zeroing in the future though, but not very near term.
>>=20
>=20
> I also agree that it's better not to have the kernel fall back =
internally on writing zeros, letting userspace do that. The assumption =
is that WRITE SAME will be O(1)-ish and so can bypass scheduling =
decisions, but if we need to write zeros, better let the application =
throttle the rate.

Writing zeroes from userspace has a *lot* more overhead when there is a =
network
filesystem involved.  It would be better to generate the zeroes on the =
server,
or directly in the disk than sending GB of zeroes over the network.


Cheers, Andreas






--Apple-Mail=_CF7582DE-2906-4EF2-9ED9-35596B0D02B6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmAGVYQACgkQcqXauRfM
H+DLKQ/9GRaFCst/9Bjwd/poEF5jxdM6qxtvLh1IreNdo5xYT9CWaWcV9RGSCTud
TPy82XDn/ml2FBV2XLsxyOXv5bjG89/Y1EWQpbsrF3p+mxak2+Qw/0PqL1sJSi7H
kb7hVGrB16n6mLKUZpnHSMiXBl/1K8Mq3YWPY43svLd7l2zCpC6TpgzCYfxpdgid
c7T9wifVH4gPz8A/PQ26MAL9oABbozDOak3ZdOJQrMWnlfqG18MtGArwAbxWG2c2
feMxx8givW6DXtxgk9OMyZYAwYrb6hGc4hK3f7r1SO6zaaCfpvUt7pupGjT15vTn
ZtxHQDgb4bgb/DI5NFPxB0+0a9+oO1nW/oU6Fhccl6bwVpdtFUrCJOa1D0pRuVlU
zdr4jVOCrsGmXDtPvJtWFrLuPgj8SVwuBvuPWaxWSTgZ/ADewV4lp0NhZymmmvVL
FzNE1ta9Z9QO3oC+FH679/xuIAReBKmQudS9dfLgVrEhhevuRqfVWnL9fP1svK+U
85tBBYgOZDe4V5rA/c+nIhGmG37cE5y1Ei5ngaDf/jiL+V728W561dT7DYU0+CjE
T3LLNhYGj991vpFZBs3jn+/87gtdilP+me2OjpFug8jyL7wFbOquhXIgdE3WLUlr
wIq3T3GDX7afC3jEN8JXEoV0oZidbBUsUdCoDfLWpJ+zQdjXfY8=
=imFu
-----END PGP SIGNATURE-----

--Apple-Mail=_CF7582DE-2906-4EF2-9ED9-35596B0D02B6--
