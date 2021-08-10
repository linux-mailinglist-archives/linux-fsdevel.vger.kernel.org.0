Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538A63E85CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbhHJV7z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:59:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56991 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235027AbhHJV7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628632769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ElH7xQBolMkqBkTgOcSotCt04OkZm087iZKxD4bzejI=;
        b=Vo1dNm7Yj1Ko+rGsX/2O0mjBNYeXXWcj/v4U46C+G5NpAU1OiGRD/fL29L7p4R2pvLF4mH
        xOymPmvJM4sdlutk3xOaArK+aH/vFi3Y+HvdXy+g2o65vTvn3T5heOTYL8eimSS3Fpf7OM
        EDoU2KyvNGGLZXu7jYNaColtqFXwfBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-RjGCULpxP1iqN7XStS2Y_w-1; Tue, 10 Aug 2021 17:59:26 -0400
X-MC-Unique: RjGCULpxP1iqN7XStS2Y_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A6CF1009607;
        Tue, 10 Aug 2021 21:59:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DF7A421F;
        Tue, 10 Aug 2021 21:59:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-87-willy@infradead.org>
References: <20210715033704.692967-87-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 086/138] mm/filemap: Add filemap_add_folio()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1814869.1628632763.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:59:23 +0100
Message-ID: <1814870.1628632763@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Convert __add_to_page_cache_locked() into __filemap_add_folio().
> Add an assertion to it that (for !hugetlbfs), the folio is naturally
> aligned within the file.  Move the prototype from mm.h to pagemap.h.
> Convert add_to_page_cache_lru() into filemap_add_folio().  Add a
> compatibility wrapper for unconverted callers.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

