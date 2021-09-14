Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FD040B047
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 16:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhINOLK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 10:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20634 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233572AbhINOLJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631628591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=331pDuunPUAM51ZF/wTCLNLkiXbz1S2DVxlkGZaJaF0=;
        b=cEch3tX+fvv+uivQH+GurH+GoTbQujImjENAFmao1HaCW0TujKSKjNAqUW5yGxQKU2Jp58
        TjVeN9WOY8MRvat07cojWUnbVit2QNhU9c2u6sxNxa6p3TTJp1CLdWeMFemRR4zLWOytc7
        cUh9y6z2XzaKsr25D5hvoO/0zmaRK2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-_RD-HQQWOtaTK8ZI4c5bKg-1; Tue, 14 Sep 2021 10:09:48 -0400
X-MC-Unique: _RD-HQQWOtaTK8ZI4c5bKg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9162319200CE;
        Tue, 14 Sep 2021 14:09:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C12376F7EB;
        Tue, 14 Sep 2021 14:09:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <6274f0922aecd9b40dd7ff1ef007442ed996aed7.camel@redhat.com>
References: <6274f0922aecd9b40dd7ff1ef007442ed996aed7.camel@redhat.com> <163162767601.438332.9017034724960075707.stgit@warthog.procyon.org.uk> <163162772646.438332.16323773205855053535.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net, linux-cachefs@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] 9p: (untested) Convert to using the netfs helper lib to do reads and caching
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <439557.1631628579.1@warthog.procyon.org.uk>
Date:   Tue, 14 Sep 2021 15:09:39 +0100
Message-ID: <439558.1631628579@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@redhat.com> wrote:

> 
> Does this change require any of the earlier patches in the series? If
> not, then it may be good to go ahead and merge this conversion
> separately, ahead of the rest of the series.

There's a conflict with patch 1 - you can see the same changes made to afs and
ceph there, but apart from that, no.  However, I can't do patch 6 without it
being applied first.  If Dominique or one of the other 9p people can get Linus
to apply it now, that would be great, but I think that unlikely since the
merge window has passed.

David

