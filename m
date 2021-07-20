Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1463CF84C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbhGTKG1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237751AbhGTKFv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:05:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94D87611CE;
        Tue, 20 Jul 2021 10:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777989;
        bh=u3WNKIIWddFWJ+6xuBJhv5SVltVDMVfMKy3ftJ4KvB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XO8dbM+x27lrnSbSVJTe3iqoHovDFziUOeYMujYQy1FNorvanARzK68I8c1Nrfjdr
         umXYm7Ry4+UAQdeUfoVhqrtJa6G8rQm5K6VhNDkbBY6GinQ33K9xyvtS1eVZg4ZL/h
         xqKIbfBtI8/oVu3UMFw1iayKUPxUT5Tc7oKzGyFTUEWfJ6wpzYc08t2ifxG/hAvmSR
         luAFMA78evHtlksjkHo8lzvc8aPuq6xBRSs0RMUMtGARcv2bhRr9PtGzLEygyg4anm
         11TX/DA5mgulVfLnxeucGvukao12Vfh1XBCYS8TEIoHruZHi8pGo8c52IAU8aAs44d
         J+Mf+HaNtYpMQ==
Date:   Tue, 20 Jul 2021 13:46:22 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 024/138] mm/filemap: Add folio_end_writeback()
Message-ID: <YPapfiBCxlnP9Ezo@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-25-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-25-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:10AM +0100, Matthew Wilcox (Oracle) wrote:
> Add an end_page_writeback() wrapper function for users that are not yet
> converted to folios.
> 
> folio_end_writeback() is less than half the size of end_page_writeback()
> at just 105 bytes compared to 228 bytes, due to removing all the
> compound_head() calls.  The 30 byte wrapper function makes this a net
> saving of 93 bytes.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---
>  include/linux/pagemap.h |  3 ++-
>  mm/filemap.c            | 43 ++++++++++++++++++++---------------------
>  mm/folio-compat.c       |  6 ++++++
>  3 files changed, 29 insertions(+), 23 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

