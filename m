Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED27D3D6CCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 05:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbhG0CwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 22:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbhG0CwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 22:52:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074FFC061757;
        Mon, 26 Jul 2021 20:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=Z5OTHAoZBoL/SIl2ruEQOeyRsTlnOUVPwpimgyS/uS8=; b=OKHmk2zQ+VU1/UmXqMg+XTROia
        eCdPlEg03Z42i9H1TINqbUMFUo0zG3Nma0I2Rv5B0ifctio5yE7P/9ncedSMUbW8/jtrZwe+qJZd6
        0k+ajWQY71ticFXRcEXl8EbThQY2GxKLLOd1ramA2skbs/trFBklvKOjSrKxiURl2ljGfgti81tvT
        ISly06NfPvXfPY6oo26nXXdwyB+3esFPaqZ3qvDMr+kHGGLhf0A+aVxdT2DLozInlhZlfzw+9bDnS
        qJjUFB7Nyni5NmLzCvstoY/QD0JWrOkK/wB95lx8Ca/8zI5Zu/bFIqdOkiJAei8v7+oEM628yyTUc
        NQR2fQuA==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8Dpe-00D0NX-GD; Tue, 27 Jul 2021 03:32:38 +0000
Subject: Re: mmotm 2021-07-23-15-03 uploaded (mm/memory_hotplug.c)
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
References: <20210723220400.w5iKInKaC%akpm@linux-foundation.org>
 <5966f6a2-bdba-3a54-c6cb-d21aaeb8f534@infradead.org>
 <5394da5e-29f0-ff7d-e614-e2805400a8bb@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1549416a-05aa-108b-ec95-cac9d84febd1@infradead.org>
Date:   Mon, 26 Jul 2021 20:32:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5394da5e-29f0-ff7d-e614-e2805400a8bb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/26/21 12:14 AM, David Hildenbrand wrote:
> On 24.07.21 20:49, Randy Dunlap wrote:
>> On 7/23/21 3:04 PM, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2021-07-23-15-03 has been uploaded to
>>>
>>>     https://www.ozlabs.org/~akpm/mmotm/
>>>
>>> mmotm-readme.txt says
>>>
>>> README for mm-of-the-moment:
>>>
>>> https://www.ozlabs.org/~akpm/mmotm/
>>>
>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>> more than once a week.
>>>
>>> You will need quilt to apply these patches to the latest Linus release (5.x
>>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>>> https://ozlabs.org/~akpm/mmotm/series
>>>
>>> The file broken-out.tar.gz contains two datestamp files: .DATE and
>>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
>>> followed by the base kernel version against which this patch series is to
>>> be applied.
>>>
>>
>> on x86_64:
>> # CONFIG_CMA is not set
>>
>> mm-memory_hotplug-memory-group-aware-auto-movable-online-policy.patch
>>
>>
>>
>> ../mm/memory_hotplug.c: In function ‘auto_movable_stats_account_zone’:
>> ../mm/memory_hotplug.c:748:33: error: ‘struct zone’ has no member named ‘cma_pages’; did you mean ‘managed_pages’?
>>     stats->movable_pages += zone->cma_pages;
>>                                   ^~~~~~~~~
>>                                   managed_pages
>> ../mm/memory_hotplug.c:750:38: error: ‘struct zone’ has no member named ‘cma_pages’; did you mean ‘managed_pages’?
>>     stats->kernel_early_pages -= zone->cma_pages;
>>                                        ^~~~~~~~~
>>                                        managed_pages
>>
>>
> 
> Thanks Randy, the following on top should make it fly:
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index bfdaa28eb86f..fa1a0afd32ba 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -741,13 +741,15 @@ static void auto_movable_stats_account_zone(struct auto_movable_stats *stats,
>         if (zone_idx(zone) == ZONE_MOVABLE) {
>                 stats->movable_pages += zone->present_pages;
>         } else {
> +               stats->kernel_early_pages += zone->present_early_pages;
> +#ifdef CONFIG_CMA
>                 /*
>                  * CMA pages (never on hotplugged memory) behave like
>                  * ZONE_MOVABLE.
>                  */
>                 stats->movable_pages += zone->cma_pages;
> -               stats->kernel_early_pages += zone->present_early_pages;
>                 stats->kernel_early_pages -= zone->cma_pages;
> +#endif /* CONFIG_CMA */
>         }
>  }
>  struct auto_movable_group_stats {
> 
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

-- 
~Randy

