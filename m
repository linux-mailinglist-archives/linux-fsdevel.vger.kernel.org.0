Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE1826CF8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 01:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIPXZr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 19:25:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:47236 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgIPXZr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 19:25:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35CEDAC3F;
        Wed, 16 Sep 2020 23:26:01 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Thu, 17 Sep 2020 09:25:36 +1000
Cc:     milan.opensource@gmail.com, lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fsync.2: ERRORS: add EIO and ENOSPC
In-Reply-To: <8842543f4c929f7004cf356224230516a7fe2fb7.camel@kernel.org>
References: <1598685186-27499-1-git-send-email-milan.opensource@gmail.com>
 <CAKgNAkiTjtdaQxbCYS67+SdqSPaGzJnfLEEMFgcoXjHLDxgemw@mail.gmail.com>
 <20200908112742.GA2956@quack2.suse.cz>
 <e4f5ccb298170357ba16ae2870fde6a90ca2aa81.camel@kernel.org>
 <87k0x2k0wn.fsf@notabene.neil.brown.name>
 <8842543f4c929f7004cf356224230516a7fe2fb7.camel@kernel.org>
Message-ID: <87sgbhi9sf.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10 2020, Jeff Layton wrote:
>
>> Regarding your "NOTES" addition, I don't feel comfortable with the
>> "clean" language.  I would prefer something like:
>>=20
>>  When fsync() reports a failure (EIO, ENOSPC, EDQUOT) it must be assumed
>>  that any write requests initiated since the previous successful fsync
>>  was initiated may have failed, and that any cached data may have been
>>  lost.  A future fsync() will not attempt to write out the same data
>>  again.  If recovery is possible and desired, the application must
>>  repeat all the writes that may have failed.
>>=20
>>  If the regions of a file that were written to prior to a failed fsync()
>>  are read, the content reported may not reflect the stored content, and
>>  subsequent reads may revert to the stored content at any time.
>>=20
>
> Much nicer.

I guess someone should turn it into a patch....

>
> Should we make a distinction between usage and functional classes of
> errors in this? The "usage" errors will probably not result in the pages
> being tossed out, but the functional ones almost certainly will...

Maybe.  I think it is a useful distinction, but to be consistent it
would be best to make it in all (section 2) man pages.  Maybe not all at
once though.  It is really up to Michael if that is a direction he is
interesting in following.

NeilBrown


>
> --=20
> Jeff Layton <jlayton@kernel.org>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl9invEOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbnU4Q//aNSYicYkJ0wMvKqbDFZKVkkiZ1Ze0PHZO0WR
/p+oyRJk0EC3wsG7CTjTgk71DCeMGMh7SQLenHx2apGrzSg585/icGvnj6rY433e
FpgleXqdsf0JkRRFvfW1SkK7ak2Qkd39nExoYX3E7nuJUQsi6JQlZwMyxQE6pO8P
YfIkwENISnk2kc6L24dboNt1W4Rbg/s4UQC8hNP/8XCHNdtZ/04XsFLdsbzAK87B
DWXGDTUPEisXqE0lvQWE1KDoeWQNB8R6bYbSUCQjqOoemqKEnmVWD8kbttpmlaOz
/mpIeYsAwp5kQuR1NePCog9zykUML9tfSKjtdoWGVgTB854gzmMFt07KbmsmipL0
YQaGsHnWl7u520D2EJ2Y3oS5DnizAKRGG2jv3i64eIWD9lAl6Cg0VS3AOLHAd1Jn
xNlpi+tKOklZNPj41mTViAE30UtYYeqy5F7cJG+3gkc/V6a6KgSgMeE84WTaOF67
eqP9ijvWsOTK6TbIif+3Wqiacgk5OHZQ3bpCgub87Na2IsazfB+jpVYxZfledwSo
Xn2acKrPwo8qMhaMzEnJC6DDGeyL1TqOTeQHyk9Ja2AvaZa43a80jyWMjpJCEcgq
fcqCpO2OPAKGAlgXI2yRvApvZdw2lEUx4CPjGR0f46H74IcOdjjVnhhHL3ndnI4p
1pnGIIE=
=o6L5
-----END PGP SIGNATURE-----
--=-=-=--
