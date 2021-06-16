Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D91E3A9769
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 12:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhFPKfF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 06:35:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232459AbhFPKeZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623839539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yl30ugH1lwCBgurpvBTL5w9+PIy6WUfvyh3uwvyfRVE=;
        b=GurRXLE4DyriEjl/925NxzUzvBM9AMDT9y08aluyxGNEt/FdieHp5Zgn9O+HD94FNhYAqa
        FoIJ/5iX1rGOHLZHrVp5cjlvUvK537QyGisSSDQu+bauSb06z+v/N1hYl0BDT3oYODDilU
        1IklteOLSSOw1FiN5zvBM2JaaCXeNrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-LHGPIrFYMsaYW2b36JRx9A-1; Wed, 16 Jun 2021 06:32:17 -0400
X-MC-Unique: LHGPIrFYMsaYW2b36JRx9A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C6BA101F006;
        Wed, 16 Jun 2021 10:32:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D20225D6D1;
        Wed, 16 Jun 2021 10:32:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210614201435.1379188-28-willy@infradead.org>
References: <20210614201435.1379188-28-willy@infradead.org> <20210614201435.1379188-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 27/33] mm/writeback: Add folio_wait_stable()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <816003.1623839532.1@warthog.procyon.org.uk>
Date:   Wed, 16 Jun 2021 11:32:12 +0100
Message-ID: <816004.1623839532@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Move wait_for_stable_page() into the folio compatibility file.
> folio_wait_stable() avoids a call to compound_head() and is 14 bytes
> smaller than wait_for_stable_page() was.  The net text size grows by 16
> bytes as a result of this patch.  We can also remove thp_head() as this
> was the last user.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Reviewed-by: David Howells <dhowells@redhat.com>

