Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD62D380D73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 17:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhENPlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 11:41:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:50496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231139AbhENPlI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 11:41:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EB9E1AF35;
        Fri, 14 May 2021 15:39:55 +0000 (UTC)
Subject: Re: [PATCH v10 07/33] mm: Add folio_get
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-8-willy@infradead.org>
 <88a265ab-9ecd-18b7-c150-517a5c2e5041@suse.cz>
 <YJ6IGgToV1wSv1gg@casper.infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <635649fa-dd98-c465-ffb4-7c0df9d4814e@suse.cz>
Date:   Fri, 14 May 2021 17:39:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJ6IGgToV1wSv1gg@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/14/21 4:24 PM, Matthew Wilcox wrote:
> On Fri, May 14, 2021 at 01:56:46PM +0200, Vlastimil Babka wrote:
>> Nitpick: function names in subject should IMHO also end with (). But not a
>> reason for resend all patches that don't...
> 
> Hm, I thought it was preferred to not do that.

Hm, no idea if there's a concensus on that, actually.

> I can fix it
> easily enough when I go through and add the R-b.

If I was right...

