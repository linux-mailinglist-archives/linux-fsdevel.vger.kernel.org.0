Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7843D0C0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 12:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbhGUJHG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 05:07:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237499AbhGUJFN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:05:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D998F6121F;
        Wed, 21 Jul 2021 09:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626860726;
        bh=HRmDj3J2brYNYZ3oraPWp2RJ5mZtNNoAs94GQWxy29M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PZxjji9JHmK84E3xjUzwVDBFcFVYOZ7gc4CHNfaCqjP0qh6f3AQ5luUvxihXImWFT
         S9RSifKHESVWA9Ouc27got5zsWYq2f0u5pPPM62GOUoShKJqxbIATmjbzo7SdYwM8d
         4hkY/TaiVt6nv6x3UyKx7fitt5kky/QFxUU8HTjnGixXr8TOAdIRGbAH50pOD9vWQj
         RJt6GnfYx9T0JFVYO3XqHYD2nljIvRx79v/FaF9KjkGMkvfOMHw/WgyOLZ57LwrtFY
         ETj8jjele54jF/S8Nwm0BYIgB5NFQLyAszkvYr2H6+u3Y6JTZX0bb4qdz7zAT7P6C2
         8tfpHB8lozQTQ==
Date:   Wed, 21 Jul 2021 12:45:20 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 047/138] mm/memcg: Add folio_lruvec()
Message-ID: <YPfssBLX/S8qDqkZ@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-48-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-48-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:33AM +0100, Matthew Wilcox (Oracle) wrote:
> This replaces mem_cgroup_page_lruvec().  All callers converted.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/memcontrol.h | 20 +++++++++-----------
>  mm/compaction.c            |  2 +-
>  mm/memcontrol.c            |  9 ++++++---
>  mm/swap.c                  |  3 ++-
>  mm/workingset.c            |  3 ++-
>  5 files changed, 20 insertions(+), 17 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
