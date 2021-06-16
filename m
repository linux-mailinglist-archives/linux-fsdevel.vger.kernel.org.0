Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C273A972F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 12:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhFPKZu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 06:25:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51643 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232306AbhFPKZt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623839023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1DhVRexl1hIuD+IRj0y8EDAY4x8a5T+YW94ra0OHDuo=;
        b=f5sAmFPRbi/wBuwUZmXCSb2ba/x5/AimfsgZjp4oFOIbFygjwWZwxwYvtyknKHj6I38xEd
        WV6zJrqbkpJyf2NDyBc4jsCDci0zIhuGHdkhLunUkMSK0OzFUtfwabuNmdAoreTMyBivd7
        sLvtxyjZMJcPi89Yqu5Szc1w2Kbb2ms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-MA_M6b6FPIKP1HWNfAW1Jw-1; Wed, 16 Jun 2021 06:23:40 -0400
X-MC-Unique: MA_M6b6FPIKP1HWNfAW1Jw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B737101F002;
        Wed, 16 Jun 2021 10:23:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A976260BF1;
        Wed, 16 Jun 2021 10:23:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210614201435.1379188-23-willy@infradead.org>
References: <20210614201435.1379188-23-willy@infradead.org> <20210614201435.1379188-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 22/33] mm/filemap: Add folio_wait_locked()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <815444.1623839015.1@warthog.procyon.org.uk>
Date:   Wed, 16 Jun 2021 11:23:35 +0100
Message-ID: <815445.1623839015@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Also add folio_wait_locked_killable().  Turn wait_on_page_locked() and
> wait_on_page_locked_killable() into wrappers.  This eliminates a call
> to compound_head() from each call-site, reducing text size by 193 bytes
> for me.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Reviewed-by: David Howells <dhowells@redhat.com>

