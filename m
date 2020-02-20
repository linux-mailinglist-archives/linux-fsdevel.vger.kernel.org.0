Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B61FE1659EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 10:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgBTJLn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 04:11:43 -0500
Received: from mout.web.de ([212.227.15.3]:33947 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgBTJLm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 04:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582189845;
        bh=vbMpoLairqKsk7lsZ4zCd9hpbkL0beCHN/AzVweLNtI=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:Date;
        b=hcamI+q/q5SSrm/QLuCC74ywkKTqKsPuKsSkHJmrFFwLCRJWO1khrkPUt8ZcTDN51
         /fRIw+qs8rpxThXROZz9/i6lbySHlvMZSMG9OS/uSjkL4w79u06hTV3pMXUs9lDGCQ
         zUtdNTwVATrVlYB6r6XSY2g7gVDw/q9/ln57tpmA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.175.64]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MLxrY-1j5oJV1UFA-007ifQ; Thu, 20
 Feb 2020 10:10:45 +0100
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [for-next][PATCH 12/26] Documentation: bootconfig: Add a doc for
 extended boot config
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Bird <Tim.Bird@sony.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
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
Message-ID: <23e371ca-5df8-3ae3-c685-b01c07b55540@web.de>
Date:   Thu, 20 Feb 2020 10:10:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iz3EHkgef/ISzsnY3CSV+i+tHS29kp3ehQ7OyVu0j3Qh1MRjhD4
 2kNZozsuSbfAVgfZQ2c1f2reumTrdl+tygGxGYptax/fHEDxIV9ypPacshUWYPuiPbdJ7Xi
 HaDH6A/4rRN83FCKqHZ9p/QzWzFKumXctso507UT6M+uKmV4+RRmqyydQTdtkiDdCLcex8y
 wWaG2+ug23HgJlgjioIMg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GxZTiIb8TFo=:BgRUH9Ab/NRq4bHPkY/hrX
 ItkQAXfW7FOzZhvXJx47bwUUeKd+ouKyyneLmedUiDxakWbNC2yV/gMLLUltUVi3Lkr/JGHGh
 HAFDglKVWnP+7b2a8lladClky+tVXC5jFIuKLE4Bc4bZ7EGyEi7bYZ3t5ISlhl0/RSxpYSFSx
 DCwRbuBmUGfy/h9QQY3WNbrVkqbDDA0us/EeYeNUmDclafQTq6YFPdb+6rxBNwx8aQQJXItnD
 YN/55J6Ht/aVHkBdTm0iOn/Pkafz0cFJROASD29pxoKzj5QE+hpNOwXPFH0JiXLr0QuaJcaYC
 fhm50l3FN18mh4BXC/dYfSwZnHVpZ5R/fh0IWWQkk/feWavBkNzSK/Q5uNVObnN1tcxb2KvTE
 soGVJZ+JoI1DTiNzxkY9he7LoH4RjislsjMAb0oJw6Lhd353h9X/upz5ktZIFW/J8v1ofVHof
 WJmMuFOUNCIMKJlQTNhhqRuf9joLkyVCrlOipcwobSFjgGlkDYTtD+spTyELfvxdKCMnulD/h
 7eODoGi9o05VhTFHfVMbuAP9IsR0da1D1TG9B18DQo+9gZ6VjyDrbl4t6OvaDWf5X0GlXWhVz
 j/x8XBwvsRnrVzFDvnDSdIq/EbPy6imT7/LFTNusay/cK7n2oE8QglPb7W90nVnGPnTS1Mbt6
 XTDX1cSbMXwH8hbsJRoVrElioQP9RTihacRVKGGMrg84AElwSpAOSLVmZUEXTG7aVobJKTImN
 DYMoixFt+QUM1sc6B7kHNmX+sLc0vqWAB7i5Q+OoGVAyYeK4W8opLinai4+02UmJbzkba314n
 cN2iB2K4DbaaNmitOdrJgp3UbRxohPJwSKTYL2TT0T5LxIizhbGlNQ+VoJARqFJAP5s2wDgQM
 NCW+aH22vdx8rAi5vwwKBe/LV4gl+Ii7/Uza0gf9VMjoZDIh4rsmYhH/JcRV08PkN+4avJkmY
 lWJkg+na3cAnKZ6WgGDge/TnGvhaRuispzGihU9XfTtDmN7V6nKUWTBqkHL5zuUTVH2/910YO
 3n25tiopO1XpdFQnxsGgKh62VH0dKYu3nFyOr404GExcQRk34zvruHHTGXgwM8Lb3jBpjSOAz
 zGzgkbKcL/VtbhZnegBZWKbrJVH9GSGQHmgROq067ReqM3HxgkxczfcgoBP3wTAxs47d3BqWb
 V0BertZzXThSuFsfsFDxdf43FL4Ns5wt0/Iw8feluBycNpnMJ72pl1NK03tzac5WEa/G4VK40
 giw5iOUp8pffI6ohl
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I wonder about a few details in the added text.


=E2=80=A6
> +++ b/Documentation/admin-guide/bootconfig.rst
=E2=80=A6
> +C onfig File Limitation

How do you think about to omit a space character at the beginning
of this line?


> +Currently the maximum config size size is 32KB =E2=80=A6

Would you like to avoid a word duplication here?


> +Note: this is not the number of entries but nodes, an entry must consum=
e
> +more than 2 nodes (a key-word and a value). =E2=80=A6

I find the relevance of the term =E2=80=9Cnodes=E2=80=9D unclear at the mo=
ment.


Could an other wording be nicer than the abbreviation =E2=80=9Ca doc for =
=E2=80=A6 config=E2=80=9D
in the commit subject?

Regards,
Markus
