Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB7AE12D8AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2019 14:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfLaNAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Dec 2019 08:00:43 -0500
Received: from mout.web.de ([212.227.17.11]:48617 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfLaNAn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Dec 2019 08:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1577797228;
        bh=E2HgD9nBbFjio41NEe6vaMsromNwNlpF21WUg2UIpOk=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=k8le8wC+e9+ioEkmdyavFxO2vEvgUlD5UPoSp4Z6p9vqe6h7waTHTjfTZsupcbnKZ
         s/myuKB6KhCVJN8/HRLEyzeJsnLBfHxj9TNbJkIvd5DWz4X2dnl1nMuphgYObcVgQx
         /+EUZrtMv0sZKAgacXGtxcUqEbf9oG0JyBMF6wUY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.105.164]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Md4l4-1j3Fks0dqE-00IAuS; Tue, 31
 Dec 2019 14:00:28 +0100
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
Subject: Re: [PATCH v8 00/13] add the latest exfat driver
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
Message-ID: <6adef0a3-8bb7-1ac4-0891-4d56edfa9df8@web.de>
Date:   Tue, 31 Dec 2019 14:00:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191220062419.23516-1-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:A2FRB0BAbHQIJIr7lMqGP2UIMxkyd7uK+JPSSyjzadAqqqjLcnz
 Td1/tsF2l3eb/GivrDYKzOploXl6pBk5jKnF1R7kBhZ5H3RQqs56TRS4+mfudSmrXLFk34W
 1NRg0aZ9ACqmPCR/6Wih9S2qGHY8df9QUrUl1LYneq+jX7oGONpZdhvK54VZ+VimD8Dqk/0
 PITT1xgYhEQkNPVzgfvMQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LdhRFhqyDkQ=:v7udlbs+Tb0d+YBYrtK5C8
 Ar6KmLw085wR8bDSta7HKCWQpU4xCOrpWV8YohB8zxELQadXTOCWkOSbcxXQmo4I3Ulp9tzGY
 w2USdlXYBwWAvv+TPMs9QCVps4nTSTLFY4sEIUi7ZGSfNyjKEGNvE1wwmNZfGKVHlzo1s2tls
 OrlB1wtQJG0N3Vt0bx4FApkL2aMvnYfqUXwPdwbkXThzjTV0WkwMW0t4buuNhnfKXxVEmxMPP
 MSb8qn0xRg9cGgybeAcLLircHrB3tfQWYcV04uvNrE0iaLZ+Y6hOKokdQP+LZze2vaoMCqO+2
 NCSKbVy3Ro7XO3vwoS0Riv5ogt4RFbMC1EWFjYPnp34aAmn39ahb7c4nN/8dOyNPWmj2ZvkEg
 34MlFZC0hEm6cne4/oCrfIvEe0uxp3327OKCGtoR6wzTCqdI3/GA+XLQR8pLVMsnEdhbFhmA0
 RS5aumIFsiIHJBW9rTHIKqTBkIEg/8bAYtKpjeBxkIZ7pBSf4K7IDNPOnc7OXMMRvD1vIdtB5
 k2HOZ8CO2LO8+JXU7r/a+RwGUhOioldKDsPbGll8m81Fqsu5azisXx3m2+xYqXUN1KFvK6eEy
 vIo3v693nCvjl/fkHMa+cM+wf7w+hZ0muk4IW/XdBbnfKF7WM2FQdnUd3DEfI/9vFuNePVNvl
 Sgek1/ey92C66Bj3QkdRaZDvCWYSgoB182NpWxyRPxzbpnYflBLfAUsaHL1TZJshNf/aMeu6z
 ik37Ruc+e+Y8ny96xoGg7m0rNxIJN7XyHEKeIZUBwP0PNdt2kmz2ym7mBB04HhYVhup2UBMWh
 f5ognVKgIfgzMZI1jwOivG3B1BHz+TE32XFa8wRrde52iDVVn90wlI+dmj68fLpna64SBR0OD
 w9OGjDOlr61SpUfstHPuWb1Oy02SnEY719e9JKHbqm1kXAbJlPHHpB/Tt1Grj0FM1Goe+X+zk
 /wulsh9FR9vskglRlUYpy29be1LY6cM5dfmig5Olv1/RD6HK6lIwvUiWKJGBB7Z2ZTTTnaQ4i
 IXwrKK8fSUrVOh49PL3wLxKhSCZ79pTJVKGRP9f3lov65hF9Yq0raIhsMcsz7kvqzAT/brHO/
 MXBoMdXv1ciCd8CbmGUAC0vqR3Jtedgvz95FEe0Viav2Zx6BPLrNJ/A46bz7B4odgidjOAOSs
 vA+iavcXj6nlxfDW4MS2+lVCtOTylTAgciqcGYdfV2MTPMMpsj64yZbJL711H2JfC82uBIBS7
 73vCT24G5dMCL5mwzt0BaXzNLYQBEJ8dFvpvMn6vmtBw0Id/F+raM8MK9Cc4=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> We plan to treat this version as the future upstream for the code base
> once merged, and all new features and bug fixes will go upstream first.

Another constructive feedback would have been nice for this question:
Would you like to offer and integrate any test cases?

Regards,
Markus
