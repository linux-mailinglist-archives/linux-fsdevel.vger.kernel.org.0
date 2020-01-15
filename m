Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1991313BD1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 11:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgAOKLF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 05:11:05 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:34749 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbgAOKLF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:11:05 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MwwqB-1jbPjR3RZD-00yRcW; Wed, 15 Jan 2020 11:11:03 +0100
Received: by mail-qt1-f179.google.com with SMTP id k40so15241447qtk.8;
        Wed, 15 Jan 2020 02:11:02 -0800 (PST)
X-Gm-Message-State: APjAAAUKK4AT3ATrrzP4UHpzm32fLBONb3msFR40Lj31wc9eXXkpkFcs
        vcykaKGiZeTyYEZueNSQb/nL8EgXlO0uX2sJKSI=
X-Google-Smtp-Source: APXvYqziRTyXJWEMEslhBRUFMtOQ7y3nd0i+31QxWsoGMe6lxRbtD7ryE0DmoQtcwAsY7DJVkrRmFucoKhb9vkmLXsg=
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr2691571qtr.142.1579083061617;
 Wed, 15 Jan 2020 02:11:01 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200115082824epcas1p4eb45d088c2f88149acb94563c4a9b276@epcas1p4.samsung.com>
 <20200115082447.19520-1-namjae.jeon@samsung.com> <20200115082447.19520-10-namjae.jeon@samsung.com>
In-Reply-To: <20200115082447.19520-10-namjae.jeon@samsung.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Jan 2020 11:10:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3Vqz=T_=sFwBBPa2_Hi_dA=BwWod=L9JkLxUgi=aKNWw@mail.gmail.com>
Message-ID: <CAK8P3a3Vqz=T_=sFwBBPa2_Hi_dA=BwWod=L9JkLxUgi=aKNWw@mail.gmail.com>
Subject: Re: [PATCH v10 09/14] exfat: add misc operations
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com,
        linkinjeon@gmail.com,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zMj7fHpmmC4v6OX5t/OWB8YWtAbKWIMqgQVeVDS3SAVH7nGq6qP
 HqK3uJ1MUa3EYP+R7SqXVkp2eTc2FyJEhjIQNDh8Np27M2dU6iH2krt54q0xvBAkh0394mK
 +XnunK5FjGveB293UoAC7QXAgQ7LyLLTJk1llYRXmpoLr/V0ajlTEemgqb1c1onO3FC1eR7
 wa6TugpjSSQgAi16x0ALw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fKc0iOiZ6uA=:/4byouMcKggKD8zS7GPPO0
 6+jnUfVu8jPu8Ic94m38pxEZl2byhP88Tg0Ek7NQVEd51vSZeiPmFhSR6mz75ExDGVJQy6HbC
 eEmsnbA7FOWCh67K2u/sBIOPUGFNUjXdA5PjL+5v/2yPiFcClUuWTPojP+sHZCL8jRNI7ErKS
 lz4P1J40D/8b08UNEG1VviLwK0w79iW4GICWrRuLllyeoN2SLej9nPAhSS0lmAZQQaYkLpvlu
 9FsOsm4EecnnDXA57YuvkFEEwjOCJ3Vj3I1D0s09GKNL9YTN7+dQS1ZO2Ms0i3Ufs3v85u0YD
 C2xczmNV+JW/fEiH16z6Z+lRljLkO8o2VYaii0P2Khw6zN/OE/LbrQzDwRm8BmlPP73oIPQGw
 a1eGLDzYzdbdOrQG2+6yT5ITeJTdkD12X8d0k4htNWr7yKQwJpxStlfgArZ3DrjkXoj+DgB8P
 QNAT0HF70JQBsrW+wOmYOLyrkdqgthSzj6VG0N8K9LTgjTI8eIFy8kbcWzI3AR04e5pIZaSDj
 JCtFHe1YhlaZjzwpXscSgZ/DjmnRBK2FdkgfsLfdf5iWlRkNMOIpkL5n/LxDMkupDkXDpBbl9
 J9EOQMD3ClTDHMgmIYNJonsYTJdXdMUXcXXpm/LVpDaug9QIqZO8hi6/r7RNbqxP8wJD3Bjh0
 a0hmQPZUmaSzh57waRvyTjU1x+FLtCfbo8oa6wgQAGms6M/zG1ATzxAOBDGJZSddTPf8Wf3Qv
 75rrQU9xnfLayKUB3jKfFfgv7nbGTm+fzD+f0FcRAWRPZWUjwdDBMYfLbBoEt/ji41RRPkFay
 gg2v7n+khbAgbn2QeFCiIaWvkcUI6IFBQCa84bXGOwZhTzRUCTflrpq3OF34n6w2fnOXwekel
 E0aSt5xb3qD5EHGfKmKA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 9:28 AM Namjae Jeon <namjae.jeon@samsung.com> wrote:

