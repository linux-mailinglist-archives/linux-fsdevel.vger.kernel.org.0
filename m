Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BA062BAD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 12:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiKPLFM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 06:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiKPLE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:04:28 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A674F4AF22
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 02:51:01 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z18so25935473edb.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 02:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMt8HjKxItO2J6bIbRsCvEdSlAZpP8uC48lcisou+nI=;
        b=eLnGvKK+w1XqLxzowLTo19VxBdUCyRC3jZCwBMpKaUWXXlLi4fs0Axmuul/wRN/I3k
         Ls2daX/AS8NBqlkGiJqqxb0gEFzgn6n0a6+XnpTDtipAc3J5NayuL7HDBO33beS0D75x
         K2gRZhVXeM0+lA+7zcbmJS/RVo1YdOeZ/sxms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NMt8HjKxItO2J6bIbRsCvEdSlAZpP8uC48lcisou+nI=;
        b=7I26oV5Rk7b5EJ/4/0qfXPGJSP9JFdmMCP95e+hKOt/Koi90Sq0pKNeuiBf9KwWcSS
         ZPaBv4FXtzEfav+a+70EWVTAUIgAiZBEZwizTOxGHkK1NjggzoXt2vCs288ZgBubeuYF
         DynDvx8zeEQazGR+rSWFmCfGlkS7BJ8bkOrvZmH8ERktbs8ckpY8DW/0UAtAgWuRo3No
         E6kf0SFqsXNIYVw+SaZolgAZOjXsGZdsHwu1zeSoNbIAqX6N0CpEtjKOm/0c6cijSIFb
         TmbMQeAF5jjNHSenqPmcVkaJLLns+jQXFYCeGoei+Be4tz9dqvwBy8XJBu8AHhCUa6ZT
         2liQ==
X-Gm-Message-State: ANoB5pm2SnS+Fh1G/6eYdaaYaaksfDfaMxt95TPTd9xk4FFkPmochRIn
        skisxAU42GWnIYrkXkI2Y6DfQQ==
X-Google-Smtp-Source: AA0mqf4Z9KF9DYfdJQdqGvbtRloYOPQXnN3MkKcJxdOs80iDic7Ysg9e6qfGKtqJuC+1emfUPfQ+gw==
X-Received: by 2002:a50:ff04:0:b0:462:709:9f7b with SMTP id a4-20020a50ff04000000b0046207099f7bmr19331341edu.263.1668595860175;
        Wed, 16 Nov 2022 02:51:00 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id s6-20020a170906bc4600b007aed2057eaesm6056420ejv.161.2022.11.16.02.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:50:59 -0800 (PST)
Date:   Wed, 16 Nov 2022 11:50:57 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH mm-unstable v1 17/20] drm/exynos: remove FOLL_FORCE usage
Message-ID: <Y3TAkWy/xXfX1cIv@phenom.ffwll.local>
Mail-Followup-To: David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>, Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-18-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116102659.70287-18-david@redhat.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 16, 2022 at 11:26:56AM +0100, David Hildenbrand wrote:
> FOLL_FORCE is really only for ptrace access. As we unpin the pinned pages
> using unpin_user_pages_dirty_lock(true), the assumption is that all these
> pages are writable.
> 
> FOLL_FORCE in this case seems to be a legacy leftover. Let's just remove
> it.
> 
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Plus ack for merging through the appropriate non-drm tree.
-Daniel

> ---
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> index 471fd6c8135f..e19c2ceb3759 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> @@ -477,7 +477,7 @@ static dma_addr_t *g2d_userptr_get_dma_addr(struct g2d_data *g2d,
>  	}
>  
>  	ret = pin_user_pages_fast(start, npages,
> -				  FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
> +				  FOLL_WRITE | FOLL_LONGTERM,
>  				  g2d_userptr->pages);
>  	if (ret != npages) {
>  		DRM_DEV_ERROR(g2d->dev,
> -- 
> 2.38.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
