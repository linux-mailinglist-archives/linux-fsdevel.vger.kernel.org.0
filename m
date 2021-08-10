Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A16F3E843D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 22:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhHJUWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 16:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52511 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229788AbhHJUWE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628626902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sCig48GNPK9nhXdx1sI4bElTHz9Voiv5w7P6BIVkF5A=;
        b=d86gj7s3VSp0UZq8vhybU7cWqj5PXsvYLrY3sDOcCi+k9/Fq8ppFFIdEFZw2HrN+3JjmHC
        fxEHPEZfhV7YkOt+QICt7ZymiVfFSWu+NZ8Bu/gTnr1oo0R85o12s5voh+s2WaCo2Yy+XC
        ag5nMe7hEfTiF3CnGhY1nHXdSLl4F94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-24nerJQIOQusUkF165CYHA-1; Tue, 10 Aug 2021 16:21:38 -0400
X-MC-Unique: 24nerJQIOQusUkF165CYHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50993CC62E;
        Tue, 10 Aug 2021 20:21:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E7E769CBB;
        Tue, 10 Aug 2021 20:21:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-41-willy@infradead.org>
References: <20210715033704.692967-41-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 040/138] mm/memcg: Convert mem_cgroup_charge() to take a folio
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1810282.1628626895.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 21:21:35 +0100
Message-ID: <1810283.1628626895@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Convert all callers of mem_cgroup_charge() to call page_folio() on the
> page they're currently passing in.  Many of them will be converted to
> use folios themselves soon.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

