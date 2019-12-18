Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9F21124052
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 08:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfLRHab (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 02:30:31 -0500
Received: from mout.web.de ([212.227.15.3]:42307 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfLRHab (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576654217;
        bh=Wql71J+0BokgVQwl76yYBuNMq5gEjNygtvAZ7X9bDBs=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=I++emGpV1DGTTp0t+qyHWDQ3Icg9xvM0gnueLPM18dkWXB9jZ9hc8fomdH1iYZ88Z
         A3YtnKuspPvmPMumiMVfmhmXFDjtVPCRia5RBX7noK0IMOtplnVE0FopllV9JVUOfZ
         iGSKFexSsDYgrIO6ZE69Zll6c06rW/kbzcJI0M58=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.36.204]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MZDki-1iOiTk3yUm-00Ky2P; Wed, 18
 Dec 2019 08:30:17 +0100
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>
References: <20191213055028.5574-1-namjae.jeon@samsung.com>
Subject: Re: [PATCH v7 00/13] add the latest exfat driver
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
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
Message-ID: <3fa1e62f-89ed-1fa7-8c56-9d1ad7d63ffa@web.de>
Date:   Wed, 18 Dec 2019 08:30:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213055028.5574-1-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:z44SlZerHFlBK6KRU9wM2+AilEfPQoj03L9MvbrP3giQ/SGUqm0
 sTUPQVyHaH3cNMKxKyzP0BCSZjfLTJys9ryPUVoZWcCBLpn7bawZvJlduA4x2Iipnfk/kaR
 W16rU2iyk5kpwF090ICgnhh74Ph/e7C9+NdLEpkLqt+gW+oWJigna7QTeUiEX3WVwZj+pma
 4ZvgP9NpWixOyYknXiQUw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GWG4t86FIX8=:9s1mJU5jdBwWJZmo6CunQE
 GSXT3wfJYrOMpZyv2VKFQveVvqQ0snw6wO8rFEfBd1pQrk+3/baoTCB3t2fBJm/ev2ur/Hq8G
 3qyL4QGVwBHo9R/b/scChrndBfKZ6M5jtpuUFL8iougix2zHgPyWV1Nz4wMklteaXr//v3v8A
 NsOm6Fu2qbZFeF+Egnot7m3WluvYRnUTwX9EtDJskKUxLuhkhEkM8qc8w0cNF6M2wsZ2UnPdL
 A82r38p8xTEqqvP2VfxCrmaqrngO0MeKc61Ov7LgAo/Vm4CrOKIXOobGyxkML1hrqNUB3oZGT
 0vi35XPVNtiarMHRmjpMDtG9kMOk9CTlft1UkSxHgyY7IiUW4eOeku6dI7OKeeEAflIUZbjwu
 DiQpEqA4bWj8qBeQ8YWkwpDg6KtglOztzE4JdzY5cmPnPKZrJWmQDa0rIrRNJDalvwmZ6UeLl
 jDYiMHgiDiuZPOUWhivJdRFFIo4ZzK6drDQRMwNRnlveFhq7Lu9ofZh7qXNQ4hAVvzj68J1vh
 eBG5YmVKPzyqw5aaDudlwo3P/JRDw0nBJbH7MaBamFsPDYf2RffqLIWL0lWO7yE6X+OCENgho
 mKv7UA7qOcxPh9nREJUlmEKrwoIOSqkdE9cu/LnbdQ6AsaE/OJWqn9+MM6ZJr9dZZcHAkZj3d
 7F0vmWDK9NIVVwYT/CQSwyainXWTywbKQGurOlAuMNZSwJIcRuL4g5csUqn3q+HX3ZupDCpzL
 ltALE2knLkAIggRB4xLD0mgfl8uEjCeF1MzFXojgyyBXYvE6PW68OFJucRJF/q/kTZ/YqA+5v
 +Xmt7VUdl3BumoJ0vpS+m8ZTTrdYCEfQh7U+PiymrTHNYZeB6tLFh1HSINsW5QA1ZAQoCqHMk
 LdLajTBp4D4fY+nU8BE/skPGdISI5Cg6Zl4r+CiXVppp0n6Se7nvoIEmcxqQNijWYrGDDKTrJ
 1adjav/tGprB7xqKR323PARv5DDOpWd1zeF42X/FPnIV3D/mJh7/tigHRgUSpEqF+4N6mqm2w
 tgDfe2lS/6Q6Wfi6hJcaWQ5sD1QYg9nCkkrqvMfw3QkkqP3yTIWMoV5oDcSgOvqyuKryW10SS
 5CjCKytxKkwEpDqk/v/j3zYru6VmidMMCMeJ1Mq59LNyaS5jCSin0FPjBv1r1qk4omfvxqK02
 2DbcQ1k/uN3MCwOrcd0jJZiYS4xecKU/fnZW6eRvOGK6uds9aawH40TreoupYrAVzMJ9+lWk2
 7a0vVvQ9B9bDIjIz+5lVoonbwKinE3rNDLDbGH356Frz0j16WdgE0uYW+NW8=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> We plan to treat this version as the future upstream for the code base
> once merged, and all new features and bug fixes will go upstream first.

Would you like to offer and integrate any test cases?

Regards,
Markus
