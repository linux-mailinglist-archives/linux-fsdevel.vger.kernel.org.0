Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B535B3D1D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 18:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiIIQgj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 12:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiIIQgg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:36:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3119D13EE53;
        Fri,  9 Sep 2022 09:36:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB56462048;
        Fri,  9 Sep 2022 16:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A88BC433D6;
        Fri,  9 Sep 2022 16:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662741393;
        bh=wu5v/zPYdVKac4kN+MxwQR8JTk1sTk072yR8Kfjjvf4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jAqYAdwSrah1Sa8IwFYC9ATdfygzVZR07PxvjkjqmTeE6lw8Bu54cPdMbudbCaAKf
         6usVdZgNNDb8RXRjSQkaFYKeGoLwHhupgHWVbFvKqiwCxSrExoKfV/GBd+6SnSF0Xu
         /dH7f/AFvbQeF7iczCFMkFgWVrHkNQDSqspoANp8qOGzQBtBt3THplTrbWDKhp4ftg
         VNHZdsaYky6wBfEzUpg62BuwERi6F1rj6Xt9MPU0CyQe9WshUsgGHlyg/9HCvmGJAp
         3DnaZmE4Pc8cFL8W+ItuVKbVF4pw7WHgn4jRYf6mseK88msl1s4haa4YLJXO95I9t7
         fabcJ2JNdwBQA==
Message-ID: <125df688dbebaf06478b0911e76e228e910b04b3.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.de>, adilger.kernel@dilger.ca,
        djwong@kernel.org, david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, brauner@kernel.org,
        fweimer@redhat.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Fri, 09 Sep 2022 12:36:29 -0400
In-Reply-To: <20220909154506.GB5674@fieldses.org>
References: <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
         <20220907135153.qvgibskeuz427abw@quack3>
         <166259786233.30452.5417306132987966849@noble.neil.brown.name>
         <20220908083326.3xsanzk7hy3ff4qs@quack3> <YxoIjV50xXKiLdL9@mit.edu>
         <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
         <20220908155605.GD8951@fieldses.org>
         <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
         <20220908182252.GA18939@fieldses.org>
         <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
         <20220909154506.GB5674@fieldses.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-09-09 at 11:45 -0400, J. Bruce Fields wrote:
> On Thu, Sep 08, 2022 at 03:07:58PM -0400, Jeff Layton wrote:
> > On Thu, 2022-09-08 at 14:22 -0400, J. Bruce Fields wrote:
> > > On Thu, Sep 08, 2022 at 01:40:11PM -0400, Jeff Layton wrote:
> > > > Yeah, ok. That does make some sense. So we would mix this into the
> > > > i_version instead of the ctime when it was available. Preferably, w=
e'd
> > > > mix that in when we store the i_version rather than adding it after=
ward.
> > > >=20
> > > > Ted, how would we access this? Maybe we could just add a new (gener=
ic)
> > > > super_block field for this that ext4 (and other filesystems) could
> > > > populate at mount time?
> > >=20
> > > Couldn't the filesystem just return an ino_version that already inclu=
des
> > > it?
> > >=20
> >=20
> > Yes. That's simple if we want to just fold it in during getattr. If we
> > want to fold that into the values stored on disk, then I'm a little les=
s
> > clear on how that will work.
> >=20
> > Maybe I need a concrete example of how that will work:
> >=20
> > Suppose we have an i_version value X with the previous crash counter
> > already factored in that makes it to disk. We hand out a newer version
> > X+1 to a client, but that value never makes it to disk.
> >=20
> > The machine crashes and comes back up, and we get a query for i_version
> > and it comes back as X. Fine, it's an old version. Now there is a write=
.
> > What do we do to ensure that the new value doesn't collide with X+1?=
=20
>=20
> I was assuming we could partition i_version's 64 bits somehow: e.g., top
> 16 bits store the crash counter.  You increment the i_version by: 1)
> replacing the top bits by the new crash counter, if it has changed, and
> 2) incrementing.
>=20
> Do the numbers work out?  2^16 mounts after unclean shutdowns sounds
> like a lot for one filesystem, as does 2^48 changes to a single file,
> but people do weird things.  Maybe there's a better partitioning, or
> some more flexible way of maintaining an i_version that still allows you
> to identify whether a given i_version preceded a crash.
>=20

We consume one bit to keep track of the "seen" flag, so it would be a
16+47 split. I assume that we'd also reset the version counter to 0 when
the crash counter changes? Maybe that doesn't matter as long as we don't
overflow into the crash counter.

I'm not sure we can get away with 16 bits for the crash counter, as
it'll leave us subject to the version counter wrapping after a long
uptimes.=20

If you increment a counter every nanosecond, how long until that counter
wraps? With 63 bits, that's 292 years (and change). With 16+47 bits,
that's less than two days. An 8+55 split would give us ~416 days which
seems a bit more reasonable?

For NFS, we can probably live with even less bits in the crash counter.=A0

If the crash counter changes, then that means the NFS server itself has
(likely) also crashed. The client will have to reestablish sockets,
reclaim, etc. It should get new attributes for the inodes it cares about
at that time.
--=20
Jeff Layton <jlayton@kernel.org>
