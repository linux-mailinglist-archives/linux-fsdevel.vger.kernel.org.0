Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF133D0C11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 12:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbhGUJHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 05:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237494AbhGUJFN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:05:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A76AA6120E;
        Wed, 21 Jul 2021 09:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626860713;
        bh=NPPjP0YI9hcbn/DRxmERl+FeN/dkyYWqw8VdjUAOmnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cgUPz7vGwqoyO+MN5GsqsX8C1w4JsiELjW/7dob09Bw0MtU0Yi9suw6hbSMiAph20
         wBLXVd1shBHHu4FHzEMl0PKAwno6y0QQYcp+Fgqf7oD+Ld1YwjELYevulsKtEiaP8w
         1/BqhK4UuDiMxZSv0/QRLIJs6QThvy9XVrSVbjNQGDS+luyKjOZOE5FrKxgCJeIHeD
         BQuk1Lc4rgfel0DMnVEVT+pO6UP24oPkx8CbPSbhzL48EDxwyUclyXmqsUOa1U2AFb
         AQeyoPakejg03lXS4DAvDKZB0NeamUnts0efpEAToEWeG3ssJDzSLtrVvxGmVG9hNo
         pf8nsitoR8F5g==
Date:   Wed, 21 Jul 2021 12:45:07 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 045/138] mm/memcg: Add folio_memcg_lock() and
 folio_memcg_unlock()
Message-ID: <YPfso9ApUu2K8DXj@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-46-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-46-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:31AM +0100, Matthew Wilcox (Oracle) wrote:
> These are the folio equivalents of lock_page_memcg() and
> unlock_page_memcg().
> 
> lock_page_memcg() and unlock_page_memcg() have too many callers to be
> easily replaced in a single patch, so reimplement them as wrappers for
> now to be cleaned up later when enough callers have been converted to
> use folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/memcontrol.h | 10 +++++++++
>  mm/memcontrol.c            | 45 ++++++++++++++++++++++++--------------
>  2 files changed, 39 insertions(+), 16 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
