Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053EB3E8595
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbhHJVo6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:44:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234156AbhHJVo4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628631871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eNfeyWrqqbqel+aMF+OwDIK7E5m7g6wfz5VP9czGAHg=;
        b=R1qKBXkc9UEIkJFx2l108kpNQ65cWFi0d5AWSb1cvt/JZUbPFoi1AOHUYsck/jQbK4z3OC
        Ut6y9rHglClFi8owSN4u30hBlYCCcA6NrJSCM/s8GAs7Rv1k6meR11G+P9GXirJ5KOR4Mx
        XTafig4kkFM0sjmKF343kqXvFH2f1nQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-_jVYxBs6NEqvFFOjQ_xFDQ-1; Tue, 10 Aug 2021 17:44:30 -0400
X-MC-Unique: _jVYxBs6NEqvFFOjQ_xFDQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03552760C0;
        Tue, 10 Aug 2021 21:44:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D36355D6CF;
        Tue, 10 Aug 2021 21:44:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-83-willy@infradead.org>
References: <20210715033704.692967-83-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 082/138] mm/lru: Convert __pagevec_lru_add_fn to take a folio
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1814230.1628631867.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:44:27 +0100
Message-ID: <1814231.1628631867@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

>  	 * looking at the same page) and the evictable page will be stranded
>  	 * in an unevictable LRU.

Does that need converting to say 'folio'?

Other than that:

Reviewed-by: David Howells <dhowells@redhat.com>

