Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8337512E667
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 14:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgABNRC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 08:17:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53913 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbgABNRC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 08:17:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id m24so5534867wmc.3;
        Thu, 02 Jan 2020 05:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5Ov6A1IS3Elx5Hi12ZOvyKLtjLuPVxWAlKpJ4puCzK8=;
        b=oIWuiAuyw/f9RlecYNULUKz4agq5Url8OSp+Q9s7r7uSdU6EcjklavuCj2ctQU2Lbk
         dwpuHKLTVZJD6OHbeBxuCIXeDxGTNv86ywJDuS3fv4BVU+LfA9HSOgx3n3EAdD0gsQzV
         KXV99qUtbQLxVWmUus0ScQudRHpc0MGnOt2stmcEb6lVxUAZ1RxQt+wFeWOytg8BhHLK
         Gmi8l68N8IW2UKFaGxtO80WLHfJKqSGg0mnBeSsppiQSbVwZhp4YjpuN0/poT1NDv9Dk
         fo4gHO0RTuQcS8vYG2ory6Mrgi77Xurv5FwzC/tDCNPG2hWzUQLYN1bwpozHJVqGN2cQ
         uKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5Ov6A1IS3Elx5Hi12ZOvyKLtjLuPVxWAlKpJ4puCzK8=;
        b=q9cf4ZjaQHszswyjKwHpg5fP1eUxD/sSYEO9t/CamEq0EvYwLI2bHH3Y0DRdmn7cW0
         Vt3nRPc2spxVTE5S81lRbjMiAEFIPVHd0EM0GbiGlV3c55YRoASIjYsF2/hsT+SarFi9
         6RhS33FjExmj1tzrQcZIN39aXDjnhw5w9zmsj/oY5zrQas12ZDMeMfHSvefzD4a7DOMd
         KLewKOijNBQS+hMV6C6LqI/rLQBRvoY7xBfOr9JP4DDljwERSzlOQdKIhYkXinEt1EdA
         TMHRdxgYjxr3ppM57ZUtH38qQntJkh8UxMPz6LKhgmp3u62+mGUCCRBqxWrt9RnxZ7Um
         nuNQ==
X-Gm-Message-State: APjAAAXoQTu4VeW2zW2iN7/qd70s02WvrgUnH5y1lPw7cFIsYA0su5Aa
        aDubygdSh7+KOuZEwT4ARKY=
X-Google-Smtp-Source: APXvYqxnoJdkJCOq9DBUebKMHvLkefHGXut6vB/tz4bIjyglfltBP9QETSdHFrrQ/ZqBlDf2MLG1iA==
X-Received: by 2002:a1c:a982:: with SMTP id s124mr14183647wme.132.1577971020707;
        Thu, 02 Jan 2020 05:17:00 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id f1sm55616958wro.85.2020.01.02.05.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 05:16:59 -0800 (PST)
Date:   Thu, 2 Jan 2020 14:16:59 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com
Subject: Re: [PATCH v8 02/13] exfat: add super block operations
Message-ID: <20200102131659.r2lxzcyhvtgxmz7m@pali>
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
 <CGME20191220062733epcas1p31665a3ae968ab8c70d91a3cddf529e73@epcas1p3.samsung.com>
 <20191220062419.23516-3-namjae.jeon@samsung.com>
 <20191229134025.qb3mmqatsn5c4gao@pali>
 <000701d5c132$bed73c80$3c85b580$@samsung.com>
 <20200102083029.uv2gtig3ski23dpe@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200102083029.uv2gtig3ski23dpe@pali>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 02 January 2020 09:30:29 Pali Rohár wrote:
> On Thursday 02 January 2020 15:06:16 Namjae Jeon wrote:
> > > > +static const struct fs_parameter_spec exfat_param_specs[] = {
> > > > +	fsparam_u32("uid",			Opt_uid),
> > > > +	fsparam_u32("gid",			Opt_gid),
> > > > +	fsparam_u32oct("umask",			Opt_umask),
> > > > +	fsparam_u32oct("dmask",			Opt_dmask),
> > > > +	fsparam_u32oct("fmask",			Opt_fmask),
> > > > +	fsparam_u32oct("allow_utime",		Opt_allow_utime),
> > > > +	fsparam_string("iocharset",		Opt_charset),
> > > > +	fsparam_flag("utf8",			Opt_utf8),
> > > 
> > > Hello! What is the purpose of having extra special "utf8" mount option?
> > > Is not one "iocharset=utf8" option enough?
> > utf8 nls_table supports utf8<->utf32 conversion and does not support
> > surrogate character conversion.
> 
> So in other words, this is just subset of UTF-8 just to 3 byte long
> sequences (for Unicode code points up to the U+FFFF).

Anyway, this is limitation of kernel's NLS framework? Or limitation in
current exfat driver implementation?

Because if it is in kernel's NLS framework then all kernel drivers would
be affected by this limitation, and not only exfat.

-- 
Pali Rohár
pali.rohar@gmail.com
