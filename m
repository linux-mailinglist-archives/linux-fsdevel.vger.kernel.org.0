Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98D3D12D975
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2019 15:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLaOYK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Dec 2019 09:24:10 -0500
Received: from mout.web.de ([212.227.17.12]:44861 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfLaOYK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Dec 2019 09:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1577802235;
        bh=njW70Kvt6w+HPNlPF02qIWP2tFKDZNV6eGaoaDh4Uzs=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=rClWCZEfooJsOCeHFtsUogo1A29BELPlWj+X719iCy/bB35BxBO/w3umMGoQZb4Rr
         61LQBF8QYLEspd8YWuPkte54KTXJii2FZpJ7mSlTt0/OFqYaDIJYtSUknzoT3/mCe/
         rqgFaV6glvpkfuLsSd5yfI5FdxHHrr0mj9BRfNnk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.105.164]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lx7Ir-1jntOk1wL3-016eNL; Tue, 31
 Dec 2019 15:23:55 +0100
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <20191220062419.23516-11-namjae.jeon@samsung.com>
Subject: Re: [PATCH v8 10/13] exfat: add nls operations
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
Message-ID: <5b0febd5-642b-83f2-7d81-7a1cbb302e3c@web.de>
Date:   Tue, 31 Dec 2019 15:23:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191220062419.23516-11-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RPqLzP+zYG43xDh+ViQocUOWTIevtgfMrRQuxh+8eGCfX0xKREN
 cPxffMC07AL319H9Zd8xsPGqEHVMV30kVGVrIeYXdtTfzs1ZDSXCmqoCqd4KB0xrJo7x63v
 3ER0+1Gv/TbyzXzYSbMHNEzHf+tTqrzCaYSA9XyQD72N+lnM0ADs3k6O26fqLTSiRLdgJTQ
 rO/v3vxd7bo49zRx3s+TA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:B2iCt72mcfw=:0gqFdzlfarZRBcKSTGIVPH
 S8fXMbI8c/oKhfJCqvPG77+vOig7kTpTRMop9JWO6bu7X9pL48sp8IkkVnJH4K5aH57hK3lyR
 cGEijjeKbs4ZEH1at4YavsoW5oLpTLML9e6MLJRbhdmdMsNs1VHK5ERclvdv1Fhe/Ic2ue751
 bfvrvK7cv7O0SK/EvrcKBJQQVsvE9TU8kryX0OxfXbOiK2Mb35omX6S4GLwEvKQRKhCF8zcs0
 UlLSqp+zjQHGhtcHhNT57+zdubdkN7+dz/CJJpiXSi7wdgTsKb51zWdqisWFo7ahcn9XfAC45
 w0daxpyesvPV+YM+dVQzq30brtsBmfHVR6RIop78P+SUXIzHtGNBIuGXZ0D0SHhWxpvohJMNe
 k0oEuuM+cdU0DzYYOgDc9Wgw//U6YNajBq/yi6TGJUPBitSpbiLy0BaMTZ8tDvgwmhsg40Lt1
 Im4WXqCdB/iKwQyrQIrYNXvMPG4MTrMB72VgbTgJuXkBoQFzzcSaVh89LcMbjia8V3k6/Do/s
 4KOUSC/mOlXZGfaCz/rz+O/2imjUX5vd0fj5NZgE/MFozV5UDdYZz/LJZuorQYPku618MjojE
 +++N4wQ1DTABsyUlMmKqX6q7B4D6SbJrBiDZspS1BLJNqqtimkkO7wlx5OXNcUzrrg2yy6Yar
 +fU2okOvE6vOXdAYIP11EEmi+aIUvjOFAXuspS1VVvgKp71US7vigWocmtmeVJ/PRTSJ4j6Gs
 4gLSLc+ldJIKBi9n+d34YksEEE+PJcBgaPm5OLmvsLU+If9MJHRC5560kY6cCGw5J2Y9GfAMo
 TyuoctLStimZFT74xiwgtfnHOj1xEFjoQi/X29XcLYIVLln5aMzWMkV9Gpv44U3C0bivK2kAt
 f13xX1I4mHR6B5Cql+RkjejMGtmrk6rfvpl3APIhSAgUmqr6p/ynRh2pWZlbp6e/rXJ+euFms
 9NQhNMInn6f9WqhjRxkpGHkqbFz59EVS4GHQDZIT8fRGnSymyiSfjXU/Xb6lGe/pSNwK0BCQD
 iSCzQbIU+Ew8F0tWmAqPzeymCRFSsyWHO33dnhLRAiU0q5CtW7NNpbd+oBlhFLFjwlqhAiq+0
 9Bbcx8hXdTnY3WH/dyxalFMjZJTduUI67lYoggwZ6VLI7UXCh7qEMMfIIUoAWHzrR+qrZwjMX
 BBGD4sFme1Mg7Dl6NiUVoOfRCVDzqgL8clhVXxQbBaXSmL/GB20FzsrFI9dZZL/rl+roDtYhV
 lBucA29XyX8TPoirlB52M0XFMD5kDreeVep7mGGSahxYQ5yR37WLg/1hN2So=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/nls.c
=E2=80=A6
> +int exfat_nls_cmp_uniname(struct super_block *sb, unsigned short *a,
> +		unsigned short *b)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < MAX_NAME_LENGTH; i++, a++, b++) {
> +		if (exfat_nls_upper(sb, *a) !=3D exfat_nls_upper(sb, *b))

Can it matter to compare run time characteristics with the following
code variant?

+	for (i =3D 0; i < MAX_NAME_LENGTH; i++) {
+		if (exfat_nls_upper(sb, a[i]) !=3D exfat_nls_upper(sb, b[i]))

Regards,
Markus
