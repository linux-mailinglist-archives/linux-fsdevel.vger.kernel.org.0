Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB2942036F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Oct 2021 20:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhJCSfr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Oct 2021 14:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbhJCSfq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Oct 2021 14:35:46 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCD8C0613EC;
        Sun,  3 Oct 2021 11:33:58 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g41so61779612lfv.1;
        Sun, 03 Oct 2021 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6ld3v+0ySEBMVkEPVI+FUdLyKyTOtGpdAbK3HoW8fmY=;
        b=o0/sEgwPEJTjKwcRN4G7/YBpKzV5C1k2JVbKag7CsUXgFHkm+tGu80j/+sdEiihDiJ
         McZIGTZLtx082Vy9+vyhPoJwUSP+xQqlD9IvBIe4faebTuSCiwNvZFPIKlSB5PWoOa3L
         4mVtefvCMySZC0ESDrR9nwma7TSHR0mkrN5lfqiEoAjLo2iQeAzuheEkhJFPEZsNwmUo
         XHu5/m39MBDLClNt5YXi7GH4VqyMqszsiR2LmLo8SyNPpibt44lrZI1Lq6JOxUwP1C4N
         IpcwbOHUuUEOqQIUeTREmme88wQbTqZRkTDGPYJuk9wIJe5pQ8/I5uc3TWjRyRXeKtgJ
         uggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6ld3v+0ySEBMVkEPVI+FUdLyKyTOtGpdAbK3HoW8fmY=;
        b=pxweFpVpezeTQTCtwaakBtVTlkow8Y00LHY6oqqTCqUW6LdSk/FheC5LJBvTpxwpyE
         bDT2BbZUgT9wFvQID7Q8n1yzx/fl1bB+z/4zrv09yC3OzU+cnRe7Xfo/o9H9yDLZZ0NJ
         c7+TPc/m7xvBl8/g/zkiQ6Q3OuZp0npFCJ4+X6vxBvHKxN5nEUqVBcxu/lENAevbCFBV
         ulBa6ZHD37yPpaOvzYOd9OAwgy7hCHFw0a7ZV5ILY5pH2DdhAYp+nAxJuH7xTDQFtaJl
         3FNGfcJN/Xi/ZGm0LpSHkq4iZCb/j61xvF0/zDdH83j5UgCKfpyBFHtu58CDBftFEMfy
         dalQ==
X-Gm-Message-State: AOAM533VKlmdMggksWgJ4cMPJ2+ynxtCXbAzpUFWBbHHK6A62LUWRHl3
        eNjFPru0PoJfD7fBE/JC8zXtAGCdAfE=
X-Google-Smtp-Source: ABdhPJyrwIHI+FgfZsnJBvZ9J1VtFdog5Zq1pnPXJlDlKclv5VEPT11Ek+8W7ElUkkDWSmEaEhzYWw==
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr10045935lfu.294.1633286036603;
        Sun, 03 Oct 2021 11:33:56 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id p23sm1353199ljm.127.2021.10.03.11.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 11:33:56 -0700 (PDT)
Date:   Sun, 3 Oct 2021 21:33:54 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/ntfs3: Keep prealloc for all types of files
Message-ID: <20211003183354.sperk5m7ertakdfz@kari-VirtualBox>
References: <ed3dc0b6-2fd4-5be0-2815-9f2504d8e1b5@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed3dc0b6-2fd4-5be0-2815-9f2504d8e1b5@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 01, 2021 at 06:58:03PM +0300, Konstantin Komarov wrote:
> Fixes: xfstest generic/274

I would always hope at least couple sentence to commit message. It would
be easier if you do this in first place and I do not need to ask it
everytime. Again I'm straight away thinking why this was done this way
in a first place. There has to be reason. Was that reason totally wrong
in a first place? Does this patch has some drawbacks? Quick look it
looks it might have, but please write about it so reviewer job is little
easier and we get more meaningfull history.

This also again needs fixes tag with prober commit id as
this seems like a bug if this fix xfstests case.

> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/attrib.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
> index 8a00fa978f5f..e8c00dda42ad 100644
> --- a/fs/ntfs3/attrib.c
> +++ b/fs/ntfs3/attrib.c
> @@ -447,11 +447,8 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
>  again_1:
>  	align = sbi->cluster_size;
>  
> -	if (is_ext) {
> +	if (is_ext)
>  		align <<= attr_b->nres.c_unit;
> -		if (is_attr_sparsed(attr_b))
> -			keep_prealloc = false;
> -	}
>  
>  	old_valid = le64_to_cpu(attr_b->nres.valid_size);
>  	old_size = le64_to_cpu(attr_b->nres.data_size);
> @@ -461,9 +458,6 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
>  	new_alloc = (new_size + align - 1) & ~(u64)(align - 1);
>  	new_alen = new_alloc >> cluster_bits;
>  
> -	if (keep_prealloc && is_ext)
> -		keep_prealloc = false;
> -
>  	if (keep_prealloc && new_size < old_size) {
>  		attr_b->nres.data_size = cpu_to_le64(new_size);
>  		mi_b->dirty = true;
> -- 
> 2.33.0
> 
