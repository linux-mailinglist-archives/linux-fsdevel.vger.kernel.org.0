Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 673A4154CC0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 21:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgBFUNc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 15:13:32 -0500
Received: from mout.web.de ([217.72.192.78]:54697 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbgBFUNc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581019971;
        bh=YlmzSQw8XEy/MGZ9AFDnUgZH/BufFdifz8Lr2qvwTmM=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=fDZrkgHiBY8/07Wjs9z8kz8H6i8TXE/ftXKXvuyImL5sIszP1xkJVwYGhprlMIZVx
         RbdVwIxYzlZJxzlMlbqe0omJlQ0/mDNNJNQd+uY/kxxTdTOe6kS2uARk5G471Y7kF/
         tTQR5pg1xgKJPWTcAghqL669pyEFZtctWtpMFF/0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.144.33]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LwqFo-1jbDnX2QEy-016Nv9; Thu, 06
 Feb 2020 21:12:51 +0100
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jth@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v12 2/2] zonefs: Add documentation
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5a6a18ff-ed4a-0404-60f8-3a155ded7a24@web.de>
Date:   Thu, 6 Feb 2020 21:12:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YvFiunu07qcHADG+yot6BuJrBTSc7FPqrAR4vlpCpOGYfkMCJHR
 YXOZy1sYMiPY0qWHcBaVrLcoL7nGgOKPIbsSCiczV9hK4i2RVFlT0a8aRGY0lkNaB+6idLu
 PDLG2oEIoRyYYTG5ooRGDosm0bGVTgS3vBWtJEOgzyj345y3XYF89J6YZsu6ay/XyyaU0mC
 H371UQKhaKn3WAFXXiQ6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MBmw8p72iS0=:dbDAursYXrROSKN/XMmgIT
 vVtA20wNb9U7hJ+C8qCoNOKGlAPw2PKJsSJqizz6Q3bTe9lVGt7cCbtyxK1iWkuAKtdSDKbHu
 mIDhCy6BsyEpAxZ2rND/dWnK+Aw2U1+FiHSdT+WYOLSSVklZWQtbLwdLHlYptpixXfrtUIZcd
 xzp7A0+FGD5pZj0mbLZCbwUsp/sNAIuPRt9pEYCqz2m01ZFwO9NYvuzlE2AR6qmG76iZ7uJNh
 6wh5mcLIK7FYhfs8a9RjHTSljAiPIMZcAVqAXiFXsBM9oHmYw+DZMguLIBH4cfA1yU/YZsRZ0
 vqumPiuCwwR4PKuVsJnBuRTF/F+uFLAZYoO3Zu1hWry3Dl8Wy8NxMXXAlaPYaGcL/OZT1y842
 xJd3c4G4d7rDb92V/Tza5RUbvRqwjFnU7FP3h7rUUtS9Iz/RXjsPEBt5hxmZj4IN3M2ECITvy
 27SiJ9yc2rtdVktxSFGlgWIP++wlRsLSvaZXd09Xx8rZqTcWH3PpWZZYVzhawbOsvFbh+i2jX
 8LfTfCXgMmlVE2f2pmQ3lGjPjmg8ce9h4HAylOGfZ9t7A8mXpBHC0N0mzNqIj5ftcKgtvaNGe
 Wz02JjVEQdCQWOfLhYDJLy7Y/JxCV/8PbRzI//hWyYweNAHCgTv0VxIHX7RGx3uld6MVL2u91
 ekap9no4StmMWyUZK3s70/GNWn9hDbuwf6PgveD5NS2LWdN1HHPTHHa44BzMvvcQpC/aBv0Vq
 pQZamYX2OrgNjxJU81JDMrF+HRSTTcHj3Qi5FXH40vaHZl0JQK5NBa6d076iPJ56UlCs1ZPQB
 eTbusM6ZJYJwRVfMoTyJ9uYji8ymF/LMoT3Akuz0Ia2sR2cDl32ZK4EpzWFJCmRccI9Ba9iBJ
 7eJ9LnF6+4JQysIgQO+PmU17slEl3p++oU0TGKMrLsYLcLAHEFhYd7Y1Rlows7z8/s7N3isAH
 CczJY6w36zYCXdDKxiDDpriCmGzh7ReLqxxGTMkC36EohBi/i7GJCvzJ2uRk4jg4XABVkRlwB
 ALjXcdG1heS+vFwYgP/x90ZspcpEp+XlX1R6BCNck1lnW99eoCOCNTY0cOsvdH80hiz7f87le
 uYHUBAZhPQP6+GaIMOmeniRZ5iShuaFI62f1WPSviZcS6a4eA/yyeZ5z8ApGpMA1lifQHf3cp
 cloKZ9ljc08OrqXoUh08oHEj+1WnQp8Wkrnev8xNPXiVZkj97cnMsgy4dkwhU0VSFbUTjmkNP
 zm/O0HaST1ffr6U+c
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/Documentation/filesystems/zonefs.txt
=E2=80=A6
> zonefs is a very simple file system =E2=80=A6

How do you think about to be consistent with the capitalisation
at the beginning of such sentences (also in the software documentation)?
https://lore.kernel.org/linux-fsdevel/20200206052631.111586-1-damien.lemoa=
l@wdc.com/

Regards,
Markus
