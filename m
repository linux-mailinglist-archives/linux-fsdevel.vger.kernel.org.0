Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8750B776A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 06:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfG0Egf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jul 2019 00:36:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39319 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfG0Egf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jul 2019 00:36:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so3172522wrt.6;
        Fri, 26 Jul 2019 21:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fgu+GGVg1EZygpoH3s9DclHYrB/yjZrN74J1ygtmHDM=;
        b=rCdaI5ow4Gypn3RIkjHZYS/h7C40k7HDxGmk4PNXBdQyErnWDTj5cewNyXnH9m9Ibc
         KWgiqyGFfnJyAJxcfuXfIGHiSY4GAexpXh+1OhSaIo227T1Iu7jqhJRpueo4l3EfKiXX
         SoDKLDixvK8YmE9NPbZiTmSWtQvBcuc5m5pxS6/JCxZo5dP8SHEbyHjxlsiHnAbbeSCq
         DbjXiK7OAS2UkXQVMBvKp+5HZpL6ObcsyxE+0js4AzVPtRbP6meDeazRmXiuyRJEEIcB
         5ZQMwgtb0aFPAWSTUxMcMXHOC8RuOYyRhkNoblpDTMiEEbg//yDXpffEZQkU/SJ0BgI0
         lJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fgu+GGVg1EZygpoH3s9DclHYrB/yjZrN74J1ygtmHDM=;
        b=Q+Te0bzZ6Swz5DGb322R1+7H4KYEFL1QSs863E/cHmyKdDObQQsrPSiMiXpVRd4UaF
         2U6xBEHzjY1oXbNcDcOrPdLvbe6JrjsdgJwRIXjR/VKGt3lErOqLsNQUXiIqLWSwyBgp
         zJdQzrOr9KrXNFZ7cf1rvr+HT3jda3fRChYD881QsO7jbixiy3Fx36wFFeeWNXKRNLrc
         POi8o0XeCx6dsZGGU4GJGvNmUch7vg69oRgSZ/EZGhWdOM+MD9yaq+5vQWUiheHe33zA
         pnSsQjnrtwM5C+MHjS0MqjHZLAASqecFWYBWLlVG94v907v3CHmCfGKcpUFZ3K7XE56Y
         EC7A==
X-Gm-Message-State: APjAAAW8Jn7tDlj0AWKH1I5OWtS95a/GBq30X7rq2BpGrLA6NPRGo/wr
        IC0X4e+znUQmZMFmfui05ZjGTQ93hMw=
X-Google-Smtp-Source: APXvYqzccEi33UZ//inmdDXND5H+3IHNcEku4M74cRWUS5+7SqqAECOVxFTsB3ZmO3bcUki1fk+CJg==
X-Received: by 2002:adf:de8e:: with SMTP id w14mr3818862wrl.79.1564202193019;
        Fri, 26 Jul 2019 21:36:33 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id j33sm110096204wre.42.2019.07.26.21.36.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 21:36:32 -0700 (PDT)
Date:   Fri, 26 Jul 2019 21:36:31 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Chris Down <chris@chrisdown.name>
Subject: Re: mmotm 2019-07-24-21-39 uploaded (mm/memcontrol)
Message-ID: <20190727043631.GA125522@archlinux-threadripper>
References: <20190725044010.4tE0dhrji%akpm@linux-foundation.org>
 <4831a203-8853-27d7-1996-280d34ea824f@infradead.org>
 <20190725163959.3d759a7f37ba40bb7f75244e@linux-foundation.org>
 <20190727034205.GA10843@archlinux-threadripper>
 <20190726211952.757a63db5271d516faa7eaac@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726211952.757a63db5271d516faa7eaac@linux-foundation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 26, 2019 at 09:19:52PM -0700, Andrew Morton wrote:
> On Fri, 26 Jul 2019 20:42:05 -0700 Nathan Chancellor <natechancellor@gmail.com> wrote:
> 
> > > @@ -2414,8 +2414,9 @@ void mem_cgroup_handle_over_high(void)
> > >  	 */
> > >  	clamped_high = max(high, 1UL);
> > >  
> > > -	overage = ((u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT)
> > > -		/ clamped_high;
> > > +	overage = (u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT;
> > > +	do_div(overage, clamped_high);
> > > +
> > >  	penalty_jiffies = ((u64)overage * overage * HZ)
> > >  		>> (MEMCG_DELAY_PRECISION_SHIFT + MEMCG_DELAY_SCALING_SHIFT);
> > >  
> > > _
> > > 
> > 
> > This causes a build error on arm:
> > 
> 
> Ah.
> 
> It's rather unclear why that u64 cast is there anyway.  We're dealing
> with ulongs all over this code.  The below will suffice.

I was thinking the same thing.

> Chris, please take a look?
> 
> --- a/mm/memcontrol.c~mm-throttle-allocators-when-failing-reclaim-over-memoryhigh-fix-fix-fix
> +++ a/mm/memcontrol.c
> @@ -2415,7 +2415,7 @@ void mem_cgroup_handle_over_high(void)
>  	clamped_high = max(high, 1UL);
>  
>  	overage = (u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT;
> -	do_div(overage, clamped_high);
> +	overage /= clamped_high;
>  
>  	penalty_jiffies = ((u64)overage * overage * HZ)
>  		>> (MEMCG_DELAY_PRECISION_SHIFT + MEMCG_DELAY_SCALING_SHIFT);
> _
> 

I assume this will get folded in with the original patch but for
completeness (multi_v7_defconfig + CONFIG_MEMCG):

Tested-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the quick fix!
