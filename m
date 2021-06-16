Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D493A9737
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 12:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhFPK3T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 06:29:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231638AbhFPK3S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623839232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5/MGpaB8x4dZp8adc4wd4CulLfA8NqaKDl+l0yyAF0g=;
        b=d5skyF9zFK3HpawldNOBgwTA29+5Pl/5C64230rgy+UvDybXKnUELlOV3FiKC+ebGTl2xT
        MPLsg98NVr4bWzSsOPcRmzMP8QSsm7WTtR0PBuvzBOlDhen/hAa60FMwON/kGwJoxHnYmK
        giW/cqGM/uKZ79Sgb+qPzgGqTBUtjEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-603-xW7F7CWCMkCBbNIzVcI7Xg-1; Wed, 16 Jun 2021 06:27:09 -0400
X-MC-Unique: xW7F7CWCMkCBbNIzVcI7Xg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C93D101F000;
        Wed, 16 Jun 2021 10:27:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C9E460BF1;
        Wed, 16 Jun 2021 10:27:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210614201435.1379188-25-willy@infradead.org>
References: <20210614201435.1379188-25-willy@infradead.org> <20210614201435.1379188-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v11 24/33] mm/swap: Add folio_rotate_reclaimable()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <815661.1623839222.1@warthog.procyon.org.uk>
Date:   Wed, 16 Jun 2021 11:27:02 +0100
Message-ID: <815662.1623839222@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> +	    !folio_unevictable(folio) && folio_lru(folio)) {

Hmmm...  Would folio_lru() be better named folio_on_lru()?  folio_lru() sounds
like it returns the folio's LRU.

David

