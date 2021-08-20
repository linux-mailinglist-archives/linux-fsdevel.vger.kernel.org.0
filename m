Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0BA3F3157
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 18:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhHTQPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 12:15:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229772AbhHTQPa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 12:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629476091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iId6LBZFVjVNhIS6gne4I0ejJ3OJjffX7KVyfwk6qZs=;
        b=Y9vunj4cM9Dy5Ycv1Re5tVhMg0DCtX0vNbyJOBpqEJzhqeYNmQa1rcoXxL+0REkAcDyyVZ
        aFcJkwCpDQ0R1qwnVb8Z3vTgo3bHVNU43DUdorGzG369PV3XJ62z3beDJgSj3h1/Vc+ME0
        9n9uyb2EnwAxn3ldhITYNhsmvFin6qU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-5iaIlbk_N3GKl_lhH0AOFQ-1; Fri, 20 Aug 2021 12:14:49 -0400
X-MC-Unique: 5iaIlbk_N3GKl_lhH0AOFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABF5E760C0;
        Fri, 20 Aug 2021 16:14:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB4C71002D71;
        Fri, 20 Aug 2021 16:14:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] mm: Export PageHeadHuge()
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 20 Aug 2021 17:14:47 +0100
Message-ID: <162947608701.760537.640097323184606750.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Export PageHeadHuge() - it's used by folio_test_hugetlb() and thence by
folio_file_page() and folio_contains().

Signed-off-by: David Howells <dhowells@redhat.com>
---

 mm/hugetlb.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 68eead0259cc..ad6ef6d2c0bc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1717,6 +1717,7 @@ int PageHeadHuge(struct page *page_head)
 
 	return page_head[1].compound_dtor == HUGETLB_PAGE_DTOR;
 }
+EXPORT_SYMBOL(PageHeadHuge);
 
 /*
  * Find and lock address space (mapping) in write mode.


