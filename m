Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9FC51407B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 11:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgAQKN7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 05:13:59 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:49095 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgAQKN7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:13:59 -0500
Received: from mail-qv1-f50.google.com ([209.85.219.50]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MPGNn-1jHVCi0JGn-00PaHr; Fri, 17 Jan 2020 11:13:57 +0100
Received: by mail-qv1-f50.google.com with SMTP id u10so10469008qvi.2;
        Fri, 17 Jan 2020 02:13:56 -0800 (PST)
X-Gm-Message-State: APjAAAU9ap6FwXObtvnTs//6gnoM+EqhKhx4ZW1UbNJiubHCFYy9ySat
        BkENvIJ0YJbSGCubhnyjVERlMku6xSY6hs84dqk=
X-Google-Smtp-Source: APXvYqwoaZC78GW7dhwVxPbk7uX0hz+jyVaodXJrhdkhFvFgQCutvZKEI2XaD/dksfbE1GnJ9fve6CoS3eGjMTvkzHk=
X-Received: by 2002:a0c:bd20:: with SMTP id m32mr6945190qvg.197.1579256035816;
 Fri, 17 Jan 2020 02:13:55 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200115082824epcas1p4eb45d088c2f88149acb94563c4a9b276@epcas1p4.samsung.com>
 <20200115082447.19520-1-namjae.jeon@samsung.com> <20200115082447.19520-10-namjae.jeon@samsung.com>
 <CAK8P3a3Vqz=T_=sFwBBPa2_Hi_dA=BwWod=L9JkLxUgi=aKNWw@mail.gmail.com>
 <CAKYAXd9_qmanQCcrdpScFWvPXuZvk4jhv7Gc=t_vRL9zqWNSjA@mail.gmail.com>
 <20200115133838.q33p5riihsinp6c4@pali> <CAK8P3a1ozgLYpDtveU0CtLj5fEFG8i=_QrnEAtoVFt-yC=Dc0g@mail.gmail.com>
 <20200115142428.ugsp3binf2vuiarq@pali> <CAK8P3a0_sotmv40qHkhE5M=PwEYLuJfX+uRFZvh9iGzhv6R6vw@mail.gmail.com>
 <20200115153943.qw35ya37ws6ftlnt@pali> <CAK8P3a1iYPA9MrXORiWmy1vQGoazwHs7OfPdoHLZLJDWqu9jqA@mail.gmail.com>
 <002801d5cce2$228d79f0$67a86dd0$@samsung.com>
In-Reply-To: <002801d5cce2$228d79f0$67a86dd0$@samsung.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Jan 2020 11:13:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a28NRp+SGr44=DTYqL0+ZqtamHwn+WYNTxVRJOJ3HtLSg@mail.gmail.com>
Message-ID: <CAK8P3a28NRp+SGr44=DTYqL0+ZqtamHwn+WYNTxVRJOJ3HtLSg@mail.gmail.com>
Subject: Re: [PATCH v10 09/14] exfat: add misc operations
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     Namjae Jeon <linkinjeon@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:OMcV1PBMCdqp0Id1noAn4yilMyi9oASYNpqGuoesk2TPvBGjpmh
 eRgtqPPBuZHKOt7FnuUjVCE3xfBNculVtQ7lGk1riSO8rWfc6YMWHOE4GhDdTt2GmuLp7tF
 rGCLUrMOKZNuxj5kfY5qgOVU1AZ+dWv8ursve8enrtc86NE1/S6NUMoJ6Xod8mtcZ0YyUsH
 DrWT0Ik0WMh6m+agB7fbw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nlZcbhdSFjo=:zrcTFlBcUvk+kOmgTtdREK
 GxI8BQONRe0KdBCIUvZ2pUV6ql8JFGo9lYKR8pnefEixu77axymKWOpbPR3ShknR+W/kk9NKL
 MltyEPZT1qV+uEzIrWCxbtce8AB6clRUTF2NvRMQvTri6Qsi0bqFfc8cT2SOOzoi8wPkEsnUK
 I8OjnIaf1GXBiVYHt38FvCsDXRGiuXz7pfQZdPjJ3o8oej9SxfWF92CR8x1V+dI5hURhn+hfY
 yXwKOdZbQWwnoRPIUhiWCQ2eLl5FuMPIe3JnXRA3w4BFLXrrlcPAr7/WRQ0C66OCN+9dNBQYy
 C6zw4xBzJU+S+nt4cm7bcLU2GvVqHPmiMJIdkQLlvNh1E0iuDDj3AVTsrVxlnpm2sKSe2RjH0
 u/BF6P+VOeYnF/mc+XbBX6uGBK6r5hrnzFnVWGMP0d3gk1c9yQq0SCtZA7PR09LZFX0eSg5Qa
 GJyruFYdO/s3qoo2fHWwFfWjMtHhrf0NwAsS2I0elSdzMIfqgDQe83/+iIrN5DFQeH0aT31+p
 6DmC3X8NKsIrRpDann/kdSs3ysSThkp1s7ZEnQi651UnpVNFCtRIxFxRE05KFHJIYzqTXFwZP
 0uxgdJaKYlRxVcDX8NHJWWNyldXVlMZhmojirxzY7VCUn111ZE/Q+tKlSHGcgFaEA2zf3l34b
 HxhG6LhyWZxF8Nu1dR32Q1T6XpEOJrFAyUMuIztn6XVNG1RXOf1n+frZMF4wrM7r/jaaquFt2
 5CEc+4YfirHtasQtknQwaCtE2Flm7m7JyJrP6Yt8dPL24oOD7WKNJbi01LHc1up+k/reyoWE5
 T4kWbY/bJIrp9Da8B/emngAzUQoZP4fW4ryF/EbytMqIzGougBkB10towissxPeeOfoEV1Iyf
 /ylIQRoBV8bMYosQ2N+Q==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 3:59 AM Namjae Jeon <namjae.jeon@samsung.com> wrote:
>
>
> > This is what I think the timezone mount option should be used
> > for: if we don't know what the timezone was for the on-disk timestamp, use
> > the one provided by the user. However, if none was specified, it should be
> > either sys_tz or UTC (i.e. no conversion). I would prefer the use of UTC
> > here given the problems with sys_tz, but sys_tz would be more consistent
> > with how fs/fat works.
> Hi Arnd,
>
> Could you please review this change ?

Looks all good to me now.

      Arnd

> /* Convert a EXFAT time/date pair to a UNIX date (seconds since 1 1 70). */
> void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
>                 __le16 time, __le16 date, u8 tz)
> {
>         u16 t = le16_to_cpu(time);
>         u16 d = le16_to_cpu(date);
>
>         ts->tv_sec = mktime64(1980 + (d >> 9), d >> 5 & 0x000F, d & 0x001F,
>                               t >> 11, (t >> 5) & 0x003F, (t & 0x001F) << 1);
>         ts->tv_nsec = 0;
>
>         if (tz & EXFAT_TZ_VALID)
>                 /* Adjust timezone to UTC0. */
>                 exfat_adjust_tz(ts, tz & ~EXFAT_TZ_VALID);
>         else
>                 /* Convert from local time to UTC using time_offset. */
>                 ts->tv_sec -= sbi->options.time_offset * SECS_PER_MIN;
> }
>
> /* Convert linear UNIX date to a EXFAT time/date pair. */
> void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
>                 __le16 *time, __le16 *date, u8 *tz)
> {
>         struct tm tm;
>         u16 t, d;
>
>         time64_to_tm(ts->tv_sec, 0, &tm);
>         t = (tm.tm_hour << 11) | (tm.tm_min << 5) | (tm.tm_sec >> 1);
>         d = ((tm.tm_year - 80) <<  9) | ((tm.tm_mon + 1) << 5) | tm.tm_mday;
>
>         *time = cpu_to_le16(t);
>         *date = cpu_to_le16(d);
>
>         /*
>          * Record 00h value for OffsetFromUtc field and 1 value for OffsetValid
>          * to indicate that local time and UTC are the same.
>          */
>         *tz = EXFAT_TZ_VALID;
> }
>
> Thanks!
>
