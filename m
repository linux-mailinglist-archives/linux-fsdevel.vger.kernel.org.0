Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605D63E8435
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 22:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhHJUTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 16:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229764AbhHJUTS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628626735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+5WCWcsiWohm6koFEPwxChqvnN4T/a8zTVPw86eJGag=;
        b=CXaSI7WP13G8G9NDhczn5MTU64F/hp19Y2LhngEfG9mWE4xEhplqk4MV/E8F5OGSnWf0jN
        ibjz5cLBA8/JcgIpY8NtpKvyNxFNZ6AgLKflmZJh5+XMLOHt8QP6tMxdCEBMbdX5f6O3SI
        u6uXJxKmzTja99xKcvMTqDJPjpD1cic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-Q9r5JzJUNAeoYlM-3-_vPg-1; Tue, 10 Aug 2021 16:18:52 -0400
X-MC-Unique: Q9r5JzJUNAeoYlM-3-_vPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64430CC622;
        Tue, 10 Aug 2021 20:18:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F40245C1A1;
        Tue, 10 Aug 2021 20:18:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-40-willy@infradead.org>
References: <20210715033704.692967-40-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v14 039/138] mm/memcg: Convert commit_charge() to take a folio
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1810157.1628626729.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 21:18:49 +0100
Message-ID: <1810158.1628626729@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> The memcg_data is only set on the head page, so enforce that by
> typing it as a folio.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: David Howells <dhowells@redhat.com>

