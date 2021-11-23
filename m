Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D369445ABE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 19:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhKWTCD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 14:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhKWTCC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 14:02:02 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78125C061574;
        Tue, 23 Nov 2021 10:58:53 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id z8so129040ljz.9;
        Tue, 23 Nov 2021 10:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XRspsMRPaJtungKQbxOEtTXjFNE8AKdkN2C98ZYyGQA=;
        b=Krxqtk55NMuwzYRWJZQJ5DKOhIsy7ybYa3bxuAJ3WGtcz7lZ9MLYiWqYk7ZMr3hLbk
         QHepYQ9nn/2vFIS5pBdZiPVrKfTw9YuwBPjSVVI4YacapQoeAFbNiusYE0FBY23L99No
         N/ISxnjn0Qivtu+q+Zgyc0kdyWGh6hVvTC6CuskhnRVSz9lo9/j/MybRwtU0feLNoM0i
         tjVFbDOgCAoqDfLQEshcVLifOfjYyW0SF+Abci6EjVwYAWYAchn8PVI0z5OJy861iirC
         dpV/+wSEvHOrhOGlT0kgJ2BO9YbvrmHCSvyEX/YVvxn1RtYJ0QZIycfP4NhpfuCr7FoN
         EM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XRspsMRPaJtungKQbxOEtTXjFNE8AKdkN2C98ZYyGQA=;
        b=CVnJe76ASdab3wCJoCClvwyyoEB/YKarlmbXEdGcJ8YVxvYFLB4e7c1ldA3jJgqO1n
         puq8lwVXmemd4A7AoPu8zsfXmYBOITerMKARzQN35MqKK4EB2y3XLIZQG5vbtjG0K28h
         rmgGISCi2ZxG9zhMF67T1a0BuoqK0vbB4V51hrlvIF848DmJ/u4iPo6On6Wu9eBfXarQ
         VXS7eO3splRLxZaAVpTzQ3aMGhZ6EC7KGhHy4TgOxwxBMfZaqg+1VkdgeQSwXf8kl+pZ
         KYoYarTHhvwilGS7LTLbO3320wMNwsp6XedDVBNvKK1sIRwuzEy0X6pv056N/kiItEFj
         Lgcw==
X-Gm-Message-State: AOAM533mLMc3gzBf87pIjPNnOOcwlyd2+W9nBPAhRq8XdKN47mO0rFmt
        Z0MJMxIZUF0B31YngZlLY1M=
X-Google-Smtp-Source: ABdhPJwFGNtTp+8q9Y2BLeh14CXJInlfm02IMs9ncnXTl5MeDFRrNPhdS0dOieduxlypXLXU80jv2A==
X-Received: by 2002:a2e:b5d8:: with SMTP id g24mr7983999ljn.250.1637693931744;
        Tue, 23 Nov 2021 10:58:51 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id v7sm1347806ljd.31.2021.11.23.10.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 10:58:51 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 23 Nov 2021 19:58:49 +0100
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 3/4] mm/vmalloc: be more explicit about supported gfp
 flags.
Message-ID: <YZ056Y8GaDrG5Miu@pc638.lan>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-4-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122153233.9924-4-mhocko@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 22, 2021 at 04:32:32PM +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> b7d90e7a5ea8 ("mm/vmalloc: be more explicit about supported gfp flags")
> has been merged prematurely without the rest of the series and without
> addressed review feedback from Neil. Fix that up now. Only wording is
> changed slightly.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/vmalloc.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index b6aed4f94a85..b1c115ec13be 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3021,12 +3021,14 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>   *
>   * Allocate enough pages to cover @size from the page level
>   * allocator with @gfp_mask flags. Please note that the full set of gfp
> - * flags are not supported. GFP_KERNEL would be a preferred allocation mode
> - * but GFP_NOFS and GFP_NOIO are supported as well. Zone modifiers are not
> - * supported. From the reclaim modifiers__GFP_DIRECT_RECLAIM is required (aka
> - * GFP_NOWAIT is not supported) and only __GFP_NOFAIL is supported (aka
> - * __GFP_NORETRY and __GFP_RETRY_MAYFAIL are not supported).
> - * __GFP_NOWARN can be used to suppress error messages about failures.
> + * flags are not supported. GFP_KERNEL, GFP_NOFS and GFP_NOIO are all
> + * supported.
> + * Zone modifiers are not supported. From the reclaim modifiers
> + * __GFP_DIRECT_RECLAIM is required (aka GFP_NOWAIT is not supported)
> + * and only __GFP_NOFAIL is supported (i.e. __GFP_NORETRY and
> + * __GFP_RETRY_MAYFAIL are not supported).
> + *
> + * __GFP_NOWARN can be used to suppress failures messages.
>   *
>   * Map them into contiguous kernel virtual space, using a pagetable
>   * protection of @prot.
> -- 
> 2.30.2
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Vlad Rezki
