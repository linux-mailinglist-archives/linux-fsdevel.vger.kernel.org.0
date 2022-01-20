Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B32494AE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 10:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359514AbiATJiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 04:38:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359380AbiATJhz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642671474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vwaun9h4PrGOctit7O7Y3jbampOsovEgn1eDqCi+RHc=;
        b=eEOaJNDcXSVmUCR8334IO0KLZV3N7JPN3xW4LrzGKFY/MnJgFbXUE0vVv7TrTeExBK8gTC
        lqtEPyTgSiSV8UwyESUS4TFe1hWKoi+NYdQgdFfMJppKKMeqb9z3ohFxVAgw1heLgzA56r
        tP3GcXugnaKkKKXvcgNlLqnzW1DCxb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-TlUAgrb-MjSgqaMVPtjPzw-1; Thu, 20 Jan 2022 04:37:49 -0500
X-MC-Unique: TlUAgrb-MjSgqaMVPtjPzw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A09901091DA5;
        Thu, 20 Jan 2022 09:37:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B386D131CC;
        Thu, 20 Jan 2022 09:37:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YekmpeQvNlGlMvNY@infradead.org>
References: <YekmpeQvNlGlMvNY@infradead.org> <YeefizLOGt1Qf35o@infradead.org> <YebpktrcUZOlBHkZ@infradead.org> <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk> <164251409447.3435901.10092442643336534999.stgit@warthog.procyon.org.uk> <3613681.1642527614@warthog.procyon.org.uk> <3765724.1642583885@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <smfrench@gmail.com>,
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
Subject: Re: [PATCH 09/11] vfs, fscache: Add an IS_KERNEL_FILE() macro for the S_KERNEL_FILE flag
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <58089.1642671440.1@warthog.procyon.org.uk>
Date:   Thu, 20 Jan 2022 09:37:20 +0000
Message-ID: <58090.1642671440@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> But you tricked Linus

Tricked?  I put a notice explicitly pointing out that I was adding it and
indicating that it might be controversial in the cover note and the pull
request and further explained the use in the patches that handle it.  I posted
the patches adding/using it a bunch of times to various mailing lists.  TYVM.

David

