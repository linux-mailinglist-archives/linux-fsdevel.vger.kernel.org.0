Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5880120797
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 14:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfLPNum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 08:50:42 -0500
Received: from mout.web.de ([212.227.17.12]:36127 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbfLPNum (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576504226;
        bh=zJ+cWF7nwDFTUgO2uMhfKRvssVyaJetGmZThvQAErVU=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=Db76xbzdOunLhR0vEg1r1yxyZT58+T+iSBTMhJ2pDW3xyeRKRYqemA/Q8L1OHaeGZ
         4g3XiHz7BA4PBQ3pRS3O3gP6xGfS8MPpXejJ91S07BCOUg856k3Kuf0i8U+hNQspcX
         caVw2apGKLi/w866i3t5xBtZqHRV7AtAJIPW6Xgo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.181.202]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LsyRS-1hirHc2nXu-012Z2A; Mon, 16
 Dec 2019 14:50:26 +0100
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>
References: <20191213055028.5574-2-namjae.jeon@samsung.com>
Subject: Re: [PATCH v7 01/13] exfat: add in-memory and on-disk structures and
 headers
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
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Message-ID: <088a50ad-dc67-4ff6-624d-a1ac2008b420@web.de>
Date:   Mon, 16 Dec 2019 14:50:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213055028.5574-2-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SrekASl3RDsBlAvfraP2ftN01mJ/kTlsHVmUM77Yq6t78iaUhuN
 8cky66fW3NgRi5JCO9z37SvnWaSILuZs0f6vQrZYRv87JcD84TktnmK3eNnAvwOnSj1f/DU
 J3CUnZx2pfE0DNRstX/E5CVkOqGEIkP0ruStDDVC1aBjmSQFYShYYCIHt/0XyP6DI+XB6wU
 /lqt7Yvdw8Yadte9O6pfg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2I+dSRb1Ew0=:RBvvt49EwCkrBBPWxJE5+L
 6W5IC2A0M5fukw6bE0fGlVQrnPHPkAwX6q19clvPjxbpf3q8t3bI7fHhOKDkY0CE/jjUZmwKO
 VqGJB8tEKrz134DbJBc002sKhV7L1S2zicfcCOcqs9BVnr/S1tRGJUOSLM58f5dYDzmmI62IL
 oVCdsfI/mGNwoT9G88aTzwuEEJn+fjVvqKPlVSloH/MqJjKAhi/SLO+x05QKv08Erj8ReDaM+
 k7je2wJ2NhdvjEHvD58BKPlAp+jp379Bg3Ca0pZeulHPEjvwKqbeEiqF+CPgEmahFqHv+d5TI
 a8CKxqsrpRBW6OhWsRZrEVTrATJI+yWEEcogkFlkth4ne7n84MK65jOi1aQ4CGZwVD/w8zrBP
 3lJtXrdNxnVdbAocX1s+qw/PSUp0LW8u9BiGOQhukUHosg2V+tPT71c2xOguUGFFjO5JgOM75
 2tCU1P7lHq5Pd0NAVDTjxMxFBG1ShXlV48bM8MhPXu+hJGL0vDKfCM/QrrSURNrINJqW/n+Tz
 B2hltMelZJODjW2jb7Z7ux/Mx/7k8YPp3+L6r/4o9CrOq6q3ZXDAN3XDKTRrBEJCrhm4V/1bT
 RvSxFRN/UKBFuL/drCnZWA4q3OSVwBn3wfMw5501x3pSFGkXIZVqmVOd/pA3V2t3Rc9NvehBl
 sPUx4W7nWFblI++/kxcTfjBSX0sINdQLq0axCvgRjci5ItFtaMr2wpyYkNi+vcvd3Hh8ibZ7m
 AqBkRiTnLTC+Sj/K3VVVUtrI6XBL8fYai710JMq5WrDoEIztHEylzd0fYlNKmdQVVcVlVMll3
 jvO66X2wC3eAlY2e/njy4+2zX0VbiDaVt9wLpFywffEDhJyVN+9zAjHdo6kp4BOxZmgudgKli
 VYxfb0QFETRCFiA/0qcU9FrOkOCpMSy+dSnyl1jpJRgz3NlY84PwwlDQg49DCP1zoEfvDiqJ9
 5kmuM3P3A0aT1WgSx3jHo6qnBgKHCM5JMFYNzim0oZIZeKixqdUKDCZ83zcgsw5kI72gS+gXY
 Q5iv5/2CX1LXO1kdPUzhwtKHO2ETG94lGPifojRP3rBcjfqdDRoPL285pL7S/Yh9mQINn/hj5
 2Lmnab8EwB/c061DfOoIqc0I1jqHgYS6WJpmVpmFo62eKPjjMYZYsV48iIDPltvchnpnC8mZD
 sMygdi5rXs2jeE6TCJ/4x4PtUCS85Tfel6GXzQLNk50Sbt64StUEV7diFtgpI9zQKWS1B851W
 YvRlByIR5wsVizcCH/7/epP//L0ugkIyemNQifFe8Fy0nIc2Q7yUsnCnW8/c=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/exfat_fs.h
=E2=80=A6
> +/* fatent.c */
=E2=80=A6
> +int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain =
*p_dir);

I have taken another look also at this function declaration.

1. Can any of these function parameters be marked as =E2=80=9Cconst=E2=80=
=9D?

2. Which source file should provide the corresponding implementation?
   (I did not find it in the update step =E2=80=9C[PATCH v7 06/13] exfat: =
add exfat
   entry operations=E2=80=9D so far.)

Regards,
Markus
