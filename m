Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0DA3E2BD2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 15:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344423AbhHFNpY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 09:45:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58783 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344424AbhHFNpW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628257506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0VbV96j7hcbKHoJWYg0a5r9V2HBRp69cIOXkwt8uqKA=;
        b=ZoQOOf7rMyKP/cfJtsWzYpFTtKDfxIAimd/MsQ0lkosBnjKYftPPrPARb5IDczSHiaNPeo
        VrHQ7umDk75RdKRxojOHjjfOdPEl9EW7Z+btRGbXtLmhs7ohUWZtk9D8P3+IF0Tg/Mmnpb
        cnTi7TSyOis7qpS5nTfo6VYhCzaDzHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-o9kCuQ05PaaOrCW-qhce1A-1; Fri, 06 Aug 2021 09:45:03 -0400
X-MC-Unique: o9kCuQ05PaaOrCW-qhce1A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA11296DCFF;
        Fri,  6 Aug 2021 13:45:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6BD75D9D5;
        Fri,  6 Aug 2021 13:44:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YQx4lx7vEbvmfBnE@casper.infradead.org>
References: <YQx4lx7vEbvmfBnE@casper.infradead.org> <YQv+iwmhhZJ+/ndc@casper.infradead.org> <YQvpDP/tdkG4MMGs@casper.infradead.org> <YQvbiCubotHz6cN7@casper.infradead.org> <1017390.1628158757@warthog.procyon.org.uk> <1170464.1628168823@warthog.procyon.org.uk> <1186271.1628174281@warthog.procyon.org.uk> <1219713.1628181333@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Jeff Layton <jlayton@redhat.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Canvassing for network filesystem write size vs page size
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1302764.1628257488.1@warthog.procyon.org.uk>
Date:   Fri, 06 Aug 2021 14:44:48 +0100
Message-ID: <1302765.1628257488@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> Filesystems should not make an assumption about this ... I suspect
> the optimum page size scales with I/O bandwidth; taking PCI bandwidth
> as a reasonable proxy, it's doubled five times in twenty years.

There are a lot more factors than you make out.  Local caching, content
crypto, transport crypto, cost of setting up RPC calls, compounding calls to
multiple servers.

David

