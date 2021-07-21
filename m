Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7503D0C13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 12:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbhGUJHf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 05:07:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237490AbhGUJFN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:05:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE5B361019;
        Wed, 21 Jul 2021 09:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626860701;
        bh=O5AzgbU5ka4qZYaeYoTThyMLeQb4DjVHL9gWjDpvgzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYr6JNncR4ZTsgvjnZsOxZ767WyicEiploh0Qb0RoOAO9N7WtIaatIevOiwl23BIa
         7yoFwdbKJrfSeThrTyAjMFTO/FeDmbdbkDH3QTiBgmU8nhJ5grl1oHmpAhcwQDaxb5
         9GL/ywt2clQwVq3cUL2Nj7/mwwysp3gJSwY5txSv7ZFI7BIz30y+l3t1czA2fNXECG
         Y4qw3BKzSXEPqyCGk2S94CFMCGKiQsGCiZK4jUepaapLrNwy8q/nxb8vkpgynnmcL0
         eRsIx0y9xlDmltSZrkZTC1Zzz9vGN2XL95Vpy9sNq27+M4OBAkab1WAskRdfG5W0GY
         5Xr54CCt6u1xA==
Date:   Wed, 21 Jul 2021 12:44:55 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 043/138] mm/memcg: Convert mem_cgroup_migrate() to
 take folios
Message-ID: <YPfslx7nqhP+CP3H@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-44-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-44-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:29AM +0100, Matthew Wilcox (Oracle) wrote:
> Convert all callers of mem_cgroup_migrate() to call page_folio() first.
> They all look like they're using head pages already, but this proves it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/memcontrol.h |  4 ++--
>  mm/filemap.c               |  4 +++-
>  mm/memcontrol.c            | 35 +++++++++++++++++------------------
>  mm/migrate.c               |  4 +++-
>  mm/shmem.c                 |  5 ++++-
>  5 files changed, 29 insertions(+), 23 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
