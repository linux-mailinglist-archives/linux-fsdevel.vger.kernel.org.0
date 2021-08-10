Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675FD3E853B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbhHJV0j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234043AbhHJV0i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628630775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KtDCw+d4IhOJljfaZEvvTjuvZfe2egAuzIik9dCQHdQ=;
        b=YZpsw5dx2MnqPcdRVX5j/KM69fUkFVp9o0SdOcvje2TYwfELl1PFFi4kXYyLXKraZWhzqS
        CjqaUTVcPyur+R5HLxVc7r/d0+R0BNI3KeUqvwbknXW0kN5dzxq+xis+V6aWR7I936kfM0
        ggvHOK1P30IGqmlsxnwjBBBxZTUKYbU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-FOPU7ubIPxiteoG95Z7Mug-1; Tue, 10 Aug 2021 17:26:14 -0400
X-MC-Unique: FOPU7ubIPxiteoG95Z7Mug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBBCA101C8A0;
        Tue, 10 Aug 2021 21:26:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D886E4536;
        Tue, 10 Aug 2021 21:26:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-77-willy@infradead.org>
References: <20210715033704.692967-77-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 076/138] mm/writeback: Add folio_redirty_for_writepage()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1813387.1628630770.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:26:11 +0100
Message-ID: <1813388.1628630771@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Reimplement redirty_page_for_writepage() as a wrapper around
> folio_redirty_for_writepage().  Account the number of pages in the
> folio, add kernel-doc and move the prototype to writeback.h.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

