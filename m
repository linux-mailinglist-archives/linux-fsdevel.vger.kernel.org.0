Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C71638768F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 12:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348514AbhERKdM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 06:33:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:42156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348515AbhERKdJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 06:33:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04CC0AFC4;
        Tue, 18 May 2021 10:31:51 +0000 (UTC)
Subject: Re: [PATCH v10 20/33] mm/filemap: Add folio_lock_killable
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-21-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c30ba5bd-0e7e-46d4-f093-586b912a68ea@suse.cz>
Date:   Tue, 18 May 2021 12:31:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-21-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> This is like lock_page_killable() but for use by callers who
> know they have a folio.  Convert __lock_page_killable() to be
> __folio_lock_killable().  This saves one call to compound_head() per
> contended call to lock_page_killable().
> 
> __folio_lock_killable() is 20 bytes smaller than __lock_page_killable()
> was.  lock_page_maybe_drop_mmap() shrinks by 68 bytes and
> __lock_page_or_retry() shrinks by 66 bytes.  That's a total of 154 bytes
> of text saved.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>


Acked-by: Vlastimil Babka <vbabka@suse.cz>
