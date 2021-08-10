Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B633E84DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 22:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhHJVAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20192 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233224AbhHJVAH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628629185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y1Vp/6OiBnakWJeS36BEKgxnmfXJ4RY91EtLxgXSPUk=;
        b=V2jKgkzkMSR7Sw9LD0JFh5iXvQge3Q/o0bQpEv1uv1C0D9lwio/jXRZ9jaNP/X4baz/p+k
        Zg5O83s/zWkDJ7bekpXZIOxcw7M+upjaElH44FKrE/VsjzsmbM5GuWdbaf8dpOEL++tcqk
        cbGm5wGaScN+aWwVgH8lqvvEALYgTcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-brpgYihDMKqjSicpROKpMA-1; Tue, 10 Aug 2021 16:59:41 -0400
X-MC-Unique: brpgYihDMKqjSicpROKpMA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEBC587D54B;
        Tue, 10 Aug 2021 20:59:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C52960C05;
        Tue, 10 Aug 2021 20:59:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-60-willy@infradead.org>
References: <20210715033704.692967-60-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 059/138] mm/rmap: Add folio_mkclean()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1812064.1628629178.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 21:59:38 +0100
Message-ID: <1812065.1628629178@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Transform page_mkclean() into folio_mkclean() and add a page_mkclean()
> wrapper around folio_mkclean().
> 
> folio_mkclean is 15 bytes smaller than page_mkclean, but the kernel
> is enlarged by 33 bytes due to inlining page_folio() into each caller.
> This will go away once the callers are converted to use folio_mkclean().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

