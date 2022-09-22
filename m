Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E145E6CE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 22:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiIVUSM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 16:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiIVUSJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:18:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D8B110B0A;
        Thu, 22 Sep 2022 13:18:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18040B83A79;
        Thu, 22 Sep 2022 20:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7C0C433D6;
        Thu, 22 Sep 2022 20:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663877885;
        bh=6v4b3j+MIvjHQBr7sFzf0op2Awjf2oGOtqPQJUi0BhE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PBDIKFf0+HT/5WE513751U+D9B8X2TiRIo4ChfKxEhlYfkCZqIXfjGWMA5s8HUPj6
         /WZCJxTUNZDksXVX0QJtUzdxKyinG3iYf+lAl5Fq1KjA/cxCGwfeQ8rXXzqlPm514l
         AOd4VqbUMSRxXQN9h7mP9Nsy2/C2mz/FOkUJSiRIioYZeYPKtLcILmKl1o9bTPSAwc
         PB4bOY9tIG2uCbLWlPVNXoM9wSEkYQuTqlvsLqxhCUoC6l6AYyOsQ1svTudGncvkfQ
         RWtrRqApPGzZ7bF/EOBqG33kqa7APErg8algJT9WxggMwagA39au085YMRZA55+5EU
         KJoHeHA5e8KNg==
Message-ID: <1ef261e3ff1fa7fcd0d75ed755931aacb8062de2.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
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
Date:   Thu, 22 Sep 2022 16:18:02 -0400
In-Reply-To: <e04e349170bc227b330556556d0592a53692b5b5.camel@kernel.org>
References: <166328063547.15759.12797959071252871549@noble.neil.brown.name>
         <YyQdmLpiAMvl5EkU@mit.edu>
         <7027d1c2923053fe763e9218d10ce8634b56e81d.camel@kernel.org>
         <24005713ad25370d64ab5bd0db0b2e4fcb902c1c.camel@kernel.org>
         <20220918235344.GH3600936@dread.disaster.area>
         <87fb43b117472c0a4c688c37a925ac51738c8826.camel@kernel.org>
         <20220920001645.GN3600936@dread.disaster.area>
         <5832424c328ea427b5c6ecdaa6dd53f3b99c20a0.camel@kernel.org>
         <20220921000032.GR3600936@dread.disaster.area>
         <93b6d9f7cf997245bb68409eeb195f9400e55cd0.camel@kernel.org>
         <20220921214124.GS3600936@dread.disaster.area>
         <e04e349170bc227b330556556d0592a53692b5b5.camel@kernel.org>
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

On Thu, 2022-09-22 at 06:18 -0400, Jeff Layton wrote:
> On Thu, 2022-09-22 at 07:41 +1000, Dave Chinner wrote:
> > On Wed, Sep 21, 2022 at 06:33:28AM -0400, Jeff Layton wrote:
> > > On Wed, 2022-09-21 at 10:00 +1000, Dave Chinner wrote:
> > > > > How do we determine what that offset should be? Your last email
> > > > > suggested that there really is no limit to the number of i_versio=
n bumps
> > > > > that can happen in memory before one of them makes it to disk. Wh=
at can
> > > > > we do to address that?
> > > >=20
> > > > <shrug>
> > > >=20
> > > > I'm just pointing out problems I see when defining this as behaviou=
r
> > > > for on-disk format purposes. If we define it as part of the on-disk
> > > > format, then we have to be concerned about how it may be used
> > > > outside the scope of just the NFS server application.=20
> > > >=20
> > > > However, If NFS keeps this metadata and functionaly entirely
> > > > contained at the application level via xattrs, I really don't care
> > > > what algorithm NFS developers decides to use for their crash
> > > > sequencing. It's not my concern at this point, and that's precisely
> > > > why NFS should be using xattrs for this NFS specific functionality.
> > > >=20
> > >=20
> > > I get it: you'd rather not have to deal with what you see as an NFS
> > > problem, but I don't get how what you're proposing solves anything. W=
e
> > > might be able to use that scheme to detect crashes, but that's only p=
art
> > > of the problem (and it's a relatively simple part of the problem to
> > > solve, really).
> > >=20
> > > Maybe you can clarify it for me:
> > >=20
> > > Suppose we go with what you're saying and store some information in
> > > xattrs that allows us to detect crashes in some fashion. The server
> > > crashes and comes back up and we detect that there was a crash earlie=
r.
> > >=20
> > > What does nfsd need to do now to ensure that it doesn't hand out a
> > > duplicate change attribute?=20
> >=20
> > As I've already stated, the NFS server can hold the persistent NFS
> > crash counter value in a second xattr that it bumps whenever it
> > detects a crash and hence we take the local filesystem completely
> > out of the equation.  How the crash counter is then used by the nfsd
> > to fold it into the NFS protocol change attribute is a nfsd problem,
> > not a local filesystem problem.
> >=20
>=20
> Ok, assuming you mean put this in an xattr that lives at the root of the
> export? We only need this for IS_I_VERSION filesystems (btrfs, xfs, and
> ext4), and they all support xattrs so this scheme should work.
>=20

