Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D104058C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 16:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343857AbhIIORm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 10:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243663AbhIIORh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:17:37 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC9BC05ACF1;
        Thu,  9 Sep 2021 05:36:32 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id s10so3395979lfr.11;
        Thu, 09 Sep 2021 05:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QwiVhbC5w9i7Idj/dJDuFYurFbOrQGVL6Jy6zXvxSuk=;
        b=q6yLhuEjqVvg/BDMnA1qtYup1DXo46hpFkxKAwS0EnFwqg+dYpLKOhvEsDw/Oh0INC
         GJQC3XLmSb4YBBpnajRmL9gf1hAzYUbgv2x2+MmXiBfYZqtcv29AkPWAxbpgdlIwmUpM
         1ZJnfq1k+SQ9MXWsVxfy9meQ97xFqr+D3/kRgBbUcrnBc6ajIP9PypEydnZvfbzTsNs5
         6blD3uG3RjkVFa91G+s/H+XkfRONSGvd9h7mbwqoIJKsbQ+ZRHLe6zpYVcm2CPRaxFZn
         sJiJE0G4x832iDguljIf+JQ8y9nG0GB68GVRgL6JXjmktqsgtH0Zs1V8m9zk4UcQoQ1Q
         kPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QwiVhbC5w9i7Idj/dJDuFYurFbOrQGVL6Jy6zXvxSuk=;
        b=7rwmUoBKmA5HXvdukzWaLs5wyPigrZGMPmMr8g3/s8nL5kvYKpNPDweyQ0efp3/XQb
         4AspDfI4MKDRN6jhJqIh+Kz9UYDhjcJ18+MNVyhOk/488fR1HoSc9PUw9UCIddmm1gP8
         aVV3Iq2PVCivvkVTppI4v/IG3MWzv2Var6Z12H7vk6fY+9II6UnpVfGwUHNjfhGsdEcP
         J/nvIY+r1dlUYOLYNzaRomp3vnzFFrtpZ9nmjK1Wsd8zcr/fVlJtxHZYbDKlMxNqeriI
         54KsucNDYCOC1l2mz0VIgABloQYexLJOY0iilUX011RueTK7emrez+mc22HhdHv5+Otr
         KJpQ==
X-Gm-Message-State: AOAM533T9xjyPYHLWxHYlsHmoYMJCV9RSxWRZGA1/3S54uSqxC9kCwtD
        9/HZPuNPaBSNqptxiYjBesQ=
X-Google-Smtp-Source: ABdhPJwBgpkPXY0gmbVnYHEDaLXYyNBjkY11EjIpz5A+a5LOMaxlk0pYVyEo++Ob70qAwMwgDMLxXw==
X-Received: by 2002:a19:c107:: with SMTP id r7mr2208817lff.29.1631190990725;
        Thu, 09 Sep 2021 05:36:30 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id q22sm187387lfc.121.2021.09.09.05.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 05:36:30 -0700 (PDT)
Date:   Thu, 9 Sep 2021 15:36:28 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs/ntfs3: Fix insertion of attr in ni_ins_attr_ext
Message-ID: <20210909123628.m5agndj35sesdurv@kari-VirtualBox>
References: <732a18ee-20ea-3e53-056c-8a4d496e5522@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <732a18ee-20ea-3e53-056c-8a4d496e5522@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 09, 2021 at 01:57:59PM +0300, Konstantin Komarov wrote:
> Do not try to insert attribute if there is no room in record.
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/frecord.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> index 938b12d56ca6..5dd7b7a7c5e0 100644
> --- a/fs/ntfs3/frecord.c
> +++ b/fs/ntfs3/frecord.c
> @@ -956,6 +956,10 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
>  			continue;
>  		}
>  
> +		/* Do not try to insert this attribute if there is no room in record. */

Multiline comment as this gets very long.

> +		if (le32_to_cpu(mi->mrec->used) + asize > sbi->record_size)
> +			continue;
> +
>  		/* Try to insert attribute into this subrecord. */
>  		attr = ni_ins_new_attr(ni, mi, le, type, name, name_len, asize,
>  				       name_off, svcn, ins_le);
> -- 
> 2.28.0
