Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D163E8539
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbhHJV0C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:26:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35154 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233895AbhHJV0C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628630739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=600amtiqtF9qYaf5YhMYdAWHErj6zDZHEY3tP4H3S6k=;
        b=UOT5BGVIVHX0IgFhMpSH78GwEEwOHIH8D4zexuQEebugcGaZXbwuT/MX3JkJJ9shUV56Wt
        Gc1njvm7EOxIfQ9U2WQDnHyQ84H212+7Zq8d4ik0kiwe0LAm9++HxVmEgcgL3kZC+M7FxK
        NFktCs+XRq3EqBtHhCYda64hGLLIpH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-boGVFplqPgGaurt5UjLA0w-1; Tue, 10 Aug 2021 17:25:38 -0400
X-MC-Unique: boGVFplqPgGaurt5UjLA0w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1508F101C8A0;
        Tue, 10 Aug 2021 21:25:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0248D1B472;
        Tue, 10 Aug 2021 21:25:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-76-willy@infradead.org>
References: <20210715033704.692967-76-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 075/138] mm/writeback: Add folio_account_redirty()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1813347.1628630735.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:25:35 +0100
Message-ID: <1813348.1628630735@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Account the number of pages in the folio that we're redirtying.
> Turn account_page_dirty() into a wrapper around it.  Also turn
> the comment on folio_account_redirty() into kernel-doc and
> edit it slightly so it makes sense to its potential callers.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

