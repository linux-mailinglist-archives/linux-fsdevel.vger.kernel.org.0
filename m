Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1781E5B9F17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 17:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiIOPmD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 11:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIOPls (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:41:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE3D7F135;
        Thu, 15 Sep 2022 08:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C082B81EC7;
        Thu, 15 Sep 2022 15:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38AAC433D6;
        Thu, 15 Sep 2022 15:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663256503;
        bh=rlYPWFSDAkkceF7nnuumRwCxflqb4EWJ0ok6kVleU78=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=L0qoLoaZylbWW9G3EOU33xsqrYNKphW711WlAzAes5iEVHL0jx3ta+ZXfkPEsKTI6
         LOuwQupSJLTDY0kMx7XNEohgk2hcqqFZRogLQCMmVKeZJLfArbzzbtuZMZicKa+M2g
         Q8/5AJR87ThypT1xvjDu5rKkQLK/qY3RdPucLMMQ5T5h9RQrpeAjRxsP6xpHJ/Q6K7
         4YgIoplcufipLrJqnpL0oLY5N2f3Zub7Ka9tWTfg9hYSHa01sTQfZ3+BudJ8Kmugve
         EaM497Eux9X+MpeofpD6JF4Q/M7UeI0IcBptZ06I5nHDr1mj5DCGUNALA2AtdlMiOA
         jOlHJDeT+0O/g==
Message-ID: <52a21018cde28eb7670a5ea86b79aef4a100d74b.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>, NeilBrown <neilb@suse.de>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        adilger.kernel@dilger.ca, djwong@kernel.org, david@fromorbit.com,
        trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, brauner@kernel.org, fweimer@redhat.com,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Date:   Thu, 15 Sep 2022 11:41:40 -0400
In-Reply-To: <20220915140644.GA15754@fieldses.org>
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

On Thu, 2022-09-15 at 10:06 -0400, J. Bruce Fields wrote:
> On Tue, Sep 13, 2022 at 09:14:32AM +1000, NeilBrown wrote:
> > On Mon, 12 Sep 2022, J. Bruce Fields wrote:
> > > On Sun, Sep 11, 2022 at 08:13:11AM +1000, NeilBrown wrote:
> > > > On Fri, 09 Sep 2022, Jeff Layton wrote:
> > > > >=20
> > > > > The machine crashes and comes back up, and we get a query for i_v=
ersion
> > > > > and it comes back as X. Fine, it's an old version. Now there is a=
 write.
> > > > > What do we do to ensure that the new value doesn't collide with X=
+1?=20
> > > >=20
> > > > (I missed this bit in my earlier reply..)
> > > >=20
> > > > How is it "Fine" to see an old version?
> > > > The file could have changed without the version changing.
> > > > And I thought one of the goals of the crash-count was to be able to
> > > > provide a monotonic change id.
> > >=20
> > > I was still mainly thinking about how to provide reliable close-to-op=
en
> > > semantics between NFS clients.  In the case the writer was an NFS
> > > client, it wasn't done writing (or it would have COMMITted), so those
> > > writes will come in and bump the change attribute soon, and as long a=
s
> > > we avoid the small chance of reusing an old change attribute, we're O=
K,
> > > and I think it'd even still be OK to advertise
> > > CHANGE_TYPE_IS_MONOTONIC_INCR.
> >=20
> > You seem to be assuming that the client doesn't crash at the same time
> > as the server (maybe they are both VMs on a host that lost power...)
> >=20
> > If client A reads and caches, client B writes, the server crashes after
> > writing some data (to already allocated space so no inode update needed=
)
> > but before writing the new i_version, then client B crashes.
> > When server comes back the i_version will be unchanged but the data has
> > changed.  Client A will cache old data indefinitely...
>=20
> I guess I assume that if all we're promising is close-to-open, then a
> client isn't allowed to trust its cache in that situation.  Maybe that's
> an overly draconian interpretation of close-to-open.
>=20
> Also, I'm trying to think about how to improve things incrementally.
> Incorporating something like a crash count into the on-disk i_version
> fixes some cases without introducing any new ones or regressing
> performance after a crash.
>=20

I think we ought to start there.

> If we subsequently wanted to close those remaining holes, I think we'd
> need the change attribute increment to be seen as atomic with respect to
> its associated change, both to clients and (separately) on disk.  (That
> would still allow the change attribute to go backwards after a crash, to
> the value it held as of the on-disk state of the file.  I think clients
> should be able to deal with that case.)
>=20
> But, I don't know, maybe a bigger hammer would be OK:
>=20
> > I think we need to require the filesystem to ensure that the i_version
> > is seen to increase shortly after any change becomes visible in the
> > file, and no later than the moment when the request that initiated the
> > change is acknowledged as being complete.  In the case of an unclean
> > restart, any file that is not known to have been unchanged immediately
> > before the crash must have i_version increased.
> >=20
> > The simplest implementation is to have an unclean-restart counter and t=
o
> > always included this multiplied by some constant X in the reported
> > i_version.  The filesystem guarantees to record (e.g.  to journal
> > at least) the i_version if it comes close to X more than the previous
> > record.  The filesystem gets to choose X.
>
> So the question is whether people can live with invalidating all client
> caches after a cache.  I don't know.
>=20

I assume you mean "after a crash". Yeah, that is pretty nasty. We don't
get perfect crash resilience with incorporating this into the on-disk
value, but I like that better than factoring it in at=A0presentation time.

That would mean that the servers would end up getting hammered with read
activity after a crash (at least in some environments). I don't think
that would be worth the tradeoff. There's a real benefit to preserving
caches when we can.

> > A more complex solution would be to record (similar to the way orphans
> > are recorded) any file which is open for write, and to add X to the
> > i_version for any "dirty" file still recorded during an unclean
> > restart.  This would avoid bumping the i_version for read-only files.
>=20
> Is that practical?  Working out the performance tradeoffs sounds like a
> project.
>
>=20
> > There may be other solutions, but we should leave that up to the
> > filesystem.  Each filesystem might choose something different.
>=20
> Sure.
>=20

Agreed here too. I think we need to allow for some flexibility here.=A0

Here's what I'm thinking:

We'll carve out the upper 16 bits in the i_version counter to be the
crash counter field. That gives us 8k crashes before we have to worry
about collisions. Hopefully the remaining 47 bits of counter will be
plenty given that we don't increment it when it's not being queried or
nothing else changes. (Can we mitigate wrapping here somehow?)

The easiest way to do this would be to add a u16 s_crash_counter to
struct super_block. We'd initialize that to 0, and the filesystem could
fill that value out at mount time.

Then inode_maybe_inc_iversion can just shift the s_crash_counter that
left by 24 bits and and plop it into the top of the value we're
preparing to cmpxchg into place.

This is backward compatible too, at least for i_version counter values
that are <2^47. With anything larger, we might end up with something
going backward and a possible collision, but it's (hopefully) a small
risk.

--=20
Jeff Layton <jlayton@kernel.org>
