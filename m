Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52643E844E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 22:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhHJU3P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 16:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229764AbhHJU3P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628627332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GDPhmoVx2vCnSG0qG6Q26w8x0PkAworRMKK+FXNiReY=;
        b=YrgZPhUKuF8UNRG1DVaLC+hPOfyE15Vv9TRin7E0EMJhPEaO2KVXyBWmB7GmlR5R/4uwv7
        4wpJTad02jP/XTI+uWlorAYz46rzKgbw96rNAb7kV51tDh7aIgLXWuU/vjYCJmfUDSsz77
        C/dDuBxfm9jtlsA56QRGnXQcRLuybjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-RdFyykJoNgKDmF-72fLxpQ-1; Tue, 10 Aug 2021 16:28:51 -0400
X-MC-Unique: RdFyykJoNgKDmF-72fLxpQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B06B5CC626;
        Tue, 10 Aug 2021 20:28:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89B0627C5F;
        Tue, 10 Aug 2021 20:28:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-46-willy@infradead.org>
References: <20210715033704.692967-46-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 045/138] mm/memcg: Add folio_memcg_lock() and folio_memcg_unlock()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1810622.1628627327.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 21:28:47 +0100
Message-ID: <1810623.1628627327@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

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

Reviewed-by: David Howells <dhowells@redhat.com>

