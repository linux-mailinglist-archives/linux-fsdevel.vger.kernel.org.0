Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2343CF848
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbhGTKFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235694AbhGTKFC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:05:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93A0061209;
        Tue, 20 Jul 2021 10:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777940;
        bh=EieI+NBJp4KDfpZlZkluxdvrsQhkDMDzUVdjQyEaG8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=scKyHutTZ3/n0QxRc31q/2A5aLiE74ooNoftRlGLUMix5k2liV/DAk3v9EHvp8iu5
         yF9uxxcFvV7m3LI+vYyTvBXYknv40MYpjKaoBX6gg1g/Hq0a4fW/AQUuixztI/AbL3
         VSOjNmcKxVsntUUsw8wSmuqE3AVTMYjx3riNuWklWs9zUnOvKROAcKYsa99RZ1K2/j
         pUuGfVmyXDQtZwS6+LIecoZyGgfA62uod+R7/79261f7PApyZ3lkNDEjvG4isV3DH+
         hXW60sRrthU/lkqudmFXdzOIZUlwd4LBnZBXaZMAVfCjREEx40GWJcL+yAOnMNrHfY
         bn+iaoXl/oblQ==
Date:   Tue, 20 Jul 2021 13:45:33 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 021/138] mm/filemap: Add folio_wait_locked()
Message-ID: <YPapTZ3E1s+vd9HD@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-22-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-22-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:07AM +0100, Matthew Wilcox (Oracle) wrote:
> Also add folio_wait_locked_killable().  Turn wait_on_page_locked() and
> wait_on_page_locked_killable() into wrappers.  This eliminates a call
> to compound_head() from each call-site, reducing text size by 193 bytes
> for me.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---
>  include/linux/pagemap.h | 26 ++++++++++++++++++--------
>  mm/filemap.c            |  4 ++--
>  2 files changed, 20 insertions(+), 10 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
