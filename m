Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254015E7C46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 15:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiIWNue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 09:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiIWNud (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:50:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB16B115F5F;
        Fri, 23 Sep 2022 06:50:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90E586116E;
        Fri, 23 Sep 2022 13:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C265FC433D6;
        Fri, 23 Sep 2022 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663941031;
        bh=OvlHBUH4cE19BPnZAbqrOC7wiAUY/u0qRpZ5QBiaIbE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Tno5cfqjSZOTCNZ4YM4mZTji5DCfZsL67reLTAxUKxtR3aWVu5Dwgh4BtVJ9tr5tD
         q6BZKpGhrsFsskSTD860t1s22/EGmqG9tI3XhyDC26Rb9AJeZ8emEXSU+PxZWMX/GS
         jrHrJZ1guJpieJHbFSkRLhNbWORlxQ25ztCgYQBYqgmmsg3m0sGRAr+fXV7d9hNtTQ
         4/+hVplSz/T7X1kezp4SpM7L5SciTl0oRyUHTw1GTNuW7PwAzGV8Bv6NR8tKqh7gUU
         U6H+Q3G0H9KQUUr0fNCwjGa8xnnnXJeRTWfeaj3r8b2l8YjFTSev4xL3qGPoaBOrjD
         DOuz+PsPp+j9A==
Message-ID: <baf852dfb57aaf5a670bc88236f8d62c99668fcc.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "jack@suse.cz" <jack@suse.cz>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Fri, 23 Sep 2022 09:50:27 -0400
In-Reply-To: <2d41c08e1fd96d55c794c3b4cd43a51a0494bfcf.camel@hammerspace.com>
References: <24005713ad25370d64ab5bd0db0b2e4fcb902c1c.camel@kernel.org>
         <20220918235344.GH3600936@dread.disaster.area>
         <87fb43b117472c0a4c688c37a925ac51738c8826.camel@kernel.org>
         <20220920001645.GN3600936@dread.disaster.area>
         <5832424c328ea427b5c6ecdaa6dd53f3b99c20a0.camel@kernel.org>
         <20220921000032.GR3600936@dread.disaster.area>
         <93b6d9f7cf997245bb68409eeb195f9400e55cd0.camel@kernel.org>
         <20220921214124.GS3600936@dread.disaster.area>
         <e04e349170bc227b330556556d0592a53692b5b5.camel@kernel.org>
         <1ef261e3ff1fa7fcd0d75ed755931aacb8062de2.camel@kernel.org>
         <20220923095653.5c63i2jgv52j3zqp@quack3>
         <2d41c08e1fd96d55c794c3b4cd43a51a0494bfcf.camel@hammerspace.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-09-23 at 13:44 +0000, Trond Myklebust wrote:
> On Fri, 2022-09-23 at 11:56 +0200, Jan Kara wrote:
> > On Thu 22-09-22 16:18:02, Jeff Layton wrote:
> > > On Thu, 2022-09-22 at 06:18 -0400, Jeff Layton wrote:
> > > > On Thu, 2022-09-22 at 07:41 +1000, Dave Chinner wrote:
> > > > > e.g. The NFS server can track the i_version values when the
> > > > > NFSD
> > > > > syncs/commits a given inode. The nfsd can sample i_version it
> > > > > when
> > > > > calls ->commit_metadata or flushed data on the inode, and then
> > > > > when
> > > > > it peeks at i_version when gathering post-op attrs (or any
> > > > > other
> > > > > getattr op) it can decide that there is too much in-memory
> > > > > change
> > > > > (e.g. 10,000 counts since last sync) and sync the inode.
> > > > >=20
> > > > > i.e. the NFS server can trivially cap the maximum number of
> > > > > uncommitted NFS change attr bumps it allows to build up in
> > > > > memory.
> > > > > At that point, the NFS server has a bound "maximum write count"
> > > > > that
> > > > > can be used in conjunction with the xattr based crash counter
> > > > > to
> > > > > determine how the change_attr is bumped by the crash counter.
> > > >=20
> > > > Well, not "trivially". This is the bit where we have to grow
> > > > struct
> > > > inode (or the fs-specific inode), as we'll need to know what the
> > > > latest
> > > > on-disk value is for the inode.
> > > >=20
> > > > I'm leaning toward doing this on the query side. Basically, when
> > > > nfsd
> > > > goes to query the i_version, it'll check the delta between the
> > > > current
> > > > version and the latest one on disk. If it's bigger than X then
> > > > we'd just
> > > > return NFS4ERR_DELAY to the client.
> > > >=20
> > > > If the delta is >X/2, maybe it can kick off a workqueue job or
> > > > something
> > > > that calls write_inode with WB_SYNC_ALL to try to get the thing
> > > > onto the
> > > > platter ASAP.
> > >=20
> > > Still looking at this bit too. Probably we can just kick off a
> > > WB_SYNC_NONE filemap_fdatawrite at that point and hope for the
> > > best?
> >=20
> > "Hope" is not a great assurance regarding data integrity ;) Anyway,
> > it
> > depends on how you imagine the "i_version on disk" is going to be
> > maintained. It could be maintained by NFSD inside
> > commit_inode_metadata() -
> > fetch current i_version value before asking filesystem for the sync
> > and by the
> > time commit_metadata() returns we know that value is on disk. If we
> > detect the
> > current - on_disk is > X/2, we call commit_inode_metadata() and we
> > are
> > done. It is not even *that* expensive because usually filesystems
> > optimize
> > away unnecessary IO when the inode didn't change since last time it
> > got
> > synced.
> >=20
>=20
> Note that these approaches requiring 3rd party help in order to track
> i_version integrity across filesystem crashes all make the idea of
> adding i_version to statx() a no-go.
>=20
> It is one thing for knfsd to add specialised machinery for integrity
> checking, but if all applications need to do so, then they are highly
> unlikely to want to adopt this attribute.
>=20
>=20

Absolutely. That is the downside of this approach, but the priority here
has always been to improve nfsd. If we don't get the ability to present
this info via statx, then so be it. Later on, I suppose we can move that
handling into the kernel in some fashion if we decide it's worthwhile.

That said, not having this in statx makes it more difficult to test
i_version behavior. Maybe we can add a generic ioctl for that in the
interim?
--=20
Jeff Layton <jlayton@kernel.org>
