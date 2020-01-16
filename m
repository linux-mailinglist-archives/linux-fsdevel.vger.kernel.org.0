Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC1C13D6F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 10:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbgAPJhD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 04:37:03 -0500
Received: from mout.web.de ([212.227.15.4]:43303 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731449AbgAPJhB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 04:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1579167405;
        bh=m0t+4JuI/Zbb5bWxl9uCpXvHpa4Fj8lq3ztfYXq77cA=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=KIuhOSQc40KPwQrGHVmPZlI3FZviNBZdIUm+s0nezsoXQDl2vSf9rcO488yoVZ74e
         Voi0GChGAA4AhBTzF6YeZaCztQBRitCfO/nxPcMJ4lkz2KcffcVpgcU/j5fnA9cjq/
         rCkLkQ1oAw6rNoCblF2ZhLoHVo5X+Sxi/42Br9uo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.6.163]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ma2V5-1jDnr13vV1-00LlsL; Thu, 16
 Jan 2020 10:36:45 +0100
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
Subject: Re: [PATCH v10 00/14] add the latest exfat driver
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
Message-ID: <7e5e56be-5b87-8f9c-60fa-134a13f8e762@web.de>
Date:   Thu, 16 Jan 2020 10:36:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:50zNE19FmdhA427OFaCmImPWk1hx7iFyaMRJzRQHP9B5a2pkKwR
 1eci7/4M1MIlpvHhRDZQski5IhycVN86VpZ6VZz67jq7dQrPq3++i8lPriEdMuN2ARILGGX
 dbbBrXouzjMsj0HJ4i/lrSpnUWfiitDYQtOXcuy98c0ry/jiNZ+2+bi7SIiIROOIyJh2kig
 DRrUF+BB8UmwIENAbBAXg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:X+xYRvIzknU=:+J9BcHO6Rk2dJMoHpb+Z+9
 ql1kHmoGA2VLyO9dnrbaiI2Wre9aRdz8oUeOfm4zP84RACG7ERLY2UU/V8MlCIJm5/y1smGJw
 p7XekBKI/JrVV1xPUF14gLHVqQBkrMt9h/kpRMkqzXxokU7DeDjnveP7zYk8N/ffTfSnDN7++
 pxR4nIhObBcfUmK6vEFYzyNGLTIjllzgYt9cTcPmgRFm8Kki3XyVj2jhl0TeWzmjeTZRvmJrG
 +tf1lOvBlXLezRQH6RTpeU+uROe31va6SiHQJD3hI9DBIF4ueKnnHfyJKSj7KKbNdqFqPKnUf
 uq8YM+MRcOj1dlMSI4Y+7yhE+PHfR+3j+rsBmdYaYJK7FWLT4qTRr7SwOrJsM+1D12JG3+lLx
 aTReuS5qQg0j5t+H0+iuZCJOqK9kFIN17NT2F+o716kQoX7q1La7z0mRq2H4VVHM5YSKAi56m
 9NRL9LU4TskJmdBqrFi3IgG68XOW7DXYIvdSlLWgajjIkAv5ObEXsj4Q3oI9mreJ7+/zKHF7l
 23kHFo4ZiYDTcGZ+En8qitgTF1OgQ28ju5RcO/IYWplqXBEtEbYj7VUR4mEm5SivQjYlfZh6C
 R/i54Wy9ZZB7guB7VJ2QaYpZliujPbDDlp1mYb+bSzsUaJ57SDTVW2oHlSFXJLFJkUmWxVxZc
 TFTiZfw2IhEOsWoNqfIXApyZ+hvfl7fhuGdCKaMLNtabNbUpWwhGe6x3I1Hci6uCxkSslrU9p
 euR9gXxwT3CoN5yjtuTceVwgUk+TlbPlpME/2N5SVQzQaGxarKHHEYoE+lbfnb+GfGjKkECjk
 p9F/637tsyZJecBhoYK2zBuK4ezkg4wLdOdKBOIN3zu2jddbo1YEBUOk4wYY2B270Ts8owfuH
 gd+17UQCHCZcakF/cA/SQ91pJEbmWcVuarmh8xGZ94qiH0AZRgiZOfPLn8ymhxDNqsQqd9NZN
 a7O4I/mW05tyJHr3aIhu7MEel2Zr1wP10h/zq6EDlz9qsyZOGGQui1FU64EmW2Z2vnRmWl8hR
 nicjO7Eev9ds0fGE5rqv4LD/iH8WOtxOFJNJ9V16pZ3jkq6ygziHKdsAK9ItSQ3+KYrWRTnu4
 iYcAOwolQauPQovbrJp4zIF78CqQBE1FPnu4bDaDSoTzO3C3UrQd2TLAt76GLPp//cw0OgDNs
 7m5WsNJFc2OCSPg23rK5wxdJmHUZcgkI+kaa1fdubhBSnW/b1vDmXW2/mt9oxngINQmL2+i0B
 ODM4Bg9j/OKs+1AtdFzq69eTqFl0QeFfTxlbqCNhSQwRPcog47tGVWwiLiVg=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> We plan to treat this version as the future upstream for the code base
> once merged, and all new features and bug fixes will go upstream first.
>
> v10:

I find it interesting how the patch change log grew.


>  - Process length value as 1 when conversion is failed.

Would this description be nicer without the word =E2=80=9Cis=E2=80=9D?


I pointed also further software development concerns out.
I hope that they will get corresponding constructive feedback finally.
Other contributors are similarly waiting for =E2=80=9Ceffects=E2=80=9D acc=
ording to
their code review comments.
How will communication delays evolve for the clarification of
remaining open issues?

Regards,
Markus
