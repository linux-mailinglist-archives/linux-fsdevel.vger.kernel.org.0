Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2CDD12E455
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 10:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgABJTG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 04:19:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38318 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbgABJTG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 04:19:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id u2so5049603wmc.3;
        Thu, 02 Jan 2020 01:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dWNZKKTfhWgqpNzUjWdosrjzGH7DY1lOFlWq07DjZ+4=;
        b=ky5Nx8hFeyeWA3d+L8RGv0QV+ipVrbqtp1d4rRFv1v6obMoP1UqvWU5QWSqtEFxPCB
         /Y7b/bCs+th98Qb7IvNajCMoaCAT/T73lUts/cmlGzZh3fq5X9yw7EGc7ipxkP/Wdk/A
         mvxDDYJkRJdVXFDlVTBHD4VXVDfcdy1KRHvTUazW8+R1EjdTniu3iV9tpgwGiTUwo9zk
         fq4lXOWKzdDJBTqyVbgaYOXQM++0Kj0fegHtndSn3RTiPrZxBj6XLcO4o2S45UWMChLI
         MAFun2ahgD3MlBALqi4bmtg6YeOsLgCfhYv7OlcSuhdYl89WqMS8xEPbX9xUNiOULkev
         3I2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dWNZKKTfhWgqpNzUjWdosrjzGH7DY1lOFlWq07DjZ+4=;
        b=TYEZoVGlc9/el2JcqFg6AqlBUQCa/t8k4aa1U0dtsu0BN040hjapbx6LvLQuLkFy2G
         kn7gLuhea/OgoUdfajK8Qktd25rCOfhYD8dHw/ARcA1iAFNW5fuwbIAZutZEJmnN4qUj
         C/RmEyUyuaGzYmc0NIC6dpD75KXrB2nHhXEBvfLit5uj8Pq/onGICp/FBDwzuaf88EVj
         whmtZ2q1OJ91BgD4Hw2HM92ofH+cfpeZVhNYXy13XronCfwUQTock5M8cv3yD0OGksVD
         d1p6XVZkMUj8RZPLFol01CuHjGYLvhQJ6InDVhWzcZMMQRpX/h154kkozq/BWPWDvFLf
         V1DQ==
X-Gm-Message-State: APjAAAUY60w6YGEbi/UjKV8Eb4vJpyU+LcA6hnIlx1Epdmg30GeYy/xh
        HbKaFJdlNoWsaWX/ABS6v9M=
X-Google-Smtp-Source: APXvYqwrZ71OWc4HSl1aU/0CvAAoZpWoLas1vEdDY6BzcirNs29twD10L9XbKUbhxHp+/KMRhinucg==
X-Received: by 2002:a1c:c919:: with SMTP id f25mr13301843wmb.49.1577956744098;
        Thu, 02 Jan 2020 01:19:04 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x18sm55457022wrr.75.2020.01.02.01.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 01:19:03 -0800 (PST)
Date:   Thu, 2 Jan 2020 10:19:02 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com
Subject: Re: [PATCH v9 09/13] exfat: add misc operations
Message-ID: <20200102091902.tk374bxohvj33prz@pali>
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
 <CGME20200102082406epcas1p268f260d90213bdaabee25a7518f86625@epcas1p2.samsung.com>
 <20200102082036.29643-10-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200102082036.29643-10-namjae.jeon@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 02 January 2020 16:20:32 Namjae Jeon wrote:
> This adds the implementation of misc operations for exfat.
> 
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
>  fs/exfat/misc.c | 253 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 253 insertions(+)
>  create mode 100644 fs/exfat/misc.c
> 
> diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
> new file mode 100644
> index 000000000000..7f533bcb3b3f
> --- /dev/null
> +++ b/fs/exfat/misc.c

...

> +/* <linux/time.h> externs sys_tz
> + * extern struct timezone sys_tz;
> + */
> +#define UNIX_SECS_1980    315532800L
> +
> +#if BITS_PER_LONG == 64
> +#define UNIX_SECS_2108    4354819200L
> +#endif

...

> +#define TIMEZONE_CUR_OFFSET()	((sys_tz.tz_minuteswest / (-15)) & 0x7F)
> +/* Convert linear UNIX date to a FAT time/date pair. */
> +void exfat_time_unix2fat(struct exfat_sb_info *sbi, struct timespec64 *ts,
> +		struct exfat_date_time *tp)
> +{
> +	time_t second = ts->tv_sec;
> +	time_t day, month, year;
> +	time_t ld; /* leap day */

Question for other maintainers: Has kernel code already time_t defined
as 64bit? Or it is still just 32bit and 32bit systems and some time64_t
needs to be used? I remember that there was discussion about these
problems, but do not know if it was changed/fixed or not... Just a
pointer for possible Y2038 problem. As "ts" is of type timespec64, but
"second" of type time_t.

> +
> +	/* Treats as local time with proper time */
> +	second -= sys_tz.tz_minuteswest * SECS_PER_MIN;
> +	tp->timezone.valid = 1;
> +	tp->timezone.off = TIMEZONE_CUR_OFFSET();
> +
> +	/* Jan 1 GMT 00:00:00 1980. But what about another time zone? */
> +	if (second < UNIX_SECS_1980) {
> +		tp->second  = 0;
> +		tp->minute  = 0;
> +		tp->hour = 0;
> +		tp->day  = 1;
> +		tp->month  = 1;
> +		tp->year = 0;
> +		return;
> +	}
> +
> +	if (second >= UNIX_SECS_2108) {

Hello, this code cause compile errors on 32bit systems as UNIX_SECS_2108
macro is not defined when BITS_PER_LONG == 32.

Value 4354819200 really cannot fit into 32bit signed integer, so you
should use 64bit signed integer. I would suggest to define this macro
value via LL not just L suffix (and it would work on both 32 and 64bit)

  #define UNIX_SECS_2108    4354819200LL

> +		tp->second  = 59;
> +		tp->minute  = 59;
> +		tp->hour = 23;
> +		tp->day  = 31;
> +		tp->month  = 12;
> +		tp->year = 127;
> +		return;
> +	}

-- 
Pali Rohár
pali.rohar@gmail.com
