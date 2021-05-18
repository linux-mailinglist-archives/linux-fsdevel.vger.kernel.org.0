Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958253875DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 11:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348007AbhERJ7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 05:59:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:53910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347639AbhERJ67 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 05:58:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D25F3AE92;
        Tue, 18 May 2021 09:57:40 +0000 (UTC)
Subject: Re: [PATCH v10 17/33] mm/memcg: Add folio wrappers for various
 functions
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-18-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1a5611e0-dd6a-84e1-41cb-33db416e8fd4@suse.cz>
Date:   Tue, 18 May 2021 11:57:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-18-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> Add new wrapper functions folio_memcg(), lock_folio_memcg(),
> unlock_folio_memcg(), mem_cgroup_folio_lruvec() and
> count_memcg_folio_event()
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
