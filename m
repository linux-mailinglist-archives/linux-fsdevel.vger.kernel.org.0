Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42519474C59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 20:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbhLNT5q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 14:57:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229451AbhLNT5p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639511865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lWNXdC7c4/QvF14/ly2qEacx83h1zt3femW1UptwI/g=;
        b=PfOe/WQQn1HBqd+q4LOARqZhT63xQARnAqFS/qgiGuPFwU4gdSjWndv9Xfm3zQqN9yjMRj
        7ewS/Nn+mLin+UexT3TqNoRyaLG07ivOBB5srJnd5Ue9XFE7QDQMk0qEKNe+YRQlTpwuXl
        hd0+xOpfHIVgpUp4CAI+XGS3LRFkCqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-LJ_2iVCRNWO_4MGxCIm4rg-1; Tue, 14 Dec 2021 14:57:39 -0500
X-MC-Unique: LJ_2iVCRNWO_4MGxCIm4rg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C884F1926DA0;
        Tue, 14 Dec 2021 19:57:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D3C41017E27;
        Tue, 14 Dec 2021 19:57:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <87e6960c660eaa883d6ee81c25449cf6fa3c9c19.camel@kernel.org>
References: <87e6960c660eaa883d6ee81c25449cf6fa3c9c19.camel@kernel.org> <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk> <163906890630.143852.13972180614535611154.stgit@warthog.procyon.org.uk>
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
Subject: Re: [PATCH v2 09/67] fscache: Implement volume registration
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1082028.1639511847.1@warthog.procyon.org.uk>
Date:   Tue, 14 Dec 2021 19:57:27 +0000
Message-ID: <1082029.1639511847@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> 
> Do we need the last two parameters to fscache_acquire_volume? I'll note
> that all of the callers in the current set just pass "NULL, 0" for them.

cifs wants to set it.  I have a patch to make cachefiles store this.  afs
should use it also.

David

