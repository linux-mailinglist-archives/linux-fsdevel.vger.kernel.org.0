Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFF93E8566
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhHJVfV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:35:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21711 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234545AbhHJVfU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628631297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cDJeQ1IVHivnnNjVy+6TxvfQSLwRaCeXGyL2mLJIpfs=;
        b=OKhbhIt6gPDKtGWw/IO/AZylIyu5BkYYRZaDu3syjcFkAXd3Anuf1QZNfgqCOG5APywcBB
        z+WSNa/UQM8pFryi1InvhRAhS03L0rpA1xyGNEhejHtr6rUZ9VfNuiK4sii97DEkJYeFXp
        dSegufzVZfB9cWL71kw6qAeQjiJKpT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-5MSDVLBIOhmregoOV89k5g-1; Tue, 10 Aug 2021 17:34:53 -0400
X-MC-Unique: 5MSDVLBIOhmregoOV89k5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D84236409B;
        Tue, 10 Aug 2021 21:34:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A359527CA8;
        Tue, 10 Aug 2021 21:34:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-80-willy@infradead.org>
References: <20210715033704.692967-80-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 079/138] mm/filemap: Add readahead_folio()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1813749.1628631290.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:34:50 +0100
Message-ID: <1813750.1628631290@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> The pointers stored in the page cache are folios, by definition.
> This change comes with a behaviour change -- callers of readahead_folio()
> are no longer required to put the page reference themselves.  This matches
> how readpage works, rather than matching how readpages used to work.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

For some of the things I'm looking at, this is actually inconvenient, but I
guess I can take an extra ref if I need it.

Reviewed-by: David Howells <dhowells@redhat.com>

