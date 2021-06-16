Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CA93A977A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 12:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhFPKgl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 06:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57412 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232296AbhFPKgA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623839634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k+dMA6glNyiQT0BmMXYIPoOIeuuIo4m4SbNgpVOMDa4=;
        b=FYE+zO3FqKZvJw9Av5eU0hrTNtClf0Lyoyyf2BtnAXpK4zzSe7Y0JQg924LiFwPKleQv49
        R0HLBNwzIwtAWLXlHfcJGmT6s8N3vMcFr8c1c4W5Ow1waDnefQms+veAMzSISfM6/fqnnr
        TatgJ2JyOPHFHcmBi+G7YVWkiNUllPo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-az5yCyK0Mq6B4ktpitQ3gA-1; Wed, 16 Jun 2021 06:33:50 -0400
X-MC-Unique: az5yCyK0Mq6B4ktpitQ3gA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 205DD19057A0;
        Wed, 16 Jun 2021 10:33:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F48359440;
        Wed, 16 Jun 2021 10:33:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210614201435.1379188-29-willy@infradead.org>
References: <20210614201435.1379188-29-willy@infradead.org> <20210614201435.1379188-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 28/33] mm/filemap: Add folio_wait_bit()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <816095.1623839626.1@warthog.procyon.org.uk>
Date:   Wed, 16 Jun 2021 11:33:46 +0100
Message-ID: <816096.1623839626@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Rename wait_on_page_bit() to folio_wait_bit().  We must always wait on
> the folio, otherwise we won't be woken up due to the tail page hashing
> to a different bucket from the head page.
> 
> This commit shrinks the kernel by 770 bytes, mostly due to moving
> the page waitqueue lookup into folio_wait_bit_common().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Reviewed-by: David Howells <dhowells@redhat.com>

