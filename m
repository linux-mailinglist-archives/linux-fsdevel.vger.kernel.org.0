Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1FB5BA70F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 08:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiIPGy7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 02:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIPGy5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:54:57 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341373D594;
        Thu, 15 Sep 2022 23:54:55 -0700 (PDT)
Received: from letrec.thunk.org ([185.122.133.20])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28G6sHId010783
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 02:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1663311263; bh=jqjwwvRnowqEU63Vd3ESTJA7Bt/dd4WUfiC93PuK8ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Ai5m0LTYmY21j+kf5nN3AizGJqlL/LrHVN1RgeEb+xCpZq0dS80CsVUaeGrp98Dzh
         /KpNaDuaR7sdPespuANIxRXxOyJEXCv8YP7HHs2NCGva/CMwd9ztDxuSA4uGkFo05H
         m+484K+K47AEq0mdO2BBceyISweo4B9/3sD3aRpUSS8DKXRwERiKgcvzzZ3t0zRzeb
         4yhRPmfhY/O1AoNMNCo8EXkA4kIWgQA918ZNtRWlEzn9yy/oOXt0goj0JAxUXZ9wzi
         fn5oc7nYYk3Jh7xY+PyIyKNHh2Wy6eSJnvowA19Qdruqe56Le+KFdzwfNySaWQOCb7
         TopHTQvd4l2ow==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 8A0D68C2B4B; Fri, 16 Sep 2022 02:54:16 -0400 (EDT)
Date:   Fri, 16 Sep 2022 02:54:16 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Message-ID: <YyQdmLpiAMvl5EkU@mit.edu>
References: <20220912134208.GB9304@fieldses.org>
 <166302447257.30452.6751169887085269140@noble.neil.brown.name>
 <20220915140644.GA15754@fieldses.org>
 <577b6d8a7243aeee37eaa4bbb00c90799586bc48.camel@hammerspace.com>
 <1a968b8e87f054e360877c9ab8cdfc4cfdfc8740.camel@kernel.org>
 <0646410b6d2a5d19d3315f339b2928dfa9f2d922.camel@hammerspace.com>
 <34e91540c92ad6980256f6b44115cf993695d5e1.camel@kernel.org>
 <871f9c5153ddfe760854ca31ee36b84655959b83.camel@hammerspace.com>
 <e8922bc821a40f5a3f0a1301583288ed19b6891b.camel@kernel.org>
 <166328063547.15759.12797959071252871549@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166328063547.15759.12797959071252871549@noble.neil.brown.name>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 16, 2022 at 08:23:55AM +1000, NeilBrown wrote:
> > > If the answer is that 'all values change', then why store the crash
> > > counter in the inode at all? Why not just add it as an offset when
> > > you're generating the user-visible change attribute?
> > > 
> > > i.e. statx.change_attr = inode->i_version + (crash counter * offset)

I had suggested just hashing the crash counter with the file system's
on-disk i_version number, which is essentially what you are suggested.

> > Yes, if we plan to ensure that all the change attrs change after a
> > crash, we can do that.
> > 
> > So what would make sense for an offset? Maybe 2**12? One would hope that
> > there wouldn't be more than 4k increments before one of them made it to
> > disk. OTOH, maybe that can happen with teeny-tiny writes.
> 
> Leave it up the to filesystem to decide.  The VFS and/or NFSD should
> have not have part in calculating the i_version.  It should be entirely
> in the filesystem - though support code could be provided if common
> patterns exist across filesystems.

Oh, *heck* no.  This parameter is for the NFS implementation to
decide, because it's NFS's caching algorithms which are at stake here.

As a the file system maintainer, I had offered to make an on-disk
"crash counter" which would get updated when the journal had gotten
replayed, in addition to the on-disk i_version number.  This will be
available for the Linux implementation of NFSD to use, but that's up
to *you* to decide how you want to use them.

I was perfectly happy with hashing the crash counter and the i_version
because I had assumed that not *that* much stuff was going to be
cached, and so invalidating all of the caches in the unusual case
where there was a crash was acceptable.  After all it's a !@#?!@
cache.  Caches sometimmes get invalidated.  "That is the order of
things." (as Ramata'Klan once said in "Rocks and Shoals")

But if people expect that multiple TB's of data is going to be stored;
that cache invalidation is unacceptable; and that a itsy-weeny chance
of false negative failures which might cause data corruption might be
acceptable tradeoff, hey, that's for the system which is providing
caching semantics to determine.

PLEASE don't put this tradeoff on the file system authors; I would
much prefer to leave this tradeoff in the hands of the system which is
trying to do the caching.

						- Ted
