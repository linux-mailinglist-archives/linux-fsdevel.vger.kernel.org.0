Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C323A96D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 12:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhFPKFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 06:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55638 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232223AbhFPKFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623837808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1oOOajeTs73uOHHw8BPW/fWJ1/8lT7ir3uJgyrWJ/4w=;
        b=AWmHOtIrMWdV5m6ISOlPeEy8+9D7Hj1mkbeq0Tp0Sl5szUNbPnz3DP5ShxUZdUofHo4z00
        JvJqJuvtNFms2/T4ouZ8qg3akzLkL5HLd17/+Bn0o2ydCY1LzA/+/b51mpbnMZBbX4xok+
        8Rz49KoRDWdg23FTcymlM5il0Hx0Z2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-TBihh347OimP-6JhKAx2Pw-1; Wed, 16 Jun 2021 06:03:27 -0400
X-MC-Unique: TBihh347OimP-6JhKAx2Pw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7BC5803620;
        Wed, 16 Jun 2021 10:03:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07FC66060F;
        Wed, 16 Jun 2021 10:03:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210614201435.1379188-14-willy@infradead.org>
References: <20210614201435.1379188-14-willy@infradead.org> <20210614201435.1379188-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 13/33] mm/filemap: Add folio_index(), folio_file_page() and folio_contains()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <814130.1623837803.1@warthog.procyon.org.uk>
Date:   Wed, 16 Jun 2021 11:03:23 +0100
Message-ID: <814131.1623837803@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> folio_index() is the equivalent of page_index() for folios.
> folio_file_page() is the equivalent of find_subpage().
> folio_contains() is the equivalent of thp_contains().
> 
> No changes to generated code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

folio_subpage() might be a better name than folio_file_page().

Reviewed-by: David Howells <dhowells@redhat.com>

