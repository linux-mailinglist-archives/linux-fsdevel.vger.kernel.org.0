Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C1AFF969
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2019 13:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfKQMZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Nov 2019 07:25:48 -0500
Received: from mout.web.de ([212.227.17.11]:44451 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfKQMZs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Nov 2019 07:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573993532;
        bh=Uaf02feixTYH58bPy/IvlhJpWmoX4O1MB3LH819q8YM=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=YWuOGy1uKjzGyRbGcDUuzpwHskSm7tAZE/E0my4jt2vh7LHbpPFDOy7CJzTkzNcQE
         6Gz8zjp+1hE968MJjQoqQtJ53kRyW9L6k4cKoQn5bt8EZz295gzBLbENuldDA8njkC
         sLVV0hyM1Lw/1OHrTrmDZf7sRxDSCHRkNaykNGzg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.59.42]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lz3FM-1hk4df42jY-014CVV; Sun, 17
 Nov 2019 13:25:32 +0100
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <20191113081800.7672-2-namjae.jeon@samsung.com>
Subject: Re: [PATCH 01/13] exfat: add in-memory and on-disk structures and
 headers
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a4bd8e3e-fcdc-9739-5407-5345743fb0b9@web.de>
Date:   Sun, 17 Nov 2019 13:25:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191113081800.7672-2-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JnxXb72fPvuC8HBk7KXO7Pz8FM2NlMhMrYfjqhDdeVuAd2hnjMy
 rPbfZkRGwqwG473TPWq2SbA1BCa59ZecabZTATksBmuL8xhcOSKeCNVAzgZkNkvX+yM0HiR
 z9Max3A5mKcLOhBX8U3m8COC/NQlaw1T+Do0yNbCmDg0nYobjOzM3lRjez5Wo7fLSxhB544
 1WtOsU4HNUkeK7Qgc1Rlw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vt0cZUFUVek=:TaEbAu5EoJUxFXmtclNSXF
 MI+T9WKBCyaZLFs5emaG9gyF5pmPKgfeU7t/1gM5+OOmczYtXWPQTIAC2xYodfeNtyXMEasMU
 GxFSgSFU1slir9rS9RjEpRVHuhr5z++ohVcc7SXR3WOLk3hFXsshwKbbvo0cSECCsjVmlaSjE
 teOEQjSKOaIb0x25mrhUa5zhs9scb07sxIMsy1+r1w8F6pZpiZNzkfG7jDZoWg+39PT20mJo1
 7RUoqL3UZZafjdDMt8iw3mJdR6rJSc3lrwcyXnnevtWjww0AAj9nGdWupIjTdOsocyoW0UBPV
 /TyQebCkjQ3IjFckjf/sDPZKWbIIZSLmVqy+QhDdTdI0vgLnWjprSha33mxlSbwVwnLXb0T0F
 hD+AIQlt9Yfp0Yd2JP8Ifm8PbfxjQnKFmStmrrg+3gzJ1YPT+ouZ3VDjBRPfp4YFuBUlnCbYk
 R8MBeBa7Acx3+EINTi4CfFc5hPkAF3rDF3J89BlFFP35i/ZEqaXsVz2SgqthVUxcuTc1u3qjs
 sq2wbmJI1sramPFTjXaZFeM5SSCLufsugvyv5tbNRmu/6pa92V+lCxGd9xgDSv9Pluc29lkt7
 WKcxbNf8FyJcCCcFA4TQ8lwTiTCXLhpvGZwpNbWuCXQIIQaU5YQ49R6KkG7a6nbf9t6Rg9r+e
 SBX6uCs46pcj80k8gjc8TRBe2RNmAT7F0Y4gGvXIUjjW3jf8peSYp6VhMYmrF00YTcDjzJTEH
 uJGlBgSmGfieettU40yUA94nvlQMn2688FTDud/b/uRLEDkmEsQnvtQLIXCUX5ad13sLy0t/i
 T7knCAZILmc2uEGrpwLY9bgKK5ygll3wTYQb9bqROqWjM2i0lOvT1Z67HNG/PySGda8A7rBp9
 5FZcQlJBzJ8tG/enY2bjiaPw0GSe3z6H/DJ8vcStwIaeOWiJv+4bVsg2IgbDMPztFokYSrCQT
 VmwPe8R1Nn7LEKGiJxTzMuvurqXKtXVytEjBpS6LVT87i9XYsy2tq/3F1eIidd2uLaMFlGFzZ
 fPglIpGNOjAZmCL0Perex1OyZmBg9TRVGwgDE0kCoKs0RARWrsWLJjpAgCaXy54JnGWKa2JyA
 3fhWVlfnrCPGmmGeNojSvE6+DgSbKKnFidxvtaBhJXbF3Xwa+5xcqWKsec293dq2doAzY9Jq4
 awYITv/9KFPtuse71Mycnt2EL6ApWy155oU4RgTC33e1puTq2g4+LC7l+iWcZaDmEUN1J9foA
 FnOuhrQaDTtpbkZlAlFEe2MpJGRmd3Sn/qHAFDHb1/t4An7HiDBEBM13DqHQ=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/exfat_fs.h
> @@ -0,0 +1,533 @@
=E2=80=A6
> +/* time modes */
> +#define TM_CREATE		0
> +#define TM_MODIFY		1
=E2=80=A6

Will it be helpful to work with more enumerations (besides =E2=80=9Cexfat_=
error_mode=E2=80=9D)
at such places?

Regards,
Markus
