Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABD43A96BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 12:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhFPKDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 06:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25009 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231491AbhFPKC7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623837653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v117kTvCI/4L2L6gl5HuZGd1wWAwT2ti0jhBIeID/Fk=;
        b=SGtXuhiiksMjAHdghuyiInFVlTwGrS1EkCiS95FToHo+gkcOovUzYt0uok5JVKEVjpcJ0Z
        dxFVqBhsXa5F0FQbX44HnCWk+NGHyFm4HdwO4cEK3QH5uDnLEc7lU0E9wwOmQiIAE/HoEk
        AEGUGvOY+SjFIvpQtSs91aYHVHnUU2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-Ut1RbZJMM-WkHsW9vCAZ9Q-1; Wed, 16 Jun 2021 06:00:51 -0400
X-MC-Unique: Ut1RbZJMM-WkHsW9vCAZ9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57881801AF1;
        Wed, 16 Jun 2021 10:00:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21BBA60C0F;
        Wed, 16 Jun 2021 10:00:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210614201435.1379188-12-willy@infradead.org>
References: <20210614201435.1379188-12-willy@infradead.org> <20210614201435.1379188-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v11 11/33] mm/lru: Add folio LRU functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <813936.1623837648.1@warthog.procyon.org.uk>
Date:   Wed, 16 Jun 2021 11:00:48 +0100
Message-ID: <813937.1623837648@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Handle arbitrary-order folios being added to the LRU.  By definition,
> all pages being added to the LRU were already head or base pages,
> so define page wrappers around folio functions where the original
> page functions involved calling compound_head() to manipulate flags,
> but define folio wrappers around page functions where there's no need to
> call compound_head().  The one thing that does change for those functions
> is calling compound_nr() instead of thp_nr_pages(), in order to handle
> arbitrary-sized folios.
> 
> Saves 783 bytes of kernel text; no functions grow.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Yu Zhao <yuzhao@google.com>

Reviewed-by: David Howells <dhowells@redhat.com>

