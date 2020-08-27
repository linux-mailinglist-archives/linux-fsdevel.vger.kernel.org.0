Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3665254A7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 18:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgH0QSv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 12:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbgH0QSt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:18:49 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816DDC06121B;
        Thu, 27 Aug 2020 09:18:47 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 30B06C009; Thu, 27 Aug 2020 18:18:39 +0200 (CEST)
Date:   Thu, 27 Aug 2020 18:18:24 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] fscache rewrite -- please drop for now
Message-ID: <20200827161824.GC31016@nautica>
References: <20200810164044.GA31753@lst.de>
 <1851200.1596472222@warthog.procyon.org.uk>
 <447452.1596109876@warthog.procyon.org.uk>
 <667820.1597072619@warthog.procyon.org.uk>
 <1428311.1598542135@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1428311.1598542135@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells wrote on Thu, Aug 27, 2020:
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > FYI, a giant rewrite dropping support for existing consumer is always
> > rather awkward.  Is there any way you could pre-stage some infrastructure
> > changes, and then do a temporary fscache2, which could then be renamed
> > back to fscache once everyone switched over?
> 
> That's a bit tricky.  There are three points that would have to be shared: the
> userspace miscdev interface, the backing filesystem and the single index tree.
> 
> It's probably easier to just have a go at converting 9P and cifs.  Making the
> old and new APIs share would be a fairly hefty undertaking in its own right.

While I agree something incremental is probably better, I have some free
time over the next few weeks so will take a shot at 9p; it's definitely
going to be easier.


Should I submit patches to you or wait until Linus merges it next cycle
and send them directly?

I see Jeff's ceph patches are still in his tree's ceph-fscache-iter
branch and I don't see them anywhere in your tree.

-- 
Dominique

