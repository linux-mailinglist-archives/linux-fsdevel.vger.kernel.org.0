Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2C2412E5CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 12:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgABLki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 06:40:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54031 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgABLkh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 06:40:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so5327590wmc.3;
        Thu, 02 Jan 2020 03:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RWu+gH3W2FAZzPLej4otzZ2FiR4SGwDwk7fqLb7ZrJo=;
        b=TJWGw7GuH45CCygsnCC9lWkvRL9jW43HEU3F3JOL+K7bEiAt+l3XTGf5WdhPQSLR7o
         +HiFMwiN7RQ4x02F7BD2kOd1OTEM+3pgVBoJGxXyf5F4bL3vSSgMMwbAQNOGDStwBPum
         JZ6xgDWMYjANjFb7YzVOGWkPb37zZLAtOeZTpwhwH9GYdnXh2T4ACL1sj3qSpg1vELzV
         O072Z1+USC8PCKWyecSVUtU93S62Q/cVe3Ff3CUgumQR2bZwPcWdl0owfUnjYmV3fXSG
         QAAld+ZjCwcjwWW8qpDS01xSFr7E2lg1usfr9IId2Jhux3TCQ6oTV60/Lzk5M6qn3ryM
         9P6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RWu+gH3W2FAZzPLej4otzZ2FiR4SGwDwk7fqLb7ZrJo=;
        b=gpHQMwaI2c7+g7p5LW6jkukIuDTK1qEf/iZVgKG+pW9Wwa3AcCXWlDY1ajmwpI9Tdz
         R5cvc9GEx6uOqyQlzFs/8yg/wdBTm1t7C/rzJ6jpTWfsAusFSBnSzhE8LiKYdYvNvQU9
         9brDISDSu7Sc7RaUEESyRsDBE2PAHXswnmaZ556lu/athkELAIWv+6DD+jEmYHg82xqB
         JQ0g3uQvl/mrPlyWA1SMRau2fZteD1EC+8NqfQ+55bNmHx7OccNDC4/OkszdDMQxoNe8
         iCxUwiUy9+4xjKhT/0DZ26Jn6GYJa2mEKcgw1ClA3RdOG8agzBHhU9X78Xt7/oO2P1b/
         UYlQ==
X-Gm-Message-State: APjAAAVbAgfSWJSljFk/80e6Boy+zMgFBrAtbXNGnefhR3wfyndyLJ4J
        VuTS6VXg5KFsDtB6Uoc4BbIsilZCybM=
X-Google-Smtp-Source: APXvYqyyk0dpfhp7UclsrPIXBTPWPVFlHMAeQ7FG7D5urplxcggNz8XUm561FgaP0LGQpngckmNc1A==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr14154179wmi.146.1577965235477;
        Thu, 02 Jan 2020 03:40:35 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id i16sm8358173wmb.36.2020.01.02.03.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 03:40:34 -0800 (PST)
Date:   Thu, 2 Jan 2020 12:40:34 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <linkinjeon@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com
Subject: Re: [PATCH v9 09/13] exfat: add misc operations
Message-ID: <20200102114034.bjezqs45xecz4atd@pali>
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
 <CGME20200102082406epcas1p268f260d90213bdaabee25a7518f86625@epcas1p2.samsung.com>
 <20200102082036.29643-10-namjae.jeon@samsung.com>
 <20200102091902.tk374bxohvj33prz@pali>
 <CAKYAXd_9XOWtcLYk-+gg636rFCYjLgHzrP5orR3XjXGMpTKWLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKYAXd_9XOWtcLYk-+gg636rFCYjLgHzrP5orR3XjXGMpTKWLA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 02 January 2020 20:30:03 Namjae Jeon wrote:
> 2020-01-02 18:19 GMT+09:00, Pali Rohár <pali.rohar@gmail.com>:
> > On Thursday 02 January 2020 16:20:32 Namjae Jeon wrote:
> >> This adds the implementation of misc operations for exfat.
> >>
> >> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> >> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> >> ---
> >>  fs/exfat/misc.c | 253 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 253 insertions(+)
> >>  create mode 100644 fs/exfat/misc.c
> >>
> >> diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
> >> new file mode 100644
> >> index 000000000000..7f533bcb3b3f
> >> --- /dev/null
> >> +++ b/fs/exfat/misc.c
> >
> > ...
> >
> >> +/* <linux/time.h> externs sys_tz
> >> + * extern struct timezone sys_tz;
> >> + */
> >> +#define UNIX_SECS_1980    315532800L
> >> +
> >> +#if BITS_PER_LONG == 64
> >> +#define UNIX_SECS_2108    4354819200L
> >> +#endif
> >
> > ...
> >
> >> +#define TIMEZONE_CUR_OFFSET()	((sys_tz.tz_minuteswest / (-15)) & 0x7F)
> >> +/* Convert linear UNIX date to a FAT time/date pair. */
> >> +void exfat_time_unix2fat(struct exfat_sb_info *sbi, struct timespec64
> >> *ts,
> >> +		struct exfat_date_time *tp)
> >> +{
> >> +	time_t second = ts->tv_sec;
> >> +	time_t day, month, year;
> >> +	time_t ld; /* leap day */
> >
> > Question for other maintainers: Has kernel code already time_t defined
> > as 64bit? Or it is still just 32bit and 32bit systems and some time64_t
> > needs to be used? I remember that there was discussion about these
> > problems, but do not know if it was changed/fixed or not... Just a
> > pointer for possible Y2038 problem. As "ts" is of type timespec64, but
> > "second" of type time_t.
> My bad, I will change it with time64_t.

Now I have looked into sources and time_t is just typedef from
__kernel_old_time_t type. So it looks like that time64_t is the type
which should be used in new code.

But somebody else should confirm this information.

> >
> >> +
> >> +	/* Treats as local time with proper time */
> >> +	second -= sys_tz.tz_minuteswest * SECS_PER_MIN;
> >> +	tp->timezone.valid = 1;
> >> +	tp->timezone.off = TIMEZONE_CUR_OFFSET();
> >> +
> >> +	/* Jan 1 GMT 00:00:00 1980. But what about another time zone? */
> >> +	if (second < UNIX_SECS_1980) {
> >> +		tp->second  = 0;
> >> +		tp->minute  = 0;
> >> +		tp->hour = 0;
> >> +		tp->day  = 1;
> >> +		tp->month  = 1;
> >> +		tp->year = 0;
> >> +		return;
> >> +	}
> >> +
> >> +	if (second >= UNIX_SECS_2108) {
> >
> > Hello, this code cause compile errors on 32bit systems as UNIX_SECS_2108
> > macro is not defined when BITS_PER_LONG == 32.
> >
> > Value 4354819200 really cannot fit into 32bit signed integer, so you
> > should use 64bit signed integer. I would suggest to define this macro
> > value via LL not just L suffix (and it would work on both 32 and 64bit)
> Okay.
> >
> >   #define UNIX_SECS_2108    4354819200LL
> >
> >> +		tp->second  = 59;
> >> +		tp->minute  = 59;
> >> +		tp->hour = 23;
> >> +		tp->day  = 31;
> >> +		tp->month  = 12;
> >> +		tp->year = 127;
> >> +		return;
> >> +	}
> Okay, I will check it.
> Thanks for your review!
> >
> > --
> > Pali Rohár
> > pali.rohar@gmail.com
> >

-- 
Pali Rohár
pali.rohar@gmail.com
