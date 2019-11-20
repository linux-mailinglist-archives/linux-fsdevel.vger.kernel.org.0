Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A91F0103A26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 13:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfKTMgZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 07:36:25 -0500
Received: from mout.web.de ([212.227.15.3]:59625 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbfKTMgZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574253368;
        bh=MxmyEzfAFTWwBXB89FoFsrUf5ujqlJkBwvTvCCN+JjQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DvRJ3p9LIV7cJZkHg3gvRDUJcdttB3hzIdcOv3tHBpabX2lR/wEsEEyY1hdXPhq4O
         Dus7YeRY65J0SkDH2FQBP4j+D98XBzBezpL19MOsQQZsLvj/JkpTp+oO18+aVITBwH
         22mU7xvgK4ICJ4RA59Z/DlwF4aK3zgP0hBVA9+wc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.176.80]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LgYRZ-1i1K2U3lfZ-00nyyf; Wed, 20
 Nov 2019 13:36:08 +0100
Subject: Re: [PATCH v3 10/13] exfat: add nls operations
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <20191119093718.3501-1-namjae.jeon@samsung.com>
 <CGME20191119094026epcas1p3eea5c655f3b89383e02c0097c491f0bc@epcas1p3.samsung.com>
 <20191119093718.3501-11-namjae.jeon@samsung.com>
 <705cb02b-7707-af52-c2b5-70660debc619@web.de>
 <00b701d59f81$319c1d90$94d458b0$@samsung.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <cb82f263-4374-c483-7093-03de81618399@web.de>
Date:   Wed, 20 Nov 2019 13:36:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <00b701d59f81$319c1d90$94d458b0$@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BKqTVjg296nd/3XyCwmU+BOe/V7LAkYtQpdMgcBGbcKjDHmLjVw
 aWD5lHdOL70ZnnKYbpOs9Ytzh7itr+eozBmaewX0knvWZN95f/7oBgOWVB2+ZoVsvJrLIzm
 aqjq6Vr14AstWil2S0/Uy4AAwdYH8EJc10HJG5BJ9QFTLIU84KhdAm0nivFyymhWTHQfZuf
 cpHGseP3PlTjwE3JbgO/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aouy91mQMf8=:HAwCSCJTRAWPF0/nU22uoy
 vHUjaorgke45/23gJ++rgn3L2gzvu6pfSRqcNROdegu24P3vsZIgxqtSjHnh3TjJjuSN1LgZw
 6x+qMaAjraWpoL303TaL78su4+T0FoTmJEdO8VPuAYAuhczbLj/u0/LMA8DKCSF0jLuPHGJhE
 mjIOk4pF20wIGIc6t/06C1KvpBUOrcI4nohNZWxfZvWnwFu1psptIQwa8p78Lm5tf1rzd1nci
 aAnTdwzWOusTt0vZTBd3nI7XnGl0lexK1yANI6S1fZ7VfQdomaviJ+kXI8xCfKQO33euSdIKo
 u39+DG/X+emKeHU5351hseB0qGgalKiK9FzicxbGr/Mnlsueyigfgk3ck5Hj6O4Dd865n3nvR
 mKyC7yowAO8qSWTVudQf9SHLtj1hvYcCbmd3dfT3YLizHIQnL3E0EqDojOAs4HXNxzIGruUvT
 vhOOxZOzhl8PkQX+8FkZkWmBKNf+nltbv8MZrRnVP6ID6lq3a7JuG+zlQTMNHCqsGIuEH/oJw
 3DSaIDyD8r+8DfPnHx35vPFyp9KfGoj2MI445x6wRduo3gj6aPLaPoCts//eeahCnwGCVBTmr
 O6XIZGkdFU5jE4Pcnc4JCP+xd7QzBcyK7psGvWX7vUfJuSCnnc++XzD421DtR3IHo8YK52g6l
 qUBKgcNT25DrCTaQyeh7VwCeYeoQ0MnXNbU9KeXRlnyYyXQemBfb3wi6O3cVyxQ8pPSO5dv/3
 Gh8FTZzl9T/2OnnWrz7N3B3zLRlS+72E9I2TCnMf6TgQa6EqIOoQxcXKPoI3HWFqUZXcRPgkw
 BsAlCF32znrTNp+BdzLkjB57NkFFCH7UeAENFyZOHvWFakXslvoEywJteWqvrhGgTvlx+chLg
 71WRRigjXugofZIs6kNn4ja2hduSJD7NxcK/eZO03GGQZ69NrRqN6V+PoUkCDVCcdD73px8Ac
 NmGNfpQ3773y+LfoeJdWp7/emOYndVch/BoqQvCFV9mrOHglR8AuvPmrHYWnQO5ZNVdJHhiDa
 NCZwsCastesc7GD/QgjQ/kyhpN8mKFdZNRQB4AvGVPukLcTP6WdSEqSIebQyCEckjEqsawrL7
 ISwGDRmHWj/sAMuTdF6nquATF3c6QygeOmR5cLy9kEBO1l6ywKtKOY4lvqb8FWe7rGcvdp+j6
 uz9HL+7KBA1jvHgs0Q8NMax5KWujQRFs1ln/Dua10s3nDQrSEw5Xx3GWyreRle3juGGxlARZA
 MxpjpOthezvVoG+o4p7aML+8zjZVCDxEyiSIgyT0bMRJTY8yVXHNDwKL2UgQ=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> =E2=80=A6
>>> +++ b/fs/exfat/nls.c
>> =E2=80=A6
>>> +static int exfat_load_upcase_table(struct super_block *sb,
>>> +		sector_t sector, unsigned long long num_sectors,
>>> +		unsigned int utbl_checksum)
>>> +{
>> =E2=80=A6
>>> +error:
>>> +	if (bh)
>>> +		brelse(bh);
=E2=80=A6
>> Can the label =E2=80=9Crelease_bh=E2=80=9D be more helpful?
=E2=80=A6
> I checked not only review point but also your review points in
> other patches, I will fix them on v4.
=E2=80=A6

Another software design alternative would be to use a jump target
like =E2=80=9Cfree_table=E2=80=9D instead at this source code place, would=
n't it?

Regards,
Markus
