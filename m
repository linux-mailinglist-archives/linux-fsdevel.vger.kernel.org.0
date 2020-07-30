Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342C223318C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 14:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgG3MDP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 08:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgG3MDO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:03:14 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A50C061794;
        Thu, 30 Jul 2020 05:03:13 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a14so2771210edx.7;
        Thu, 30 Jul 2020 05:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kTyIB8a8ynCW3WqaP6UVysZ6xRftgn4zqn+hfslnyfk=;
        b=UwzAb5zoVB/2SjBmyyK0tLHY6mooRDRvP1GGboYTwuAR8aHTPIErlWnGYl+QMCAnIL
         yQA5KglMPV1nEtOb7DHGActKRO3l8MWgwOdaNahAYgA3kHgOmBgMXlGd2HI9I8iRrQrJ
         wJgVaeOvoH9XzlJzskZo1NyVdWeLw8x2PUPy1EZNT20QfesYz3oX5U7qNS1xgX7sfzrF
         ENVjmOvisgVOKKSpbzThAIbdpGEoAqwPm4q8ioaTNwxJIf0jtmIbYv7mae6ThqRWT497
         KWPqBviEq0zDV183wqqQXIByMXeJUlfa7qFmI44NwRQI+wpNK/TIMHfUciugJyaNUJpg
         VLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=kTyIB8a8ynCW3WqaP6UVysZ6xRftgn4zqn+hfslnyfk=;
        b=JTy4grDlktV05AKMPFIPtatj4/l1ntNcQcR+1kWY4SLBS1ZiE9tT+/44Dr8AtT56UZ
         Pzwqp/v2hI9YyzXlDdgE2B4gIlUdWjs3csOoPQsTqjZdlS4eA3/QkYz0sMWXAv3YbC0Z
         mhyKQTPn1D4O/kfrHWfaGJN2e7pqkDrgN+j+PXsf3ET5x+m6ZzZ/JAMUXgBqhKyPjtRk
         FbXBalo56zeYW5oJ3YZ1Pi4H8WP731Ua6aFKRLqMU+WQSX2rJ1FafxZwa1jz1yWAN4yx
         aMWOIJYlYXLN8bZdle45JPiKQpJoopx0Y7f8OkE4gPhvHmjCOsxjnggjfc4nSf6ChfBe
         yBXQ==
X-Gm-Message-State: AOAM532DLIwc9MSPYKO/PgE9ic9FkTm+iaP7Phz3AByYOnSqI3ILdaOP
        JiN97/gH4SuhxmGzBQ6XzYINVxYe
X-Google-Smtp-Source: ABdhPJz6WS7N0D21c7MBqLBmnP9+Pig+3y1KgatNCRD3IGpud2kNLYc1R2efcFjX5Wl6CLo5SVCOnQ==
X-Received: by 2002:aa7:ca4f:: with SMTP id j15mr1460242edt.334.1596110591672;
        Thu, 30 Jul 2020 05:03:11 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id b18sm5628976ejc.41.2020.07.30.05.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 05:03:11 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [Linaro-mm-sig] [PATCH] dma-resv: lockdep-prime
 address_space->i_mmap_rwsem for dma-resv
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     linux-xfs@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-rdma@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Dave Chinner <david@fromorbit.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@mellanox.com>, Qian Cai <cai@lca.pw>,
        linux-fsdevel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-media@vger.kernel.org
References: <20200728135839.1035515-1-daniel.vetter@ffwll.ch>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b9b42b4e-78cd-ed10-5ce5-a9261b018e08@gmail.com>
Date:   Thu, 30 Jul 2020 14:03:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728135839.1035515-1-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 28.07.20 um 15:58 schrieb Daniel Vetter:
> GPU drivers need this in their shrinkers, to be able to throw out
> mmap'ed buffers. Note that we also need dma_resv_lock in shrinkers,
> but that loop is resolved by trylocking in shrinkers.
>
> So full hierarchy is now (ignore some of the other branches we already
> have primed):
>
> mmap_read_lock -> dma_resv -> shrinkers -> i_mmap_lock_write
>
> I hope that's not inconsistent with anything mm or fs does, adding
> relevant people.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: linux-xfs@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Thomas Hellström (Intel) <thomas_os@shipmail.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: linux-mm@kvack.org
> Cc: linux-rdma@vger.kernel.org
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/dma-buf/dma-resv.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
> index 0e6675ec1d11..9678162a4ac5 100644
> --- a/drivers/dma-buf/dma-resv.c
> +++ b/drivers/dma-buf/dma-resv.c
> @@ -104,12 +104,14 @@ static int __init dma_resv_lockdep(void)
>   	struct mm_struct *mm = mm_alloc();
>   	struct ww_acquire_ctx ctx;
>   	struct dma_resv obj;
> +	struct address_space mapping;
>   	int ret;
>   
>   	if (!mm)
>   		return -ENOMEM;
>   
>   	dma_resv_init(&obj);
> +	address_space_init_once(&mapping);
>   
>   	mmap_read_lock(mm);
>   	ww_acquire_init(&ctx, &reservation_ww_class);
> @@ -117,6 +119,9 @@ static int __init dma_resv_lockdep(void)
>   	if (ret == -EDEADLK)
>   		dma_resv_lock_slow(&obj, &ctx);
>   	fs_reclaim_acquire(GFP_KERNEL);
> +	/* for unmap_mapping_range on trylocked buffer objects in shrinkers */
> +	i_mmap_lock_write(&mapping);
> +	i_mmap_unlock_write(&mapping);
>   #ifdef CONFIG_MMU_NOTIFIER
>   	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
>   	__dma_fence_might_wait();

