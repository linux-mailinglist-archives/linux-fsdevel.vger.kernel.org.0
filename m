Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579E83E847E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 22:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbhHJUmp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 16:42:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47653 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230181AbhHJUmn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628628140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=++wkOjMEpIZk1UaKIXWLectFjgawTsU5Dv9e7nL8sMw=;
        b=YKtbzcH/oaFXRCwH9WDWcHK+0PEW9HsFQ9ggyJXkYQtiSYrsGjryPGJXYVaBP5VAhv9pwA
        IiU4d74TcALqYzMqRClCmvZJ0NFt5vBRioG3fz5aJ+hP2SNBl5o9X42OuErKaTgH5c1UHi
        prubz61SOr5hgrdwq+jBcJTBpTKfi0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-OpMXW8FxO3ygC_RBe5wxOA-1; Tue, 10 Aug 2021 16:42:19 -0400
X-MC-Unique: OpMXW8FxO3ygC_RBe5wxOA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 074CB1008062;
        Tue, 10 Aug 2021 20:42:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C29A2B0B3;
        Tue, 10 Aug 2021 20:42:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-53-willy@infradead.org>
References: <20210715033704.692967-53-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 052/138] mm: Add folio_raw_mapping()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1811269.1628628133.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 21:42:13 +0100
Message-ID: <1811270.1628628133@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Convert __page_rmapping to folio_raw_mapping and move it to mm/internal.h.
> It's only a couple of instructions (load and mask), so it's definitely
> going to be cheaper to inline it than call it.  Leave page_rmapping
> out of line.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I assume you're going to call it from another source file at some point,
otherwise this is unnecessary.

Apart from that,

Reviewed-by: David Howells <dhowells@redhat.com>

