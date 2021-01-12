Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825D32F3F69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 01:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404640AbhALWVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 17:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394523AbhALWUw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:20:52 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DF7C061575;
        Tue, 12 Jan 2021 14:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=s+I14tYnxOlyfxHrlO9JYe0T5UDj9LyjfS6FStHPM4c=; b=nLfDVtpl4aEhI+9k8tvCHGFGIL
        WUoLkJx7AclGbCCkV6bC9lDRuKncLV99etAOe0ireXEKACLePG0cbdqNHY27eJPc4hh8MpZegnwVX
        jWSAkmF0i7pe8V4eKrt9Qh+wWtvAlBW1S+eEuvrwN61WHiuJVG8ONldkStnwAP3Cz8lghcyaLFxFt
        Wdmy5t5dZyyVX4V5pEEHySq7QR1M4HktljsJeMqwkf6TPS/AEK6VVRD8Be2I9nRMP77weJX79Yrni
        hR69k2dEzuSN2Gv9xSuiZEpikGp0KHtAfRpbo62ve8H9bMzXNvyyRFspZfELVRWnDrTyltMN6aJ9z
        1uFe+JBQ==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzS1G-0003Ru-OR; Tue, 12 Jan 2021 22:20:07 +0000
Subject: Re: mmotm 2021-01-12-01-57 uploaded (NR_SWAPCACHE in mm/)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Shakeel Butt <shakeelb@google.com>
References: <20210112095806.I2Z6as5al%akpm@linux-foundation.org>
 <ac517aa0-2396-321c-3396-13aafba46116@infradead.org>
 <20210112135010.267508efa85fe98f670ed9e9@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6ef78ccc-ab9e-5a18-ced7-ed2e993e4fef@infradead.org>
Date:   Tue, 12 Jan 2021 14:20:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210112135010.267508efa85fe98f670ed9e9@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/12/21 1:50 PM, Andrew Morton wrote:

>>
>> on i386 and x86_64:
>>
>> when CONFIG_SWAP is not set/enabled:
>>
>> ../mm/migrate.c: In function ‘migrate_page_move_mapping’:
>> ../mm/migrate.c:504:35: error: ‘NR_SWAPCACHE’ undeclared (first use in this function); did you mean ‘QC_SPACE’?
>>     __mod_lruvec_state(old_lruvec, NR_SWAPCACHE, -nr);
>>                                    ^~~~~~~~~~~~
>>
>> ../mm/memcontrol.c:1529:20: error: ‘NR_SWAPCACHE’ undeclared here (not in a function); did you mean ‘SGP_CACHE’?
>>   { "swapcached",   NR_SWAPCACHE   },
>>                     ^~~~~~~~~~~~
> 
> Thanks.  I did the below.

WorsForMe. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> But we're still emitting "Node %d SwapCached: 0 kB" in sysfs when
> CONFIG_SWAP=n, which is probably wrong.  Shakeel, can you please have a
> think?

-- 
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
