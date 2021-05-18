Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEF4387A61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 15:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhERNuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 09:50:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:57882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231285AbhERNuG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 09:50:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22196AEF5;
        Tue, 18 May 2021 13:48:47 +0000 (UTC)
Subject: Re: [PATCH v10 32/33] fs/netfs: Add folio fscache functions
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-33-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <6a84ea0e-cb79-2106-940c-33f525d2122d@suse.cz>
Date:   Tue, 18 May 2021 15:48:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-33-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> Match the page writeback functions by adding
> folio_start_fscache(), folio_end_fscache(), folio_wait_fscache() and
> folio_wait_fscache_killable().  Also rewrite the kernel-doc to describe
> when to use the function rather than what the function does, and include
> the kernel-doc in the appropriate rst file.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks like set_page_private_2() should be removed by this patch as it removes
the last caller, and the other functions were removed by previous patch.

Other than that,

Acked-by: Vlastimil Babka <vbabka@suse.cz>
