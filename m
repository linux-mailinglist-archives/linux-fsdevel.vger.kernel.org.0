Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4423876E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 12:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243799AbhERKuI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 06:50:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:60360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241590AbhERKuI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 06:50:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D72FAFBD;
        Tue, 18 May 2021 10:48:49 +0000 (UTC)
Subject: Re: [PATCH v10 24/33] mm/swap: Add folio_rotate_reclaimable
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-25-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <86fb536c-2ffc-a3e4-9c7b-5b2708c444b0@suse.cz>
Date:   Tue, 18 May 2021 12:48:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-25-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> Move the declaration into mm/internal.h and rename
> rotate_reclaimable_page() to folio_rotate_reclaimable().  This eliminates
> all five of the calls to compound_head() in this function, saving 75 bytes
> at the cost of adding 14 bytes to its one caller, end_page_writeback().
> Net 61 bytes savings.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
