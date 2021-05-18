Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F1C3876C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 12:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348600AbhERKm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 06:42:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:53270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348596AbhERKm5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 06:42:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C208EAD77;
        Tue, 18 May 2021 10:41:38 +0000 (UTC)
Subject: Re: [PATCH v10 23/33] mm/filemap: Add folio_wait_locked
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-24-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <59e67626-7f68-5154-1943-6cd1ab7515d6@suse.cz>
Date:   Tue, 18 May 2021 12:41:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-24-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> Also add folio_wait_locked_killable().  Turn wait_on_page_locked()
> and wait_on_page_locked_killable() into wrappers.  This eliminates a
> call to compound_head() from each call-site, reducing text size by 200
> bytes for me.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>


Acked-by: Vlastimil Babka <vbabka@suse.cz>

(and it fixes filemap.c to be compilable again)
