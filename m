Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47CB487670
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 12:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347102AbiAGLZm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 06:25:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60243 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347089AbiAGLZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641554739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LihP/f7kkQcoH5EB358WZj2ActRS2QGX7JqNWfqK9rU=;
        b=Ohl5L76r0hKkxCpTTtIEE+HjjFZ/0G814H02JauPWnHGG4Thwewxz8CbK5yMSpNYxaADsA
        K7+/gtJxtqZttX9ZMpTJQE0hDYF8TySDyiq/yVoR0uJj8MMFy2hBnitxQp46nn3Dn1BqL+
        3R6zgXjhn+pSl7PFB1I/XDeVSB+ZdpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-ujFKLBTZNaCuaYSpYvGkxQ-1; Fri, 07 Jan 2022 06:25:33 -0500
X-MC-Unique: ujFKLBTZNaCuaYSpYvGkxQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C3041800D50;
        Fri,  7 Jan 2022 11:25:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1DF02A189;
        Fri,  7 Jan 2022 11:25:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <94b5163b0652c6106aa01a0f4c03bdf57c0a7e71.camel@kernel.org>
References: <94b5163b0652c6106aa01a0f4c03bdf57c0a7e71.camel@kernel.org> <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk> <164021552299.640689.10578652796777392062.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 46/68] cachefiles: Mark a backing file in use with an inode flag
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3149601.1641554716.1@warthog.procyon.org.uk>
Date:   Fri, 07 Jan 2022 11:25:16 +0000
Message-ID: <3149602.1641554716@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> Probably, this patch should be merged with #38. The commit logs are the
> same, and they are at least somewhat related.

That's not so simple, unfortunately.  Patch 46 requires bits of patches 43 and
45 in addition to patch 38 and patch 39 depends on patch 38.

David

