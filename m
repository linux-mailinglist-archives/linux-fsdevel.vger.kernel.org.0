Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 092DF12E3E7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 09:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbgABIad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 03:30:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51863 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgABIac (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 03:30:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id d73so4916786wmd.1;
        Thu, 02 Jan 2020 00:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cRA5UVy21UN6dx2Qu5x3A9NVTLMX1jIGtdux3DRTZi0=;
        b=VKHqU4TKviMD3V2ScKm0W9Lw0Sk9giP+++S/ooIPT/aqNYjT5nu96Nl8U+odxA7ZuM
         RHOt6YPQx0YiRCgyylRY1P5b1mHvxwZRf+jmFFDvoiwLxNwixuEi1+aaKEWHGmrvn+KI
         KtEQQzrkna0S7O0W9KzkKEv6566lVsQnC0rofLvbNk4x1occ509mXasZd0KS2N7K8h3n
         C9BSccSSpSB1wtrbSS7aAHJP0xmbnMzd9CXfnQ2A2bNsEPNpbRBB1cUo2jLp7PjznENe
         KNEBta4QcRgfJcTbv6j2NemQibn9eqJyohRX6htPPzgv1bxwtaWL9SQRHO6CEepXhPlm
         z8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cRA5UVy21UN6dx2Qu5x3A9NVTLMX1jIGtdux3DRTZi0=;
        b=csNlzMM7JGasLgbN68nGqInfg2gUJJxVK+RYeXpWVstES/hA0+jEQwUhiSitebt1YT
         JvWfmN8jijv2PVz6FXpfq/4w5TYF6Eyh8mg09xc8eqYZCWEoTUMrdeMwCwAS05PjbqtQ
         0BuTXhAz7s8j35QqmneZxkBh1z3JMI2iJkvNzkKFD5HxJumdQSCWSw17RhJfkr7LyRuL
         us71MPEn1bMoF8UMo5QbmTl69hijbbzUzMLQl6LOiwF7LSO9Jwd+y+A7vZRndqkMiBbr
         fiNSH8zu/FqbDYb2ZTgjzl2s60bDvNMqrTqHmJKyIt8mSFkKY77bBSRhJQQNiMVMAaf+
         bRSw==
X-Gm-Message-State: APjAAAVzC5QBMbmraFyLBtMIAxUwhKWKlBQrpj/BHXz3LxsfgwkoAD/O
        QLrh+QyHefmeHAVuP0q9u5w=
X-Google-Smtp-Source: APXvYqxdrkvInhhSWiKnZlCOsPojT6xfRgodoe5qmviVFC2wVVnHxGm2u2iYYTz7EQ/6e2CNDYVrhg==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr12944271wmb.81.1577953830730;
        Thu, 02 Jan 2020 00:30:30 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id a9sm7633562wmm.15.2020.01.02.00.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 00:30:30 -0800 (PST)
Date:   Thu, 2 Jan 2020 09:30:29 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com
Subject: Re: [PATCH v8 02/13] exfat: add super block operations
Message-ID: <20200102083029.uv2gtig3ski23dpe@pali>
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
 <CGME20191220062733epcas1p31665a3ae968ab8c70d91a3cddf529e73@epcas1p3.samsung.com>
 <20191220062419.23516-3-namjae.jeon@samsung.com>
 <20191229134025.qb3mmqatsn5c4gao@pali>
 <000701d5c132$bed73c80$3c85b580$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000701d5c132$bed73c80$3c85b580$@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 02 January 2020 15:06:16 Namjae Jeon wrote:
> > > +static const struct fs_parameter_spec exfat_param_specs[] = {
> > > +	fsparam_u32("uid",			Opt_uid),
> > > +	fsparam_u32("gid",			Opt_gid),
> > > +	fsparam_u32oct("umask",			Opt_umask),
> > > +	fsparam_u32oct("dmask",			Opt_dmask),
> > > +	fsparam_u32oct("fmask",			Opt_fmask),
> > > +	fsparam_u32oct("allow_utime",		Opt_allow_utime),
> > > +	fsparam_string("iocharset",		Opt_charset),
> > > +	fsparam_flag("utf8",			Opt_utf8),
> > 
> > Hello! What is the purpose of having extra special "utf8" mount option?
> > Is not one "iocharset=utf8" option enough?
> utf8 nls_table supports utf8<->utf32 conversion and does not support
> surrogate character conversion.

So in other words, this is just subset of UTF-8 just to 3 byte long
sequences (for Unicode code points up to the U+FFFF).

> The utf8 option can support the surrogate
> character conversion of utf16 using utf16s_to_utf8s/utf8s_to_utf16s of
> the nls base.

So this is full UTF-8 support, right?

And what is the point to have two options for UTF-8 support, when one is
incomplete / broken? I see no benefit to have first option at all.
Providing incomplete / broken support to userspace does not make much
sense if we already have full and working support via different mount
option. Maybe second option with full UTF-8 support should be used also
by iocharset=utf8 and then we do not need utf8 option at all?

-- 
Pali Rohár
pali.rohar@gmail.com
