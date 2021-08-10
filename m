Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51E83E8537
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbhHJVYR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:24:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234613AbhHJVYP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628630632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zl+SFxMBURzTNx0iFxg9wDAN9QWXIbjsgbL3OqA/y9s=;
        b=Hw0V2fzFZz4tu0YFVANSA06bCmLRysLacD3PRqEgwWuRLmzvPLdCbwsnrhZefC/0gxVv1B
        3oXctYYSixE/Jhs/32O+Zg542krEtbeN4sOLUXGxPni73TCCgUyGU6GbvaNKVcdh87MVXy
        cBqoKEYuydBMnpOrw2RkYTf0cek+LZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-RnWwPulcPtu7SNFoNycdsQ-1; Tue, 10 Aug 2021 17:23:50 -0400
X-MC-Unique: RnWwPulcPtu7SNFoNycdsQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 767D7801B3C;
        Tue, 10 Aug 2021 21:23:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CCCB5D9C6;
        Tue, 10 Aug 2021 21:23:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-74-willy@infradead.org>
References: <20210715033704.692967-74-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 073/138] mm/writeback: Add folio_cancel_dirty()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1813245.1628630627.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:23:47 +0100
Message-ID: <1813246.1628630627@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Turn __cancel_dirty_page() into __folio_cancel_dirty() and add wrappers.
> Move the prototypes into pagemap.h since this is page cache functionality.
> Saves 44 bytes of kernel text in total; 33 bytes from __folio_cancel_dirty
> and 11 from two callers of cancel_dirty_page().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

