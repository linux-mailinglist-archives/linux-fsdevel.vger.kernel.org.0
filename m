Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B25433EEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 21:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbhJSTFt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 15:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34174 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234965AbhJSTFs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 15:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634670215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tRaOIrF08dbh2ftF+sxbGCRY/m5+9tQxqmnUi1VRrmU=;
        b=cxYWsbVGDxtdX6PUrQGxEWJrCezBqBm7rIbFOA9CvECn2eDHz9PIRlU+/P/fejho7QVXIo
        Hum994lqFoKHrTPnDyUtIB3DJdrlSOyNqQLnBNAQUqo0NE0SXjNFYv7+0CBehknBBOf2Yp
        fX6e1NMUHicoaqH06u15UYiCLlOLAkA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-Tw0CSNocOwyVLRRe_70G4A-1; Tue, 19 Oct 2021 15:03:30 -0400
X-MC-Unique: Tw0CSNocOwyVLRRe_70G4A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7B6F8143FD;
        Tue, 19 Oct 2021 19:03:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01C8D103BAAF;
        Tue, 19 Oct 2021 19:02:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <39bc040e9bb88b47f386baa09ed4a508281ce7d6.camel@redhat.com>
References: <39bc040e9bb88b47f386baa09ed4a508281ce7d6.camel@redhat.com> <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk> <163456865277.2614702.2064731306330022896.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/67] vfs: Provide S_KERNEL_FILE inode flag
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2972194.1634670175.1@warthog.procyon.org.uk>
Date:   Tue, 19 Oct 2021 20:02:55 +0100
Message-ID: <2972195.1634670175@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@redhat.com> wrote:

> It'd be better to fold this in with the patch where the first user is
> added. That would make it easier to see how you intend to use it.

Yeah - I didn't put it in there because as I zip backwards and forwards
through the patch stack, applying/deapplying this change triggers a complete
rebuild.

David

