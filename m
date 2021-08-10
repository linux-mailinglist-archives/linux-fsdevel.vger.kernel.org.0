Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C7B3E7C76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 17:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243377AbhHJPgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 11:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28125 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243542AbhHJPgP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628609753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pQuJr7Ds39z6uYEw+kh5aIvtiC3dxt3i1eb/vtWoNzI=;
        b=Pz+gxoDELt4RwP8rJ51/f6W1YCEx2ymf2QBwH6BfHgXvcXNOwSKsAu5honlRI/YkSevuQ0
        h3/DBH2Rc1cCAJTqQf0x7f2Nx+myEvT/L9BytHRUlWQizUS+KMotBwIQf2pcyY5O4jozPg
        siYxL/bChESJlyt5xuaxdhfzu02tJeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-cYEMvEvLNe-WOlg089RZLg-1; Tue, 10 Aug 2021 11:35:51 -0400
X-MC-Unique: cYEMvEvLNe-WOlg089RZLg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CB37801AE7;
        Tue, 10 Aug 2021 15:35:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02E2C60C05;
        Tue, 10 Aug 2021 15:35:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-24-willy@infradead.org>
References: <20210715033704.692967-24-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v14 023/138] mm/swap: Add folio_rotate_reclaimable()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1796498.1628609745.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 16:35:45 +0100
Message-ID: <1796499.1628609745@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Convert rotate_reclaimable_page() to folio_rotate_reclaimable().  This
> eliminates all five of the calls to compound_head() in this function,
> saving 75 bytes at the cost of adding 15 bytes to its one caller,
> end_page_writeback().  We also save 36 bytes from pagevec_move_tail_fn()
> due to using folios there.  Net 96 bytes savings.
> 
> Also move its declaration to mm/internal.h as it's only used by filemap.c.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: David Howells <dhowells@redhat.com>

