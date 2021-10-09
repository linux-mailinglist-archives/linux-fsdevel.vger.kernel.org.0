Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86884427B83
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Oct 2021 17:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbhJIP5z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Oct 2021 11:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbhJIP5z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Oct 2021 11:57:55 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07926C061570;
        Sat,  9 Oct 2021 08:55:58 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y26so52811252lfa.11;
        Sat, 09 Oct 2021 08:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j/DYc5RlEP9xD1mKY1rOuN9uAOFnxVcUhKzBUCb0KHA=;
        b=En3HqArde3AYFU8Z4EK7mbyPL46PD3IgVLmThH7v24uSEZ65qfN7+/OX/10vE2Odce
         eQqJeLAczkojv5Jz4nI1KHgoSYvp8/xAom0MoR5x7DeUBMqiew3x8bwq4op1rmI3YtMm
         pRhE6ZKCd3Ap2z0EroxC3gABsYs1a526I46fnFxkrSlCzjAUQ+n9DVBCzuRSUjuQ7sgB
         XSIShQcQLiV/lu1FaFw3KyEeweinOExrqdgWQH/pXM49AcrA+lgVF0YRHnPGEzPuWgtI
         6GwP/+c7OtcTY02ALZGH16ycfpye0goP9dymJg5MvBayaDaXLVTHnd7BoLte0mHiEMzL
         7+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j/DYc5RlEP9xD1mKY1rOuN9uAOFnxVcUhKzBUCb0KHA=;
        b=DMy2w2EvMpx+MZV4K2utZoIyD31eD/A5zYW00Jw9dS6UAGLtth/6FoQWW57f9OUYtv
         k0ibwxCr2Rz274+MWHXmiSJ6kUCOzBo9l5mkYNxDjswNSswpBqYMLzKZZC9D3nnlxbMZ
         Z7kk1mVfc0HmY8rZaN+pgzm6h4YctUM22KtZbWxnnklbx6xxsyVoKN4XrqsiHCkekx9H
         Z9rKFAnsMgkT/WSdUM8jZzGQTFsuk44xpjUxGtrkF65HTQnifdU9mgBXRxs8zETMzG8z
         83G8CWr2c9AYcas5V6CrVuuYWw/Dof6yJ6yXRzYQarl3klIJNqswPMStuFxmHKQ3tVBZ
         6DmA==
X-Gm-Message-State: AOAM532KJpnZX2VjB+4FbOYBmrv0WVstziyoK1VyR2PN5FrcORyoiL0O
        RAyNUhi0FwsKiA1jDx0qksTUlJcIOEU=
X-Google-Smtp-Source: ABdhPJxLNB2YyndYag8YdX9NyMD94LLlHOHGLbAnP1JUyquRzNpjKX0xYaBP2rm+fkSMfCGpXwlRhw==
X-Received: by 2002:a05:6512:3e21:: with SMTP id i33mr16830858lfv.535.1633794956390;
        Sat, 09 Oct 2021 08:55:56 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id w18sm132498ljj.134.2021.10.09.08.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 08:55:55 -0700 (PDT)
Date:   Sat, 9 Oct 2021 18:55:53 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs/ntfs3: Keep prealloc for all types of files
Message-ID: <20211009155553.ujyj5zilm327ksi2@kari-VirtualBox>
References: <bb2782a2-d6af-ef7e-2e35-3b1d87a11ff7@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb2782a2-d6af-ef7e-2e35-3b1d87a11ff7@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 05, 2021 at 06:55:44PM +0300, Konstantin Komarov wrote:
> Before we haven't kept prealloc for sparse files because we thought that
> it will speed up create / write operations.
> It lead to situation, when user reserved some space for sparse file,
> filled volume, and wasn't able to write in reserved file.
> With this commit we keep prealloc.
> Now xfstest generic/274 pass.

Is it possible that you make repo for xfstests which contain changes
what you have done for it. Testing example 274 will need modifications
to xfstests so testing this will take too much time for me.

Hopefully we will get ntfs3 support to upstream xfstest but I totally
understand if you do not have time for it. That is why I ask that just
make repo for github and just but your changes to there so that someone
can make upstream support.

  Argillander

> Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
> v2:
>   Expanded commit message.
> 
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
