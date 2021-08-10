Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D607F3E8534
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhHJVWp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43940 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234338AbhHJVWp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628630542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jk2IhlnlOCt1ZKtSeYx6ofnITIH2EWYZO/2dRAfdcPU=;
        b=D3YrG+XC5QhRb6pDXLO4y3rItCvQtOQJXOztVnDTs016B+9yvm0I+Ox0Jum+L43/yM5lYi
        U3xBilWDjkkf2MaxwZwUsXG/sVFAFdei4FMVls/QWolXGdvILi5/g9CCVACieYaZ7OZFeK
        Icw58hKMbaeq9tgVLxCY2P+LeGCBAuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242--Ht1JF46PyORuJLBuAinOA-1; Tue, 10 Aug 2021 17:22:20 -0400
X-MC-Unique: -Ht1JF46PyORuJLBuAinOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D20B0185302E;
        Tue, 10 Aug 2021 21:22:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF4EE60BF1;
        Tue, 10 Aug 2021 21:22:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-73-willy@infradead.org>
References: <20210715033704.692967-73-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 072/138] mm/writeback: Add folio_account_cleaned()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1813184.1628630537.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:22:17 +0100
Message-ID: <1813185.1628630537@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Get the statistics right; compound pages were being accounted as a
> single page.  This didn't matter before now as no filesystem which
> supported compound pages did writeback.  Also move the declaration
> to filemap.h since this is part of the page cache.  Add a wrapper for
> account_page_cleaned().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

