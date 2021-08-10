Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E713E7C7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 17:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243421AbhHJPkI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 11:40:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243546AbhHJPjc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628609949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/XX2NCopgWUN1ynp8Zyld+km/JWS/skjUysosbsfUW0=;
        b=ZhSfFHfwhGsBYucKC4mV2tDc7zHjldqTR8yprjZTDRK62YSPbSEFytS7kJALBm4SZRizD4
        lxnIxjz8Es76c7EGfN8FioRs1ruM4CIclxc/vKPRTYrqiFhHvCq/YKj3Wcg4wzLjaCc65z
        80GZwtRnO4WXPfQ3/5Nk1ZlVpgA96jg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-WpF4DkhwP-mSxhE2UWd9_A-1; Tue, 10 Aug 2021 11:39:08 -0400
X-MC-Unique: WpF4DkhwP-mSxhE2UWd9_A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D4591008064;
        Tue, 10 Aug 2021 15:39:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0C76136F5;
        Tue, 10 Aug 2021 15:39:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-32-willy@infradead.org>
References: <20210715033704.692967-32-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v14 031/138] fs/netfs: Add folio fscache functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1796697.1628609944.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 16:39:04 +0100
Message-ID: <1796698.1628609944@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Match the page writeback functions by adding
> folio_start_fscache(), folio_end_fscache(), folio_wait_fscache() and
> folio_wait_fscache_killable().  Remove set_page_private_2().  Also rewrite
> the kernel-doc to describe when to use the function rather than what the
> function does, and include the kernel-doc in the appropriate rst file.
> Saves 31 bytes of text in netfs_rreq_unlock() due to set_page_fscache()
> calling page_folio() once instead of three times.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Assuming you fixed the kernel test robot report:

Reviewed-by: David Howells <dhowells@redhat.com>

