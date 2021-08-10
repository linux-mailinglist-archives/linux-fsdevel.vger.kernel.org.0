Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0EC3E8463
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 22:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhHJUck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 16:32:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29626 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232955AbhHJUck (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628627537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D/GCP1SLhUcFuFlTZh0zMqdOZ6Hi0zcBSRyMkejTCjQ=;
        b=TjL5DjMV5G+eUOVEpQMs9bgQAWaO8qxZj2tMXpZZgSe8S/iiuI+ETLmODDCTAWWP8UXe2X
        mgbQDIJ/uKTzfZTwYSWAIXdfiCT90sCDdR60teiFIsVI/FAKDl9H/e2fOUDeX1Z7JzFDa4
        usp8yJRl1RrF4uuM3DbKtkXCKM+GTMo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-rSi96D8OPE-Jbi_H-_1BvA-1; Tue, 10 Aug 2021 16:32:16 -0400
X-MC-Unique: rSi96D8OPE-Jbi_H-_1BvA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AFF3CC622;
        Tue, 10 Aug 2021 20:32:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D562F3AFD;
        Tue, 10 Aug 2021 20:32:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-48-willy@infradead.org>
References: <20210715033704.692967-48-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 047/138] mm/memcg: Add folio_lruvec()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1810791.1628627530.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 21:32:10 +0100
Message-ID: <1810792.1628627530@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> This replaces mem_cgroup_page_lruvec().  All callers converted.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

