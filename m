Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1923F1F7C08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 19:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgFLREG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 13:04:06 -0400
Received: from mout.web.de ([212.227.17.11]:53161 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbgFLRED (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 13:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591981431;
        bh=YSEcAwOr387X5HBmVwv6BhS4b5bKKB88hiXcZp0ZjIY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Bem2VpT4SAL8WPc7TCdBlS8RKB1muu1WhG0QO0x9xUpDHmQec+vtW73pGUdcYrd0N
         FtboUu/vN9Ptg4rX8dn2XhGW3DRs44hK7wDIla1jDJfCEoeazFpnBDWgkF8eZpZl/3
         m34Ekqxy+oTj9P//Wjpy3YlmZOtldQ1zFuJqFOsg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.95.40]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIya8-1jTvAb0cuY-00KO5J; Fri, 12
 Jun 2020 19:03:51 +0200
Subject: Re: [PATCH v2] proc/fd: Remove unnecessary variable initialisations
 in seq_show()
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
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <80794080-138f-d015-39df-36832e9ab5d4@web.de>
Date:   Fri, 12 Jun 2020 19:03:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612170033.GF8681@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FCSzmPXvf2NP54FkrjfIIyRWoschM7Gc1pUP1XCU0xxdOIgMUV6
 nvR9G0wP7Z8qKntwDt2xN1RnMaorSSd2Lb5qmFi6di1CJtO3244U6/Cg1nIcUHUW+UDMue/
 KWf88ApBohFDj8XCdBqYu/28dZblqCJg21zEzoWbvTfvas9Q3iBLPQwmuGZ0FrqrkBnac2D
 9j9lVdaDSzvmbsoE/rFmg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dfTCC8nZwgg=:R8v5BJtf3vaTcVbAgYo9ks
 UK+BFc0vH2lYZs15qUnkms3jySMLzAPWU910l0MMQdrt/2KD0Ab7us2QEeMM0BocVSvSiR/Sc
 hJWxY6AJC64fGmos59P3kjJs4p4NNl7+3oO+2lSLLj85xe3zoAVN3MCDSEwhVQVP0pP0HxmfE
 WfVN6adAbLHF/epzbQOzWAZCBArhNgZTdxIpt+ZOszOIAGBeU6EY9ubxXjjRQyC47ZyqkjjuU
 1S6WZ5oGgJNNqptB+nbb246Ku0WM2t+nT/2nv+ELICx5FODtWvnR/6FlBwc7cg6KPqxK5rXr4
 AEOX7Z7N56hVCMMxbXzTuHUKsUyeGjn8owsVTirDE/CSKSPqmVzbfcOOZvPDLyqw2R9Fpf8Tk
 Jk4mjQjMAw3GYSN/p9I6ku0/8XfYIOiGbDVSFEe1GF4m1M+ReBpsNkju37TlwS/Wn1R5lX97u
 E6b2I9wvaLoIsUu01/RzpcfSQYwfDavK3THGE+Z1qekbehf2gVwBDuJJC/Uf8O+i4xYEAG+tA
 afj3YjZtYv/xuq5f1pX4pouAnWHYJbqSp/f9LnAScBC8hjOUQTbyW37b9ITvqnocj8F9xUCA0
 urXQGa8x+z99W4Dj91dKK8Czb5W7/isbCh2CdYPcvsHOTlPuM9CliMnau0miiIKwjm5ORiCBn
 wYJVULc7o8ruq/gmkmG/3aIBJ2Mbb1oK2Ds6UwhTW/ccWRUcKLskeSMI6a1RC0Dq/so1OldYW
 bNEaI+2+guTit9wWWdzfPpdNDYVBL2D29Sypfzn8UDmATQL+cAB4Zpl3Ph7UZJmkvYzcFDCYH
 W/iYsdEyv0lqUFnXEdEpV0yJIyFkov8w/BEqP9A7QSmWdrffVRRPEOKNkOkTQWGdSXgw6X+cv
 E69lLWRJJG6laeyfTtF0d3iftmPw/znZU9Y/eNzcABFHsN2smqMnCrmtZK9PJybbjNgqOFoKe
 dVkEdK+4bStQHoE2teKX22bA9086MbPi1jBPKV9FiqbyN4kII0MvoyABHtdrW9lhMhwlkH9BD
 Gh8M6QPLXd0y4vvMgoPCJdTtMFH8f+3V71lru+qBfJPIrKjuTTts9KiT7DIbZn3oLjGW9v4YW
 +xau7ONHNJRPgNzTQ2UGomzb0Z4zawoYHAd2VYjIqE09auLU97u+VuRGIXmeplfdiR733ak0G
 yknp7Ik8Hu/Nty8JrRdoSED5r/Jls5ReFHE746D646YN+f9jE12oJa2L2GVdsqg47HG50eCHC
 dHyiuP/sPfhxGjBZs
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>> 'files' will be immediately reassigned. 'f_flags' and 'file' will be
>>> overwritten in the if{} or seq_show() directly exits with an error.
>>> so we don't need to consume CPU resources to initialize them.
>>
>> I suggest to improve also this change description.
>>
>> * Should the mentioned identifiers refer to variables?
>>
>> * Will another imperative wording be preferred?
>>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/process/submitting-patches.rst?id=3Db791d1bdf9212d944d749=
a5c7ff6febdba241771#n151
>>
>> * I propose to extend the patch a bit more.
>>   How do you think about to convert the initialisation for the variable=
 =E2=80=9Cret=E2=80=9D
>>   also into a later assignment?
>
> Please stop commenting on people's changelogs.  You add no value.

Would you like to clarify concrete software development ideas?

Regards,
Markus
