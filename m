Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEE83E850A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbhHJVQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39108 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234146AbhHJVQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628630173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dLkInt1G4THI75AqLzGUP2gQtOK1/r2t/T8AZY8aJsk=;
        b=E3GZOrsCnpSSbmhqOuqhh45EJwNf45krJgQnkRbVIkERerGMIEhSwiEHMRNd1LWwQriRNZ
        UB0aj+OTQVZt/hR8DXJmgJj6y1lqT6DKlgiI+8YnmWWkyq7HxktQ3H65Jpk1KpySEE2220
        NZMtIjTi4YxFJR7/OO5anOriAKXo7io=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-GSo1H4wpNBG4PFuMLUSslw-1; Tue, 10 Aug 2021 17:16:09 -0400
X-MC-Unique: GSo1H4wpNBG4PFuMLUSslw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FD3C106B316;
        Tue, 10 Aug 2021 21:16:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D794779D0;
        Tue, 10 Aug 2021 21:16:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-67-willy@infradead.org>
References: <20210715033704.692967-67-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 066/138] mm/writeback: Add __folio_end_writeback()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1812820.1628630166.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:16:06 +0100
Message-ID: <1812821.1628630166@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> test_clear_page_writeback() is actually an mm-internal function, although
> it's named as if it's a pagecache function.  Move it to mm/internal.h,
> rename it to __folio_end_writeback() and change the return type to bool.
> 
> The conversion from page to folio is mostly about accounting the number
> of pages being written back, although it does eliminate a couple of
> calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

