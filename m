Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39E83A96BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 11:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhFPKBI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 06:01:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43821 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231476AbhFPKBH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623837541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tDra7duGdJtvXy9UbrpYtRJLG4m9nZjGKLs8yOICISM=;
        b=Ct8VJlDMkkqXzMC9AihM8y/Exyeiq5Dx5uREPfpihiBmU8g13pibAhqBvybFXhG0sdDuH+
        SLgf0In7lSbbnUIuCMwsyjQakLNF1Syhw4xumg3KKbZQ69dZpzqUGTvYzjb9T8Rd5oj47/
        CxqziwACYykhWm9wUxn7d86ER/OVz94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-XOS2j8QTMXy9ge3zMxXNAw-1; Wed, 16 Jun 2021 05:59:00 -0400
X-MC-Unique: XOS2j8QTMXy9ge3zMxXNAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C67131084F49;
        Wed, 16 Jun 2021 09:58:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E59295C1C5;
        Wed, 16 Jun 2021 09:58:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210614201435.1379188-11-willy@infradead.org>
References: <20210614201435.1379188-11-willy@infradead.org> <20210614201435.1379188-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 10/33] mm: Add folio flag manipulation functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <813816.1623837536.1@warthog.procyon.org.uk>
Date:   Wed, 16 Jun 2021 10:58:56 +0100
Message-ID: <813817.1623837536@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> These new functions are the folio analogues of the various PageFlags
> functions.  If CONFIG_DEBUG_VM_PGFLAGS is enabled, we check the folio
> is not a tail page at every invocation.  This will also catch the
> PagePoisoned case as a poisoned page has every bit set, which would
> include PageTail.
> 
> This saves 1684 bytes of text with the distro-derived config that
> I'm testing due to removing a double call to compound_head() in
> PageSwapCache().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Reviewed-by: David Howells <dhowells@redhat.com>

