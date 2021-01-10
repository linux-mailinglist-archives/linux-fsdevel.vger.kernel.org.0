Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE30B2F09C9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Jan 2021 22:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbhAJVQe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Jan 2021 16:16:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726447AbhAJVQe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Jan 2021 16:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610313307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rxOZFxk9FoO306GsC2fkx0fNsyYQ9FUyxG7qC/hq6I0=;
        b=KrezSGTCCX+KyNfvislaOar964oB9z3+xPiIIdG5LHQIa/FAoBYomP1OMoev6VcZvqzHkU
        CB0nA/0+7hRZ/0nUWMg07p1sVehKKfelaooTrG2b8z6aB4e3X+lFjePRrL/tBLVHJ6V7qy
        0G3NA6yeQjf6OMRy4htxS788uosTW8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-Kk6bgDgTN0KXmNEno4OnzA-1; Sun, 10 Jan 2021 16:15:03 -0500
X-MC-Unique: Kk6bgDgTN0KXmNEno4OnzA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5CD2801817;
        Sun, 10 Jan 2021 21:15:00 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EA785D769;
        Sun, 10 Jan 2021 21:14:58 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 10ALEvRs016838;
        Sun, 10 Jan 2021 16:14:57 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 10ALEtlh016834;
        Sun, 10 Jan 2021 16:14:55 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sun, 10 Jan 2021 16:14:55 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: Re: [RFC v2] nvfs: a filesystem for persistent memory
In-Reply-To: <20210110162008.GV3579531@ZenIV.linux.org.uk>
Message-ID: <alpine.LRH.2.02.2101101410230.7245@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com> <20210110162008.GV3579531@ZenIV.linux.org.uk>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Sun, 10 Jan 2021, Al Viro wrote:

> On Thu, Jan 07, 2021 at 08:15:41AM -0500, Mikulas Patocka wrote:
> > Hi
> > 
> > I announce a new version of NVFS - a filesystem for persistent memory.
> > 	http://people.redhat.com/~mpatocka/nvfs/
> Utilities, AFAICS
> 
> > 	git://leontynka.twibright.com/nvfs.git
> Seems to hang on git pull at the moment...  Do you have it anywhere else?

I saw some errors 'git-daemon: fatal: the remote end hung up unexpectedly' 
in syslog. I don't know what's causing them.

> > I found out that on NVFS, reading a file with the read method has 10% 
> > better performance than the read_iter method. The benchmark just reads the 
> > same 4k page over and over again - and the cost of creating and parsing 
> > the kiocb and iov_iter structures is just that high.
> 
> Apples and oranges...  What happens if you take
> 
> ssize_t read_iter_locked(struct file *file, struct iov_iter *to, loff_t *ppos)
> {
> 	struct inode *inode = file_inode(file);
> 	struct nvfs_memory_inode *nmi = i_to_nmi(inode);
> 	struct nvfs_superblock *nvs = inode->i_sb->s_fs_info;
> 	ssize_t total = 0;
> 	loff_t pos = *ppos;
> 	int r;
> 	int shift = nvs->log2_page_size;
> 	size_t i_size;
> 
> 	i_size = inode->i_size;
> 	if (pos >= i_size)
> 		return 0;
> 	iov_iter_truncate(to, i_size - pos);
> 
> 	while (iov_iter_count(to)) {
> 		void *blk, *ptr;
> 		size_t page_mask = (1UL << shift) - 1;
> 		unsigned page_offset = pos & page_mask;
> 		unsigned prealloc = (iov_iter_count(to) + page_mask) >> shift;
> 		unsigned size;
> 
> 		blk = nvfs_bmap(nmi, pos >> shift, &prealloc, NULL, NULL, NULL);
> 		if (unlikely(IS_ERR(blk))) {
> 			r = PTR_ERR(blk);
> 			goto ret_r;
> 		}
> 		size = ((size_t)prealloc << shift) - page_offset;
> 		ptr = blk + page_offset;
> 		if (unlikely(!blk)) {
> 			size = min(size, (unsigned)PAGE_SIZE);
> 			ptr = empty_zero_page;
> 		}
> 		size = copy_to_iter(to, ptr, size);
> 		if (unlikely(!size)) {
> 			r = -EFAULT;
> 			goto ret_r;
> 		}
> 
> 		pos += size;
> 		total += size;
> 	} while (iov_iter_count(to));
> 
> 	r = 0;
> 
> ret_r:
> 	*ppos = pos;
> 
> 	if (file)
> 		file_accessed(file);
> 
> 	return total ? total : r;
> }
> 
> and use that instead of your nvfs_rw_iter_locked() in your
> ->read_iter() for DAX read case?  Then the same with
> s/copy_to_iter/_copy_to_iter/, to see how much of that is
> "hardening" overhead.
> 
> Incidentally, what's the point of sharing nvfs_rw_iter() for
> read and write cases?  They have practically no overlap -
> count the lines common for wr and !wr cases.  And if you
> do the same in nvfs_rw_iter_locked(), you'll see that the
> shared parts _there_ are bloody pointless on the read side.

That's a good point. I split nvfs_rw_iter to separate functions 
nvfs_read_iter and nvfs_write_iter - and inlined nvfs_rw_iter_locked into 
both of them. It improved performance by 1.3%.

> Not that it had been more useful on the write side, really,
> but that's another story (nvfs_write_pages() handling of
> copyin is... interesting).  Let's figure out what's going
> on with the read overhead first...
> 
> lib/iov_iter.c primitives certainly could use massage for
> better code generation, but let's find out how much of the
> PITA is due to those and how much comes from you fighing
> the damn thing instead of using it sanely...

The results are:

read:                                           6.744s
read_iter:                                      7.417s
read_iter - separate read and write path:       7.321s
Al's read_iter:                                 7.182s
Al's read_iter with _copy_to_iter:              7.181s

Mikulas

