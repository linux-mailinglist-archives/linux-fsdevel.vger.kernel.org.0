Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A2B3CF838
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbhGTKFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237389AbhGTKCi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:02:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75A2E61186;
        Tue, 20 Jul 2021 10:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777796;
        bh=DGsSLkp6uOwkTE0wLeS3fDnP+ph5ucsvgTOh8pwLif8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sB4JjV59376NGRoZBMG7hpcGnb7VpGw3pmKH59qKAxxRlZOOYSKz0sfX17uGhQ1Vl
         jGi9PHoPGSpMqky5+Rh7tss1dvXG1X9PVJ8ZlbOMNDkefEvjGdXzCSC3pZwkxgrUCr
         M+E1/kis0svJheifPAMRAEecK35cEpgn3IS+AOa2iVqBmt2fYMnlpR9Pc3i/68SVuR
         x5tJJ8Ao8t2AnuGvEnkrSPYIwlW+fjuyTR0+oDVF0hKxj9GJuE+WGa3VP4nhxelJWB
         PeKIAonmyTHMemjlfuGjovsDI89jkpE6w1VJ4aId6nMs7nfIpH2G1OaXbNQn6wGabe
         h5H02YwdPtbnQ==
Date:   Tue, 20 Jul 2021 13:43:09 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 013/138] mm/filemap: Add folio_index(),
 folio_file_page() and folio_contains()
Message-ID: <YPaovQH8n4ex1UFs@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-14-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:34:59AM +0100, Matthew Wilcox (Oracle) wrote:
> folio_index() is the equivalent of page_index() for folios.
> folio_file_page() is the equivalent of find_subpage().
> folio_contains() is the equivalent of thp_contains().
> 
> No changes to generated code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

