Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761D4434850
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 11:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhJTJvj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 05:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230063AbhJTJvi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634723362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yrwzIKxJLyOlRuVjyH2WuWw8q3AM6f6AtDPiL7a0cJ0=;
        b=e1d6jJS9q1vFwL5elu4m1sQhJeTNo0YQdIyCVdPCFdKOWVIEyYey2EoR7qm2Tc3RPf0dRe
        8P83sq/RgDCqEcujye9PIXDSi35fN2g+8qG6VFEWDHWAMeiqNESDQBAyg+v4cjc5eO423N
        TIaj9jVwUeYPa91VeXEC6dT9nK9k1tM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-ZFkCjXapNaOorQ1nti-2Sg-1; Wed, 20 Oct 2021 05:49:19 -0400
X-MC-Unique: ZFkCjXapNaOorQ1nti-2Sg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE16F1006AAE;
        Wed, 20 Oct 2021 09:49:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3ED3018A8F;
        Wed, 20 Oct 2021 09:49:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <d58335124c7467703201a9cdba765a46a780c855.camel@redhat.com>
References: <d58335124c7467703201a9cdba765a46a780c855.camel@redhat.com> <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk> <163456866523.2614702.2234665737111683988.stgit@warthog.procyon.org.uk>
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
Subject: Re: [PATCH 03/67] vfs, fscache: Force ->write_inode() to occur if cookie pinned for writeback
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3087476.1634723349.1@warthog.procyon.org.uk>
Date:   Wed, 20 Oct 2021 10:49:09 +0100
Message-ID: <3087477.1634723349@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@redhat.com> wrote:

> IDGI: how would I_PINNING_FSCACHE_WB get set in the first place? 

This is used by a later patch, but because this modifies a very commonly used
header file, it was causing mass rebuilds every time I pushed or popped it.  I
can merge it back in now, I think.

David

