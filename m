Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EE8410493
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 09:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242517AbhIRHEU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Sep 2021 03:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241829AbhIRHEN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Sep 2021 03:04:13 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF085C061574;
        Sat, 18 Sep 2021 00:02:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id c8so42280727lfi.3;
        Sat, 18 Sep 2021 00:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Iv66vXX7J5CxDss690/EZstKTh3xBr9NHityj90xHw=;
        b=DvA6w6f/ngKAS8/lng5G6iiaY41TCj/QH4ysOzsPjMx8I8Y5EpF8yBmvPCjwpwcwjP
         VquTGOAOA0ivCj5hZ+HvEHevLA37n0xdD8cOauCz8Gx4kyS00Q8GxflfhiwbiCf1S6JM
         TR+Su8r2MskO53P/Pfk7rnFHp6Tgf0p1tFSiYYsB4k/X7APh7qwETBCM0rKsy/X02mR3
         SDT0Vyy9+yJM4lB2B9Aqul0C44scXIZOvB6Ciiq1BrfSBT52HrNQOr7JUxR3XbJ3DUtg
         rSxv4IhUsX3Dkaj5KrRk6iuVyuILg2Gh3A+LRnPI2F7Vrqr4VerBggEUAZK1WFHI4h7F
         i1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Iv66vXX7J5CxDss690/EZstKTh3xBr9NHityj90xHw=;
        b=3fpoLkQcW9lGBkGoO7fzJ9qyUS7NpN9mYQqvaeVnIgBTr16KXI7aZwUGNUn8wyp6h0
         xm9P6MN6M9PvwRgfU+nlZqduqdWHFb9iscZRmc0C+JseT4I6Z49JhVbJDfhIjO9EzExU
         gawB2OOi4oxtaiA7EsTQRgGJZsstbAEaIbVFYX+S7bEPl6i/wipEDvTq1xH8AH4BA2L8
         flvY8sXwRG95eBh0AYNsNTSFqXhg6cpd92+e4TS3cWxQY8f0GxoaVJsy31onavesfIdZ
         lbn9rIMr3NWUXvKs39tYLrFbIIGmKq9SAcDTHGcQPKaMi87LIOYaFtMfkgadZi+ycq+k
         6t+Q==
X-Gm-Message-State: AOAM532/MHvhQYuQGafwvFCFqgldLhunPkhY5NnNz9TaPg7COG4mYkzd
        OZRcBqQD/AWkKGzAXLsqneQ=
X-Google-Smtp-Source: ABdhPJwy/99eBz7Lj43jsyz8H9Lw3h+VtRNQz+J8LMOvad5b5T8RqUdrYEi3jJibj4e1LSruUFgsQA==
X-Received: by 2002:a2e:99d3:: with SMTP id l19mr1362376ljj.184.1631948568300;
        Sat, 18 Sep 2021 00:02:48 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id bu8sm700713lfb.216.2021.09.18.00.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 00:02:47 -0700 (PDT)
Date:   Sat, 18 Sep 2021 10:02:46 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs/ntfs3: Fix insertion of attr in ni_ins_attr_ext
Message-ID: <20210918070246.rhbbvjwnwfnd4f7u@kari-VirtualBox>
References: <a08b0948-80e2-13b4-ea22-d722384e054b@paragon-software.com>
 <9fd8b3d5-2f1e-29c3-282a-d2276b5d0db9@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fd8b3d5-2f1e-29c3-282a-d2276b5d0db9@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 13, 2021 at 06:12:58PM +0300, Konstantin Komarov wrote:
> Do not try to insert attribute if there is no room in record.
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

Reviewed-by: Kari Argillander <kari.argillander@gmail.com>

> ---
>  fs/ntfs3/frecord.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> index 938b12d56ca6..834cb361f61f 100644
> --- a/fs/ntfs3/frecord.c
> +++ b/fs/ntfs3/frecord.c
> @@ -956,6 +956,13 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
>  			continue;
>  		}
>  
> +		/*
> +		 * Do not try to insert this attribute
> +		 * if there is no room in record.
> +		 */
> +		if (le32_to_cpu(mi->mrec->used) + asize > sbi->record_size)
> +			continue;
> +
>  		/* Try to insert attribute into this subrecord. */
>  		attr = ni_ins_new_attr(ni, mi, le, type, name, name_len, asize,
>  				       name_off, svcn, ins_le);
> -- 
> 2.33.0
> 
> 