I had a look at this today and it's not as straightforward as it
sounds.=A0

In particular, there is no guarantee that an export will not cross
filesystem boundaries. Also, nfsd and mountd are very much "demand
driven". We might not touch an exported filesystem at all if nothing
asks for it. Ensuring we can do something to every exported filesystem
after a crash is more difficult than it sounds.

So trying to do something with xattrs on the exported filesystems is
probably not what we want. It's also sort of janky since we do strive to
leave a "light footprint" on the exported filesystem.

Maybe we don't need that though. Chuck reminded me that nfsdcltrack
could be used here instead. We can punt this to userland!

nfsdcltrack could keep track of a global crash "salt", and feed that to
nfsd when it starts up. When starting a grace period, it can=A0set a
RUNNING flag in the db. If it's set when the server starts, we know
there was a crash and can bump the crash counter. When nfsd is shutting
down cleanly, it can call sync() and then clear the flag (this may
require a new cld upcall cmd). We then mix that value into the change
attribute for IS_I_VERSION inodes.

That's probably good enough for nfsd, but if we wanted to present this
to userland via statx, we'd need a different mechanism. For now, I'm
going to plan to fix this up in nfsd and then we'll see where we are.

> > If you're worried about maximum number of writes outstanding vs
> > i_version bumps that are held in memory, then *bound the maximum
> > number of uncommitted i_version changes that the NFS server will
> > allow to build up in memory*. By moving the crash counter to being a
> > NFS server only function, the NFS server controls the entire
> > algorithm and it doesn't have to care about external 3rd party
> > considerations like local filesystems have to.
> >=20
>=20
> Yeah, this is the bigger consideration.
>=20
> > e.g. The NFS server can track the i_version values when the NFSD
> > syncs/commits a given inode. The nfsd can sample i_version it when
> > calls ->commit_metadata or flushed data on the inode, and then when
> > it peeks at i_version when gathering post-op attrs (or any other
> > getattr op) it can decide that there is too much in-memory change
> > (e.g. 10,000 counts since last sync) and sync the inode.
> >=20
> > i.e. the NFS server can trivially cap the maximum number of
> > uncommitted NFS change attr bumps it allows to build up in memory.
> > At that point, the NFS server has a bound "maximum write count" that
> > can be used in conjunction with the xattr based crash counter to
> > determine how the change_attr is bumped by the crash counter.
>=20
> Well, not "trivially". This is the bit where we have to grow struct
> inode (or the fs-specific inode), as we'll need to know what the latest
> on-disk value is for the inode.
>=20
> I'm leaning toward doing this on the query side. Basically, when nfsd
> goes to query the i_version, it'll check the delta between the current
> version and the latest one on disk. If it's bigger than X then we'd just
> return NFS4ERR_DELAY to the client.
>=20
> If the delta is >X/2, maybe it can kick off a workqueue job or something
> that calls write_inode with WB_SYNC_ALL to try to get the thing onto the
> platter ASAP.

Still looking at this bit too. Probably we can just kick off a
WB_SYNC_NONE filemap_fdatawrite at that point and hope for the best?
--=20
Jeff Layton <jlayton@kernel.org>
