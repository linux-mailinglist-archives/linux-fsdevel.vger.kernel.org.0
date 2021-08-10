Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A753E8563
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbhHJVfE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:35:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23728 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233625AbhHJVfE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628631281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M07184jKAvMxpfzMZ1dKXh+WpGAO8RO24s56vHQzw+s=;
        b=TUMPxX0zOdjISO/MKysXuRCcmVkVYhxS6f3YTCo8fZT4ua0rqXIzKWddZRWLH3/v9zQcve
        oGdF7qtU4vhmn/u2t/m4HNcaAjUEf/zrDyZ4w4WVeqkqXLt8Thdlog8WPZDxHNpFtcsYJZ
        iCYOpk9gCG4/8PSuaGbnRtOBV+ccHko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-7po_AAuOPrmO7ZYwl-BnwA-1; Tue, 10 Aug 2021 17:17:03 -0400
X-MC-Unique: 7po_AAuOPrmO7ZYwl-BnwA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27503593C5;
        Tue, 10 Aug 2021 21:17:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 042E85D9C6;
        Tue, 10 Aug 2021 21:17:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-68-willy@infradead.org>
References: <20210715033704.692967-68-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 067/138] mm/writeback: Add folio_start_writeback()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1812884.1628630220.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:17:00 +0100
Message-ID: <1812885.1628630220@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Rename set_page_writeback() to folio_start_writeback() to match
> folio_end_writeback().  Do not bother with wrappers that return void;
> callers are perfectly capable of ignoring return values.
> 
> Add wrappers for set_page_writeback(), set_page_writeback_keepwrite() and
> test_set_page_writeback() for compatibililty with existing filesystems.
> The main advantage of this patch is getting the statistics right,
> although it does eliminate a couple of calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

