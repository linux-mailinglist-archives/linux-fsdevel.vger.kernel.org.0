Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBFD3694CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 16:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242625AbhDWOeG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 10:34:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241174AbhDWOeE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619188407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TjxYyjr3+n/FgdeoX21aU0rXvOBSEI7Z5zCaxLkZK4Q=;
        b=FPY+RzXPMgUD6g+zYy6K2V76gXPi0ahgYiy/09+H1FZ52r4fvDnZR4n1lYkxPKQj+xSwD8
        ywEMpevakTRNd7OEaJafjfotZkJGDXT+oCYiJf9QAcgAZRwzymzpaXWDdNdjab2KKTLbsx
        13iM3AlCHhVDmhGmZd6z5xdFX0vhJtA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-AceqMeyuOfiNiPlJDe3uCw-1; Fri, 23 Apr 2021 10:33:24 -0400
X-MC-Unique: AceqMeyuOfiNiPlJDe3uCw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F459839A4C;
        Fri, 23 Apr 2021 14:33:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-124.rdu2.redhat.com [10.10.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3B2960C25;
        Fri, 23 Apr 2021 14:33:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210423140625.GC235567@casper.infradead.org>
References: <20210423140625.GC235567@casper.infradead.org> <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk> <161918448151.3145707.11541538916600921083.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        Dave Wysochanski <dwysocha@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/31] iov_iter: Add ITER_XARRAY
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3153357.1619188393.1@warthog.procyon.org.uk>
Date:   Fri, 23 Apr 2021 15:33:14 +0100
Message-ID: <3153358.1619188394@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Apr 23, 2021 at 02:28:01PM +0100, David Howells wrote:
> Now, is this important?  There are no filesystems which do I/O to THPs
> today.  So it's not possible to pick up the fact that it doesn't work,
> and I hope to have the page cache fixed soon.  And fixing this now
> will create more work later as part of fixing the page cache.  But I
> wouldn't feel right not mentioning this problem ...

So I can leave the code as-is for the moment and it can be fixed with your
patches?

David

