Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677025BA12C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 21:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiIOTZp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 15:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIOTZl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 15:25:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6083B33428;
        Thu, 15 Sep 2022 12:25:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 691E1B8220F;
        Thu, 15 Sep 2022 19:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7A8C433D6;
        Thu, 15 Sep 2022 19:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663269935;
        bh=ucJVaZmo1gTYksTNgKQ8uLGOBZ5G8yH/7/rnhJXgz9Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=e4h9ievjP86DQhsNojGC+0Pvg8Xch4cpPv+JT9G1V0ZSfDheexL5+CbDaGY1aFTJC
         NHKDPzrFd2gVP2ig1M4GOQ2l3o3XtP4aaLj4t5JCqhJ2u9zyXrJMUps5479bombbPI
         u+t/D/MpLRYAQjXjY+M9aj1BGCEPWxG0IuwmHVMsz+LqUBRXywlH5GW0oLXVBFfZCJ
         UBJmf0juPF9c09XObXor+Q+JfUtDOVNrlCbPTKOeIe96i/Db2wpPeE07gXbhAD1X48
         MDWyR+YA/k1ZmaUSMnDXPoraS50gdb2KCADml+GEomw1oQoJ7X0FAR4w/2MpaXv/EE
         bHwX1+v9YSdzw==
Message-ID: <e8922bc821a40f5a3f0a1301583288ed19b6891b.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "neilb@suse.de" <neilb@suse.de>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
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
        "tytso@mit.edu" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Thu, 15 Sep 2022 15:25:32 -0400
In-Reply-To: <871f9c5153ddfe760854ca31ee36b84655959b83.camel@hammerspace.com>
References: <20220908083326.3xsanzk7hy3ff4qs@quack3>
         <YxoIjV50xXKiLdL9@mit.edu>
         <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
         <20220908155605.GD8951@fieldses.org>
         <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
         <20220908182252.GA18939@fieldses.org>
         <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
         <166284799157.30452.4308111193560234334@noble.neil.brown.name>
         <20220912134208.GB9304@fieldses.org>
         <166302447257.30452.6751169887085269140@noble.neil.brown.name>
         <20220915140644.GA15754@fieldses.org>
         <577b6d8a7243aeee37eaa4bbb00c90799586bc48.camel@hammerspace.com>
         <1a968b8e87f054e360877c9ab8cdfc4cfdfc8740.camel@kernel.org>
         <0646410b6d2a5d19d3315f339b2928dfa9f2d922.camel@hammerspace.com>
         <34e91540c92ad6980256f6b44115cf993695d5e1.camel@kernel.org>
         <871f9c5153ddfe760854ca31ee36b84655959b83.camel@hammerspace.com>
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

