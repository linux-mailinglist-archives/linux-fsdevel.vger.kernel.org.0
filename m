Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD14380936
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 14:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhENMMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 08:12:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:53088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232862AbhENMMf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 08:12:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 84398AEBB;
        Fri, 14 May 2021 12:11:22 +0000 (UTC)
Subject: Re: [PATCH v10 08/33] mm: Add folio_try_get_rcu
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-9-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <64af9109-930e-7637-b3a9-aedd8dd617f4@suse.cz>
Date:   Fri, 14 May 2021 14:11:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-9-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> This is the equivalent of page_cache_get_speculative().  Also add
> folio_ref_try_add_rcu (the equivalent of page_cache_add_speculative)
> and folio_get_unless_zero() (the equivalent of get_page_unless_zero()).
> 
> The new kernel-doc attempts to explain from the user's point of view
> when to use folio_try_get_rcu() and when to use folio_get_unless_zero(),
> because there seems to be some confusion currently between the users of
> page_cache_get_speculative() and get_page_unless_zero().
> 
> Reimplement page_cache_add_speculative() and page_cache_get_speculative()
> as wrappers around the folio equivalents, but leave get_page_unless_zero()
> alone for now.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
