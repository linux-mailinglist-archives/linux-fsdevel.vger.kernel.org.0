Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A2F34EB1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 16:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhC3OwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 10:52:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:41986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232072AbhC3Ov7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:51:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617115918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FeiXbsSBDO0yIAHhuajm81IE2/8vNOQeW72E4DtHwVk=;
        b=Ewie4i2t6nD+VvvCQ5EZiJnqXyfPn6/3UeluTdu+Rzjf2fn47rWct2TpfJ2EtmiLKipAFh
        TbHRHytId/EPsphch0Z4v7JUQbCRHmCLa6mkZjD88M9qJV3zSja2QnLEGHEesuCRn+0ClR
        dMgEO8YEIcbUjuDa6Q8RKv+m3XpN/MI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 39535B317;
        Tue, 30 Mar 2021 14:51:58 +0000 (UTC)
Subject: Re: [PATCH] reiserfs: update reiserfs_xattrs_initialized() condition
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>
References: <20210221050957.3601-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <bd7b3f61-8f79-d287-cbe5-c221a81a76ca@i-love.sakura.ne.jp>
 <CAHk-=wjoa-F1mgQ8bFYhbyGCf+RP_WNrbciVqe42MYkjNjUMpg@mail.gmail.com>
 <35304c11-5f2e-e581-cd9d-8f079b5c198e@i-love.sakura.ne.jp>
From:   Jeff Mahoney <jeffm@suse.com>
Message-ID: <7883a127-80b1-fba0-3403-ab023a12a4cb@suse.com>
Date:   Tue, 30 Mar 2021 10:51:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <35304c11-5f2e-e581-cd9d-8f079b5c198e@i-love.sakura.ne.jp>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="05VH0NehCBQKKV0fKHsnMSqv89I1Y9ezq"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--05VH0NehCBQKKV0fKHsnMSqv89I1Y9ezq
Content-Type: multipart/mixed; boundary="HumM37SFtqroY8ZTlIlBgAJYq70fLLvgW";
 protected-headers="v1"
From: Jeff Mahoney <jeffm@suse.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Message-ID: <7883a127-80b1-fba0-3403-ab023a12a4cb@suse.com>
Subject: Re: [PATCH] reiserfs: update reiserfs_xattrs_initialized() condition
References: <20210221050957.3601-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <bd7b3f61-8f79-d287-cbe5-c221a81a76ca@i-love.sakura.ne.jp>
 <CAHk-=wjoa-F1mgQ8bFYhbyGCf+RP_WNrbciVqe42MYkjNjUMpg@mail.gmail.com>
 <35304c11-5f2e-e581-cd9d-8f079b5c198e@i-love.sakura.ne.jp>
In-Reply-To: <35304c11-5f2e-e581-cd9d-8f079b5c198e@i-love.sakura.ne.jp>

--HumM37SFtqroY8ZTlIlBgAJYq70fLLvgW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/30/21 10:47 AM, Tetsuo Handa wrote:
> On 2021/03/22 4:20, Linus Torvalds wrote:
>> On Sun, Mar 21, 2021 at 7:37 AM Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>
>>> syzbot is reporting NULL pointer dereference at reiserfs_security_ini=
t()
>>
>> Whee. Both of the mentioned commits go back over a decade.
>>
>> I guess I could just take this directly, but let's add Jeff Mahoney
>> and Jan Kara to the participants in case they didn't see it on the
>> fsdevel list. I think they might want to be kept in the loop.
>>
>> I'll forward the original in a separate email to them.
>>
>> Jeff/Jan - just let me know if I should just apply this as-is.
>> Otherwise I'd expect it to (eventually) come in through Jan's random
>> fs tree, which is how I think most of these things have come in ..
>>
>=20
> Linus, please just apply this as-is.
>=20
> Jan says "your change makes sense" at https://lkml.kernel.org/m/2021032=
2153142.GF31783@quack2.suse.cz
> and Jeff says "Tetsuo's patch is fine" at https://lkml.kernel.org/m/7d7=
a884a-5a94-5b0e-3cf5-82d12e1b0992@suse.com
> and I'm waiting for Jan/Jeff's reply to "why you think that my patch is=
 incomplete" at
> https://lkml.kernel.org/m/fa9f373a-a878-6551-abf1-903865a9d21f@i-love.s=
akura.ne.jp .
> Since Jan/Jeff seems to be busy, applying as-is will let syzkaller answ=
er to my question.

Hi Tetsuo -

You're right.  The other call site in reiserfs_xattr_set is fine because
of the privroot check before it.

The patch is fine as-is.

Thanks,

-Jeff


--=20
Jeff Mahoney
Director, SUSE Labs Data & Performance


--HumM37SFtqroY8ZTlIlBgAJYq70fLLvgW--

--05VH0NehCBQKKV0fKHsnMSqv89I1Y9ezq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE8wzgbmZ74SnKPwtDHntLYyF55bIFAmBjOwsFAwAAAAAACgkQHntLYyF55bKc
VBAAr7CeeZPy6tJTHwzJcVGfw3VycW4BDjLO+10nQe+aSL2Tx9BDGq0yNk7dvHPgf7ZrvEsuCpqI
VmTEtJt7mfqxuo8JosN9PuJHKBjWO++LlxCBTYkS+c/OpDkq0FNa7ipL2CJksR4T3MKMA0sA9DCn
Xx2Qa6w/ODKLHAs9yNAqLbtgRMs0KusArSdt1WO0700oU0E9BVoS34TpFC14isJ3gdcSTfFtH5Qx
vpprkeaYssnJJ8VFUu55YexgkF0P4d49+7YaKq53LmA7du/0jTTFCLEh72c5e8pRZPsDhGPJW6XF
FxMWKQmpolOEtGB1vwLnrf1M0Ac+uyloP7dKXlqTive7V1NQzCA4E1pXuQORgWW85fl2srW5xDNR
XzFwAzgezoOtAmUsMDQvgZSy3P9D0znZLoKPbvY+aCfsr5smHWnkKxTuuuIa8Z9XWmydfWbAcBHv
caB5m5Y+qjHWqv7wILx8T8mALc3YMowdBEr2XX5UsG1d1IzbqnsOxBBm+mGdPWRzhnJ+4XNrXfUh
k2cYRRH+agbfcXevx+2pLoxH3ix1IBPZ/j6NHtKX+VvceE+zQZnR+yG7rgNKTtDSHNS4dxu76BA4
lMivZTjcFLCAiYkzVy8mQsfyHe+WfE+LjmwnR+fwVRONhvGw1aTuge9nDHHItr699JIKTuGQDbKE
cp8=
=1dMr
-----END PGP SIGNATURE-----

--05VH0NehCBQKKV0fKHsnMSqv89I1Y9ezq--
