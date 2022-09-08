Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87545B2A1D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 01:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiIHXXo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 19:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIHXXn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:23:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2162705;
        Thu,  8 Sep 2022 16:23:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0FB6B822CC;
        Thu,  8 Sep 2022 23:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E9CC433C1;
        Thu,  8 Sep 2022 23:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662679419;
        bh=nH3goiwh4MPlbyp6wbqIpdi/uAY7tWd6MeTco+vFrpI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qRRZyY6jlpIBg7m7TJ+5c6bka15n1MoQlKCiCheWqANfJzVNRATy3aPNi5bXsWKqN
         +Im0EssEQvJ/xsPYz4KaAU27m+04C/mmI3E0oAJeJ5xDgJO9rDhkNXDK9BTy6jjwRw
         ASsPSLfUblxcT1iuhRHIWuexZf5KT25U2TCTokpMpyAFdqheZynGUVrIkq0LpDBtlK
         ACuy9x3fzecAnR7gQuMs5dLVeT8pek1/qrgTzkjT60UjMEO/BcpeB8lSrj8XdW31zi
         Guf0FVbBLdJh//f1ge+9feD618r1fVso65EwnjgOQbL3UQV+mdqyOjabi2fhqrgHOT
         Rdlozw8pCusJw==
Message-ID: <53298467f5fce443c70ef6821e055d10caf9331e.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        adilger.kernel@dilger.ca, djwong@kernel.org, david@fromorbit.com,
        trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, brauner@kernel.org, fweimer@redhat.com,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Date:   Thu, 08 Sep 2022 19:23:36 -0400
In-Reply-To: <166267807678.30452.18035749642786839300@noble.neil.brown.name>
References: <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
        , <20220907125211.GB17729@fieldses.org>
        , <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
        , <20220907135153.qvgibskeuz427abw@quack3>
        , <166259786233.30452.5417306132987966849@noble.neil.brown.name>
        , <20220908083326.3xsanzk7hy3ff4qs@quack3>, <YxoIjV50xXKiLdL9@mit.edu>
        , <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
        , <20220908155605.GD8951@fieldses.org>
        , <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
        , <20220908182252.GA18939@fieldses.org>
        , <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
         <166267807678.30452.18035749642786839300@noble.neil.brown.name>
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

On Fri, 2022-09-09 at 09:01 +1000, NeilBrown wrote:
> On Fri, 09 Sep 2022, Jeff Layton wrote:
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
>=20
> As I understand it, the crash counter would NEVER appear in the on-disk
> i_version.
> The crash counter is stable while a filesystem is mounted so is the same
> when loading an inode from disk and when writing it back.
>=20
> When loading, add crash counter to on-disk i_version to provide
> in-memory i_version.
> when storing, subtract crash counter from in-memory i_version to provide
> on-disk i_version.
>=20
> "add" and "subtract" could be any reversible hash, and its inverse.  I
> would probably shift the crash counter up 16 and add/subtract.
>=20
>=20

If you store the value with the crash counter already factored-in, then
not every inode would end up being invalidated after a crash. If we try
to mix it in later, the client will end up invalidating the cache even
for inodes that had no changes.

> >=20
> > The machine crashes and comes back up, and we get a query for i_version
> > and it comes back as X. Fine, it's an old version. Now there is a write=
.
> > What do we do to ensure that the new value doesn't collide with X+1?=
=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
