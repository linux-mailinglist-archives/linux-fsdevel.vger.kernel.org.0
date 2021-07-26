Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE2A3D53B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 09:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhGZGeC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 02:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60562 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232207AbhGZGeB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 02:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627283669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=um4df6F+Tcs1NedbhaEs9ICFL4JEkb2ohkfDmaRpXVs=;
        b=HdnxcrnE9PyzpgE4b4yqNeXuzbLGuc5mu+BoNa8WdKmEgkUsbrZweEAbaDgdVG599z1bPn
        /tgVP/+z3SG4Jx0LyZGJeuHrMvy/bCcfROrLbYV1EAC2ShAhCETm5A1dOjXkv9B8655s8D
        kAghvLQmEWyTkHZGzHHZ3yjrQwRTKTI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-4zuSIHD9Mf6nKi8E5E68zg-1; Mon, 26 Jul 2021 03:14:28 -0400
X-MC-Unique: 4zuSIHD9Mf6nKi8E5E68zg-1
Received: by mail-wm1-f72.google.com with SMTP id n7-20020a05600c3b87b029024e59a633baso2407859wms.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jul 2021 00:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=um4df6F+Tcs1NedbhaEs9ICFL4JEkb2ohkfDmaRpXVs=;
        b=QXmb3UFIkjrdjmiDsJ78MOFFyDslF5w1K0MMu/8baNm7IAjUkb+/jS94VsV9C0LXjQ
         XcnWfSLhB457aLBBTUnmHDqsnRmApVDqK5zxGMZEed05RJY4beglVrS9LoSzng/BOJ5W
         dc4WRP15r1dpfRvIsMCr6NmXLWvRXX0Qt8hYko3/rRNtxUX0Gqq/1qtuh2o2gpUxC/KZ
         LzQqzcFr21Ik3ShnjmBUY5pCum4mt6Z28wrUKowh/YlyaulZ8VTW1NZaP4+mfaMQKJVM
         un/TcM7vtcgYqDlwtYsf0tvOisULBPalbu8E0VWcQnTeifeL6PRlJY3zxxMY2q+7bzEv
         oMww==
X-Gm-Message-State: AOAM530+28F9dRQx/BVA/kZa6ykhb0A6eIkIO7NLsFHYzoLRmk45Dur4
        MO+lUxZBcWyCNM50ZxNsaBzoRyHMtZX21JYXhIAyx/ELyM+/BpNkPDutAg+O+tJrKu5GG8tx3UE
        E0/9nFGTHibkwYGxYmHZ2GCj+Kg==
X-Received: by 2002:a05:600c:a08:: with SMTP id z8mr11306683wmp.52.1627283667217;
        Mon, 26 Jul 2021 00:14:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrJ5ioNqCfkDgUWTA7YxeWf82kzHlJSCsGt9E8hJ1xGP6IhEO9RD5CtVqgDVl+ePM/lAAEqw==
X-Received: by 2002:a05:600c:a08:: with SMTP id z8mr11306664wmp.52.1627283667006;
        Mon, 26 Jul 2021 00:14:27 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23b33.dip0.t-ipconnect.de. [79.242.59.51])
        by smtp.gmail.com with ESMTPSA id d203sm7830431wmd.38.2021.07.26.00.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 00:14:26 -0700 (PDT)
Subject: Re: mmotm 2021-07-23-15-03 uploaded (mm/memory_hotplug.c)
To:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
References: <20210723220400.w5iKInKaC%akpm@linux-foundation.org>
 <5966f6a2-bdba-3a54-c6cb-d21aaeb8f534@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <5394da5e-29f0-ff7d-e614-e2805400a8bb@redhat.com>
Date:   Mon, 26 Jul 2021 09:14:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5966f6a2-bdba-3a54-c6cb-d21aaeb8f534@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 24.07.21 20:49, Randy Dunlap wrote:
> On 7/23/21 3:04 PM, akpm@linux-foundation.org wrote:
>> The mm-of-the-moment snapshot 2021-07-23-15-03 has been uploaded to
>>
>>     https://www.ozlabs.org/~akpm/mmotm/
>>
>> mmotm-readme.txt says
>>
>> README for mm-of-the-moment:
>>
>> https://www.ozlabs.org/~akpm/mmotm/
>>
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
>>
>> You will need quilt to apply these patches to the latest Linus release (5.x
>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>> https://ozlabs.org/~akpm/mmotm/series
>>
>> The file broken-out.tar.gz contains two datestamp files: .DATE and
>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
>> followed by the base kernel version against which this patch series is to
>> be applied.
>>
> 
> on x86_64:
> # CONFIG_CMA is not set
> 
> mm-memory_hotplug-memory-group-aware-auto-movable-online-policy.patch
> 
> 
> 
> ../mm/memory_hotplug.c: In function ‘auto_movable_stats_account_zone’:
> ../mm/memory_hotplug.c:748:33: error: ‘struct zone’ has no member named ‘cma_pages’; did you mean ‘managed_pages’?
>     stats->movable_pages += zone->cma_pages;
>                                   ^~~~~~~~~
>                                   managed_pages
> ../mm/memory_hotplug.c:750:38: error: ‘struct zone’ has no member named ‘cma_pages’; did you mean ‘managed_pages’?
>     stats->kernel_early_pages -= zone->cma_pages;
>                                        ^~~~~~~~~
>                                        managed_pages
> 
> 

Thanks Randy, the following on top should make it fly:

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index bfdaa28eb86f..fa1a0afd32ba 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -741,13 +741,15 @@ static void auto_movable_stats_account_zone(struct auto_movable_stats *stats,
         if (zone_idx(zone) == ZONE_MOVABLE) {
                 stats->movable_pages += zone->present_pages;
         } else {
+               stats->kernel_early_pages += zone->present_early_pages;
+#ifdef CONFIG_CMA
                 /*
                  * CMA pages (never on hotplugged memory) behave like
                  * ZONE_MOVABLE.
                  */
                 stats->movable_pages += zone->cma_pages;
-               stats->kernel_early_pages += zone->present_early_pages;
                 stats->kernel_early_pages -= zone->cma_pages;
+#endif /* CONFIG_CMA */
         }
  }
  struct auto_movable_group_stats {


-- 
Thanks,

David / dhildenb

