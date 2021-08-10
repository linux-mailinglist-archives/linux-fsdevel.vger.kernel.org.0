Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7522C3E8440
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 22:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhHJUXV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 16:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57996 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229764AbhHJUXU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628626977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CHBYsozolbXpzdoVsHmdC2uUbYB0KswpdxuScQqdhm0=;
        b=cpNBe1lFQmkjKKAdERYlfoZ0aCe2KTnd/4GRu7i/Ta6WXZJsrnP6YN1UQb3CfbgBPSTzDy
        tf546OMfiN+5cgi4C1En3voL6QEUJsGaYDYQrB2nkGTYOn5qVvOg0FYrYT+gmuFMedIMAY
        GnlvWuvJXu4tnXngCenv9CRDXKZi35k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-ox03ABrBNRmvQ8aqsM4jNA-1; Tue, 10 Aug 2021 16:22:56 -0400
X-MC-Unique: ox03ABrBNRmvQ8aqsM4jNA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEBE28799EB;
        Tue, 10 Aug 2021 20:22:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F86C18A9E;
        Tue, 10 Aug 2021 20:22:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-42-willy@infradead.org>
References: <20210715033704.692967-42-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 041/138] mm/memcg: Convert uncharge_page() to uncharge_folio()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1810338.1628626972.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 21:22:52 +0100
Message-ID: <1810339.1628626972@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Use a folio rather than a page to ensure that we're only operating on
> base or head pages, and not tail pages.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

