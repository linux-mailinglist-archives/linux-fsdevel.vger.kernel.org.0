Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACEF5134C32
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 20:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgAHTxi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 14:53:38 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:34317 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgAHTxi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:53:38 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MowX2-1jTWZy1Ixq-00qV6s; Wed, 08 Jan 2020 20:53:36 +0100
Received: by mail-qv1-f42.google.com with SMTP id o18so1968763qvf.1;
        Wed, 08 Jan 2020 11:53:36 -0800 (PST)
X-Gm-Message-State: APjAAAUZLPRLKxsGpRz/QG6xdozAa4DoKL3IPVWytmaMXZZIJjzMaMiV
        j5mA/YdTcN2b41bgK7sIX1EO+cNAxKIssljLPO4=
X-Google-Smtp-Source: APXvYqzz1FEb17HQw2MzP9KbuWTRpvX3DXpUClw6P4CBrHAMSrHr5EA6+oQLpF/hUblCQhUOBZ7UJ10/HWIJ7uNh/OU=
X-Received: by 2002:a0c:bd20:: with SMTP id m32mr5713916qvg.197.1578513215022;
 Wed, 08 Jan 2020 11:53:35 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191119071406epcas1p285f075eac966cfdd6f79362ecc433d6b@epcas1p2.samsung.com>
 <20191119071107.1947-1-namjae.jeon@samsung.com> <20191119071107.1947-10-namjae.jeon@samsung.com>
In-Reply-To: <20191119071107.1947-10-namjae.jeon@samsung.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jan 2020 20:53:18 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2_-xkiV0EeemKDNgsU+Xv+fROmsTUa6j0hBaQSCPKMag@mail.gmail.com>
Message-ID: <CAK8P3a2_-xkiV0EeemKDNgsU+Xv+fROmsTUa6j0hBaQSCPKMag@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] exfat: add misc operations
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>, linkinjeon@gmail.com,
        Markus.Elfring@web.de, sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jRwLuZZDM0g+KFqNC89Z06v7rG4UYhEHg+LwMdad9ssopYREh3s
 VzybyV7HsdLjm7JB42xcCirw2KHBt+9RbX1/VkgeyvxHxyMxnwRf3xHTq+YICIYeraADjRr
 9H+M5TpdfPtyTfOGuSPb6UwubJQVbMfSlwoXiBJjNclty+wcq8jyp58EpjXXyw5OTEpaphO
 XisG/OA3IozM7BiGS7/+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iYqflDIp2fY=:HguQYxkFQEPXp+GtBYr94O
 YKql0y34sQIth81A4+xX3aSvoWQvWoERBfu8SHmWzbFGrmdh/xvM1xslro/ggzcEngRCP3ufC
 XdUh5CNUCEjN+2bWbwPymkyWiN76Tfz9IPL2FPcbtrg84DjA8DkAtPn+dcBwBl/8vkqRH2A44
 MdV4GBNey28NO3DAJz9LjojYIjM3y9dSfEXmMVOpLPY5MSLFkOizgh+51+EsKsrYEWXp3fK+8
 usLqfDSOGyiTH3oMrkkozhVwpUhGLIYW/tqatZSrInrKAPupaeoH+UPDl5+kwRKWLlf1Nne95
 OapS5YSz1B/o4st+d/dKoyqrKfnXBIk6P6lSw62SUcV+i3s3kXc4/DmoJ8hhi0wbm78qAT0hx
 WYDh4887oT1Mnc/NrpT5xRVK3/bNA7tOZyb6V+HLxuaMZOfiFduDmt9KJuzlNL+5LcRmsLNk4
 VhZaE+1SQaRFeY2AygqGMZTj2zh0XGrtUFfV+fKgcQL3RBNGIckvYXgDfPfim+WevKwJfGGEB
 PTD8RR6GKf2TiAgE3TGfT2Zsivd/Ng0tp7MOMUHe1dMFI+LGDE89b/rHguWWLldbtTltXmTbc
 f3EH42gcezVSqA611A4g9eqUgrGq+LBxI8yv61onOos2CDdxkMkvaLOu+/Bj7u/RM/iX5yoxw
 Ki9y+Pgg/b3uuoH8pfHOfOb2QhCzptZPAy5zOKo46mT7uUKJi6p6y/LTtseCd4eXBFlitgVaz
 acOKBZLvq8a9Ci2744yZfgnA/0ZX6mRpwyFXxMYJoKDmqkwfYB311YgRaAc7yzlXIryrAnrez
 MX+NmhW/e/79Plla2dkftfF5+wcIzF5s0tGl4sJUGTiVvdijentI7UukN+2hroDWRSV0OFDXQ
 8Q/v4ybSwjJ6TpZytmjA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 19, 2019 at 8:16 AM Namjae Jeon <namjae.jeon@samsung.com> wrote:

> +/* <linux/time.h> externs sys_tz
> + * extern struct timezone sys_tz;
> + */
> +#define UNIX_SECS_1980    315532800L
> +
> +#if BITS_PER_LONG == 64
> +#define UNIX_SECS_2108    4354819200L
> +#endif
> +
> +/* days between 1970/01/01 and 1980/01/01 (2 leap days) */
> +#define DAYS_DELTA_DECADE    (365 * 10 + 2)
> +/* 120 (2100 - 1980) isn't leap year */
> +#define NO_LEAP_YEAR_2100    (120)
> +#define IS_LEAP_YEAR(y)    (!((y) & 0x3) && (y) != NO_LEAP_YEAR_2100)
> +
> +#define SECS_PER_MIN    (60)
> +#define SECS_PER_HOUR   (60 * SECS_PER_MIN)
> +#define SECS_PER_DAY    (24 * SECS_PER_HOUR)

None of this code should exist, just use time64_to_tm() and tm_to_time64()

> +       if (!sbi->options.tz_utc)
> +               ts->tv_sec += sys_tz.tz_minuteswest * SECS_PER_MIN;

I would make tz_utc the default here. Not sure what windows uses or what
the specification says, but sys_tz is a rather unreliable interface, and it's
better to not use that at all if it can be avoided.

It may be useful to have a mount option for the time zone offset instead.

> +       ts->tv_nsec = 0;
> +}
> +
> +/* Convert linear UNIX date to a FAT time/date pair. */
> +void exfat_time_unix2fat(struct exfat_sb_info *sbi, struct timespec64 *ts,
> +               struct exfat_date_time *tp)

This is basically time64_to_tm(), just be careful about to check whether
months are counted from 1 or 0.

       Arnd
