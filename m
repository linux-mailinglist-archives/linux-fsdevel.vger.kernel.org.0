Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FAE3E8474
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 22:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhHJUkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 16:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60531 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229822AbhHJUkH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628627984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8hN9X0coZ/dZkZpRS5vtT+uzi+4IbErPaehQsrg5q0U=;
        b=cV4BC9FvFP559dLnPKQ2djxDyxMfYCEzKNKzxIJUrEn2Jwcdxqhh59hV+AIKeACUmC4/8p
        RkvlEQC+xJSXY/LdADqtDJPpnYB0Mo7ztBzpEDB1qQYurrQBEGGmRwq9JniwXOF1EkZPJ3
        ICtukUlbOgc9zpqcQl+ywol8/AnAqa8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-65fBjrNeMviyqPfbF--8uw-1; Tue, 10 Aug 2021 16:39:42 -0400
X-MC-Unique: 65fBjrNeMviyqPfbF--8uw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7749D101C8A0;
        Tue, 10 Aug 2021 20:39:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 530D05C1A1;
        Tue, 10 Aug 2021 20:39:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-51-willy@infradead.org>
References: <20210715033704.692967-51-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 050/138] mm/workingset: Convert workingset_activation to take a folio
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1811129.1628627979.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 21:39:39 +0100
Message-ID: <1811130.1628627979@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> This function already assumed it was being passed a head page.  No real
> change here, except that thp_nr_pages() compiles away on kernels with
> THP compiled out while folio_nr_pages() is always present.  Also convert
> page_memcg_rcu() to folio_memcg_rcu().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

