Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DCD387735
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 13:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348742AbhERLOJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 07:14:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:60494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241330AbhERLOI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 07:14:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01033AFE6;
        Tue, 18 May 2021 11:12:50 +0000 (UTC)
Subject: Re: [PATCH v10 26/33] mm/writeback: Add folio_wait_writeback
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-27-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <6e998f49-f37e-c7ce-278e-e220a7212f10@suse.cz>
Date:   Tue, 18 May 2021 13:12:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-27-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> wait_on_page_writeback_killable() only has one caller, so convert it to
> call folio_wait_writeback_killable().  For the wait_on_page_writeback()
> callers, add a compatibility wrapper around folio_wait_writeback().
> 
> Turning PageWriteback() into folio_writeback() eliminates a call to
> compound_head() which saves 8 bytes and 15 bytes in the two functions.
> That is more than offset by adding the wait_on_page_writeback
> compatibility wrapper for a net increase in text of 15 bytes.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
