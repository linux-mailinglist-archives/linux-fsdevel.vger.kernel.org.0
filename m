Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269EA436E41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 01:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhJUX0D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 19:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhJUX0D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:26:03 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738E1C061764;
        Thu, 21 Oct 2021 16:23:46 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 3A054C025; Fri, 22 Oct 2021 01:23:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1634858624; bh=QI1jya4xqRMNt0nBwtRPZvmfVzkS65CSiephRu49A14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fVWPBuMNPq+56y7BBbK8XcmZk8C7+A4uMvtdWGWNoua2vs5ycR8vKcY110GLtlfv2
         NWVdnQVy+5aei8AuhFKQ1f5d+SWbkDSYe9bWwu+znHwMcurF8xMJHVw8qOzzg48J6U
         yHpnW9Ji1L53Wpao3R+Y53txMcZ3WadMd+QZlxiW5CY2n6BDQrGYgvEinl5k+zxse+
         699V/S04Hbq3RgwatQjKBuZeM8XD2tDFWjzpbVsMM6Beg+6/IFNhQ/P+IBXrtoEBOa
         7Gc0j0T92mxC4CHXRApx6FIv6QM0jL6YFSVH3je9y6z3fXDbTMFCCt59sWjqW8/SXm
         4dcVa8aQWj5qw==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id A0916C009;
        Fri, 22 Oct 2021 01:23:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1634858622; bh=QI1jya4xqRMNt0nBwtRPZvmfVzkS65CSiephRu49A14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wCfvZldvxLZsSiHYUs6ZYL1OQASI/j2ET8hioD+e6sQHqCSTwKRfkAeKHvXSCHmfp
         BrEuYvwxIsZPLPDB2c4Qb/gMaYrQ4kSblDU1VzimusdT5tlcACjqAXt6cFwh4CRHaM
         F3LB7T+69GUFAlMluHLb4qsPxYGlI468GMEaKyEoJA/QjZB3VRD+/lgDH2vw/8zkks
         RyAD8WMbiNRXri/ALt9JLYls+7h+NDluEJ4FsXHan691VrqwVahTEg6QE3hCi2m8wg
         CA6g+FqIcNtJdAislVbATvjTVk9qNlCvMcol1akzoFNZTQR2oHIf19bMT1LuA7jgu1
         +uvzvQ6xYO+dw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id f1866e14;
        Thu, 21 Oct 2021 23:23:30 +0000 (UTC)
Date:   Fri, 22 Oct 2021 08:23:15 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Steve French <smfrench@gmail.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-afs@lists.infradead.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        v9fs-developer@lists.sourceforge.net,
        CIFS <linux-cifs@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ilya Dryomov <idryomov@gmail.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/67] fscache: Rewrite index API and management system
Message-ID: <YXH2Y7+coD5sgEDG@codewreck.org>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
 <YXHntB2O0ACr0pbz@relinquished.localdomain>
 <CAH2r5msO7-QCXv6JQj2Tado9ZoWAHRkgq6-En18PeKSXFDdBLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH2r5msO7-QCXv6JQj2Tado9ZoWAHRkgq6-En18PeKSXFDdBLw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Steve French wrote on Thu, Oct 21, 2021 at 06:15:49PM -0500:
> Have changes been made to O_TMPFILE?  It is problematic for network filesystems
> because it is not an atomic operation, and would be great if it were possible
> to create a tmpfile and open it atomically (at the file system level).
> 
> Currently it results in creating a tmpfile (which results in
> opencreate then close)
> immediately followed by reopening the tmpfile which is somewhat counter to
> the whole idea of a tmpfile (ie that it is deleted when closed) since
> the syscall results
> in two opens ie open(create)/close/open/close

That depends on the filesystem, e.g. 9p open returns the opened fid so
our semantic could be closer to that of a local filesystem (could
because I didn't test recently and don't recall how it was handled, I
think it was fixed as I remember it being a problem at some point...)

The main problem with network filesystem and "open closed files" is:
what should the server do if the client disconnects? Will the client
come back and try to access that file again? Did the client crash
completely and should the file be deleted? The server has no way of
knowing.
It's the same logic as unlinking an open file, leading to all sort of
"silly renames" that are most famous for nfs (.nfsxxxx files that the
servers have been taught to just delete if they haven't been accessed
for long enough...)

I'm not sure we can have a generic solution for that unfortunately...

(9P is "easy" enough in that the linux client does not attempt to
reconnect ever if the connection has been lost, so we can just really
unlink the file and the server will delete it when the client
disconnects... But if we were to implement a reconnect eventually (I
know of an existing port that does) then this solution is no longer
acceptable)

-- 
Dominique Martinet | Asmadeus
