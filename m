Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B78AD152960
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 11:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgBEKpS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 05:45:18 -0500
Received: from mout.web.de ([212.227.17.12]:58085 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbgBEKpR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 05:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580899504;
        bh=zP+pcu3LniuuN2pWuLFHiwLtLmL564R2Tg32R9YiNQQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Hu1kOwtyxGh9cAOiUa42ci2YY8bkRf9VnPPVwBTKSqtQq49py+XWVzsKiej6Dl+Ga
         7oFnIJeNVE91ZoDZVdCDQ50QmxJVTvcu7s4YolfW4svCtzium6JKehTZMZAUReoC5d
         QcoDtmjxI38fzpVnTYDve7bP8fqzzQoVB8/DnkhE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.89.156]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MBkLb-1irLol1Leh-00Aqcp; Wed, 05
 Feb 2020 11:45:04 +0100
Subject: Re: [v10 1/2] fs: New zonefs file system
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jth@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <68ef8614-87f8-1b6e-7f55-f9d53a0f1e1c@web.de>
 <cfb36fa5dcf97113198848874c0ca9ba215e26fa.camel@wdc.com>
 <b1336be5-16f1-cb46-3469-46974406de14@web.de>
 <BYAPR04MB5816A4CD15C760D0E5768285E7020@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <827e50c9-c847-0398-2820-46e210f0fc4d@web.de>
Date:   Wed, 5 Feb 2020 11:44:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816A4CD15C760D0E5768285E7020@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UUgvIhy+4P8ikAPaapv318Bzz+OBbbCmPy0QoThJEh/xGvxoxoz
 3ujbaURXPQ1bRQp8bEqw16vFeQlbSPTAxYMK3cHHGgHTZGaEsuNDZ9kkSiIv2O79q/3S3Kv
 3vGIPL4IG60bmzneg2JtOdSKlguxu6z5Pc0Dg+fJy6ryOq9bDQJbvZXJOCoeNejKrFEWuOT
 lzHUwvWRWrAhdxbdAifBg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vuQHiFUAGT0=:yoAm55Xorssu3mL8YmeO9m
 SunO96UdgcSDjsR+wF1zxA65MNmkU2cF+BoR7JN+VgCSUB0i9Z+BYcuPSyAkap1qs4AULED63
 rWQYNQ6hO/1DHCNeTDnk86UTCWLD8X3Bv+dnk+/As8bLBE5MCHbx260TWUh77sqqnGdMlq0Y+
 nzoJWRhSd9LeUCtFKMeqDTo7n/WO2riRWHYbRW0a/2PN3JeBZTgJrmgOubTPfdgnR7KbcqwLW
 SfB2POvidn0fTkIuCOEckVSe6LT9pgMM8PLyOpXfzg1mlozkZjWQtX7kb/Z82IQOmHU6hhD7Y
 VDpxSG0ct8ll1tXjceaQzyOIKUy2jrMSiGuGQbztc4BRr56guUN/sKKa7RbU7p/PUTKLB1rb7
 72UfDTKDQ+RzLPY1vDD/nl9tv8YmnHFmibCgPHeOgEVqh4JSrqpREPm2TnFkNzam1AEMzqUvI
 DmueuHQxBo6/fpmqMcRSagUNNeyWJZq1ZCCwFdo9Abt18X9Jr4PHq5a+wOM/7Bzh8gegikF1E
 uK0PBR7apCl94argMp9SJeyyMbsYkRmwNcX2lspmiIDryc1IY+Dt0C5zre1mG/dLXN/73uCDX
 yJHDAPgYFzqMtq23aEto81prhTnz3vo2zynw/wJSEKyu7hAhJSjisbosag0g5R9EotyPyabk6
 KChlQq5UQzg+7Naau14B3LSD3SHqVHd96X/271it4ZVrye19Jw/JX9YYEbgJZ1qWCZfWzNBgm
 6CUWb20D90FhjBVsugFFTB4ks5eGRYDQyZGe6pLp3wQckHVkCkROopq6VrnnwccRf0Fig4cwj
 s4Mk5PQ9qw/SwiWYgaNaUcHaaRTw1U0xiDfJYyX0XmAbWvJryZPc9lC9FSLNqsKw4yt0tJDyp
 0D8m9RQ7hE/ECgmBdL9mTfZjZGFSVoEnIDcmWvEFKjRstxRxeDyMaZSgKvrr/1Rw1DqlS2hOQ
 JMGtCljjIGPZ7y7nF8cM/0jKBK7mLnP8Zi3/kZPX+F///i6bQqbyTandyM2xJ5kXL2O4loI76
 mqVpWXmH5BZ0hOQkbK/v6IkjgMuxCITjwMHJ1LN02vNy5Ueim/5WW5NUl1e9OT3F3BKrOgLBn
 grh0z+2w0invYCCojvw7j+oevpoLDCv0YgqQkBopkx+OIcUZctVrU1BRc4M761MJHyTXesVN2
 4fszyBi04hzW4wzJS7RW63OYmxJ7n61P358TvU2AwG/9KjM3lRiIctDc6b2vxD6ZaUGUKfGAM
 UEpOskK1VhEaZk2+G
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> I propose to define this array also as a completely immutable data stru=
cture.
>
> I understood that and pointed out that the added "const" does not change=
 a thing.

Should the stored pointers be constants (besides the corresponding string =
literals)?


> I think that as is, it already is immutable.

Would you like to distinguish the scope for items in this variable a bit m=
ore?


Are any other software components similarly affected?

Regards,
Markus
