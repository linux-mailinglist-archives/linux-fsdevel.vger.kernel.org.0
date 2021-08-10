Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779933E8503
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbhHJVPS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:15:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234070AbhHJVPF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628630077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EYahC2ZnCWSTFW9U9F8k/7+TQ22UjLyYMk29C3tLkHA=;
        b=GB2Fo+OsBL4K3wTsQ9G41EWJ8w2z0CjZiTzvLeqH419RyyrXuRyWBPbBZ2RcE5gsAjkUX1
        cDHSqB3mqvDh5kINDrQoLpk1l0YnhzbYn6Lijjv0/s0zrtimQCDUQ8/N/RTg2+7MTvPAas
        x3oxpz/2SIHdmo8exw0TrHRj9Lm7s9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-XPcEg2AINHOfMLKGZvmO1A-1; Tue, 10 Aug 2021 17:14:34 -0400
X-MC-Unique: XPcEg2AINHOfMLKGZvmO1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7E3A106F6ED;
        Tue, 10 Aug 2021 21:14:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BE395C1A1;
        Tue, 10 Aug 2021 21:14:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-66-willy@infradead.org>
References: <20210715033704.692967-66-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v14 065/138] mm/writeback: Change __wb_writeout_inc() to __wb_writeout_add()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1812746.1628630070.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:14:30 +0100
Message-ID: <1812747.1628630070@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Allow for accounting N pages at once instead of one page at a time.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>

Reviewed-by: David Howells <dhowells@redhat.com>

