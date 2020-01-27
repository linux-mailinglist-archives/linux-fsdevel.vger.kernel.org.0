Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E045014A209
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgA0Kdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:33:31 -0500
Received: from mout.web.de ([212.227.17.12]:33775 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbgA0Kda (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580121199;
        bh=dAxxIGooUrpYMIc/V5niU8NEItO2A/L1D6LYedd4Kb4=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=rYtGbKgXJevnIC0LSpzxAHP/IKW+VPszQwWByyb8862z5f0q/rLwrRCg6/dn26fKy
         yN2pdgxkucwdVXmmINN4hHUUbEMWkcDInaT9jQIX25fchM4pjMjasQbKusT0SiOREm
         BxRWuAAhRkMlqnWdIJsTZJSdAtJMUnssoQlMP3Zc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.115.58]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2Mcy-1jleO31bkK-00s2n6; Mon, 27
 Jan 2020 11:33:19 +0100
To:     Pragat Pandya <pragat.pandya@gmail.com>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>
Subject: Re: [PATCH 02/22] staging: exfat: Rename variable "Month" to "month"
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
Message-ID: <3b444326-1295-fecb-2ff8-ddf770627bec@web.de>
Date:   Mon, 27 Jan 2020 11:33:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:uxyvTeLc2QZWHfxXQ5yjYIF7M1dLi6IMScZb2KpG8Uq+6jIlYNg
 EISlabkrMWvvBQeq+PTHJ8YgcvrsWZSlU5dpwXGm7yK9lpW7HY7pMVqw9CJsru0DKyGnU6e
 5ghtARIjPhQxdMlvUW5e3ZxW+wLyqi7kWwg7c00y7R52MpGnzCl10mopxbBYi0AlYRc67t5
 fl1DgXZwziDgsNGVWtY5A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mm3Dq3GHmXE=:/CU046Gjox9LZ75LmHF9ae
 my+9+rjVnQtMTHuR82tfX5j0oowwBGnwpzyK3l5yXJHNLXy+oXdoLusdhR30lHp+PaacMYM42
 gAeULAX+P7V9TB3gZHRsEvfVvJOKnCUT1HqljCdVKk4PR8K2QrJCvrsQmAne332mHWyGZrQ+L
 0o7U4+n4gf8mqFIOUViYVe7SGtml3RP+s93bNe5S4WZC/GBMVj/8HYpAaVQcAxWlHhc0yBEYx
 q5SltDeo01wPircy5Il/LZqLP7XRMAlNlUiwBLKrJ5IP5opsOCxJhR8Wd43qA3zypjCS8WERP
 wf6eIylGZ4Fr62m7sa5RCoPAoeLBaFtLTD9Jn5Ua9In0bSYOtWKU6IrxF/fxExgxiw/dstDEa
 vtKZC6JNdaPrSqXCqaTzPTS6GNxZp2l3h45ZzhMKqCMzGgDw/G5UcdyJJENtn0DOooFlupLVz
 evMVjlCDwm+SEL7ytnLpG+9HRYZctb+l9Hrcl2sFIJF4so5OOhNfwOo4Tjsq5QtsBc26jVV0b
 dnu3AvDLSMcG3YJFxaP/MVnJxyLg9k1z/tMADpAd2s/ULzp6hsDLtlrVMY8hk2aZQcGnjbe3t
 xJjUot5iI8u3+g+b0lfWKB3Y8L3HvDy6z/iB0l1ArNw+bAMhF4W8DyqXJDihN+nVMxu04o8Gb
 9vI7KYpKMUu+W7ZaQ0ndPdP6rHaCSo9lhbv8kKTT0Ka30K17dZZu/XHhtJjwbRVr+yKpFhCgz
 gexeRfuUjXNOBgXa5fdYoArBEyyQZZlTqaGouRjnuIII37qrwckAluuUhUjrH58tlWWKofO+G
 euH6zPFS35e+psL5C2f2aM0J03mBVqxI/Y8pGZ8K/u6dJpa0DY4sDMN2E3/RmZqcSbIVcwOot
 OX4QDLk9nYX+0InxYnnYTbtYaExuvv4b98Wxres2Lk2/6Mft6Her9Kaa9/hR1tqT4tIi7HsSc
 jVoPhQJ+KoQNtSl6m6SZGSZ4FDrSKMFm8hs5p1vu8En9tX3qnIleDiFRG0M/RbalsomjoKXsj
 rbEoHVkkjTfNeIXaywxNF5xj1CtA07hYQFhdrWRix9zN+bOUgD4ehioIicVW008dS5liKgaw7
 QFm0Qzpj+ySkApYQC2u7HIB9uXUgudmT+K8imYekEXgWrT9kr1FOJNJ+VrG7XL8BWUsEcXlAX
 tK6s7+myWCDvz+d1TYDt/Ur2N6fXhKeAdJATwYrwILkzlomXCRXQrYmdKiLGIt4Zc01Zhm+5k
 2NvtGIlv9ccBMwVmP
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Change all the occurrences of "Month" to "month" in exfat.

I hope that the final commit will not contain a misplaced quotation character
in the subject.

Regards,
Markus
