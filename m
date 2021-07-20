Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E023CF82A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237560AbhGTKCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:02:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237097AbhGTKBO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:01:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82F0B61209;
        Tue, 20 Jul 2021 10:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777712;
        bh=ACwdOqNdcSDdPdwZhzCQApak7JmD7gYgFfks/TLhApY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWL3FNMkM9GiZqbX9zrwE4G/1zDoTqP+xPOohrXEvn/1h2/ZOY5vtwLIxJxdYYtbM
         cMoqTB/ra7OrmN2m1Mm6DXZgbU5hQ/avOJxKGkjDnUxWoC0bFdcZkFg6AEmcwInZyU
         4zC0ZIXo+G+GUaR0ANI8RE7n7LfmIm6IzUqpHnI3nAIhiCHzEPVMakOwUIafKYs/58
         56PJM9VkECjz8il5rcYoEC8ZrM/ZGN1AFfRjOPo+wXSZWaCW4qK5RPpwGgIouvjTur
         9mnoJImmuT6UC8nXt5UHHK2hkxJmSHE+05Wpayh06QlfGCRRN21aDSN+0HI88s/FC7
         U1qivMsAGFgaQ==
Date:   Tue, 20 Jul 2021 13:41:45 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 008/138] mm: Add folio_get()
Message-ID: <YPaoaXP2Nao4I0Jb@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-9-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:34:54AM +0100, Matthew Wilcox (Oracle) wrote:
> If we know we have a folio, we can call folio_get() instead
> of get_page() and save the overhead of calling compound_head().
> No change to generated code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---
>  include/linux/mm.h | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

