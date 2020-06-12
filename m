Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E96D1F757B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 10:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgFLIsd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 04:48:33 -0400
Received: from mout.web.de ([212.227.17.12]:50475 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgFLIsd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 04:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591951701;
        bh=HK2Dio0rEolq34BLqaplYRdsKrzgzy/oPHEw5z7wh5Q=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=Vg1jix1jbt63dt1rYG6cujTkSF9nisdydf0dqcHczRBDlWufI9DyKOPKHjqEis3iL
         1oirA7Po8gyvShvxfHPCPQOq86uupWeKYxrE2l6JLlR0nQxqLk1Bh0jGnoM+yhq9UP
         EEi38gepmF/+0X3kk/w7sZ8T1RFJjS/225ytkW0I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.95.40]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mg7I1-1jXF8i13sz-00NPdJ; Fri, 12
 Jun 2020 10:48:21 +0200
To:     Tetsuhiro Kohada <kohada.t2@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>,
        Takahiro Mori <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        Hirotaka Motai <motai.hirotaka@aj.MitsubishiElectric.co.jp>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exfat: remove EXFAT_SB_DIRTY flag
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
Message-ID: <4591596d-b33c-7e6d-803b-3375064bcf3f@web.de>
Date:   Fri, 12 Jun 2020 10:48:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wkgP/M8BFsNaww6uQtIh8+GIB/f3o2qn+dcL/nn1qnv6EJVBcyt
 ZSjmY+HeHbGWC3FauJOJEX/vF/QpgqRQCAov5snCi16bCZW9HyLM/Y3v9IHjYtNEFSEQQim
 dfJlRRgqJNVLenHsy+TCQwAMHsVPr7y3ZfYYYBzERWvBgFq7Rs0OvtCEErOvIM2ep0wW0Ys
 gwRG7IkCFW5tFQtsnHCGQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fX3/Il3Wc6c=:XLnUazOB0peALOiA2mJwhQ
 grukQXKVITIFKLEnlmCBPax5YsFmuuu3B9xFj5dW5MtoImq0ZVsktJedCaMrE9TgaaRD/9L/8
 2Y5XAdJehQzOdjUK9UDNxu/OKfMGJF7Gg/NIWFOIppK5DacZdl9WZnTn4do52NbP+aLxKQ0wo
 De6LQpnDm8DsD3O+gkml/LcbEs7YAhL+xIvx/fjxZGvHCLzPG6jVmKvJm7q+Q34JkQIK9mZRN
 IQWqWzDhXlSpTC4QcevicXD8DQWANdjACiP7UUWHqRgfNxWJ1M7di3NfPdGDcNDQrOC2V13kg
 szDnYs1YG1MMd0o1IOQEAJFIyRFxRH5XRf54ZyBj6WfmZ/V3+vPRnNrCU1ojqR+ON9GU8GbyW
 D2n/R48fnZmnLLPmU8L/OySxU3n0UHlUnbyZWJAZKnQKHjMvAYvbVQHfwWH7NhMZAlrnFmFVz
 At61T65GepxFfxXoFDr0znmwHK5LosqyFsL3YYzSkFkTwMHvs94mLueYbiYeSGj3UEctzNlYW
 jafOeePJVX+jlX3Z0g/7+v8fYxCQLnBNGOGR3rbya1S78nPtABSFIqrtH/mhrDaExohpcWr2r
 54SQRAjHz/wvQow7pb84+jXkokgjkpGTZuhUnR5KxltfW7Ys2Dt+29M340ERFouGgsMlja350
 R16yBllW6lP0g9ZUyDYgT4CWkPsc0eUGdQBnCxgy5R5Nrme11jxYbR+ddOU+vGsBip9g+2Xf5
 nMq5YxWCOKAO/KUG5kmmvldHR0tqIhAcxPek6ifp8MdT1rosdE9O63P2qIHTge/b+YldJErfJ
 tgc+KU1Ya/6boHUTjXs25dOI9kQSwoLZArqdvCMSq+YrUI7jYtWxfa1TywSxeyYvBh1S+y1tK
 QQ3OBulvEEOKu+7g7mvgCxy3FiU9BPr8Ui1zD5ocwaCuyaonNHKf8KCYwY4R5Df2UOvB85zH6
 WUfvfk58WBQnO3k3V036wN8alErpbkWWSyb/wanzd2RYsX/2W2jNFd1sHJ2XWw0czDMjdLf+U
 u1ienj4lxaxXUkaOmM8XzVu7nOCgKcN7qjDgdeNRi1UBRNm+bmiiu5F7BE5NRPi7M04r/06Sx
 UKMQcZrqm6/LG4Vh5Y4pThEDIhMMNBhtGKWWRgq1Bho9WpM39BerS0DYJHps5z7HV6s8poHEg
 dgRLwp2qH3AYx2eZWylnXC9Bdx6/E+ekEc+WAUafeqMukGzEnwuyFB6QfDp9CpkZWd7Slxb3V
 63kY1dcjGEk4bJ6WW
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> remove EXFAT_SB_DIRTY flag and related codes.

I suggest to omit this sentence because a similar information
is provided a bit later again for this change description.


> If performe 'sync' in this state, VOL_DIRTY will not be cleared.

Please improve this wording.


Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit messag=
e?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3Db791d1bdf9212d944d749a5c7f=
f6febdba241771#n183

Regards,
Markus