> +#define SECS_PER_MIN    (60)
> +#define TIMEZONE_SEC(x)        ((x) * 15 * SECS_PER_MIN)
> +
> +static void exfat_adjust_tz(struct timespec64 *ts, u8 tz_off)
> +{
> +       if (tz_off <= 0x3F)
> +               ts->tv_sec -= TIMEZONE_SEC(tz_off);
> +       else /* 0x40 <= (tz_off & 0x7F) <=0x7F */
> +               ts->tv_sec += TIMEZONE_SEC(0x80 - tz_off);
> +}
> +
> +static inline int exfat_tz_offset(struct exfat_sb_info *sbi)
> +{
> +       if (sbi->options.time_offset)
> +               return sbi->options.time_offset;
> +       return sys_tz.tz_minuteswest;
> +}
> +
> +/* Convert a EXFAT time/date pair to a UNIX date (seconds since 1 1 70). */
> +void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
> +               __le16 time, __le16 date, u8 tz)
> +{
> +       u16 t = le16_to_cpu(time);
> +       u16 d = le16_to_cpu(date);
> +
> +       ts->tv_sec = mktime64(1980 + (d >> 9), d >> 5 & 0x000F, d & 0x001F,
> +                             t >> 11, (t >> 5) & 0x003F, (t & 0x001F) << 1);
> +       ts->tv_nsec = 0;

This part looks good to me now.

> +       if (tz & EXFAT_TZ_VALID)
> +               /* Treat as UTC time, but need to adjust timezone to UTC0 */
> +               exfat_adjust_tz(ts, tz & ~EXFAT_TZ_VALID);
> +       else
> +               /* Treat as local time */
> +               ts->tv_sec -= exfat_tz_offset(sbi) * SECS_PER_MIN;
> +}

Whereas this seems rather complex, when it deals with three different
cases:

- timezone stored in inode
- timezone offset passed as mount option
- local time from sys_tz.tz_minuteswest

Does the exfat specification require to use some notion of 'local time' here
as the fallback? The problem with sys_tz.tz_minuteswest is that it is
not too well-defined, so if there is a choice, falling back to UTC would
be nicer.

> +/* Convert linear UNIX date to a EXFAT time/date pair. */
> +void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
> +               __le16 *time, __le16 *date, u8 *tz)
> +{
> +       struct tm tm;
> +       u16 t, d;
> +
> +       /* clamp to the range valid in the exfat on-disk representation. */
> +       time64_to_tm(clamp_t(time64_t, ts->tv_sec, EXFAT_MIN_TIMESTAMP_SECS,
> +               EXFAT_MAX_TIMESTAMP_SECS), -exfat_tz_offset(sbi) * SECS_PER_MIN,
> +               &tm);

I think you can drop the clamping here, as thes_time_min/s_time_max fields
should take care of that.

For writing out timestamps, it may be best to always encode them as UTC
and set set timezone-valid bit for that. That way, the min/max values
are known at compile time regardless of which time zone the machine
thinks it is in.

      Arnd
