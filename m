Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4C72C4D92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 04:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbgKZDAL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 22:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729715AbgKZDAK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 22:00:10 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C987C0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 19:00:09 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id k11so493744pgq.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 19:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=CLUvaNFj/PurXHTr5z9vmApyltiJfzFSkjwCQHk27Nk=;
        b=WHW8I2y0MPHzhrMDKHi79uizkexoDaIscCw1GWtxg7GTjVco8QFv3EJtcnKsebd3Vz
         EKfUZgtAH8UOGHk8/86XYCYQLqpF0+3NcJca/LK9g/1bYfgFbXaamLdpaBNMBL4Rht0j
         E05riYul8IlXDN3iEuYXFiKfXqr6g/S5PSgsRImYuqcJXnsq/YfYinh+6iZCACjGkPXz
         ms/gwQDPmF6pmWFboQQob42miT54K+sHWF9lWleReUxQ8rXgv2siOV3G/gPJPOk0QBbB
         46Yez1jGTTVE3PydB9kZt0z5wqwVtTYHgf+o3QW70X9bJYqLY3n7MFzWo8Ynn8Qd1ZjV
         keCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=CLUvaNFj/PurXHTr5z9vmApyltiJfzFSkjwCQHk27Nk=;
        b=OFAuzu6sC/fT/NUKLDNlwrvGpWiUvlppjMKSnnINPkCH6uAB4W9dgZWFfSFeAdMy8J
         u3KJc2kG75G9Y6VMncQ5XW1pw8LROG6SxKqXvx27qcTtal5KgNPgNed0T36h3ZXNCHq6
         Cae6/RuO9iWQ9iH+vEroJwwsAmFzC47oV5PO9lqIMCQ1Z1zl75/KSOMgrnxSc/cns33Q
         Z+MDMKUipyiVEfRcUJef1tkk4zsVqzPoybAyqWycZ/VVQ2xd1RjCRBvsxyowXElpd581
         7P0e5yU2EJwlcUMbkDVPELBmhcS0KwXlpb2xKYPiNIL8D6M1goZxTHUP4m6MwJQJb79p
         FGew==
X-Gm-Message-State: AOAM531c5/scMJD3pw9ovKj7/ptqQEbpx4owh+iN8AcGdcfezRXkkT5A
        8j01CTt+DejywEbcaDJqqv/koQ==
X-Google-Smtp-Source: ABdhPJybuFh0mFrl+Q6q7Hcb+Lq2vTCBVYmwBarsqkSwBM8BiikLz5hnIx8RR8kJy571/RZADrLhoQ==
X-Received: by 2002:a17:90a:6588:: with SMTP id k8mr1056676pjj.197.1606359608591;
        Wed, 25 Nov 2020 19:00:08 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id s145sm3105674pfs.187.2020.11.25.19.00.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Nov 2020 19:00:07 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <13D075AD-D08F-44DA-B01C-9CDF239D4358@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5232A0BF-221A-45DB-A681-BE4E94ED05F0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: UAPI value collision: STATX_ATTR_MOUNT_ROOT vs STATX_ATTR_DAX
Date:   Wed, 25 Nov 2020 20:00:02 -0700
In-Reply-To: <CAJfpegvc5FjU-X1DxNtPjJLgEp_gT228kqk2Va31nk7GjZbPBQ@mail.gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Sandeen <sandeen@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        linux-kernel@vger.kernel.org
To:     Miklos Szeredi <miklos@szeredi.hu>
References: <1927370.1606323014@warthog.procyon.org.uk>
 <CAJfpegvc5FjU-X1DxNtPjJLgEp_gT228kqk2Va31nk7GjZbPBQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_5232A0BF-221A-45DB-A681-BE4E94ED05F0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 25, 2020, at 12:26 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>=20
> On Wed, Nov 25, 2020 at 5:57 PM David Howells <dhowells@redhat.com> =
wrote:
>>=20
>> Hi Linus, Miklos, Ira,
>>=20
>> It seems that two patches that got merged in the 5.8 merge window =
collided and
>> no one noticed until now:
>>=20
>> 80340fe3605c0 (Miklos Szeredi     2020-05-14 184) #define =
STATX_ATTR_MOUNT_ROOT         0x00002000 /* Root of a mount */
>> ...
>> 712b2698e4c02 (Ira Weiny          2020-04-30 186) #define =
STATX_ATTR_DAX                        0x00002000 /* [I] File is DAX */
>>=20
>> The question is, what do we do about it?  Renumber one or both of the
>> constants?
>=20
> <uapi/linux/stat.h>:
> * Note that the flags marked [I] correspond to generic FS_IOC_FLAGS
> * semantically.  Where possible, the numerical value is picked to =
correspond
> * also.
>=20
> <uapi/linux/fs.h>:
> #define FS_DAX_FL 0x02000000 /* Inode is DAX */
>=20
> The DAX one can be the same value as FS_DAX_FL, the placement (after
> STATX_ATTR_VERITY, instead of before) seems to confirm this intention.

Yes, this looks like a bug in the STATX_ATTR_DAX value.  It should be =
the same
as FS_DAX_FL, like all of the other STATX_ATTR_* [I] values are.

Cheers, Andreas






--Apple-Mail=_5232A0BF-221A-45DB-A681-BE4E94ED05F0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl+/GjIACgkQcqXauRfM
H+A16RAArYXwTjbh6UN5DHPHFjmKbi40h9BMIlxtwkeVKXptVB1oe4FsbhtpnYrm
5mQuxaCPBs70A8ZcSN7tMv5ldseeoThIGoCq84VqFC17lQHd6KzEZw+b2kc85wtc
PCOVgT/xabaHVvRr4ZXYN8m+tdka+FSbBjS3S7pwPKM2Xam9Ov6Mv4YZ4E0Knsnd
DvltX8X3cZ5cK+EXzRKcddbpgh6eUJgBxcIrk3RXD4q35OLNI6PIvP6kD/xBizti
NUgpAWoJspTP95XurKHERCPMhwwmEDEEa5naBJpQvhKDkqzxAIbYSnGDORYXy+sF
FW+GP3Z/EFgd994P0ZRaDNuuSBLdMzRCJtOCjE+bIpZLNhci5niGBjUdS+b6gA5N
q2bNt8UJC+AgTlz0PVMFPlSKG33w65rnrBsGQnmY8l4YufmnD2z7nZglmwZVGVx8
RqLJYzYMYQwgFN9peQ4YEjo/NVTi1tiiKBq2eJ3cQ92lPrcxnYKNNgjyGGqWd5SX
RXv8bmRn+iDsvYL0MH7N9Y/TKA5y2Y4MU4q9wKxwQfLzZEaSAWmVcw1A18+zIuPr
if9rkcxqH5/ZMmgAmzDJXZ89PakYfYW4hc21AcUJV4Hy1eF9ohi3Hv+B1l/d5z1S
hvHWuu/C5Kyq8/crZgE0ZT6d9f5bdHLaNLvKflXJ/feliySLb74=
=HE3n
-----END PGP SIGNATURE-----

--Apple-Mail=_5232A0BF-221A-45DB-A681-BE4E94ED05F0--
