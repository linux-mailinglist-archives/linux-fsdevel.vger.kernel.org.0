Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513593AA1C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 18:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhFPQun (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 12:50:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45492 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhFPQum (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:50:42 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 315401FD47;
        Wed, 16 Jun 2021 16:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623862115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hQ+D0zwBmN0mr2rj4VUIzQYymZvSbOwJk8/LO7m/rRg=;
        b=lnuKje7YJATKsMcZ9TUxqvYwWIs2ujbdHxPtbnmnoT31qMwdu2Gtw3GcXoMbTV7gnrsczE
        aW3sEz2N7wrrC4VvxA33w+VRy9MO852dRszst4TOaTKTgOBDMheWTdi9jnlqglBdt3j71/
        jh9lwqhECCnElgtZq5fBytdmlkWb1KM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623862115;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hQ+D0zwBmN0mr2rj4VUIzQYymZvSbOwJk8/LO7m/rRg=;
        b=KY6j1qi6O455vws1B6eBSbGBqOnvyMrTJCrhpjrdhgrQGMmzmklDF3lobbeEK7+xfGq6M1
        xh20PzXRbW688WDg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 18FE2118DD;
        Wed, 16 Jun 2021 16:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623862115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hQ+D0zwBmN0mr2rj4VUIzQYymZvSbOwJk8/LO7m/rRg=;
        b=lnuKje7YJATKsMcZ9TUxqvYwWIs2ujbdHxPtbnmnoT31qMwdu2Gtw3GcXoMbTV7gnrsczE
        aW3sEz2N7wrrC4VvxA33w+VRy9MO852dRszst4TOaTKTgOBDMheWTdi9jnlqglBdt3j71/
        jh9lwqhECCnElgtZq5fBytdmlkWb1KM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623862115;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hQ+D0zwBmN0mr2rj4VUIzQYymZvSbOwJk8/LO7m/rRg=;
        b=KY6j1qi6O455vws1B6eBSbGBqOnvyMrTJCrhpjrdhgrQGMmzmklDF3lobbeEK7+xfGq6M1
        xh20PzXRbW688WDg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 3ll2BWMrymApKAAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 16 Jun 2021 16:48:35 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        Thomas Lindroth <thomas.lindroth@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <016b2fe2-0d52-95c9-c519-40b14480587a@gmail.com>
 <CAJfpeguzkDQ5VL3m19jrepf1YjFeJ2=q99TurTX6DRpAKz+Omg@mail.gmail.com>
 <YMn1s19wMQdGDQuQ@casper.infradead.org>
 <CAJfpegsMNc-deQvdOntZJHU2bW34JF=e0gwxPe19eFXp1t0PFQ@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Possible bogus "fuse: trying to steal weird page" warning related
 to PG_workingset.
Message-ID: <029095d9-399a-e323-15f3-b665e9852eb3@suse.cz>
Date:   Wed, 16 Jun 2021 18:48:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegsMNc-deQvdOntZJHU2bW34JF=e0gwxPe19eFXp1t0PFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/16/21 3:47 PM, Miklos Szeredi wrote:
> On Wed, 16 Jun 2021 at 14:59, Matthew Wilcox <willy@infradead.org> wrote:
>>
>> > AFAICT fuse is trying to steal a pagecache page from a pipe buffer
>> > created by splice(2).    The page looks okay, but I have no idea what
>> > PG_workingset means in this context.
>> >
>> > Matthew, can you please help?
>>
>> PG_workingset was introduced by Johannes:
>>
>>     mm: workingset: tell cache transitions from workingset thrashing
>>
>>     Refaults happen during transitions between workingsets as well as in-place
>>     thrashing.  Knowing the difference between the two has a range of
>>     applications, including measuring the impact of memory shortage on the
>>     system performance, as well as the ability to smarter balance pressure
>>     between the filesystem cache and the swap-backed workingset.
>>
>>     During workingset transitions, inactive cache refaults and pushes out
>>     established active cache.  When that active cache isn't stale, however,
>>     and also ends up refaulting, that's bonafide thrashing.
>>
>>     Introduce a new page flag that tells on eviction whether the page has been
>>     active or not in its lifetime.  This bit is then stored in the shadow
>>     entry, to classify refaults as transitioning or thrashing.
>>
>> so I think it's fine for you to ignore when stealing a page.
> 
> I have problem understanding what a workingset is.  Is it related to

"working set" is the notion of the set of pages that the workload needs to
access at the moment/relatively short time window, and it would be beneficial if
all of it could fit in the RAM.
PG_workinsgset is part of the mechanism that tries to estimate this ideal set of
pages, and especially when the workload shifts to another set of pages, in order
to guide reclaim better. See the big comment at the top of mm/workingset.c for
details

> swap?  If so, how can such a page be part of a file mapping?

Not related to swap. It was actually first implemented only for file pages (page
cache), but then extended to anonymous pages by aae466b0052e ("mm/swap:
implement workingset detection for anonymous LRU")

> Thanks,
> Miklos
> 

