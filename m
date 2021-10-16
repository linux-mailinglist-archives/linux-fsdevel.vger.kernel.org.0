Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8882F430280
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Oct 2021 13:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240352AbhJPL72 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Oct 2021 07:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237354AbhJPL71 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Oct 2021 07:59:27 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7F3C061570;
        Sat, 16 Oct 2021 04:57:19 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id oa4so9070295pjb.2;
        Sat, 16 Oct 2021 04:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u5MO7DkWYSqdzO3qOav/OWM6RlCDZkLzS8EdCFz7uvs=;
        b=mAH6CE6DMguHwb5ZWFxkZHaKGuOcA+WlqiVStDmUpPUVVtKspPmy1xmnhJPSgCMxVe
         AVIt/0IHGlUHyMom5+2kj+gmx5AC2uswJTxVwstRgKqXsvR3Sfp+Q9Q6Tpv2hBmZMzHL
         Dh1sVAqtpi8zIZebYT6cLCajOkdFgf4kfyKZjFlCd4mBckwq8dsYw0LfqwS9ZqyniYSS
         cb77HaXhnHJMDG+fuHiJIWLQLONEDxNVS7byOzYXSK2xLhO+vSBYS98qh7hsAe0htJl0
         J2FuIMCFuMyHyM2iHfAVFMwLGlRtp4BntzzUp5M38fCzRGwNpOVFFLGvEL9sf6ZkowTr
         ZpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u5MO7DkWYSqdzO3qOav/OWM6RlCDZkLzS8EdCFz7uvs=;
        b=0hf0V4N7nn9UBZuV2JF0/PwsfUEnhF4PnqDoMYBXtTu71DRMzghpkqi7+IjXC10ARz
         9QVt0wK7vEhfzRH1xo1rc6m/RGJiXccM3sMY7AkrW7EXDHJ8RZB8hSOkdcZL5RmbyZIW
         bZ1CpTtXyv590NANUYtoCclNTehBl8SwtM1Ij7l1qXCE+8qOJ5DFKFY8z7c1GR2sDGA7
         v4lNln+NqDG590gV+/eLM4+mbMeXP1cIgEd5+76dpmm72D42m4aXodgkhkCYt9X2X9hB
         dY7OxKt4NKgtoMWbXRtFjVZ39r4BTS9Z1TKL7cbCC1O1y57ceRBU9MNKkI3zzYSHk1du
         okag==
X-Gm-Message-State: AOAM532c78+Bj7ex3hr81KAPvxuvfYKnpS+DGA7yKvkhuUyyw2EP+jfZ
        CSKKsai8k7533BDALuS+u+2S3Y3iA7o=
X-Google-Smtp-Source: ABdhPJyc4Odc0xXmHIUlm+swXx8CC85V6niPe3fQSl5vJH4+yNbuM5h4XTz1SKA8xbPqUzydhieklQ==
X-Received: by 2002:a17:90b:4f4b:: with SMTP id pj11mr20437226pjb.4.1634385438903;
        Sat, 16 Oct 2021 04:57:18 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (24.151.64.34.bc.googleusercontent.com. [34.64.151.24])
        by smtp.gmail.com with ESMTPSA id w12sm1825851pgm.18.2021.10.16.04.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 04:57:18 -0700 (PDT)
Date:   Sat, 16 Oct 2021 11:57:15 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Not [PATCH] :)
Message-ID: <20211016115715.GA17291@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20211016115429.17226-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016115429.17226-1-42.hyeyoo@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 16, 2021 at 11:54:29AM +0000, Hyeonggon Yoo wrote:
> Hello, it seems there's mismatch in unit (byte and kB) in meminfo.
> Would something like this will be acceptable?
> 
> commit d42f3245c7e2 ("mm: memcg: convert vmstat slab counters
> to bytes") changed it to bytes but proc seems to print everything in
> kilobytes.
> 

This is not actually patch - I'll send you a patch
if this is not my misunderstanding :)

Thanks,
Hyeonggon.

> ---
>  fs/proc/meminfo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 6fa761c9cc78..182376582076 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -52,8 +52,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  		pages[lru] = global_node_page_state(NR_LRU_BASE + lru);
>  
>  	available = si_mem_available();
> -	sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
> -	sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
> +	sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B) / 1024;
> +	sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B) / 1024;
>  
>  	show_val_kb(m, "MemTotal:       ", i.totalram);
>  	show_val_kb(m, "MemFree:        ", i.freeram);
> -- 
> 2.27.0
> 
