Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 102B713C2D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 14:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgAONbB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 08:31:01 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38196 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgAONbA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:31:00 -0500
Received: by mail-ot1-f68.google.com with SMTP id z9so13953732oth.5;
        Wed, 15 Jan 2020 05:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fAOeXDRIFaUFNONgtpOUkG+D4IroA4wgYRWzDTSRd0s=;
        b=frzTSkzQQWX4VjczDNEDcuNHb5JEDqNX6M4BnBJ7CSNPqX/yg1oTMXKQx+C9las5hp
         f+btcUWXU1Nc4eX6U+t4B1r5ZDEjryLNNTIZDPZAvpvKQ/K1jlqj9E0gZ1ZCuNLI+Mux
         HiIB0ZidAiJSXBVX2os15BI7/Y72/yXWXHMS5KObVOO7unYX0ySxhFAC+vyDqWigiovh
         cuQiVR9E7gQq+9kVBHO90s9HDYJus8cgguLuZhVe5hgWUULZH79+koFeJYDXyfeQ543R
         IdDSsLsKEvIgCIB1jRxcSV+2FE3ynu1h/gzi6eYbNoLgn2Rgpt1KG95nSN2enGsm70S+
         ghNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fAOeXDRIFaUFNONgtpOUkG+D4IroA4wgYRWzDTSRd0s=;
        b=NLiFeRpj10ouaDhgJcgo2p3tVsbRdVP+n3FmU5qzuo5I3pQRVhryA5HLEMlN47Eg7B
         VjpcLMpj+A5wDIX4vIBjUP5aCvtaNiQ4k6Mjzu03fjYhPAu/LoTXxY3hixZ5pTGv7FuJ
         RSKEaiHRVKJGh2HIObPMRtRwSU5lLw/lIMU70VZyPkuZsBgwLNB2HMW8h7ESLQ0mXT7k
         2mvUdetatJoZLC1phfZUej0+vfCGU6No17N+4GBW5VDU0pVL7QNF3HpKPofXX3EcU/M5
         dDGKr8TaDLp4n8OggvI3WfiygOjG2UmnzbOJLiarpBYW4NHFiCUCbued79rZWriOrEPy
         d2xw==
X-Gm-Message-State: APjAAAVo9fc+KD6SJoMbAOLiHCqGk6xAz6t0qY1k3odrL2BssCzdXlVq
        YHHXDQQBiSa4cFVkzPm9itvLvGM4vEBTFftJIYf6Jg==
X-Google-Smtp-Source: APXvYqysJw7pgv4PQLsZuez7XkX8FpXJWIj/tJczIZ3Z3NRp3N4+5pYeDIO45G/tlhAAMWGfEY3HfNSBTVmltZeNVl4=
X-Received: by 2002:a9d:6196:: with SMTP id g22mr2804475otk.204.1579095059650;
 Wed, 15 Jan 2020 05:30:59 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Wed, 15 Jan 2020 05:30:59 -0800 (PST)
In-Reply-To: <CAK8P3a3Vqz=T_=sFwBBPa2_Hi_dA=BwWod=L9JkLxUgi=aKNWw@mail.gmail.com>
References: <CGME20200115082824epcas1p4eb45d088c2f88149acb94563c4a9b276@epcas1p4.samsung.com>
 <20200115082447.19520-1-namjae.jeon@samsung.com> <20200115082447.19520-10-namjae.jeon@samsung.com>
 <CAK8P3a3Vqz=T_=sFwBBPa2_Hi_dA=BwWod=L9JkLxUgi=aKNWw@mail.gmail.com>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Wed, 15 Jan 2020 22:30:59 +0900
Message-ID: <CAKYAXd9_qmanQCcrdpScFWvPXuZvk4jhv7Gc=t_vRL9zqWNSjA@mail.gmail.com>
Subject: Re: [PATCH v10 09/14] exfat: add misc operations
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-01-15 19:10 GMT+09:00, Arnd Bergmann <arnd@arndb.de>:
> On Wed, Jan 15, 2020 at 9:28 AM Namjae Jeon <namjae.jeon@samsung.com>
> wrote:
>
>> +#define SECS_PER_MIN    (60)
>> +#define TIMEZONE_SEC(x)        ((x) * 15 * SECS_PER_MIN)
>> +
>> +static void exfat_adjust_tz(struct timespec64 *ts, u8 tz_off)
>> +{
>> +       if (tz_off <= 0x3F)
>> +               ts->tv_sec -= TIMEZONE_SEC(tz_off);
>> +       else /* 0x40 <= (tz_off & 0x7F) <=0x7F */
>> +               ts->tv_sec += TIMEZONE_SEC(0x80 - tz_off);
>> +}
>> +
>> +static inline int exfat_tz_offset(struct exfat_sb_info *sbi)
>> +{
>> +       if (sbi->options.time_offset)
>> +               return sbi->options.time_offset;
>> +       return sys_tz.tz_minuteswest;
>> +}
>> +
>> +/* Convert a EXFAT time/date pair to a UNIX date (seconds since 1 1 70).
>> */
>> +void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64
>> *ts,
>> +               __le16 time, __le16 date, u8 tz)
>> +{
>> +       u16 t = le16_to_cpu(time);
>> +       u16 d = le16_to_cpu(date);
>> +
>> +       ts->tv_sec = mktime64(1980 + (d >> 9), d >> 5 & 0x000F, d &
>> 0x001F,
>> +                             t >> 11, (t >> 5) & 0x003F, (t & 0x001F) <<
>> 1);
>> +       ts->tv_nsec = 0;
>
> This part looks good to me now.
Thanks.
>
>> +       if (tz & EXFAT_TZ_VALID)
>> +               /* Treat as UTC time, but need to adjust timezone to UTC0
>> */
>> +               exfat_adjust_tz(ts, tz & ~EXFAT_TZ_VALID);
>> +       else
>> +               /* Treat as local time */
>> +               ts->tv_sec -= exfat_tz_offset(sbi) * SECS_PER_MIN;
>> +}
>
> Whereas this seems rather complex, when it deals with three different
> cases:
>
> - timezone stored in inode
> - timezone offset passed as mount option
> - local time from sys_tz.tz_minuteswest
>
> Does the exfat specification require to use some notion of 'local time'
> here
> as the fallback? The problem with sys_tz.tz_minuteswest is that it is
> not too well-defined,
It is not described in the specification. I don't know exactly what
the problem is because sys_tz.tz_minuteswest seems to work fine to me.
It can be random garbage value ?
> so if there is a choice, falling back to UTC would
> be nicer.
Okay.
>
>> +/* Convert linear UNIX date to a EXFAT time/date pair. */
>> +void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64
>> *ts,
>> +               __le16 *time, __le16 *date, u8 *tz)
>> +{
>> +       struct tm tm;
>> +       u16 t, d;
>> +
>> +       /* clamp to the range valid in the exfat on-disk representation.
>> */
>> +       time64_to_tm(clamp_t(time64_t, ts->tv_sec,
>> EXFAT_MIN_TIMESTAMP_SECS,
>> +               EXFAT_MAX_TIMESTAMP_SECS), -exfat_tz_offset(sbi) *
>> SECS_PER_MIN,
>> +               &tm);
>
> I think you can drop the clamping here, as thes_time_min/s_time_max fields
> should take care of that.
Okay.
>
> For writing out timestamps, it may be best to always encode them as UTC
> and set set timezone-valid bit for that. That way, the min/max values
> are known at compile time regardless of which time zone the machine
> thinks it is in.
Okay, I will check it.
Thanks for your review!
>
>       Arnd
>
