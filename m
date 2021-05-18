Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F20F387699
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 12:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348387AbhERKfu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 06:35:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:44980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242597AbhERKft (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 06:35:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DAE9BAF19;
        Tue, 18 May 2021 10:34:30 +0000 (UTC)
Subject: Re: [PATCH v10 21/33] mm/filemap: Add __folio_lock_async
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-22-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7fb7b8a3-b559-88d6-b46e-d822fc689500@suse.cz>
Date:   Tue, 18 May 2021 12:34:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-22-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> There aren't any actual callers of lock_page_async(), so remove it.
> Convert filemap_update_page() to call __folio_lock_async().
> 
> __folio_lock_async() is 21 bytes smaller than __lock_page_async(),
> but the real savings come from using a folio in filemap_update_page(),
> shrinking it from 514 bytes to 403 bytes, saving 111 bytes.  The text
> shrinks by 132 bytes in total.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>


Acked-by: Vlastimil Babka <vbabka@suse.cz>
