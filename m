Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BEF3CF854
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbhGTKHh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:07:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237119AbhGTKG3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:06:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D83FD611CE;
        Tue, 20 Jul 2021 10:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626778027;
        bh=iPmwjmC8WNu5AcLdX9lHZAteWoohHIql0w9cmjRFCVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LEamEA3reH7OMpokEgVzKU+yhWwYclVf6vZ7ns/vMWUu6Iletp3b4RyQQgMKaHfmT
         RJO8YK/EugK3n5TRCdhzriQUTxXwujv1pyMRedkr87DYMnAkiaA9aEOnBoDPEj79zq
         Iad+fFDhHNfyY1ISAzgQghdKi19Yh4yiFWu7XcpzP7MsOCiQkNQEVIwckxUuZYSFo+
         t2weX5mP/B7PiGy0C3kQpqTilqpcXufNMRPifAz0BVqm86jutf8+YNrfBtqFtAWUlr
         4FI+N3/qugJLTET6HEn5yDh9WSYMEwYmUdsx5gHCUw3cizCS2MNUf5A58aH3L16Ck0
         m/v3fUQrXDmvA==
Date:   Tue, 20 Jul 2021 13:46:59 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 028/138] mm/filemap: Add folio_wake_bit()
Message-ID: <YPapo4IQ0x6emBdG@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-29-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-29-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:14AM +0100, Matthew Wilcox (Oracle) wrote:
> Convert wake_up_page_bit() to folio_wake_bit().  All callers have a folio,
> so use it directly.  Saves 66 bytes of text in end_page_private_2().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---
>  mm/filemap.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
