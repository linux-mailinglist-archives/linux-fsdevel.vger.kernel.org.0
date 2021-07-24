Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13593D493E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 20:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhGXSJQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 14:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhGXSJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 14:09:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6132C061575;
        Sat, 24 Jul 2021 11:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=wxAvS7iHGAxQWca5sytD64g1MZMTPyvQWkfE1x9lyIc=; b=bfZdswynQet3POsZpKRsWLVCtB
        Ih7EaGUOn+jsTPK7g7hfFQJ7/CoBkoxVtg0mFVxTtWFNe3/Ds1qkSIeJT1Vmg49OGMzCDYRmpmgxe
        KbBbYukXS6uXDNmnPMTPGqwvfk5/y4z5caWg1haZT5yRagQTsYtA0sT1gKCnO8YKoC7tRnHkZxpNk
        yZL8n70g+pDMXdATNwZRHFVKHIU1hmmQ+5B4A4C76MH2hTzfuQQs2dK5OsejlYkWskqG0eSIld9KO
        XkVtTw1RHhGYXfPLmP3DdNvt5opveHzDWlUOcL+ZsWWewWunV6Ln8/6z9rl2Wi7Uc9V8njhIRaiBo
        MMcvD4Og==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7MiQ-007ggV-Od; Sat, 24 Jul 2021 18:49:38 +0000
Subject: Re: mmotm 2021-07-23-15-03 uploaded (mm/memory_hotplug.c)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        David Hildenbrand <david@redhat.com>
References: <20210723220400.w5iKInKaC%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5966f6a2-bdba-3a54-c6cb-d21aaeb8f534@infradead.org>
Date:   Sat, 24 Jul 2021 11:49:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723220400.w5iKInKaC%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/23/21 3:04 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2021-07-23-15-03 has been uploaded to
> 
>    https://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> https://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> https://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.
> 

on x86_64:
# CONFIG_CMA is not set

mm-memory_hotplug-memory-group-aware-auto-movable-online-policy.patch



../mm/memory_hotplug.c: In function ‘auto_movable_stats_account_zone’:
../mm/memory_hotplug.c:748:33: error: ‘struct zone’ has no member named ‘cma_pages’; did you mean ‘managed_pages’?
   stats->movable_pages += zone->cma_pages;
                                 ^~~~~~~~~
                                 managed_pages
../mm/memory_hotplug.c:750:38: error: ‘struct zone’ has no member named ‘cma_pages’; did you mean ‘managed_pages’?
   stats->kernel_early_pages -= zone->cma_pages;
                                      ^~~~~~~~~
                                      managed_pages


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>

