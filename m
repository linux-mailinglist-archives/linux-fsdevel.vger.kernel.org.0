Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573783E7C22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 17:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243038AbhHJP1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 11:27:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242988AbhHJP1h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628609234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aR5WiP8Sy2Ok7L+iqhhcSFE1BU6ka1g0BypnNp795AU=;
        b=V0ReLh3JEcrgu1mRHPMa7ITiaccvM2MfUR/pwVcQHkgmoiFEQp5C6s6bKw2JxJbesGWXc5
        gOAzmUQW/x/xzKTRCieYlFwDMelY0oaRUqv0cz8/51ZrvLrlo3lq5lhIo53OeyblF53uE0
        aus0+I+t01ZhAuFmKtOIuLOMiKe8av4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-mihzOg3-MlCdZKFZdunwXw-1; Tue, 10 Aug 2021 11:27:11 -0400
X-MC-Unique: mihzOg3-MlCdZKFZdunwXw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3FD38C578A;
        Tue, 10 Aug 2021 15:26:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58C225D9CA;
        Tue, 10 Aug 2021 15:26:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-2-willy@infradead.org>
References: <20210715033704.692967-2-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v14 001/138] mm: Convert get_page_unless_zero() to return bool
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1796019.1628609209.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 16:26:49 +0100
Message-ID: <1796020.1628609209@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> atomic_add_unless() returns bool, so remove the widening casts to int
> in page_ref_add_unless() and get_page_unless_zero().  This causes gcc
> to produce slightly larger code in isolate_migratepages_block(), but
> it's not clear that it's worse code.  Net +19 bytes of text.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: David Howells <dhowells@redhat.com>

