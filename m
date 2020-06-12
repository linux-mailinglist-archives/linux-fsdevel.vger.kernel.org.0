Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C951F7D11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 20:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgFLSnw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 14:43:52 -0400
Received: from mout.web.de ([212.227.17.11]:55365 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgFLSnw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 14:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591987423;
        bh=lxBdK8gHsvSK/Iu8IS9YbyfayhOVqmSbI4Q8j7/FpGc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SWHnAJpXvosrEc18uAXXoWBWvZKIhw7lRJpDr2go6V4p24DyVCgBjNRBq2G6damXK
         XCfdU5L4qM8GriCh63xb3YSUnv+8D0PdqpGxpuzWwc2c8ipmbnSS6mpnMryqAFA3fy
         5fgyknD/a6XuJdyXUhJd44VMlCVALkdmq/QQHWoA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.95.40]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOUxo-1jZIuH119q-00Q6rc; Fri, 12
 Jun 2020 20:43:43 +0200
Subject: Re: [v2] proc/fd: Remove unnecessary variable initialisations in
 seq_show()
To:     Matthew Wilcox <willy@infradead.org>,
        Kaitao Cheng <pilgrimtao@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <20200612160946.21187-1-pilgrimtao@gmail.com>
 <7fdada40-370d-37b3-3aab-bfbedaa1804f@web.de>
 <20200612170033.GF8681@bombadil.infradead.org>
 <80794080-138f-d015-39df-36832e9ab5d4@web.de>
 <20200612170431.GG8681@bombadil.infradead.org>
 <cd8f10b2-ffbd-e10f-4921-82d75d1760f4@web.de>
 <20200612182811.GH8681@bombadil.infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d3d13ca7-754d-cf52-8f2c-9b82b8cc301f@web.de>
Date:   Fri, 12 Jun 2020 20:43:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612182811.GH8681@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DCr2orYd8VJsx4WGTioBEp06aSWlx8veXC8sVp6/zogsUPECx93
 gEQ6E3StyH6xXh0a4P9aeUvrvSTfB8IYKfufCFnvyowd465hKIH7Nnfa3e2zJ5UMEnsSYxr
 xS010oaacgMxiJ75aAvyV1a6fC0uEnAv6LqoKif8wDXlPMQtjE5A4zFxIYRPIT/4hvhH63o
 E54Ey9XcdHnAsRNX1jk6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wG3z8PKKMvM=:A807e++Bv7MWcg01YBSE8w
 pzPfETSjVjZhU42e7WrCdtBE5qmHbQEMFroYdks9boBwKCDrUK836Z1Dw5ZvUrd1GfGCPuIFI
 OTiqP8Z/bs8SkQD3puVTGSr6aE7CVhjB9ykfMfTRDMNP1TxlOi/NFMj4kO+9W/IZ+7bKdqOZa
 yEnX1IbKxJsP0j/Vmfu8HSNa86G265KOQ8Dzkto3CQTxI2oYB/tZDnF41/KJgQrLqJSTNh+0M
 vDd9bDK5LEHV2mN40F1QV7ZIZswIzgDTLTjhsjIyvI6kAaufhEG2AD2MGq4aS5JsMvOMNvsvf
 gqLxyoJETARv8KMHl6XVcyuBZFyYfZe6MuJH8HGPT70NSWePMqAgejAEGEj47DtLkdnUhUN8j
 Rggz2/rgMl9BXLy1K0STpGOsWCdKNp5G2U/OJQLqdQlZxdegwyIoJHhuBPGcjoyDf3GpqODuE
 p+QkFOiUXeEWZr/d08eVs+0GRmR/8jVrd7y70ynEgi5TvJf092GlhmQgqmWq0JvlpiB+zTdjp
 Drbp5MOyXa4KkczLQ5Qi/HRju2tqPvD15SJYpKQ0iQCRBgaECXbb+0ssDCam1dUmq9tIqvUAB
 NMqo4lZTTPoRDb+tHEDjR5ZHYRh0FzdsHDj1H6rvrDBWvj/n49PnryaBd9m4cJNgtfr/ek5CD
 C41nyyPG377Y0PEduiT/EFXX6/Wmly5dCckBG6GTqWG/cwq+N8LOcAkVqYMsMUmxDaMz/jpvT
 wmlh/oQk5kZknR7ahENbWgsVnALeZFyxDbuM2QDnZvKfHhoOEsb7O/Km7IlW10WUQTJyo5UDZ
 5zCi/k4I83uTTRnvgZb8/N7qFSUrpzYOh0It4vCJCYjABWq+1J+GBi9f8Db3BTsF0HR2tD6m8
 87fuLNjFXs0NP1EnWLhv4vEOo8+HVUYYeGcRjD/zTwjs0Qx18SiGBS8HO6PfQIg404rKfQnrh
 cp6BGXl/+DkqyzINIL67fSN4A6Hkfm8tKI6zDjFN83C/kOLq0I3+8FnM4qvzWDpu/47XzTYNK
 Sr+nd6uC/sm9x6rqi7UoVcvr6GTn/r9cQmPlZ5ssDD9T6iLnP9t+QUuzSq5kqHabx67Rz76Ux
 97uKVIQZuD6gJgxhxIwRxmgb4cmudYZo9mak0KyTeNypgUXJfJjrG+LC3aKmXVXanQ9ztG+eN
 OTwi6I84CBz2aF1+CaC3dA0u/hoWXOzbMS8SQIIt2P8s23O0FIGhvhwf47WcepL8e/s5dB0vq
 H5ro5PZ4cWPs+cyy6
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> The presented suggestions trigger different views by involved contribut=
ors.
>
> Most of the views I've heard are "Markus, go away".
> Do you not hear these views?

I notice also this kind of feedback.
The clarification is still evolving for these concerns and communication d=
ifficulties.

I suggest to take another look at published software development activitie=
s.


>> In which directions can the desired clarification evolve?
>
> You could try communicating in a way that the rest of us do.

I got also used to some communication styles.
I am curious to find the differences out which hinder to achieve a better
common understanding.


> For example, instead of saying something weird about "collateral evoluti=
on"
> you could say "I think there's a similar bug here".

* Why do you repeat this topic here?

* Do try to distract from implementation details which were pointed out
  by two developers for this patch?


>> How do you think about further function design alternatives?
>
> Could you repeat that in German?  I don't know what you mean.

I imagine that you could know affected software aspects better.

Regards,
Markus
