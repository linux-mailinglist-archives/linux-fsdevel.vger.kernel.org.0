Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71EB3E8545
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhHJV3I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:29:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52460 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233895AbhHJV24 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628630913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7W+BJA5izsCfvfOVQ5W0TJSnZONv7dHE2tmjYF6PPTw=;
        b=Ovqc93rDNbf4Mfddhk3d8U9MZQwjpmYuaJkixzzOVlCQgmDHV+nINWX3aSH5iPCgbC83pL
        kAoZ3kU7q1VFFkKSwT/oeA+jqyftaeiuTZWe6pVYJM7PyZjw1eiHze7qd5FqT7ULA4mOuX
        ZEpmfrmKKwL0thEuWKZPF6G73Z9UZQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-k0adTsQJONalutK6SS-W8A-1; Tue, 10 Aug 2021 17:28:30 -0400
X-MC-Unique: k0adTsQJONalutK6SS-W8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBE326409E;
        Tue, 10 Aug 2021 21:28:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46286100763B;
        Tue, 10 Aug 2021 21:28:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-78-willy@infradead.org>
References: <20210715033704.692967-78-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 077/138] mm/filemap: Add i_blocks_per_folio()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1813488.1628630900.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:28:20 +0100
Message-ID: <1813489.1628630900@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Reimplement i_blocks_per_page() as a wrapper around i_blocks_per_folio().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