On Thu, 2022-09-15 at 19:03 +0000, Trond Myklebust wrote:
> On Thu, 2022-09-15 at 14:11 -0400, Jeff Layton wrote:
> > On Thu, 2022-09-15 at 17:49 +0000, Trond Myklebust wrote:
> > > On Thu, 2022-09-15 at 12:45 -0400, Jeff Layton wrote:
> > > > On Thu, 2022-09-15 at 15:08 +0000, Trond Myklebust wrote:
> > > > > On Thu, 2022-09-15 at 10:06 -0400, J. Bruce Fields wrote:
> > > > > > On Tue, Sep 13, 2022 at 09:14:32AM +1000, NeilBrown wrote:
> > > > > > > On Mon, 12 Sep 2022, J. Bruce Fields wrote:
> > > > > > > > On Sun, Sep 11, 2022 at 08:13:11AM +1000, NeilBrown
> > > > > > > > wrote:
> > > > > > > > > On Fri, 09 Sep 2022, Jeff Layton wrote:
> > > > > > > > > >=20
> > > > > > > > > > The machine crashes and comes back up, and we get a
> > > > > > > > > > query
> > > > > > > > > > for
> > > > > > > > > > i_version
> > > > > > > > > > and it comes back as X. Fine, it's an old version.
> > > > > > > > > > Now
> > > > > > > > > > there
> > > > > > > > > > is a write.
> > > > > > > > > > What do we do to ensure that the new value doesn't
> > > > > > > > > > collide
> > > > > > > > > > with X+1?=20
> > > > > > > > >=20
> > > > > > > > > (I missed this bit in my earlier reply..)
> > > > > > > > >=20
> > > > > > > > > How is it "Fine" to see an old version?
> > > > > > > > > The file could have changed without the version
> > > > > > > > > changing.
> > > > > > > > > And I thought one of the goals of the crash-count was
> > > > > > > > > to be
> > > > > > > > > able to
> > > > > > > > > provide a monotonic change id.
> > > > > > > >=20
> > > > > > > > I was still mainly thinking about how to provide reliable
> > > > > > > > close-
> > > > > > > > to-open
> > > > > > > > semantics between NFS clients.=A0 In the case the writer
> > > > > > > > was an
> > > > > > > > NFS
> > > > > > > > client, it wasn't done writing (or it would have
> > > > > > > > COMMITted),
> > > > > > > > so
> > > > > > > > those
> > > > > > > > writes will come in and bump the change attribute soon,
> > > > > > > > and
> > > > > > > > as
> > > > > > > > long as
> > > > > > > > we avoid the small chance of reusing an old change
> > > > > > > > attribute,
> > > > > > > > we're OK,
> > > > > > > > and I think it'd even still be OK to advertise
> > > > > > > > CHANGE_TYPE_IS_MONOTONIC_INCR.
> > > > > > >=20
> > > > > > > You seem to be assuming that the client doesn't crash at
> > > > > > > the
> > > > > > > same
> > > > > > > time
> > > > > > > as the server (maybe they are both VMs on a host that lost
> > > > > > > power...)
> > > > > > >=20
> > > > > > > If client A reads and caches, client B writes, the server
> > > > > > > crashes
> > > > > > > after
> > > > > > > writing some data (to already allocated space so no inode
> > > > > > > update
> > > > > > > needed)
> > > > > > > but before writing the new i_version, then client B
> > > > > > > crashes.
> > > > > > > When server comes back the i_version will be unchanged but
> > > > > > > the
> > > > > > > data
> > > > > > > has
> > > > > > > changed.=A0 Client A will cache old data indefinitely...
> > > > > >=20
> > > > > > I guess I assume that if all we're promising is close-to-
> > > > > > open,
> > > > > > then a
> > > > > > client isn't allowed to trust its cache in that situation.=A0
> > > > > > Maybe
> > > > > > that's
> > > > > > an overly draconian interpretation of close-to-open.
> > > > > >=20
> > > > > > Also, I'm trying to think about how to improve things
> > > > > > incrementally.
> > > > > > Incorporating something like a crash count into the on-disk
> > > > > > i_version
> > > > > > fixes some cases without introducing any new ones or
> > > > > > regressing
> > > > > > performance after a crash.
> > > > > >=20
> > > > > > If we subsequently wanted to close those remaining holes, I
> > > > > > think
> > > > > > we'd
> > > > > > need the change attribute increment to be seen as atomic with
> > > > > > respect
> > > > > > to
> > > > > > its associated change, both to clients and (separately) on
> > > > > > disk.=A0
> > > > > > (That
> > > > > > would still allow the change attribute to go backwards after
> > > > > > a
> > > > > > crash,
> > > > > > to
> > > > > > the value it held as of the on-disk state of the file.=A0 I
> > > > > > think
> > > > > > clients
> > > > > > should be able to deal with that case.)
> > > > > >=20
> > > > > > But, I don't know, maybe a bigger hammer would be OK:
> > > > > >=20
> > > > >=20
> > > > > If you're not going to meet the minimum bar of data integrity,
> > > > > then
> > > > > this whole exercise is just a massive waste of everyone's time.
> > > > > The
> > > > > answer then going forward is just to recommend never using
> > > > > Linux as
> > > > > an
> > > > > NFS server. Makes my life much easier, because I no longer have
> > > > > to
> > > > > debug any of the issues.
> > > > >=20
> > > > >=20
> > > >=20
> > > > To be clear, you believe any scheme that would allow the client
> > > > to
> > > > see
> > > > an old change attr after a crash is insufficient?
> > > >=20
> > >=20
> > > Correct. If a NFSv4 client or userspace application cannot trust
> > > that
> > > it will always see a change to the change attribute value when the
> > > file
> > > data changes, then you will eventually see data corruption due to
> > > the
> > > cached data no longer matching the stored data.
> > >=20
> > > A false positive update of the change attribute (i.e. a case where
> > > the
> > > change attribute changes despite the data/metadata staying the
> > > same) is
> > > not desirable because it causes performance issues, but false
> > > negatives
> > > are far worse because they mean your data backup, cache, etc... are
> > > not
> > > consistent. Applications that have strong consistency requirements
> > > will
> > > have no option but to revalidate by always reading the entire file
> > > data
> > > + metadata.
> > >=20
> > > > The only way I can see to fix that (at least with only a crash
> > > > counter)
> > > > would be to factor it in at presentation time like Neil
> > > > suggested.
> > > > Basically we'd just mask off the top 16 bits and plop the crash
> > > > counter
> > > > in there before presenting it.
> > > >=20
> > > > In principle, I suppose we could do that at the nfsd level as
> > > > well
> > > > (and
> > > > that might be the simplest way to fix this). We probably wouldn't
> > > > be
> > > > able to advertise a change attr type of MONOTONIC with this
> > > > scheme
> > > > though.
> > >=20
> > > Why would you want to limit the crash counter to 16 bits?
> > >=20
> >=20
> > To leave more room for the "real" counter. Otherwise, an inode that
> > gets
> > frequent writes after a long period of no crashes could experience
> > the
> > counter wrap.
> >=20
> > IOW, we have 63 bits to play with. Whatever part we dedicate to the
> > crash counter will not be available for the actual version counter.
> >=20
> > I'm proposing a 16+47+1 split, but I'm happy to hear arguments for a
> > different one.
>=20
>=20
> What is the expectation when you have an unclean shutdown or crash? Do
> all change attribute values get updated to reflect the new crash
> counter value, or only some?
>=20
> If the answer is that 'all values change', then why store the crash
> counter in the inode at all? Why not just add it as an offset when
> you're generating the user-visible change attribute?
>=20
> i.e. statx.change_attr =3D inode->i_version + (crash counter * offset)
>=20
> (where offset is chosen to be larger than the max number of inode-
> > i_version updates that could get lost by an inode in a crash).
>=20
> Presumably that offset could be significantly smaller than 2^63...
>=20


Yes, if we plan to ensure that all the change attrs change after a
crash, we can do that.

So what would make sense for an offset? Maybe 2**12? One would hope that
there wouldn't be more than 4k increments before one of them made it to
disk. OTOH, maybe that can happen with teeny-tiny writes.

If we want to leave this up to the filesystem, I guess we could just add
a new struct super_block.s_version_offset field and let the filesystem
precompute that value and set it at mount time. Then we can just add
that in after querying i_version.
--=20
Jeff Layton <jlayton@kernel.org>
