Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7AD1E90E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 13:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgE3LlP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 May 2020 07:41:15 -0400
Received: from mout.web.de ([212.227.15.14]:57647 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbgE3LlO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 May 2020 07:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590838856;
        bh=wx9yY0xCg1I2QE9+DW1tUFqrPBN+57R1T71xo/th0lc=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=GOr/8voINzaomvO7hkU1Ayqwsl3BZ860Dx4HOegB8ZiDE8SHKKWKTzFwJedP6RD1a
         qSfxRr4ODeuJ4CmrYv3u1CoALpuYRql/9bZ14Ro+ypckjgOx4/KDp8UjV54Jr+VRmH
         OP5JKS12TsQWtE6pZ6tjWwLkHiv22oyDmn3Seh2M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.149.250]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MHdwC-1jiIi40OJI-003Iwr; Sat, 30
 May 2020 13:40:56 +0200
To:     Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Ian Kent <raven@themaw.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] checkpatch/coding-style: Allow 100 column lines
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a45357fe-6570-ef20-ed0e-494cdf7a6f1d@web.de>
Date:   Sat, 30 May 2020 13:40:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S+6BfI3Pe/izDw3FK2rwTurnJjSVrwOilQz4gyhLQkseKvWNrYA
 A0PrKZM5t8b49igU9ThGutPSkPpEoo9a7ia4XbWPEscrPkIWSJYG/d2NGvwlK+kK1qavs9x
 OYFQLHxc6+t4pasPs6M4x+vGPVsEvlIkvJ+vkJv/5yPNOnRt5gtduNMimHzcsece/P368et
 nAZSFcMQGcLRcuOt29mdg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:R79Xzg7gD5Q=:G7rsiSe6NXtl+/4O788YH8
 cEf9Y/M4VFipfKhOVh8ySZOQZVZAOrWQJ0all1XuimHtiTYEYprsVRgc3AjraHJj5YfLQy/OE
 KCgOyaCT0qBq4BJ6n0MUjQqYMYAapKKUnAkL95GEk5GDL8L23N9dP6OcoSIhutE/Xck4/7If3
 5ZPbYC0HpYilR0s+pGmWaghNtvtk6lWlUbHACnyEdwxXWwx4CssEtYqTlwuwpyV5EA2gp7iIW
 ozooQoihKBf13fN4qlpSwIWyDODgve/VRt/E9MriokQS3zqfmfjzXw1s7oyYyfLH3fQqYDRGn
 BpmG7xTG+XMfduvLqyviy+rz0dRq0Q1gLpX6qSoIsX5oJcA0WXCkhdSoVzs1rRh2Oy1jyOrlU
 gmcdzDfH9r0BV+dPI+JC8YGT1Kbc64Hwd1eqkBNj0+MetpsLMizjaQdMwWStRTmyVo2lwFlYR
 kkUScuUvgAmK1i8nyub8LW8PYiUclohwx6yYTA6pdCxopTUuGVsxuvYCFqiFSooqFhonR7uik
 LVW/3Gazve0YgY54+1lOCaZ2VZ6hvGAccxqcLsm67kupy+YlxUukuk/Q2X8365i6EIAxvTGBD
 NbL15ypNzpL5FqTZDz/dq8u6dst1jQMV7CrFzf9s9H4GmRBDfvZ2OUxMQxKxykVUOYfbupR0A
 Z/GcXVx1hm4OSYYrgeyUNUpHpsHkG3E+8CNG8MzXfTg+KSDIQzmMdmiOBdS8vyGCQWBCc5e3Y
 AjA14d1Db9XyXT2v5Ww+OrmLvFEN7EnX9l7SOgt2jXDLXb/oj5m0ErGd1Pxv/IH28zdmewsXW
 GkrpGEXwCzvrd7oWAYjxFOnIMAC4YBIH2m0QIkrzS6nd+geuz/rkLN2HB/CLUqNfz+0BuqyZ8
 QoRnvDA869JwwWMEj1oW8BQFSR4vWf8Lz/DvugC8viIVB7UnRo3mfkkoMFSDN/rEirHz8QWEi
 /f6nGPPvE8wnF5oiUER1b0ybsiljo+/60dVXJr7XQ5/LuAm7VZJx4SoVeHvtbF4AyDCIG5Dqm
 AYqJNajO88xH4y0GpGqWQmvNZE3VFZ8H4Lii9E87kovrKq12cEDDxnkx6VrLM/MuUYu8MTEM2
 KdqXWETqU0+bY599z5qb161f8SEc+Se5k0Mg30oC5HrVXDbLWp4qvcO3vQhrzbos6dw0CzRr2
 9/TRxEU90rOs59BvE+SQDS3FycaFc06Kz+Vr5E8f+5BNwsGLU8D3ygRbEVqfTp8hda5WC7E4G
 perbZ1v39CpLqKflc
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Change the maximum allowed line length to 100 from 80.
>
> Miscellanea:
>
> o to avoid unnecessary whitespace changes in files,
>   checkpatch will no longer emit a warning about line length
>   when scanning files unless --strict is also used
> o Add a bit to coding-style about alignment to open parenthesis

I suggest to convert this patch into a patch series with three update step=
s.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D86852175b016f0c6873dcbc24b=
93d12b7b246612#n138


=E2=80=A6
> +++ b/Documentation/process/coding-style.rst
> @@ -84,15 +84,22 @@ =E2=80=A6
=E2=80=A6
> +=E2=80=A6 and are
> +are placed =E2=80=A6

Please avoid a word duplication here.


> +=E2=80=A6 to a function open parenthesis.

Wording alternatives:

+is to align descendants to an open parenthesis of a function call.


> +These same rules are =E2=80=A6

+The same rules are applied to function headers with a long argument list.


Regards,
Markus
