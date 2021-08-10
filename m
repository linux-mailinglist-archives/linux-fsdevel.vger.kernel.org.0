Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2689C3E8428
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 22:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhHJUMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 16:12:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232825AbhHJUMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628626348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/qZnHu7B6saq4K/1dn4UHCTV47joknlef7bAyXiiqEQ=;
        b=ZuRm/QJaGb03XFZa4k5zRJ6R46fRqrNtQTejMKAkujgWN2+RDSuqVWEv9GQlkJ8w68EvTA
        f61i35zaZhaKiVzi68J1eZesI+xmMfX+wbUw3qlVfmqyvpfXCgxFTtn6oMOjE8YJx1K41N
        iDqnmWJPLb1NqoJGioy/mUXwKQC9MxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-TCubkeAZN8m2rg4LZVuYEw-1; Tue, 10 Aug 2021 16:12:25 -0400
X-MC-Unique: TCubkeAZN8m2rg4LZVuYEw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55649760C0;
        Tue, 10 Aug 2021 20:12:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1EE45C25A;
        Tue, 10 Aug 2021 20:12:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-38-willy@infradead.org>
References: <20210715033704.692967-38-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 037/138] mm/memcg: Convert memcg_check_events to take a node ID
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1809870.1628626342.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 21:12:22 +0100
Message-ID: <1809871.1628626342@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> memcg_check_events only uses the page's nid, so call page_to_nid in the
> callers to make the interface easier to understand.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

