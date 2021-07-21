Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AB83D0C0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 12:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbhGUJHA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 05:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236198AbhGUJEk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:04:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E882660E0C;
        Wed, 21 Jul 2021 09:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626860690;
        bh=znU5Htf5GYSQ6lIPjRSpsOFT5YVIkrLC8MSv18umkhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HNcn+KRfumgFJ7J8mC3U91aerMw9Vnl/jj7mus9d988SGVA8lprgI/eljEEJBeKlG
         1CGaZ3XG1arRg2J2C1lgC/iyz7TjVLe3lsXtY8PWn7JUzdLUczqcHpGl2GDizfnERf
         CDhEZRamqjtgbwueG3JivFONEH/itY0UWXEKs8mTLSIYUEmjLn970Iq+23C28mFsY3
         iH0y68uIuv0D+SZK/Yj9bIMUYH6sXPJ8v/b9nnS8XYrNu7j8YokNIx+Cz5ig7UCGyO
         8y6fQd2xYSUax7d9J+4z+qKBAjaputusDi5fk3/klLjoyRusAlSayGWlYRJRj38nt3
         ZIeyUTkHfoPsA==
Date:   Wed, 21 Jul 2021 12:44:45 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 042/138] mm/memcg: Convert mem_cgroup_uncharge() to
 take a folio
Message-ID: <YPfsjSKI8XhC5/Vf@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-43-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-43-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:28AM +0100, Matthew Wilcox (Oracle) wrote:
> Convert all the callers to call page_folio().  Most of them were already
> using a head page, but a few of them I can't prove were, so this may
> actually fix a bug.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/memcontrol.h |  4 ++--
>  mm/filemap.c               |  2 +-
>  mm/khugepaged.c            |  4 ++--
>  mm/memcontrol.c            | 14 +++++++-------
>  mm/memory-failure.c        |  2 +-
>  mm/memremap.c              |  2 +-
>  mm/page_alloc.c            |  2 +-
>  mm/swap.c                  |  2 +-
>  8 files changed, 16 insertions(+), 16 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

