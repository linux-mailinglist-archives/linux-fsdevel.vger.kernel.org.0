Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2087E3E8514
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbhHJVSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36376 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234009AbhHJVSo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628630301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kd5sOM2lE8G16kwKZ2yuKZ958xSbsd3EPAS6DFRskxc=;
        b=Tu8VMfHSKYQkwRAYsqXUo8HHHSoWOqzMlLYlhbFM0+96ljuM7GemTFFqFCrMrOCYke04et
        aR85w9R0MdWycsgpJeTf8KyTEHILjIx3vriD0AGtyRTV/0FYLLfk/TtHm4WR+XLZEL3UMu
        KXJCMJSvVxbAYKzdcT0iZQDheXm3Bu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-yC7zaF9kPhe3PLmfplJmDw-1; Tue, 10 Aug 2021 17:18:20 -0400
X-MC-Unique: yC7zaF9kPhe3PLmfplJmDw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D9F4801AEB;
        Tue, 10 Aug 2021 21:18:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDC5B10016FF;
        Tue, 10 Aug 2021 21:18:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-69-willy@infradead.org>
References: <20210715033704.692967-69-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 068/138] mm/writeback: Add folio_mark_dirty()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1812968.1628630297.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:18:17 +0100
Message-ID: <1812969.1628630297@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Reimplement set_page_dirty() as a wrapper around folio_mark_dirty().
> There is no change to filesystems as they were already being called
> with the compound_head of the page being marked dirty.  We avoid
> several calls to compound_head(), both statically (through
> using folio_test_dirty() instead of PageDirty() and dynamically by
> calling folio_mapping() instead of page_mapping().
> 
> Also return bool instead of int to show the range of values actually
> returned, and add kernel-doc.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

