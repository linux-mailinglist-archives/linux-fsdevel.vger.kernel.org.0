Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55F03E8599
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhHJVqS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48672 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234748AbhHJVqS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628631954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W5aEPW0vVy1f3yTR/vbVxRNZoiXDLOWVh/Qz0zOsQjE=;
        b=X4Gzgx5N6nAKsYyi6O3ri8NQEqqnrTmtsCCSrNLEvTn8mPnIuQDYDdaLLdn+kIkoX39vWN
        TCHsJcxNE1MGD/LfCeTlkmS1Gy3C9Lgc/Mi667p/KS1k1egFOdui/glRYYsBRb25ol83L0
        ZN3aBDieE88SFM/NMGIgs8EYQOar+4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-0cNJ5zi3PNy-F2A2lDvuWg-1; Tue, 10 Aug 2021 17:45:53 -0400
X-MC-Unique: 0cNJ5zi3PNy-F2A2lDvuWg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94CBF106B6A2;
        Tue, 10 Aug 2021 21:45:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7405D1B472;
        Tue, 10 Aug 2021 21:45:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-84-willy@infradead.org>
References: <20210715033704.692967-84-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 083/138] mm/lru: Add folio_add_lru()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1814288.1628631950.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:45:50 +0100
Message-ID: <1814289.1628631950@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Reimplement lru_cache_add() as a wrapper around folio_add_lru().
> Saves 159 bytes of kernel text due to removing calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

