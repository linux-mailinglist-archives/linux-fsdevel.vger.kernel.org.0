Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07C13E846D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 22:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbhHJUhV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 16:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232989AbhHJUhV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628627818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NQQ3vMbFXOyLNA8o0T1JkNTfAtfvFXrPq9SU5hge6L0=;
        b=WqBI6sNhH42CKBWDdzWNIi3/ODABKzdjlBYeP/2gl9FxwxrQMQI9X6lv0dIAJFKWwlcOh/
        ze4TJu4NX2+r014Qcv7tWw0CMFf6j8Eq0fw5ow5aDD2wIJjtrqyro8c/i+eo3xYT9kkNFF
        +JWZB83CYd8vz1q88xG2bffrJelZzIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-QNe406-APZi5ySA5y5-k6w-1; Tue, 10 Aug 2021 16:36:57 -0400
X-MC-Unique: QNe406-APZi5ySA5y5-k6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2075D107ACF5;
        Tue, 10 Aug 2021 20:36:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE27B3AFD;
        Tue, 10 Aug 2021 20:36:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-50-willy@infradead.org>
References: <20210715033704.692967-50-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 049/138] mm/memcg: Add folio_lruvec_relock_irq() and folio_lruvec_relock_irqsave()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1811015.1628627814.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 21:36:54 +0100
Message-ID: <1811016.1628627814@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> These are the folio equivalents of relock_page_lruvec_irq() and
> folio_lruvec_relock_irqsave().  Also convert page_matches_lruvec()
> to folio_matches_lruvec().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

