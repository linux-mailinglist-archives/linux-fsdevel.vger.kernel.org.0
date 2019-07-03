Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A33605E26B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 13:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfGCLBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 07:01:40 -0400
Received: from mout.web.de ([212.227.17.11]:52001 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfGCLBj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562151697;
        bh=7C/NrUBsajY3HikFKE3ESNwy1N7be5V4OIMGJXMzAZo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AMT5iW4QJ1a8KIqYjKZoIbPqIvogBhxP+dWdC4Zr7Er9Sd9HmDm4aS/GtcGwDd5re
         vq3tz4nLectsQgzE+LZp9r4DOI5OSvYptcjigECGopTi5WKkUX/c0v5RQvQPXGI2EC
         xB6XGVMS4YGLO1yyiPdf5rTmsWpCF5i50n7L52no=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.189.108]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MV4bp-1i1iXc2CUP-00YPRG; Wed, 03
 Jul 2019 13:01:37 +0200
Subject: Re: fs/seq_file: Replace a seq_printf() call by seq_puts() in
 seq_hex_dump()
To:     Enrico Weigelt <lkml@metux.net>, linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <8c295901-cdbd-a4a2-f23f-f63a58330f20@web.de>
 <10744a9b-1c15-1581-8422-bbbf995c0da3@metux.net>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f62fdb13-59b7-4e5d-b64a-37b96b5c0125@web.de>
Date:   Wed, 3 Jul 2019 13:01:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <10744a9b-1c15-1581-8422-bbbf995c0da3@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:N003hvYwQN1uWLMrMfUW4raVikLZDfUNVcDl9uEOKu1vB5wrcoK
 5VIEMUYS34GpXIficw0cjEVujeGQJoKIVyxtcLw97q2hDcZa9z8sLizvtAGjOnne2i2RjcQ
 weyEGiftOv8ttv6orNtQ65Xk6PEOLiFP7TyBdh4uOL6fH0DhGRHWukONpo9LDL0ekPGdBAD
 gZX9PLHych+wRP7mXoNAw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ncFuTUxlYSc=:H19U2kmrDjNvssYDeae4ng
 ljPPccxY4QwN8nz0rFoUgjqGCqaSY3ZLb+d99Ze2Oh9zvNGNhBtPkrscwrGTyhulbw7As2kZm
 RiHYVnSA6NHvK5eC/T4rpEmKr45oLd1S9z0nWg5Xb47DjQmHNnR/aq6e2Sbh/d3NAcKFcf15r
 VmELRvOVa4xMEbyyAg4kpx6XAuf7iRQbj1sDKj5M8rf9t8tfEkQWjzSme+Lwvi/A5hKB3EmYx
 XB/zIHMgi9WM6GW7QIhWc92q9u+bVK2Q7VzI45cY4phwPVNGycmKSrgiSzdhg61AcxSHpe6K2
 53AVMM9KmEY8Ca02L4299GtBMqKsn6j7hj+kOjYq3gDE6MyhMg+mMVejqzWu3N8YauXgMWJbJ
 MOc5hA/Iyr9TE7+LdChPvgvNtvW9oLo8UUbUnIXUrLzCHOLnht3Tsj21PMUi4yl/6ISgguIG9
 KD/FlV3cl3UuEpA0bi+D8HNOH2zbd1c/bqJiVMbFXfKGHK56JaiTDGjiHqzU21Uz8/5E0aaxn
 WE11n0CbrHK53EY+2xzPE0iQC7YeZ4Q3NC5Ex1bO4a9Nrp1Ypkpi1IE2KSvH4/n0k1aUavf0d
 QR8qmK7C0raFMo8NNSK08CsFQlhttjf8pNAI2kbMjjcVfOGbVjdzP5ez9tazaMnlru2sPpGLJ
 JZJl289I2mmii/SCZvlQ0vTkOL37RzkQKDLeGS1T3ipT7NKdNyzSuPVlIycBM5g4YpjcqaFQL
 MZKoF76s0tm0vpi0hKb4hRYAowXVsCCbW1mGW76Px9gzaHLe3LAoRmiCNUTN4mwGasXbzKs0t
 N270kgM2DUlcynhFppHESRx3hdxo+9yMI8pRhsoo54TasiZdqAk0pdBIwf9vgtxCQINjv4R+D
 5AjYB3yndV217zSrzm1TbIC9zxxQqPsgacS8FM7InH08komn2wOW/6lFZFwdDFb0gvMw9sWYQ
 0rHGrAbsaHCBBvKkvmw4QzOkRPnvDQ+y5Tx9VpYuND8JCMkjGIDn36MMXJghy/XLd3WIVr/1D
 Wd908HeABb5UYF9M+nYMSLMz0VpnxcLMfYoSIkymJkb7MC1MIIhF/43Sdg+JXGSa7jAC52CR1
 IC7bz1NZJ/5e0fwnxxDFO4hxEery1Ev9ntS
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Looks good,

Thanks for your feedback.


> but have you checked whether "m" could ever be NULL

I wonder about this enquiry.

This function parameter should be valid as usual.
Thus it should not be a null pointer under ordinary conditions.


> and whether seq_puts() has a check for that ?

These output functions do not provide an explicit sanity check for their first parameter
so far.

Regards,
Markus
