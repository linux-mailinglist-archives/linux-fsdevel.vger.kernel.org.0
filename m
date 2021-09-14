Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5636740BAD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 23:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhINWAm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 18:00:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33997 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232355AbhINWAl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631656763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EWjhoOQgjMbe+X4Kudlp/xxXqmY4RO46zebmZlYS91U=;
        b=d8sKvooepPAj758YN1Y4s8Jhzu6GpI2HFeL90SppH18Z1b4cHH+maEIQchpiJGZJAicbmb
        7yqrzG0Ag8q6/8yeg7cZ6tyHQNN0rTs7Aky4C//RYwUhIXkRuep9Msd5FaQtC0k4edu7bX
        F/AoHATmAGfr5V5ohkP74x3+0o/P6EM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-95cK3flVO5ioljTyre8X1Q-1; Tue, 14 Sep 2021 17:59:22 -0400
X-MC-Unique: 95cK3flVO5ioljTyre8X1Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBB68189CD1F;
        Tue, 14 Sep 2021 21:59:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27B141972D;
        Tue, 14 Sep 2021 21:59:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YUEZXktGOCUWfvnU@codewreck.org>
References: <YUEZXktGOCUWfvnU@codewreck.org> <6274f0922aecd9b40dd7ff1ef007442ed996aed7.camel@redhat.com> <163162767601.438332.9017034724960075707.stgit@warthog.procyon.org.uk> <163162772646.438332.16323773205855053535.stgit@warthog.procyon.org.uk> <439558.1631628579@warthog.procyon.org.uk>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
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
Content-ID: <746600.1631656752.1@warthog.procyon.org.uk>
Date:   Tue, 14 Sep 2021 22:59:12 +0100
Message-ID: <746601.1631656752@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dominique Martinet <asmadeus@codewreck.org> wrote:

> Agreed with the merge window passed it'll be for next one -- but I'd
> like this to sit in -next for as long as possible, so I'd appreciate
> either being able to carry the patch in my tree (difficult as then
> you'll need to base yourself on mine) or you putting it in there somehow
> after I've got the most basic tests verified again (do you have a branch
> pulled for linux-next?)

I can put it into my fscache-next branch.

David

