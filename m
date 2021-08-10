Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C253E84FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhHJVNe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:13:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30633 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231894AbhHJVNe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628629991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=br1YRIL5nRr88xcVpnkVqktB/tJrDf5BHsRvg7A9uAw=;
        b=HZzq/MD5NzTIuIIqGiD+BahgqN7DWV+9h7rUxGlmyiD+2pNU5/+smAABW/iQJW3WTRZDpa
        BmB2+YMirudrN2hP8NHxki6GM5cqY8V7+lg11y+FF8Gi2A2kozTB9+Af+0p87Hp7xxECV6
        shvU7l6qEMS53c8KKtsXE8LMjAWM0uk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-tg1l0d0QP8aOY-nelRhFjg-1; Tue, 10 Aug 2021 17:13:10 -0400
X-MC-Unique: tg1l0d0QP8aOY-nelRhFjg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E42AF106F6EB;
        Tue, 10 Aug 2021 21:13:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3ED2421F;
        Tue, 10 Aug 2021 21:13:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-64-willy@infradead.org>
References: <20210715033704.692967-64-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 063/138] mm/writeback: Rename __add_wb_stat() to wb_stat_mod()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1812677.1628629986.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:13:06 +0100
Message-ID: <1812678.1628629986@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Make this look like the newly renamed vmstat functions.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

