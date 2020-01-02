Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF86012E5AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 12:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgABLaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 06:30:04 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37954 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgABLaE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 06:30:04 -0500
Received: by mail-ot1-f68.google.com with SMTP id d7so52245302otf.5;
        Thu, 02 Jan 2020 03:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zsUL2C0WaaJc/RKLuim/CUrfNo1Iw2tHL4HfNNGKlGQ=;
        b=DI7nFGHOQf6wsy/Ujxwg6jXNd66N92P1l1ay1EWZ94nVNSjECeIyLwYQNIXYdkY89M
         plyTW9zXm+f2WPmwzN6KUAA12p+gE/HlMPEprAEBHpJOsGCGWq6ntnjEZnyK4C/6bfaG
         fl/sjOVHJ+xEp0o4CT0+Frs67gBY9HcZp26dhjexvxnnCTfGtaDkpXj4wOmSvo64Q7J6
         9m053YlV9MpzdJDaC107jepOpSYCa28GcJuG+tbiMpfdC2By/a75ieQKKL9/BLTHiVn7
         emjN7zuXQuOnNEgY4p5LTbIUWb1PpHjgV7DuxtOee7o9EgPWe6DSregQUHPIb+X9N5RB
         VC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zsUL2C0WaaJc/RKLuim/CUrfNo1Iw2tHL4HfNNGKlGQ=;
        b=fIfExfR3Yyq7Iofp5VVRXBGafuJrvieoCSGHqs+Yvh29jKxuN2nLuPEZu1KnyuDrfm
         mQ2SyqU5QPbdxNoSJ+HCoPoL8q5v71Hhtc3s7Rek2QYb9JSMopfrnZVXp/Ar1kpsUztS
         OpAH+HGa/3HohLIa9kpPANIdi3DjzWAalQ2e3X8L7l4OZQ/DGkoYVwczjvLv/J0ULi4n
         tLY311fR30wFVpLgE2F3hep5HYwLppC2BgV3drFw3XANHlF7c1ViVQlOVVuUcGeVQE+R
         ZleDYYmkX4kwsMor8333uIvnINGd4Iz5LNIz0mD3ZjlySSwRpDJ/se2SFLKdEQY/wkMP
         6kUg==
X-Gm-Message-State: APjAAAUx/nkPJ69v6iyLssJM3wgYr2Kag/X9cAjacsv9D5sZXRCw6Vy8
        5zzkDDLyvEmwXUcbSSoAsm7Nhd9NT1nWrulF9FU=
X-Google-Smtp-Source: APXvYqx8NQX+ydY+eeNDp28dUg9R1svX91x1kJ14OwQoZoSrATITd1jR8fbXt5whBGr7Ll3uhqkiyuU/GUqUX5oZEKM=
X-Received: by 2002:a05:6830:1141:: with SMTP id x1mr17726618otq.120.1577964603627;
 Thu, 02 Jan 2020 03:30:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Thu, 2 Jan 2020 03:30:03 -0800 (PST)
In-Reply-To: <20200102091902.tk374bxohvj33prz@pali>
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
 <CGME20200102082406epcas1p268f260d90213bdaabee25a7518f86625@epcas1p2.samsung.com>
 <20200102082036.29643-10-namjae.jeon@samsung.com> <20200102091902.tk374bxohvj33prz@pali>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Thu, 2 Jan 2020 20:30:03 +0900
Message-ID: <CAKYAXd_9XOWtcLYk-+gg636rFCYjLgHzrP5orR3XjXGMpTKWLA@mail.gmail.com>
Subject: Re: [PATCH v9 09/13] exfat: add misc operations
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-01-02 18:19 GMT+09:00, Pali Roh=C3=A1r <pali.rohar@gmail.com>:
> On Thursday 02 January 2020 16:20:32 Namjae Jeon wrote:
>> This adds the implementation of misc operations for exfat.
>>
>> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
>> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
>> ---
>>  fs/exfat/misc.c | 253 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 253 insertions(+)
>>  create mode 100644 fs/exfat/misc.c
>>
>> diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
>> new file mode 100644
>> index 000000000000..7f533bcb3b3f
>> --- /dev/null
>> +++ b/fs/exfat/misc.c
>
> ...
>
>> +/* <linux/time.h> externs sys_tz
>> + * extern struct timezone sys_tz;
>> + */
>> +#define UNIX_SECS_1980    315532800L
>> +
>> +#if BITS_PER_LONG =3D=3D 64
>> +#define UNIX_SECS_2108    4354819200L
>> +#endif
>
> ...
>
>> +#define TIMEZONE_CUR_OFFSET()	((sys_tz.tz_minuteswest / (-15)) & 0x7F)
>> +/* Convert linear UNIX date to a FAT time/date pair. */
>> +void exfat_time_unix2fat(struct exfat_sb_info *sbi, struct timespec64
>> *ts,
>> +		struct exfat_date_time *tp)
>> +{
>> +	time_t second =3D ts->tv_sec;
>> +	time_t day, month, year;
>> +	time_t ld; /* leap day */
>
> Question for other maintainers: Has kernel code already time_t defined
> as 64bit? Or it is still just 32bit and 32bit systems and some time64_t
> needs to be used? I remember that there was discussion about these
> problems, but do not know if it was changed/fixed or not... Just a
> pointer for possible Y2038 problem. As "ts" is of type timespec64, but
> "second" of type time_t.
My bad, I will change it with time64_t.
>
>> +
>> +	/* Treats as local time with proper time */
>> +	second -=3D sys_tz.tz_minuteswest * SECS_PER_MIN;
>> +	tp->timezone.valid =3D 1;
>> +	tp->timezone.off =3D TIMEZONE_CUR_OFFSET();
>> +
>> +	/* Jan 1 GMT 00:00:00 1980. But what about another time zone? */
>> +	if (second < UNIX_SECS_1980) {
>> +		tp->second  =3D 0;
>> +		tp->minute  =3D 0;
>> +		tp->hour =3D 0;
>> +		tp->day  =3D 1;
>> +		tp->month  =3D 1;
>> +		tp->year =3D 0;
>> +		return;
>> +	}
>> +
>> +	if (second >=3D UNIX_SECS_2108) {
>
> Hello, this code cause compile errors on 32bit systems as UNIX_SECS_2108
> macro is not defined when BITS_PER_LONG =3D=3D 32.
>
> Value 4354819200 really cannot fit into 32bit signed integer, so you
> should use 64bit signed integer. I would suggest to define this macro
> value via LL not just L suffix (and it would work on both 32 and 64bit)
Okay.
>
>   #define UNIX_SECS_2108    4354819200LL
>
>> +		tp->second  =3D 59;
>> +		tp->minute  =3D 59;
>> +		tp->hour =3D 23;
>> +		tp->day  =3D 31;
>> +		tp->month  =3D 12;
>> +		tp->year =3D 127;
>> +		return;
>> +	}
Okay, I will check it.
Thanks for your review!
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com
>
