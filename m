Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60E53CF818
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbhGTKBS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:01:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237217AbhGTJ77 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 05:59:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D556611C1;
        Tue, 20 Jul 2021 10:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777637;
        bh=p5uSBgJJ+wS0cVChz6vXA8/Bv6m8BRWGmlKb3LPk/5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cYYSveaWzu3aLgEPC4SlzYnwciiURfG7Q6cZw1ftr936Dev3syKhvwMkrG9RyRohV
         mdJx8L8wi+d1A1scsRKR8Norir6+83UfIKVw3fPZDLQaKnFa3wR5vK69xJM+v+OFUX
         09DAZtLp9nlT8SiWxiECY4oGH1FJ7/wSnwykdVL7+MBcNpUkFL3mbREsnRKWA6jax3
         cYVLY4/ZzQREo0hRxqPltFb8eASPyVxQLiyU/3EA+NKjgPbbe5B2/DymuGC2IJl2qa
         qrj2di/vsDscrbzPacu6fuykeHB9FjcP49/3EfQbRJjXI8YRen0hhGtbkPjffVO8dZ
         7D2QQdOMNN3Hw==
Date:   Tue, 20 Jul 2021 13:40:30 +0300
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
Subject: Re: [PATCH v14 003/138] mm: Add folio_pgdat(), folio_zone() and
 folio_zonenum()
Message-ID: <YPaoHqOhO0ydu6nN@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-4-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:34:49AM +0100, Matthew Wilcox (Oracle) wrote:
> These are just convenience wrappers for callers with folios; pgdat and
> zone can be reached from tail pages as well as head pages.  No change
> to generated code.
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
>  include/linux/mm.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

