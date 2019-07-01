Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D72E5B7FE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 11:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfGAJ0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 05:26:35 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:58351 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728345AbfGAJ0f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:26:35 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 67F391926;
        Mon,  1 Jul 2019 05:26:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 01 Jul 2019 05:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=f4czRt2dBkv8pN065obux10iigs
        5H2P/jUH4YPctBX4=; b=HbMdosaKJFUEmlxfPpgvwRPfUZZUnDtXEJSulkXKgRS
        iq2GM3kPTqhnydLP/Hn1C1SM0wRFzxeqFQeuMY0cl17hHk0C4KQqSIu9e4hM9Nc/
        1zY63VrUibN3ZqIkqGDzcgcgMLBRU3ezQvgVh+OV6PHp6CvTgFqXjvc7F6h9sS3A
        s+psyVrnpX+4fRU1CEdKWo4NZTck9e93U1dpLG/+U2oVKS09doU0qqMw9okwRRRY
        6YSXvr9WPdOAwrycZTB5T9Y54XbrUOasHAvfBpe++hlNwRQei0ErkXozmdjG0kE2
        ANDFeR7mAs5D6Liz8gJdrSj/lANX4Bwz9Htdki1KOcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=f4czRt
        2dBkv8pN065obux10iigs5H2P/jUH4YPctBX4=; b=BXvZF4HvskL2NSVGHZ0Fai
        pg5j0fHec3NoomL+fMN06PIxdn1g8X6AjhJoax5Q8jGxMrLCDpaWFSdepVlxV/Fa
        9/yN6jJcMkJj0lBvOjvjfC4uLa7pqMoW30cqqRdZ0DvBXam/RwuUx1dBvhW/r41o
        opZS+NBFQyPyxIGUTe2rnK4wsyA80nXXE+H4Xbn0O2Psfm9lqvwKecFMkqGpK0jn
        ZeJKqfLElbOxcX5t46Fa+N5zhyGvzKrySddU3sfs5RVCnn1VGp5RL40vMbqmOu0d
        uukhWVdWs501gAzAuRSPWubLEk80RDGAQCDuXScXf0on+ITTTdLmSFhquXCCFqUg
        ==
X-ME-Sender: <xms:xNEZXZ2Ol1P8OXll-4lgGH7sAy1d0uFZSyHMJ-Es9JVAQyiHZbvw8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrvdeigddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvgedrudelrdefuddrgeenucfrrghrrghmpehmrghilhhf
    rhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:xNEZXcFQV42vo-KmGldRMALNC7NGl2OO0b9N5E_bqmxd0JpnDAmVMQ>
    <xmx:xNEZXciLWpFKc4Ak5VIpYa2gAJwJGtzduq1hkcjeLPi1SRM0TX3zKA>
    <xmx:xNEZXVD8xLq-PNaGPYToblU5TA44fwD_xjDHmcubFMuYvWg0YhS7Og>
    <xmx:x9EZXReMZW3f4q3cfjMzqXuJlFpECY_7lk8QU65JRm-j6WdmfvGskw>
Received: from localhost (unknown [124.19.31.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 63C7F380074;
        Mon,  1 Jul 2019 05:26:27 -0400 (EDT)
Date:   Mon, 1 Jul 2019 19:26:25 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>, Theodore Ts'o <tytso@mit.edu>,
        Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: shrink_dentry_list() logics change (was Re: [RFC PATCH v3 14/15]
 dcache: Implement partial shrink via Slab Movable Objects)
Message-ID: <20190701092625.GA9703@ares>
References: <20190411013441.5415-1-tobin@kernel.org>
 <20190411013441.5415-15-tobin@kernel.org>
 <20190411023322.GD2217@ZenIV.linux.org.uk>
 <20190411024821.GB6941@eros.localdomain>
 <20190411044746.GE2217@ZenIV.linux.org.uk>
 <20190411210200.GH2217@ZenIV.linux.org.uk>
 <20190629040844.GS17978@ZenIV.linux.org.uk>
 <20190629043803.GT17978@ZenIV.linux.org.uk>
 <20190629190624.GU17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629190624.GU17978@ZenIV.linux.org.uk>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 29, 2019 at 08:06:24PM +0100, Al Viro wrote:
> On Sat, Jun 29, 2019 at 05:38:03AM +0100, Al Viro wrote:
> 
> > PS: the problem is not gone in the next iteration of the patchset in
> > question.  The patch I'm proposing (including dput_to_list() and _ONLY_
> > compile-tested) follows.  Comments?
> 
> FWIW, there's another unpleasantness in the whole thing.  Suppose we have
> picked a page full of dentries, all with refcount 0.  We decide to
> evict all of them.  As it turns out, they are from two filesystems.
> Filesystem 1 is NFS on a server, with currently downed hub on the way
> to it.  Filesystem 2 is local.  We attempt to evict an NFS dentry and
> get stuck - tons of dirty data with no way to flush them on server.
> In the meanwhile, admin tries to unmount the local filesystem.  And
> gets stuck as well, since umount can't do anything to its dentries
> that happen to sit in our shrink list.
> 
> I wonder if the root of problem here isn't in shrink_dcache_for_umount();
> all it really needs is to have everything on that fs with refcount 0
> dragged through __dentry_kill().  If something had been on a shrink
> list, __dentry_kill() will just leave behind a struct dentry completely
> devoid of any connection to superblock, other dentries, filesystem
> type, etc. - it's just a piece of memory that won't be freed until
> the owner of shrink list finally gets around to it.  Which can happen
> at any point - all they'll do to it is dentry_free(), and that doesn't
> need any fs-related data structures.
> 
> The logics in shrink_dcache_parent() is
> 	collect everything evictable into a shrink list
> 	if anything found - kick it out and repeat the scan
> 	otherwise, if something had been on other's shrink list
> 		repeat the scan
> 
> I wonder if after the "no evictable candidates, but something
> on other's shrink lists" we ought to do something along the
> lines of
> 	rcu_read_lock
> 	walk it, doing
> 		if dentry has zero refcount
> 			if it's not on a shrink list,
> 				move it to ours
> 			else
> 				store its address in 'victim'
> 				end the walk
> 	if no victim found
> 		rcu_read_unlock
> 	else
> 		lock victim for __dentry_kill
> 		rcu_read_unlock
> 		if it's still alive
> 			if it's not IS_ROOT
> 				if parent is not on shrink list
> 					decrement parent's refcount
> 					put it on our list
> 				else
> 					decrement parent's refcount
> 			__dentry_kill(victim)
> 		else
> 			unlock
> 	if our list is non-empty
> 		shrink_dentry_list on it
> in there...

Thanks for still thinking about this Al.  I don't have a lot of idea
about what to do with your comments until I can grok them fully but I
wanted to acknowledge having read them.

Thanks,
Tobin.
