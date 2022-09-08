Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7CF5B2504
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 19:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiIHRm1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 13:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbiIHRmI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:42:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDC6F22E3;
        Thu,  8 Sep 2022 10:40:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 315E8B8219F;
        Thu,  8 Sep 2022 17:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF787C433D6;
        Thu,  8 Sep 2022 17:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662658815;
        bh=lOOhDMJqAJ4IWViD/vMxAvwDHCCQ4KSk3LDLvJPm2b8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jOjgqtB8wXqzhfDI4J+C/903aXH0rQaTb7qR5v89q/oUZzCQQO6ekfmeefPsnCQk4
         RnO7TCnkT3eE/qMb7GnFEjmQHCCy70T2gWRHLb1+qsgKWLOB1zNiI9LqA0O9M/LHTb
         TotEhE768MXAJqYpU5jYDz1lCKtOnuKq+tzKSlzlW0gouCHWcrpLCC4I7vZNM26k6y
         5IZqUpWB6q2nfS6ZoK31qn8JMnEqiXBC+Bk7AgzcifSL4lr2QlltiMcQxWifvj7Iaw
         LZx96/KNZs18aoGi3MMb8wSgWM5WtSggbiLe1/rkhJb4Qioq6nCWk9qjCYRVfrmxqG
         okXyb82PbMNyQ==
Message-ID: <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
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
Date:   Thu, 08 Sep 2022 13:40:11 -0400
In-Reply-To: <20220908155605.GD8951@fieldses.org>
References: <20220907111606.18831-1-jlayton@kernel.org>
         <166255065346.30452.6121947305075322036@noble.neil.brown.name>
         <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
         <20220907125211.GB17729@fieldses.org>
         <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
         <20220907135153.qvgibskeuz427abw@quack3>
         <166259786233.30452.5417306132987966849@noble.neil.brown.name>
         <20220908083326.3xsanzk7hy3ff4qs@quack3> <YxoIjV50xXKiLdL9@mit.edu>
         <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
         <20220908155605.GD8951@fieldses.org>
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

On Thu, 2022-09-08 at 11:56 -0400, J. Bruce Fields wrote:
> On Thu, Sep 08, 2022 at 11:44:33AM -0400, Jeff Layton wrote:
> > On Thu, 2022-09-08 at 11:21 -0400, Theodore Ts'o wrote:
> > > On Thu, Sep 08, 2022 at 10:33:26AM +0200, Jan Kara wrote:
> > > > It boils down to the fact that we don't want to call mark_inode_dir=
ty()
> > > > from IOCB_NOWAIT path because for lots of filesystems that means jo=
urnal
> > > > operation and there are high chances that may block.
> > > >=20
> > > > Presumably we could treat inode dirtying after i_version change sim=
ilarly
> > > > to how we handle timestamp updates with lazytime mount option (i.e.=
, not
> > > > dirty the inode immediately but only with a delay) but then the tim=
e window
> > > > for i_version inconsistencies due to a crash would be much larger.
> > >=20
> > > Perhaps this is a radical suggestion, but there seems to be a lot of
> > > the problems which are due to the concern "what if the file system
> > > crashes" (and so we need to worry about making sure that any
> > > increments to i_version MUST be persisted after it is incremented).
> > >=20
> > > Well, if we assume that unclean shutdowns are rare, then perhaps we
> > > shouldn't be optimizing for that case.  So.... what if a file system
> > > had a counter which got incremented each time its journal is replayed
> > > representing an unclean shutdown.  That shouldn't happen often, but i=
f
> > > it does, there might be any number of i_version updates that may have
> > > gotten lost.  So in that case, the NFS client should invalidate all o=
f
> > > its caches.
> > >=20
> > > If the i_version field was large enough, we could just prefix the
> > > "unclean shutdown counter" with the existing i_version number when it
> > > is sent over the NFS protocol to the client.  But if that field is to=
o
> > > small, and if (as I understand things) NFS just needs to know when
> > > i_version is different, we could just simply hash the "unclean
> > > shtudown counter" with the inode's "i_version counter", and let that
> > > be the version which is sent from the NFS client to the server.
> > >=20
> > > If we could do that, then it doesn't become critical that every singl=
e
> > > i_version bump has to be persisted to disk, and we could treat it lik=
e
> > > a lazytime update; it's guaranteed to updated when we do an clean
> > > unmount of the file system (and when the file system is frozen), but
> > > on a crash, there is no guaranteee that all i_version bumps will be
> > > persisted, but we do have this "unclean shutdown" counter to deal wit=
h
> > > that case.
> > >=20
> > > Would this make life easier for folks?
> > >=20
> > > 						- Ted
> >=20
> > Thanks for chiming in, Ted. That's part of the problem, but we're
> > actually not too worried about that case:
> >=20
> > nfsd mixes the ctime in with i_version, so you'd have to crash+clock
> > jump backward by juuuust enough to allow you to get the i_version and
> > ctime into a state it was before the crash, but with different data.
> > We're assuming that that is difficult to achieve in practice.
>=20
> But a change in the clock could still cause our returned change
> attribute to go backwards (even without a crash).  Not sure how to
> evaluate the risk, but it was enough that Trond hasn't been comfortable
> with nfsd advertising NFS4_CHANGE_TYPE_IS_MONOTONIC.
>=20
> Ted's idea would be sufficient to allow us to turn that flag on, which I
> think allows some client-side optimizations.
>=20

Good point.

> > The issue with a reboot counter (or similar) is that on an unclean cras=
h
> > the NFS client would end up invalidating every inode in the cache, as
> > all of the i_versions would change. That's probably excessive.
>=20
> But if we use the crash counter on write instead of read, we don't
> invalidate caches unnecessarily.  And I think the monotonicity would
> still be close enough for our purposes?
>=20
> > The bigger issue (at the moment) is atomicity: when we fetch an
> > i_version, the natural inclination is to associate that with the state
> > of the inode at some point in time, so we need this to be updated
> > atomically with certain other attributes of the inode. That's the part
> > I'm trying to sort through at the moment.
>=20
> That may be, but I still suspect the crash counter would help.
>=20

Yeah, ok. That does make some sense. So we would mix this into the
i_version instead of the ctime when it was available. Preferably, we'd
mix that in when we store the i_version rather than adding it afterward.

Ted, how would we access this? Maybe we could just add a new (generic)
super_block field for this that ext4 (and other filesystems) could
populate at mount time?
--=20
Jeff Layton <jlayton@kernel.org>
