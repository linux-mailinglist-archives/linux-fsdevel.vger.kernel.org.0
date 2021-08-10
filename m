Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727333E7C68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 17:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243534AbhHJPgM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 11:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58699 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243388AbhHJPfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628609702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RQ/0SiinduV3LbfrDNpCgNc852w6KVFq2vg6uA6nZMY=;
        b=b/BEBggs1mh6gjLGN/7bNCM2jTd0z7txwNj/wh+aYv4oYgcluHAxRsk50xmb4tVKFs0ZXR
        THAszCCW9HXddZtESSV3li0OpfH2MZkFYNETT7kzMLtIdsNnclG/J8H6PC7VqGsEfQo/T+
        QVHlqEEsL60exeoCVooXDcBCCFqObUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-SQn8TOELMhaaUUu2SlN4DQ-1; Tue, 10 Aug 2021 11:34:59 -0400
X-MC-Unique: SQn8TOELMhaaUUu2SlN4DQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 677571026200;
        Tue, 10 Aug 2021 15:34:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8386620DE;
        Tue, 10 Aug 2021 15:34:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-23-willy@infradead.org>
References: <20210715033704.692967-23-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v14 022/138] mm/filemap: Add __folio_lock_or_retry()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1796456.1628609695.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 16:34:55 +0100
Message-ID: <1796457.1628609695@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Convert __lock_page_or_retry() to __folio_lock_or_retry().  This actually
> saves 4 bytes in the only caller of lock_page_or_retry() (due to better
> register allocation) and saves the 14 byte cost of calling page_folio()
> in __folio_lock_or_retry() for a total saving of 18 bytes.  Also use
> a bool for the return type.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Reviewed-by: David Howells <dhowells@redhat.com>

