Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537473A972C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 12:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhFPKYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 06:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23494 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232306AbhFPKYu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623838964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6RWnqSpcrgZjh1XQbVRPquCQDLA5T0X105aU7/jdsck=;
        b=M1uQEIQj+Ln28NnKcAtXZvqy7vC7hYq78oYhZD4P3j59W7RY9e3wTMei7urYsob8bAe+Qr
        RL/0WZ40Vp7Q4FaAz5usAvVYCm5qd9KJyQ5NJY9Gq3R3ikfNyS0QxsOr6X9MqRKu1frKJy
        lvVGLeEj6x6/wiHNH5vvlBhtR1K8N8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-tbmZIluGMNipFgvMy9vLIg-1; Wed, 16 Jun 2021 06:22:42 -0400
X-MC-Unique: tbmZIluGMNipFgvMy9vLIg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F0F5800D55;
        Wed, 16 Jun 2021 10:22:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58F325D9E2;
        Wed, 16 Jun 2021 10:22:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210614201435.1379188-22-willy@infradead.org>
References: <20210614201435.1379188-22-willy@infradead.org> <20210614201435.1379188-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 21/33] mm/filemap: Add __folio_lock_async()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <815371.1623838958.1@warthog.procyon.org.uk>
Date:   Wed, 16 Jun 2021 11:22:38 +0100
Message-ID: <815372.1623838958@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> There aren't any actual callers of lock_page_async(), so remove it.
> Convert filemap_update_page() to call __folio_lock_async().
> 
> __folio_lock_async() is 21 bytes smaller than __lock_page_async(),
> but the real savings come from using a folio in filemap_update_page(),
> shrinking it from 515 bytes to 404 bytes, saving 110 bytes.  The text
> shrinks by 132 bytes in total.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Reviewed-by: David Howells <dhowells@redhat.com>

