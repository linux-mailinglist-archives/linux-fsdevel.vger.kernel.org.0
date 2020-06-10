Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35EE1F5121
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 11:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgFJJ2c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 05:28:32 -0400
Received: from mout.web.de ([212.227.17.11]:58825 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbgFJJ2b (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591781280;
        bh=oezWqI7HL3i+z/22SIzrsqLgJ1K5t78e47/mcvcy2BE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=cjyUeV+7FyLH0Y/wiZb6cR98CgRwS0Dt7W+1cvv7bm80Ha0xXJuOEF0FDzgpXhdtK
         2rUokqvd6HnueaqL5hWqWbgVp+guF1Jxr6xMI+hvoyHfFROJWKYW4U0TXAQSa0V+tv
         M2RVYovDOtc9kE/SGHqVA77/93BXPxEOzjd7d75w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.155.16]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNOV6-1jYauw39Hm-00P0cj; Wed, 10
 Jun 2020 11:28:00 +0200
Subject: Re: exfat: Improving exception handling in two functions
From:   Markus Elfring <Markus.Elfring@web.de>
To:     linux-fsdevel@vger.kernel.org,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Tetsuhiro Kohada <kohada.t2@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
References: <9b9272fb-b265-010b-0696-4c0579abd841@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <208cba7b-e535-c8e0-5ac7-f15170117a7f@web.de>
Date:   Wed, 10 Jun 2020 11:27:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <9b9272fb-b265-010b-0696-4c0579abd841@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WqE5Z56HN/jah4MONpHubuHITUhC9Q6yoPvJ5lo2AbwKKwmWwza
 Kj5LyaPbiMoo7zt1cHnW3/TuRsQU1dmkbgU0cB4sUPfqMWmZSiUDE3aA8lBrlxuvWc9lGyU
 FJfJkPRFn09mloBNh7lLUoZM2TZBG7m0jPBXXUsdFrsLTYgINwFPru1TvcoRU0at74Y3vKU
 bAnAIG7quO4BN4GMyoVLw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vPBeZXUdBXU=:6K1h/hGIidn/VoXZodVyzM
 dNHVl4WNXXI99qMlkFpiiO2R0Ly+3isacldol6Ns1ufFfWuQT5bqlLwhXg/qfABKHwv5wuj09
 Ely2zGaa+PWW3Vxs5iXlAKPAUpvd4IhoJ2rltGa/F35hqDqwaBo3MGkhw2en/19pUdtC3E6jw
 h8ItZbb3kpWXtvXV7eH9tvfhI4dV2uuUCMNUi+UG6nKJMS6cDipH1zJtA6g7ld3kyAo0LC+Ks
 11xeLMTnG9TntYWKlvOFOoAR5fzfAax85cjHH+pdsHlHhuJlKeoYY03dsjxKCVSrq9r2BGsdT
 +mT76PCRHEXIMpHu55BargcJXvoPpBCTTn5JUh9P5tV7JAhilfS20bnAudH56t7niyMI2qQ+n
 SLSSMt5gUBfjpW8EJOilQ8ABtm/EZoAPgswdkXldWRkJTZwJxGExeVqMAQRPf+gW9QSfVKwPk
 hoSqNS7m6XhWSuNAit3bIg38mmobGakX5q+63gZN5mNr0aCds1/a7DnMKPxbwXE8oCElSllzz
 1Cxev3+7fSY+TqsCNiFtBFtefnY3fr8d7sFl4Gq6PqYA71haIwxe3DstElJeXB2JX0DxO6tOK
 6QkQe/yvpOmid9seHIr7xjGuHtUmVbWEjD8qxsgMxobmZjzf/r3gOiSqWOmDEHUNKfUDrlpV5
 GQMpwFM04zkf75XA7fFFRm7wpwQOmGy4xZzcSVJRcda7m7xmVXfcIaehKCFMqJPG8mIFOQCl9
 inwKMp7B20YRFRTPwi4RH78YMLUDhEx/zEhm7xGHbfrNvmBqN2+CBTr8fU0b2SVm0yxCc9Yu/
 Jk9yC8oqOpB4BA3putCMZgqioQURWAyhokscMC/diu+aEAdoqU1us+Zj20LK2CLNKoz7oeVBd
 5lxqlDKbJkJfBpE1OY6NjrXdS+H5BNpDvIf7ycWrr6Y7gHqT9vQ7HrVdfaVniAvqlyK5DvRqY
 pH/vuHx8TnpLMEb7eZukV2kyq24UZIS9OhmavMkph4Y9eAZ7bT/5quIQ5CfYhPIqXM8/B7wZ2
 7mi5MZuRwWcX8I5XQsyzdCPzTIYPUc9xyYaf4qYzNTcPeKdjRyvSPiqvSKB7V26sJyisCV4/3
 owa/pkVy8ZRMGjqA46vbM0KEoZTR4qW6eEJ2E2+VNbBo1Qm7QvpXCKOZH8iTKyb+LFMT8OvFl
 m+rPHt47EZ5lWkR0sAZmAzcNaaPUvWWBbbz47eTD9kTQLxXkVW6V32PswX8h7B6a0RwmjexvV
 7lQf9G9y/g3GBGYkz
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I have taken another look at pointer usage after calls of the function =E2=
=80=9Cbrelse=E2=80=9D.
My source code analysis approach pointed implementation details
like the following out for further software development considerations.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/f=
s/exfat/namei.c?id=3D3d155ae4358baf4831609c2f9cd09396a2b8badf#n1078

=E2=80=A6
		epold =3D exfat_get_dentry(sb, p_dir, oldentry + 1, &old_bh,
			&sector_old);
		epnew =3D exfat_get_dentry(sb, p_dir, newentry + 1, &new_bh,
			&sector_new);
		if (!epold || !epnew)
			return -EIO;
=E2=80=A6

I suggest to split such an error check.
How do you think about to release a buffer head object for the desired
exception handling if one of these function calls succeeded?

Would you like to adjust such code in the functions =E2=80=9Cexfat_rename_=
file=E2=80=9D
and =E2=80=9Cexfat_move_file=E2=80=9D?

Regards,
Markus
