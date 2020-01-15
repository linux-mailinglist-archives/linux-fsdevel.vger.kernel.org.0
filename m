Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E77B13C354
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 14:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgAONin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 08:38:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36670 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgAONin (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:38:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so15792698wru.3;
        Wed, 15 Jan 2020 05:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MRqEF+ZMOwLJppUz+VO6oZ4Q/D2Rzrl4xHi1YEYQLtg=;
        b=uTk70boG6WkAXIawTZJ3I3ANEBmErGIvR4jdgXu/LJRiKxfSq8uC2IwjTYDag5dm0I
         K24X45XFx3PyPSBtSFg7B7mjTXP2fgmoF9fGrbEJC98hSnbR1cJ1EotH3QLxirQRzYLm
         JYQ2GN0i3QyHZ1Bja5mvMu8KpMhElHxkA84rQGD5Gn2r4Ly68pB1i+jF7MQ252lRoNCM
         IXQxxW2dBArSBXOU8AJHe0Hw1HoxtoM6kWSpSFKWqeGjaOogAnADc1E3ihXv/lxE933J
         oCal5kT3Or0GgsauRJXrjWL2wtwe35P4CS7nxyz+7RjVCd+9W11wnkL9TUqMUQ5L8AYE
         w2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MRqEF+ZMOwLJppUz+VO6oZ4Q/D2Rzrl4xHi1YEYQLtg=;
        b=TljXnfKxSmPrdMEatVPNCrcrLiPDScpVbpq9DvXcgjBgHuEvGdrTXodyGSbPzBcxgX
         4hWX7gXo9hMu97K4/+yyjWrvTyI8FrcX8WhcTAyarskPK/MF0XTjDe6VOOVtcWN+/66g
         sIDStR2yQbQSZr9++6VD3wSU0NfJEul4hr5PGNraWmSIXl095WNLoiPf6CNibomu1gh2
         7j5/WNaxLx2N0HaxP1AZn/ZcHGHsbWr90FC+lDi0gFJncjzu5vllwLvnLkUAO+a8VMWL
         NBIK1Aq7/VcsD7UNdBjoNszYKG7GH6VtK23MLuPmoYOB/5oKX4RnJrTJnVoGzK2irlVI
         6E0A==
X-Gm-Message-State: APjAAAX/dMfkpd1NzBdejYEguncBUccEMs5o7EWCN5rs+1PiMAZNdNIt
        KfWv74EcsVmouVNudPmFFc4=
X-Google-Smtp-Source: APXvYqzjIg3lMcAWmPk2mqWA8QUaBKNQJHUapYxN/nrWZJxSVVUtgXz1O8LMMB87rZZ1kaQotBJQgg==
X-Received: by 2002:a05:6000:cf:: with SMTP id q15mr30716458wrx.393.1579095520162;
        Wed, 15 Jan 2020 05:38:40 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id h66sm25056366wme.41.2020.01.15.05.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 05:38:39 -0800 (PST)
Date:   Wed, 15 Jan 2020 14:38:38 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <linkinjeon@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com
Subject: Re: [PATCH v10 09/14] exfat: add misc operations
Message-ID: <20200115133838.q33p5riihsinp6c4@pali>
References: <CGME20200115082824epcas1p4eb45d088c2f88149acb94563c4a9b276@epcas1p4.samsung.com>
 <20200115082447.19520-1-namjae.jeon@samsung.com>
 <20200115082447.19520-10-namjae.jeon@samsung.com>
 <CAK8P3a3Vqz=T_=sFwBBPa2_Hi_dA=BwWod=L9JkLxUgi=aKNWw@mail.gmail.com>
 <CAKYAXd9_qmanQCcrdpScFWvPXuZvk4jhv7Gc=t_vRL9zqWNSjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKYAXd9_qmanQCcrdpScFWvPXuZvk4jhv7Gc=t_vRL9zqWNSjA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday 15 January 2020 22:30:59 Namjae Jeon wrote:
> 2020-01-15 19:10 GMT+09:00, Arnd Bergmann <arnd@arndb.de>:
> > On Wed, Jan 15, 2020 at 9:28 AM Namjae Jeon <namjae.jeon@samsung.com>
> > wrote:
> >
> >> +#define SECS_PER_MIN    (60)
> >> +#define TIMEZONE_SEC(x)        ((x) * 15 * SECS_PER_MIN)
> >> +
> >> +static void exfat_adjust_tz(struct timespec64 *ts, u8 tz_off)
> >> +{
> >> +       if (tz_off <= 0x3F)
> >> +               ts->tv_sec -= TIMEZONE_SEC(tz_off);
> >> +       else /* 0x40 <= (tz_off & 0x7F) <=0x7F */
> >> +               ts->tv_sec += TIMEZONE_SEC(0x80 - tz_off);
> >> +}
> >> +
> >> +static inline int exfat_tz_offset(struct exfat_sb_info *sbi)
> >> +{
> >> +       if (sbi->options.time_offset)
> >> +               return sbi->options.time_offset;
> >> +       return sys_tz.tz_minuteswest;
> >> +}
> >> +
> >> +/* Convert a EXFAT time/date pair to a UNIX date (seconds since 1 1 70).
> >> */
> >> +void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64
> >> *ts,
> >> +               __le16 time, __le16 date, u8 tz)
> >> +{
> >> +       u16 t = le16_to_cpu(time);
> >> +       u16 d = le16_to_cpu(date);
> >> +
> >> +       ts->tv_sec = mktime64(1980 + (d >> 9), d >> 5 & 0x000F, d &
> >> 0x001F,
> >> +                             t >> 11, (t >> 5) & 0x003F, (t & 0x001F) <<
> >> 1);
> >> +       ts->tv_nsec = 0;
> >
> > This part looks good to me now.
> Thanks.
> >
> >> +       if (tz & EXFAT_TZ_VALID)
> >> +               /* Treat as UTC time, but need to adjust timezone to UTC0
> >> */
> >> +               exfat_adjust_tz(ts, tz & ~EXFAT_TZ_VALID);
> >> +       else
> >> +               /* Treat as local time */
> >> +               ts->tv_sec -= exfat_tz_offset(sbi) * SECS_PER_MIN;
> >> +}
> >
> > Whereas this seems rather complex, when it deals with three different
> > cases:
> >
> > - timezone stored in inode
> > - timezone offset passed as mount option
> > - local time from sys_tz.tz_minuteswest
> >
> > Does the exfat specification require to use some notion of 'local time'
> > here
> > as the fallback? The problem with sys_tz.tz_minuteswest is that it is
> > not too well-defined,
> It is not described in the specification. I don't know exactly what
> the problem is because sys_tz.tz_minuteswest seems to work fine to me.
> It can be random garbage value ?
> > so if there is a choice, falling back to UTC would
> > be nicer.
> Okay.

