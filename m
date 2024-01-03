Return-Path: <linux-fsdevel+bounces-7217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96443822E04
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 14:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C7A285C12
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAF6199B4;
	Wed,  3 Jan 2024 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="DSU2cI4s";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="alfUp47L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59DC199A1;
	Wed,  3 Jan 2024 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 6E37AC026; Wed,  3 Jan 2024 14:10:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704287439; bh=nNLSz3IQyDfOhUPqR/BsW6lP6xUFuUzC9P2KcyoDIGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DSU2cI4sZf90qwRfnaXnznL7jIlbzmSuznoRXPqYlvafbrPQAEpuqVf2EctFivLL6
	 EqQN+rDFO5kMoPHxJsvZDTAz+FJnuG+NOehkLZUbpCJ0tUKQkB28Zcwxm9l8ssujoS
	 fcA25Qoqq4QAUxL+lAcgNB9Sx3uClqJlcs8e3viPQhl3m7Dq4oc/c1qVCCzJ0KfxLs
	 ZqQs6Cabvh5jwJE20Pl5v9/8uuZxvuSewqEme5RfqMfM0x7Ec3a29K9sH3O92lMCvt
	 /X30sNmyGkn+YL/BiQ2P2XJBodDL6HyR4c3vIyS+H7XbWYfYTW2Ni9mPC9/JdzWIbv
	 qNaDmmKbdA6bQ==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id A1D64C009;
	Wed,  3 Jan 2024 14:10:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704287438; bh=nNLSz3IQyDfOhUPqR/BsW6lP6xUFuUzC9P2KcyoDIGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=alfUp47LcXS8Qn3+pM3575baz2IlmljGvcJijYZ9Gud9tjALEz1+mys8tps/nOpEs
	 3l1lyYmuJdM0qPObSIEky+UOMT/TorZQ56huXodWvki8aQnQXO7yZ0uBLQSa7pOD1t
	 5SyVGBURpK+D8S7dKO9j2yjtif7k4yrKlPi7+9WDUwkil5dcygJciP5lVbS/leQz6d
	 Lg/0Ri3BlT4O7FYFqnkqSzJ6nN8gMb65wTuW8kwop7fUFl3eXZM/I4SkkKSKowIeJB
	 a9FdxA4xJ9MPVFG92oNtP53beEe2cJg9l6m92bTZnVgUcigZLYpFkHAU6WrBAXePZb
	 04dlr6Z5i13vw==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 861cbe98;
	Wed, 3 Jan 2024 13:10:29 +0000 (UTC)
Date: Wed, 3 Jan 2024 22:10:14 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH] 9p: Fix initialisation of netfs_inode for 9p
Message-ID: <ZZVctju5TEjS218p@codewreck.org>
References: <20231221132400.1601991-41-dhowells@redhat.com>
 <20231221132400.1601991-1-dhowells@redhat.com>
 <292837.1704232179@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <292837.1704232179@warthog.procyon.org.uk>

David Howells wrote on Tue, Jan 02, 2024 at 09:49:39PM +0000:
> This needs a fix that I would fold in.  Somehow it gets through xfstests
> without it, but it seems problems can be caused with executables.

Looking at a file without that patch we seem to be reading just zeroes
off pre-existing files; I'm surprised xfstest doesn't have a write
something/umount/mount/check content is identical test...

(You're probably aware of this, but note for others this breaks with the
rest of the patch series even if the big 9p patch isn't applied -- this
is the main reason I'd rather just get the patch in this cycle, as the
new patches got more tests with the full series than with the 9p writes
patch dropped.)


> 9p: Fix initialisation of netfs_inode for 9p
> 
> The 9p filesystem is calling netfs_inode_init() in v9fs_init_inode() -
> before the struct inode fields have been initialised from the obtained file
> stats (ie. after v9fs_stat2inode*() has been called), but netfslib wants to
> set a couple of its fields from i_size.

Would it make sense to just always update netfs's ctx->remote_i_size in
the various stat2inode calls instead?
We don't have any cache coherency so if a file changes beneath us
through an edit on the server (or through another client) hell will
break loose anyway, but stat would update the inode's i_size so it'll
likely be weird that the remote_i_size doesn't get updated.


> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Tested-by: Marc Dionne <marc.dionne@auristor.com>
> cc: Eric Van Hensbergen <ericvh@kernel.org>
> cc: Latchesar Ionkov <lucho@ionkov.net>
> cc: Dominique Martinet <asmadeus@codewreck.org>

With that being said, it seems to do the immediate job:
Acked-by: Dominique Martinet <asmadeus@codewreck.org>

-- 
Dominique Martinet | Asmadeus

