Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EDF380798
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 12:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhENKpb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 06:45:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:52850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhENKpa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 06:45:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4339ABF6;
        Fri, 14 May 2021 10:44:18 +0000 (UTC)
Subject: Re: [PATCH v10 04/33] mm/debug: Add VM_BUG_ON_FOLIO and
 VM_WARN_ON_ONCE_FOLIO
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-5-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d87e6208-c0b2-cad3-7536-fc1be87edd5d@suse.cz>
Date:   Fri, 14 May 2021 12:44:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-5-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> These are the folio equivalents of VM_BUG_ON_PAGE and VM_WARN_ON_ONCE_PAGE.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