Arnd, what is the default value of sys_tz.tz_minuteswest? What is the
benefit of not using it?

I though that timezone mount option is just an old hack when userspace
does not correctly set kernel's timezone and that this timezone mount
option should be in most cases avoided.

So also another question, what is benefit of having fs specific timezone
mount option? As it is fs specific it means that it would be used so
much.

> >
> >> +/* Convert linear UNIX date to a EXFAT time/date pair. */
> >> +void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64
> >> *ts,
> >> +               __le16 *time, __le16 *date, u8 *tz)
> >> +{
> >> +       struct tm tm;
> >> +       u16 t, d;
> >> +
> >> +       /* clamp to the range valid in the exfat on-disk representation.
> >> */
> >> +       time64_to_tm(clamp_t(time64_t, ts->tv_sec,
> >> EXFAT_MIN_TIMESTAMP_SECS,
> >> +               EXFAT_MAX_TIMESTAMP_SECS), -exfat_tz_offset(sbi) *
> >> SECS_PER_MIN,
> >> +               &tm);
> >
> > I think you can drop the clamping here, as thes_time_min/s_time_max fields
> > should take care of that.
> Okay.
> >
> > For writing out timestamps, it may be best to always encode them as UTC
> > and set set timezone-valid bit for that. That way, the min/max values
> > are known at compile time regardless of which time zone the machine
> > thinks it is in.
> Okay, I will check it.
> Thanks for your review!
> >
> >       Arnd
> >

-- 
Pali Rohár
pali.rohar@gmail.com
