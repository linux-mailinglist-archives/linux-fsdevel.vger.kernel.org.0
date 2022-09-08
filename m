Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64515B22AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 17:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiIHPot (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 11:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiIHPop (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:44:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDAB20BF6;
        Thu,  8 Sep 2022 08:44:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B35A7B82177;
        Thu,  8 Sep 2022 15:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560D7C433C1;
        Thu,  8 Sep 2022 15:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662651877;
        bh=KKlPeweE+V5xU5UKySdETFhFvGBGdAvY07pcwu38RQE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QwYDYggu9ENjDnFBPi2d659s4ilkA4jms8keuRvwMigE1nEJl+S/rDSDIvdjnffCU
         M0r9JZnW8ubjjLcf5PrZHUCEgoOHiIgLK+htlTZAfZRw/dFQR1Y5ZNRyTC1OyAlLmz
         h79BlCe0mWnpJLINHENoIhVn44gvhWjb3uDuIehDm2L5FmhkgwLVQOprp+aCAI+O6E
         dp6Pzc3XRBwj5YQzY1YcsljiDbfYqxJxHAi9wzCsehjdo9JUhl26AdVNI94ty/in6P
         PKmcXvw3C8qkq7UX8Gv1GU9d9VWTdD0sxqdfuNJ0wnsMpN8NNfCPaIOyzFyPJFZKde
         o1uAof77gY5lA==
Message-ID: <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Cc:     NeilBrown <neilb@suse.de>,
        "J. Bruce Fields" <bfields@fieldses.org>, adilger.kernel@dilger.ca,
        djwong@kernel.org, david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, brauner@kernel.org,
        fweimer@redhat.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Thu, 08 Sep 2022 11:44:33 -0400
In-Reply-To: <YxoIjV50xXKiLdL9@mit.edu>
References: <20220907111606.18831-1-jlayton@kernel.org>
         <166255065346.30452.6121947305075322036@noble.neil.brown.name>
         <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
         <20220907125211.GB17729@fieldses.org>
         <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
         <20220907135153.qvgibskeuz427abw@quack3>
         <166259786233.30452.5417306132987966849@noble.neil.brown.name>
         <20220908083326.3xsanzk7hy3ff4qs@quack3> <YxoIjV50xXKiLdL9@mit.edu>
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

On Thu, 2022-09-08 at 11:21 -0400, Theodore Ts'o wrote:
> On Thu, Sep 08, 2022 at 10:33:26AM +0200, Jan Kara wrote:
> > It boils down to the fact that we don't want to call mark_inode_dirty()
> > from IOCB_NOWAIT path because for lots of filesystems that means journa=
l
> > operation and there are high chances that may block.
> >=20
> > Presumably we could treat inode dirtying after i_version change similar=
ly
> > to how we handle timestamp updates with lazytime mount option (i.e., no=
t
> > dirty the inode immediately but only with a delay) but then the time wi=
ndow
> > for i_version inconsistencies due to a crash would be much larger.
>=20
> Perhaps this is a radical suggestion, but there seems to be a lot of
> the problems which are due to the concern "what if the file system
> crashes" (and so we need to worry about making sure that any
> increments to i_version MUST be persisted after it is incremented).
>=20
> Well, if we assume that unclean shutdowns are rare, then perhaps we
> shouldn't be optimizing for that case.  So.... what if a file system
> had a counter which got incremented each time its journal is replayed
> representing an unclean shutdown.  That shouldn't happen often, but if
> it does, there might be any number of i_version updates that may have
> gotten lost.  So in that case, the NFS client should invalidate all of
> its caches.
>=20
> If the i_version field was large enough, we could just prefix the
> "unclean shutdown counter" with the existing i_version number when it
> is sent over the NFS protocol to the client.  But if that field is too
> small, and if (as I understand things) NFS just needs to know when
> i_version is different, we could just simply hash the "unclean
> shtudown counter" with the inode's "i_version counter", and let that
> be the version which is sent from the NFS client to the server.
>=20
> If we could do that, then it doesn't become critical that every single
> i_version bump has to be persisted to disk, and we could treat it like
> a lazytime update; it's guaranteed to updated when we do an clean
> unmount of the file system (and when the file system is frozen), but
> on a crash, there is no guaranteee that all i_version bumps will be
> persisted, but we do have this "unclean shutdown" counter to deal with
> that case.
>=20
> Would this make life easier for folks?
>=20
> 						- Ted

Thanks for chiming in, Ted. That's part of the problem, but we're
actually not too worried about that case:

nfsd mixes the ctime in with i_version, so you'd have to crash+clock
jump backward by juuuust enough to allow you to get the i_version and
ctime into a state it was before the crash, but with different data.
We're assuming that that is difficult to achieve in practice.

The issue with a reboot counter (or similar) is that on an unclean crash
the NFS client would end up invalidating every inode in the cache, as
all of the i_versions would change. That's probably excessive.

The bigger issue (at the moment) is atomicity: when we fetch an
i_version, the natural inclination is to associate that with the state
of the inode at some point in time, so we need this to be updated
atomically with certain other attributes of the inode. That's the part
I'm trying to sort through at the moment.
--=20
Jeff Layton <jlayton@kernel.org>
