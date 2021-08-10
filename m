Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B03C3E840B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 22:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhHJUCO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 16:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230525AbhHJUCN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628625710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8fKmlPsC4KL9Ox8Fy5TOXo0E1WLzgN066kklEj5Em50=;
        b=eSYzR1gyRzxRQdQniC/RcoG9BrnSbxRyiL+F3plJD8QU+69gZIYwZsLsOa91upcLpWQHbJ
        qtOOZmDUORdSyZGQrY+EEF2IeZ9ISCdoPpl9FkLaniXbOpotOQJ1BR7C4ouq7ropFKoWi2
        HgIgF7XYG8x/+HPr+F2gn+LOIQ65Sbg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-RiFPUn-NMCqGnyfKhoTNTQ-1; Tue, 10 Aug 2021 16:01:49 -0400
X-MC-Unique: RiFPUn-NMCqGnyfKhoTNTQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EC481009600;
        Tue, 10 Aug 2021 20:01:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F088A26E7D;
        Tue, 10 Aug 2021 20:01:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-34-willy@infradead.org>
References: <20210715033704.692967-34-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 033/138] mm: Add folio_nid()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1809349.1628625706.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 21:01:46 +0100
Message-ID: <1809350.1628625706@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> This is the folio equivalent of page_to_nid().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

