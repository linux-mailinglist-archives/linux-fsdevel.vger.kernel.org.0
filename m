Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D598A462391
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 22:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhK2Vq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 16:46:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56416 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232289AbhK2VoZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638222067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QCFD7Ah5IiTcd1a6Gpk3m6ibgmYONE5XP5yWvVfmZ5A=;
        b=d8KZdRNeWbkx/snx57lR+PNe+zpdjw1dwmtdRrIunFkxeGf0XHjbuXaZPrVsW39KDk8nR2
        XBQcR4qbVlmLxoMQCMMUlFMFdKXLD+OWrd8dePPLcufW0qycMUOPYlnEsRdg034lv5zo3W
        yqd8DrWOVFyFQqZJctPFxStasdw7AHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-5Dz_xYvhN12pm6HYXYz0Bg-1; Mon, 29 Nov 2021 16:41:02 -0500
X-MC-Unique: 5Dz_xYvhN12pm6HYXYz0Bg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83E5C1927807;
        Mon, 29 Nov 2021 21:40:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21F1160BF4;
        Mon, 29 Nov 2021 21:40:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <163819627469.215744.3603633690679962985.stgit@warthog.procyon.org.uk>
References: <163819627469.215744.3603633690679962985.stgit@warthog.procyon.org.uk> <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 35/64] cachefiles: Add security derivation
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <302430.1638222055.1@warthog.procyon.org.uk>
Date:   Mon, 29 Nov 2021 21:40:55 +0000
Message-ID: <302431.1638222055@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I missed out the patch description:

    cachefiles: Add security derivation
    
    Implement code to derive a new set of creds for the cachefiles to use when
    making VFS or I/O calls and to change the auditing info since the
    application interacting with the network filesystem is not accessing the
    cache directly.  Cachefiles uses override_creds() to change the effective
    creds temporarily.
    
    set_security_override_from_ctx() is called to derive the LSM 'label' that
    the cachefiles driver will act with.  set_create_files_as() is called to
    determine the LSM 'label' that will be applied to files and directories
    created in the cache.  These functions alter the new creds.
    
    Also implement a couple of functions to wrap the calls to begin/end cred
    overriding.
    
    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: linux-cachefs@redhat.com

David

