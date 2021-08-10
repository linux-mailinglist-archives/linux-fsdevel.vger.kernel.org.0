Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9922B3E8591
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbhHJVmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:42:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32644 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233625AbhHJVl5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628631695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tTmh7DbYqD4x1J43pDaiNE/jVXwaZO+ywqlAbKF5gtE=;
        b=grl//HioVSixjN3wICf0WcP2WJu+waYWExAfLq6onOzZvlie4PlNjOxGZuj7xP/imX1iYU
        kuMPEv0rRYSoshwebtghdmQ8txZbGvAWAzQsWBvx2IMV3DkwlmLCwWpV9NnuMWU1OuYRS0
        jWBrXlCGILH2rzx+k57w4ha+HOyFh2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-0Tay2-xaORyOa7KbZe0nKQ-1; Tue, 10 Aug 2021 17:41:33 -0400
X-MC-Unique: 0Tay2-xaORyOa7KbZe0nKQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93EE61853028;
        Tue, 10 Aug 2021 21:41:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 717457A8D5;
        Tue, 10 Aug 2021 21:41:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-82-willy@infradead.org>
References: <20210715033704.692967-82-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 081/138] mm: Add folio_evictable()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1814101.1628631690.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:41:30 +0100
Message-ID: <1814102.1628631690@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> This is the folio equivalent of page_evictable().  Unfortunately, it's
> different from !folio_test_unevictable(), but I think it's used in places
> where you have to be a VM expert and can reasonably be expected to know
> the difference.

It would be useful to say how it is different.  I'm guessing it's because a
page is always entirely mlocked or not, but a folio might be partially
mlocked?

David

