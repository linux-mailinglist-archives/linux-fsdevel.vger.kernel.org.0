Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446253C815D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 11:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbhGNJV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 05:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41103 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238825AbhGNJV5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626254345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=znVfHiAcFHX9tJuBNtdE1enTDALli5tsEzq060vRh+Q=;
        b=hew/+TiFc4P7jIOUxBq10rByYPEV4AYofzq752JSu906zpe/HUtGdtyhiM90QsCjmLUayg
        FP5asFm6teP7dMzTb2E9YMuT2x4GRWtoJJ6B+ObzwASuMxz2AiZiW8Fg3M/nwSwmSYhy+X
        mvUTlApns6vS+2fHohBb/cBMrwPrdfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-nQkNRMj3N_WxmjWm5Vh2DA-1; Wed, 14 Jul 2021 05:19:01 -0400
X-MC-Unique: nQkNRMj3N_WxmjWm5Vh2DA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73754A40C2;
        Wed, 14 Jul 2021 09:18:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-19.rdu2.redhat.com [10.10.118.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5028146;
        Wed, 14 Jul 2021 09:18:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YO23WOUhhZtL6Gtn@cmpxchg.org>
References: <YO23WOUhhZtL6Gtn@cmpxchg.org> <20210712030701.4000097-1-willy@infradead.org> <20210712030701.4000097-11-willy@infradead.org> <YOzdKYejOEUbjvMj@cmpxchg.org> <YOz3Lms9pcsHPKLt@casper.infradead.org> <20210713091533.GB4132@worktop.programming.kicks-ass.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     dhowells@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v13 010/137] mm: Add folio flag manipulation functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3996757.1626254335.1@warthog.procyon.org.uk>
Date:   Wed, 14 Jul 2021 10:18:55 +0100
Message-ID: <3996758.1626254335@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> wrote:

> For example, in __set_page_dirty_no_writeback()
> 
> 	if (folio_is_dirty())
> 		return !folio_testset_dirty()
> 
> is less clear about what's going on than would be:
> 
> 	if (folio_test_dirty())
> 		return !folio_testset_dirty()

"if (folio_is_dirty())" reads better to me as that's more or less how you'd
structure a sentence beginning with "if" in English.

On the other hand, folio_test_xxx() fits in with a folio_testset_xxx() naming
style.  English doesn't really have test-and-set operator words.

David

