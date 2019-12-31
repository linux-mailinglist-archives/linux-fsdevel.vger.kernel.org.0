Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEAF312D8F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2019 14:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLaNZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Dec 2019 08:25:28 -0500
Received: from mout.web.de ([212.227.17.12]:42901 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfLaNZ1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Dec 2019 08:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1577798712;
        bh=470q3I825nYFxXPcP3MP9hzsbCX3q75kHxojLYycG3o=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=IKEbwOC+2WHnzi2KTszdTYJMCn91ixuTyj+w0Uu+2Wff+6Q117/rFXSuy55jYFFJX
         OtutirVFP2lXZOwe5XIy6+awnHyrk1NFJPJhklx8zWQmlGjAKzKv43qCcJWsYKzfYc
         5r9GD9TwByEsKcQ0MNkOKuRxYOYRnW727PJ80y0M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.105.164]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LlWCR-1jLtK31rBH-00bLwh; Tue, 31
 Dec 2019 14:25:12 +0100
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <20191220062419.23516-2-namjae.jeon@samsung.com>
Subject: Re: [PATCH v8 01/13] exfat: add in-memory and on-disk structures and
 headers
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <33715804-5d15-cd21-a885-3e892061161b@web.de>
Date:   Tue, 31 Dec 2019 14:25:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191220062419.23516-2-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6mynOxjQEKhVU+L7koUvJFS75Apb//Ce0dHCOW/QsGaLW14O41W
 1GOnvYs6C95jZB8uwNP5xyuMcQcTvJBIQ57qbAWg19kVCWRWNnptpOQh5JX/Vck/1eTlpIh
 IfTqKLXfkYOvcYlualbA1ZAMxd+Q7yZ84iIxVNHcsIfVKTVRjyXtvZ9my4hbLDGaEbF3pEi
 GMStfQ4PrffAWuHt3ZjAA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4pqTkmkJDr4=:6n8fQg5dHD4jgCgvEQC5ev
 +k6RTwn/1NBuOXKFzrkRRJs0Z10AH1z5c4Llk/jEV0KsUI4Z6FIAJOsxaFq1X6BKykqvc0UhX
 w+vLev1tMdgS87lbpOG8/YbwOMKxfIhoF7xbof/VpGHJmlwN6yVIknEhzyjH1OLxmI0kWj0OV
 xDtXb2hLg2QF5QrLQQyvzLe/z60mHBoSqRrf98Thiqm8BvZqAU0yzDSDKAX0/3AiUSfK8YSaa
 E72+YZ4VeImZoJb9ufLwGfHz1yVmILKOlJbppiHe2g5HoPx0XxXgozLNVsBqvn/BUX4WWijn7
 Gz7J++GbUr1uNeV3r0rmnSRKftYPf8ABU+MQopwSg/lDHOZhhEEzKo39tZxuMIHneaj4dS+7r
 gRXL1rULBLuDEAylH2zsWpEFmKlMaULSQw1fXZhq8Wx0s6J9zORl3Ght3+ah9Q1qVicIGsOlq
 d0BkoFLbdFIUu2kwff2wS/hpt99YDCnSaO0LZlSZnMAr+oX/KIBQhfk05uAmbR+4onlUuuaku
 lTnO0VwxNcRcZbpm/A7WbQoDAfeYRsNUA8kvMxCQBRn7f9oPTqrQPUCLENlY97KiD06exSea5
 vGykAn/LYPzQtPlURa/baEiJEChPmPzSkT5zFh4UwMx8oPBJoM2tzksVKuRMwcSHDovR5Kuko
 c1tvOcW5kWnFFp2FFC0BEsbUqru9h25W5qtztWTvNtuIbkhu+BkAzgBp1uz+KJVSAvVPDp8iH
 v1htlHof8uB/l4kCgTToSTg6LGKku95pjGkzIxyiOoO08RjohsMcMLRU0SD3XuYIJyo31oHEA
 ovFUoRklKZuK4UWe0vGVaaVssEruVU/Fok/hsI8WfjeRqzQV9jZcLNsGAA1ctZW0h53NeQzsh
 KyMytWC/in831glPeZtTI7pOBUHjd+EE77Gcq2B8Iug2gGOBu07orpF8NYoqIURqoVBi0TIyD
 oMWrQSJ4MH1UZBJM/4M2CUGt7COrem6SWEMBvvPB845SyOfard5s2Sshi0SdLhO85I+olkKqq
 8aKVbsr/wVYrFu1z8Wbn3zit53j7s9qUZ/nlYrBehbD4wnD43r0ctIDK6thVPEjc52fQG7nKu
 6SkH11T12pTZ/4LAN6CVMj4iKiNYJAD5/ogxnxM7+cVFHK/WMvqUth2jMcTErjeXLTOWbsb7W
 e9HKnsFdGh0LSAj2iuwhIP27xuPG3axOOWgV/N/7X68mth1QlCQ2Aru6jtniip7UjdhxJQ4/H
 mbERSM8rUoU5XwoK+1BuI2ZB1bQSRhyZpbE5ucMvTB27WWMoVQGKoXSbzIFI=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/exfat_fs.h
=E2=80=A6
> +/* type values */

Will the conversion of the specification =E2=80=9C#define TYPE_=E2=80=A6=
=E2=80=9D into enumerations
get any further software development attention?

Regards,
Markus
