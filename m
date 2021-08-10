Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7663E84C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 22:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbhHJUyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 16:54:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57316 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234138AbhHJUyQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628628833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ojfchDHZZe02MpiAkNZbBGO/kn+hVEYwNKUNGTRTUGA=;
        b=fQMzjFg38PRh/3oA03NXULBojdvrESwC+C3TLgMEmtzMXkHMSokyULtYwFxyvq45ht2d3J
        DXVqUOjMI5rVa2+Fv49qAxRcLHbmnjFa9RBeyyoLSfZlONBGlhg6DqRqINlvFVNROZCXea
        zrilJZrV1gDGRCenu2ibyUdQ5ByHBug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-1QSjJwqIMmKy864jiRE-bQ-1; Tue, 10 Aug 2021 16:53:50 -0400
X-MC-Unique: 1QSjJwqIMmKy864jiRE-bQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BDAC107ACF5;
        Tue, 10 Aug 2021 20:53:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE1D25D9CA;
        Tue, 10 Aug 2021 20:53:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-57-willy@infradead.org>
References: <20210715033704.692967-57-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 056/138] mm: Add folio_young and folio_idle
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1811773.1628628826.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 21:53:46 +0100
Message-ID: <1811774.1628628826@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Idle page tracking is handled through page_ext on 32-bit architectures.
> Add folio equivalents for 32-bit and move all the page compatibility
> parts to common code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

