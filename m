Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE7B1DFD92
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 May 2020 09:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgEXHq4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 May 2020 03:46:56 -0400
Received: from mout.web.de ([217.72.192.78]:40719 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgEXHqz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 May 2020 03:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590306411;
        bh=RVx2ZpfrKwAQMz1Fvlh8UKxMRyjqGc9WECkJRsumVFg=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=f+asM5zM/k+m7lwzW0OPZH1NUkj8qEtiv6oVzxuXxMTVdj4GQsVe/uHzcjW6Hb/zH
         j7gdKzEM+6kXwgAjuB6ymE2P8YYCmfejk1rIeqTKe1cG+Q4dvvHGjrA93nrHakZCJY
         E/B/dQ1ySGbzCqesZWrQdgT0ceD9+oBJfsuG7J4Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.187.46]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXGOC-1jWlZl11lW-00YsIH; Sun, 24
 May 2020 09:46:51 +0200
To:     Kaitao Cheng <pilgrimtao@gmail.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH] proc/fd: Remove the initialization of variables in
 seq_show()
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
Message-ID: <e218bc34-b8cf-cf0d-aaf1-e1f259d29f7c@web.de>
Date:   Sun, 24 May 2020 09:46:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DkfpQb1eUe7ib/LnNNAnPf2vk0nC57Dnmw1w3PAvhXKKlO4u/HF
 n7j6Ybmf8+OfYpII9QlGJCt22NHNywJBWSQd56nwdINTsSNc1eSTzfzJ4A/cf04tU7bkAuX
 GXKVbpeAXkY+AHPrUYQAksVb6fvp+JXBTFomMLUrZ/kKjR/6zEcsesdEbTI4hTtbkBJb1u/
 6cR7hg1KD+/5YAcdC5lIg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aJN1yDCRtTE=:c5iEpkAwjn6hFw1GtWBYae
 FDUZDxbHnKWqV9Ph109r1QFs+cAZycSwlNTEZrBReHwUU2ghklwtrksCXJs6rpwB5vx+C1Tlv
 nNUCyPrRzYjcrWJamHKwEhWJJeFZMFQS8AaIUv8TWc+AVIrBW5/Kgi2cgO47lz5Hy3D3KKnU/
 BOPLOfKuK/BtP1/dq1NeurugQeC31d14AQEKudvqPnmTEog7hUWAhHLPYFy8R0XFmSphXliLs
 s9MTEbU719vKeaB7OYV3ubu7W3oJZ5dZtuWxndGjMEfhXbWex6NEsfMwbsylPfpbVOIPd3pJI
 wod/DAWsMEb45FxoRK/xf65PFmhK2bFwr3PBiiMn92WqUPFgUGs7hzPBmzE9yBFs+O3jd6oZ6
 8wYHPb83WWee8Bxr/tZgI/v83aOhJ9afoOjkP/1fBJ/NPDgk6iCzYtuvZPHLyJXdgUq3rUItn
 MpDgi4Lvx+lgvtNt79YLFjv10KNnhFP6T4dxNfmVAFMjknNiJU0EZETGhyjb4xb9G2crU7XUH
 8EtEV8eABTX7WFekvmZajJ7wPEvBE/98NoSDqw6Kap1IJkHUCo6aNoABNIer05P7GFiVAUm1O
 QregnxSGN538HdwKzbxSvWgiM9RYCEx5wd30BRugEVrQsRUcPhUdznpxeAht3dnWu1OXQSPK8
 BSmCEvTH09LoxSNPD+w7jPDYKumOHH/JgeJmMp//EIgPlZIIB/YhPSPtF6XR4rXugfERT3s3m
 EoTpqEVOpZb0/YDzZx1fi+o4H62ufCYytUjSLb02W7jbMQka5t5je40Uy9cqaB58Gpd7AQ9qA
 XdJpsieXlWxeJo97c9IfTFLpSq1yvEEkJ2fFmuMZlUTHUt4iblOKncjmJ5Iu1KCOVxksKMmUf
 WwonzHpMsvvYXbyH2SFRahAYpg+Wz0arg0HprbSXA2Rx9sioXkFAuiz0JM6NzrDSHHJRQ4LsT
 1l4eKYlukL1Knn9vl6/bLbHSR3JDJFjlOWidcq9YoAv9NcYw6olkV6xtpnRA+TdFFrU/K71S6
 sxZfW2AlKF+U+TH68S5m8d0+nF3aifR0V+yZuiA0EK2kxRXzRiD3vSO9U20aEX6ZcavOdOpKH
 HvOgJRLWFrM7Wt+Y7WbYPxyTnOuJn3DKaR3E2eeMuJh6qrn651BJXomuyZtLeoVJL0zhV4ycm
 uYUA7e3hBI6g2OQry/S16F/xPY6wpC4O6nvIoGQWr5VSD23YqOyIfBRca3O34xneydY17Qnj+
 TpBISmZ6vstFTHySq
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> The variables{files, file} will definitely be assigned,

I find an other specification nicer for these identifiers.


> so we don't need to initialize them.

I suggest to recheck programming concerns around the handling
of the null pointer for the variable =E2=80=9Cfile=E2=80=9D.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs=
/proc/fd.c?id=3Dcaffb99b6929f41a69edbb5aef3a359bf45f3315#n20
https://elixir.bootlin.com/linux/v5.7-rc6/source/fs/proc/fd.c#L20

Will another imperative wording be preferred for the change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3Dcaffb99b6929f41a69edbb5aef=
3a359bf45f3315#n151

Regards,
Markus
