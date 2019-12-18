Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8B6C123FED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 08:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfLRHAu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 02:00:50 -0500
Received: from mout.web.de ([212.227.15.4]:50847 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfLRHAu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576652429;
        bh=HEVqlBMuHVQwjhLQA1qIaNrb256F6p8krZdbgoetx54=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=A+lt93RUoLNxaWM7AkIkUL4MiZkHPcUiIbEvea7xOffBoDlKqkDvLbY9CdCLloZHo
         46QkwDGN7GB58aXU8Z3AxNFZgljcRpO/kJVLNeOdfM0XAUZIVF3kOqLlnJ1gHKs7lf
         WWYbi3o+U3Qrl2eKXOsXPNg5SIPdU4g+ZenMRxgg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.36.204]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MT8sw-1iIgPa3cvO-00S5W6; Wed, 18
 Dec 2019 08:00:29 +0100
Subject: Re: [v5 10/13] exfat: add nls operations
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <20191125000326.24561-1-namjae.jeon@samsung.com>
 <CGME20191125000633epcas1p1bce48f6e0fdd552fe74dbdb7976d5182@epcas1p1.samsung.com>
 <20191125000326.24561-11-namjae.jeon@samsung.com>
 <147eac54-5846-ffe1-4b6b-ebf611d1252b@web.de>
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
Message-ID: <db6a467c-2fe8-9cf4-8447-1b7cbfd222a0@web.de>
Date:   Wed, 18 Dec 2019 08:00:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <147eac54-5846-ffe1-4b6b-ebf611d1252b@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7lCiLfWBCrd+QEOxHEQ8qqirKCsCth+iCZ89RrYVGBQVKOzYPt2
 /43DSMGStcVwEoevrv16tVP6IiLLgjzFYBYNh6djNQw/zCF3VwXIKO/jdhkwDBVkCxNrHiV
 efcYIJTPAgQhstd4yiBM/ZweL1u+UEN2t5znoydfZy7fTMDx2y67xGyLaB+xxVhYZVmmVc5
 Odo69TDR/BIdTMMkCV2UA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:G8px9mSQLuk=:1xHuOAYeOZjnbSktpJebpF
 BS7ogWHJvVJnxkEzAGA0tPqJw4AYAhnvfv5U8eDDmlNwA7LxL0Fc85pi3xXdu1eLo0jMI+cCI
 KZhzULQG4R2VtqTnR62AxF/JWjbLdVhO3H1mXDAa6V9UquTg6HF8zap9fQOjjGxYuRMg7iDBV
 GNVF1YfEv5DmoyTNjByamgT/MIUZXCtk2vild0YK5xNeldnSWPGUZ2p2C5uS6c6vuF/fu37Dw
 IN1zoc7/LdgzxbPKnAUXuhBqMrVmwfcxi69QCVUc2rRg3Le9g/EgYTonRQ+95/uuJL2jvXU9+
 3uAasT3JqYmaWveQlZiErCnkI3GqywDNfBR8EP2SHLLrRB6M7LIQJ9MxS4tu1y7E5/aoOBeld
 7Pj6ElSsmlYY/r6+T0EzBfmDB76nH0cnUZsgw2j9SmAsjxRq9RNrhlQazGFmg1Mcm5LWioF6y
 /0eLp+86lt6/fsbFeTYwKqkuD8dENyX5S9Nh9SH8ugUKRp5tDvcDHYF2xLUvjjkRbHJx6taZk
 wRxB5J70oCpftXer8eh6FRRLKYfeVj6KfU5IMfOpgknn0YTDh8jSACY6CeDtZRjc6zzYOW9vD
 ik54vX60AVbguUq0JuL/z2XJHirtD/ZCBiLmk61wmEXzudlY/tHKoSeqXvwq8khRFAlWcgD08
 PfTLHPVepvsxwTblOLUBW1J11bHR6KO2pY1nMvfnfdk2vbNtpHNC0qCsJhYfUlx6Xl28E3thY
 hfWz//Konk1YkJNuGUVN03k4tK4qre17NbV1rg5RpalyxBaEg8tvARnmeqz95yiS98ItK0uJu
 lL+G7AZClfC1pr2rAvWurjrV7U1fk8yJnDFmtH6TRzfIEdYpRG2+0D0xQxMZ3FHqmb0t8O7gM
 FKnOpdDwJrW3WAu0Ok4I8EcLu9dXoo1q4M/Hidj8Zig7Nehtx6dpO8SjEZIpldXOcB8W8VIAb
 tgxNVUW5ormCsO4REyr8PwUaLZE0VDPyvKFhYOYXRqEm5aIHn2aJZ6ln6eD6gxkqJiHiM8UNS
 RvUK2hjU3OgARZEqvMUPPSPIh1jnluKEOIaa0Tlu+Oklh7D8dueTNiKA9WOG64ub76QpKYtxc
 6u1t+90CeCKTO1dGc0yOxeylvjY6MiqNZK/3JrwV4SczntBlHo+/VYSBzxAe4/91zOuAGl+O+
 1PmPZPiA9NzzhXcdlKqg1ZOnyaeoXkId/t8l4f1khLQv6weVSxWBGQ+42Qk6RXtyCCHkHy+r6
 9ZHFbAaLJPLFjncAI5iR9Hl48qnrH+Oz+zZLMLHuS/2C5veP1cFCGzeK1FD8=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> * Can it be that a type other than =E2=80=9Cint=E2=80=9D would be more p=
ortable
>   for the desired data processing at these source code places?
>
> * How do you think about to use more meaningful identifiers for
>   two of the shown literals?

Would you like to clarify these software development concerns?

Regards,
Markus
