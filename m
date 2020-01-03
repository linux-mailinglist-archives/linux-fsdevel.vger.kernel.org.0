Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20ED512F634
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 10:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgACJke (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 04:40:34 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33723 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgACJkd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 04:40:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id d139so6592325wmd.0;
        Fri, 03 Jan 2020 01:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=z1sUFXN33eMwyXE2eTCARUGnX+8et5EQa8hCrvn/5Sc=;
        b=SrA6nUwm62irmPRBtrIwVIEjOkRsJCbFyPHjC5DjnhhK6GTxXc6gsycA3ujsIMsxg4
         i45307YPC1MyEMM1skVyx952bf6FlRSt+9eGR6HQDHxzLtpG1i+rlrdI5TDeFR0lFhNt
         FQuE8WXIjy55PLxksj/zeFD6Hge9uwq3bREYpM71T+719ltp3HCOnklcTdUNqCFRePoN
         lgOIeKzNhoL26aEHgAX2x+cIoF36QBLdkOnXCgLVgq/6Mo50nxzAsNkQZBHfsrVrd6qt
         vBDFi/aK6mebP0Tz2CiaIyd0rindW0GCwXlHEcCd/JvpN71E9DaWbi9mR4MkgiOpH1Vl
         f2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z1sUFXN33eMwyXE2eTCARUGnX+8et5EQa8hCrvn/5Sc=;
        b=OD0873O05KrLOiWMT2+yEWzdYV5xuximdArr+6Ureizhf0bMdEIwT/XBThoLiSTfpS
         vINZGK9cPkYpzzqK5PW9qT3mMA54N8Gn4gW4NJtGPUzxNH2RzM4yWjb/WV1lZtINnMhS
         Y3rx10/shpDCrUypBFJ2WIUH3kiYCysQk+Rfz4KC4Ad8v6jM4O5YXxRG5eCgK0n85TK3
         xpIhCvELQnzTkoR6HgXiUCtY2UHnxSWvXLgxNMhiYW9dgDitSqOxJXB/Ul3l/MYbxQbx
         lF9vTGe33jJYkaN/GGQ2Xqj/3eZwiifxQR/yyINf0+dcxZ22vFwld60OHyljqKSr056B
         9Jcw==
X-Gm-Message-State: APjAAAVU3BeyUWe7MvbFXnv7ymyT6ydActxvTtCkbw4+14oJfDD+/hZN
        ipy1P3RpBHJwgEWJvJusu6M=
X-Google-Smtp-Source: APXvYqxyPaimcB9/3A8rmvZKsr/6QcbOuGvkDnZCyg40dhJrBadxWjEwJtWrw0vXqxqv0WQIMu5uUA==
X-Received: by 2002:a1c:6707:: with SMTP id b7mr19436777wmc.54.1578044431951;
        Fri, 03 Jan 2020 01:40:31 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id b17sm57646598wrp.49.2020.01.03.01.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 01:40:31 -0800 (PST)
Date:   Fri, 3 Jan 2020 10:40:30 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com
Subject: Re: [PATCH v9 10/13] exfat: add nls operations
Message-ID: <20200103094030.zg4p5bqos32gc4hy@pali>
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
 <CGME20200102082407epcas1p4cf10cd3d0ca2903707ab01b1cc523a05@epcas1p4.samsung.com>
 <20200102082036.29643-11-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200102082036.29643-11-namjae.jeon@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 02 January 2020 16:20:33 Namjae Jeon wrote:
> This adds the implementation of nls operations for exfat.
> 
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
>  fs/exfat/nls.c | 809 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 809 insertions(+)
>  create mode 100644 fs/exfat/nls.c
> 
> diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
> new file mode 100644
> index 000000000000..af52328e28ff
> --- /dev/null
> +++ b/fs/exfat/nls.c

...

> +static int exfat_convert_uni_to_ch(struct nls_table *nls, unsigned short uni,
> +		unsigned char *ch, int *lossy)
> +{
> +	int len;
> +
> +	ch[0] = 0x0;
> +
> +	if (uni < 0x0080) {
> +		ch[0] = uni;
> +		return 1;
> +	}
> +
> +	len = nls->uni2char(uni, ch, MAX_CHARSET_SIZE);
> +	if (len < 0) {
> +		/* conversion failed */
> +		if (lossy != NULL)
> +			*lossy |= NLS_NAME_LOSSY;
> +		ch[0] = '_';
> +		return 1;
> +	}
> +	return len;
> +}

Hello! This function takes one UCS-2 character in host endianity and
converts it to one byte (via specified 8bit encoding).

> +static int __exfat_nls_uni16s_to_vfsname(struct super_block *sb,
> +		struct exfat_uni_name *p_uniname, unsigned char *p_cstring,
> +		int buflen)
> +{
> +	int i, j, len, out_len = 0;
> +	unsigned char buf[MAX_CHARSET_SIZE];
> +	const unsigned short *uniname = p_uniname->name;
> +	struct nls_table *nls = EXFAT_SB(sb)->nls_io;
> +
> +	i = 0;
> +	while (i < MAX_NAME_LENGTH && out_len < (buflen - 1)) {
> +		if (*uniname == '\0')
> +			break;
> +
> +		len = exfat_convert_uni_to_ch(nls, *uniname, buf, NULL);
> +		if (out_len + len >= buflen)
> +			len = buflen - 1 - out_len;
> +		out_len += len;
> +
> +		if (len > 1) {
> +			for (j = 0; j < len; j++)
> +				*p_cstring++ = buf[j];
> +		} else { /* len == 1 */
> +			*p_cstring++ = *buf;
> +		}
> +
> +		uniname++;
> +		i++;
> +	}
> +
> +	*p_cstring = '\0';
> +	return out_len;
> +}
> +

This function takes UCS-2 buffer in host endianity and converts it to
string in specified 8bit encoding.

> +
> +int exfat_nls_uni16s_to_vfsname(struct super_block *sb,
> +		struct exfat_uni_name *uniname, unsigned char *p_cstring,
> +		int buflen)
> +{

Looking at the code and this function is called from dir.c to translate
exfat filename buffer stored in filesystem to format expected by VFS
layer.

On exfat filesystem file names are always stored in UTF-16LE...

> +	if (EXFAT_SB(sb)->options.utf8)
> +		return __exfat_nls_utf16s_to_vfsname(sb, uniname, p_cstring,
> +				buflen);
> +	return __exfat_nls_uni16s_to_vfsname(sb, uniname, p_cstring, buflen);

... and therefore above "__exfat_nls_uni16s_to_vfsname" function must
expect UTF-16LE buffer and not just UCS-2 buffer in host endianity.

So two other things needs to be done: Convert character from little
endian to host endianity and then process UTF-16 buffer and not only
UCS-2.

I see that in kernel NLS module is missing a function for converting
UTF-16 string to UTF-32 (encoding in which every code point is
represented just by one u32 variable). Kernel has only utf16s_to_utf8s()
and utf8_to_utf32().

> +}

Btw, have you tested this exfat implementation on some big endian
system? I think it cannot work because of missing conversion from
UTF-16LE to UTF-16 in host endianity (therefore UTF-16BE).

-- 
Pali Rohár
pali.rohar@gmail.com
