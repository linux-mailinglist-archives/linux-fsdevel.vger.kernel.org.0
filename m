Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05495A6B6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 19:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiH3R4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 13:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiH3Rzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:55:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF83B7E838;
        Tue, 30 Aug 2022 10:53:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21F5A614EC;
        Tue, 30 Aug 2022 17:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F94DC433B5;
        Tue, 30 Aug 2022 17:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661882009;
        bh=vCK6CST7ctMbCISxwN2JFQPXC0nxggMxJE8Qv8vIua4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kdyP1qF4LUhTZCBdTjOvFfxiYTDILbA1AbrABLir16ACmXUIxZK2B5OrMO4yDv6j1
         3uNB7TlEiEn0Em7YW1hiBeijJ6L/4lpD5L5QrDeEBv5hqhpxKq5ncNVbY2rQkeDCpI
         yEp34r9ecnRrzDQm0FQNoDVhKo1u0Q5mT4C92Gi810wp5zXVISOHXT1LGzII0QW5ua
         1r6LC/sCe3pzIFUP2V4u2A+cBcOxkSYlLlXCP4o+7fReWDLzfUkghtoUprDhaCE6XU
         2y1b4BJ/XbebcnmipvjXC6lLbFMWLl3i9xjx4E8ywzr69WrCKHCk6KMS209xhLy32F
         KGCDJ0679pkNg==
Message-ID: <5f194ec391498f18602f75126d78bfe21132ecea.camel@kernel.org>
Subject: Re: [PATCH v3 1/7] iversion: update comments with info about atime
 updates
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-ceph@vger.kernel.org" <linux-ceph@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "walters@verbum.org" <walters@verbum.org>
Date:   Tue, 30 Aug 2022 13:53:26 -0400
In-Reply-To: <5fd1f7e99d5ab87db48c8c3603b014c1c2d2ec5a.camel@hammerspace.com>
References: <20220826214703.134870-1-jlayton@kernel.org>
         <20220826214703.134870-2-jlayton@kernel.org>
         <20220829075651.GS3600936@dread.disaster.area>
         <549776abfaddcc936c6de7800b6d8249d97d9f28.camel@kernel.org>
         <166181389550.27490.8200873228292034867@noble.neil.brown.name>
         <f5c42c0d87dfa45188c2109ccf9baeb7a42aa27e.camel@kernel.org>
         <20220830132443.GA26330@fieldses.org>
         <a07686e7e1d1ef15720194be2abe5681f6a6c78e.camel@kernel.org>
         <20220830144430.GD26330@fieldses.org>
         <e4815337177c74a9928098940dfdcb371017a40c.camel@hammerspace.com>
         <20220830151715.GE26330@fieldses.org>
         <3e8c7af5d39870c5b0dc61736a79bd134be5a9b3.camel@hammerspace.com>
         <4adb2abd1890b147dbc61a06413f35d2f147c43a.camel@kernel.org>
         <5fd1f7e99d5ab87db48c8c3603b014c1c2d2ec5a.camel@hammerspace.com>
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

On Tue, 2022-08-30 at 17:47 +0000, Trond Myklebust wrote:
> On Tue, 2022-08-30 at 13:02 -0400, Jeff Layton wrote:
> > On Tue, 2022-08-30 at 15:43 +0000, Trond Myklebust wrote:
> > > On Tue, 2022-08-30 at 11:17 -0400, J. Bruce Fields wrote:
> > > > On Tue, Aug 30, 2022 at 02:58:27PM +0000, Trond Myklebust wrote:
> > > > > On Tue, 2022-08-30 at 10:44 -0400, J. Bruce Fields wrote:
> > > > > > On Tue, Aug 30, 2022 at 09:50:02AM -0400, Jeff Layton wrote:
> > > > > > > On Tue, 2022-08-30 at 09:24 -0400, J. Bruce Fields wrote:
> > > > > > > > On Tue, Aug 30, 2022 at 07:40:02AM -0400, Jeff Layton
> > > > > > > > wrote:
> > > > > > > > > Yes, saying only that it must be different is
> > > > > > > > > intentional.
> > > > > > > > > What
> > > > > > > > > we
> > > > > > > > > really want is for consumers to treat this as an opaque
> > > > > > > > > value
> > > > > > > > > for the
> > > > > > > > > most part [1]. Therefore an implementation based on
> > > > > > > > > hashing
> > > > > > > > > would
> > > > > > > > > conform to the spec, I'd think, as long as all of the
> > > > > > > > > relevant
> > > > > > > > > info is
> > > > > > > > > part of the hash.
> > > > > > > >=20
> > > > > > > > It'd conform, but it might not be as useful as an
> > > > > > > > increasing
> > > > > > > > value.
> > > > > > > >=20
> > > > > > > > E.g. a client can use that to work out which of a series
> > > > > > > > of
> > > > > > > > reordered
> > > > > > > > write replies is the most recent, and I seem to recall
> > > > > > > > that
> > > > > > > > can
> > > > > > > > prevent
> > > > > > > > unnecessary invalidations in some cases.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > That's a good point; the linux client does this. That said,
> > > > > > > NFSv4
> > > > > > > has a
> > > > > > > way for the server to advertise its change attribute
> > > > > > > behavior
> > > > > > > [1]
> > > > > > > (though nfsd hasn't implemented this yet).
> > > > > >=20
> > > > > > It was implemented and reverted.=A0 The issue was that I
> > > > > > thought
> > > > > > nfsd
> > > > > > should mix in the ctime to prevent the change attribute going
> > > > > > backwards
> > > > > > on reboot (see fs/nfsd/nfsfh.h:nfsd4_change_attribute()), but
> > > > > > Trond
> > > > > > was
> > > > > > concerned about the possibility of time going backwards.=A0 See
> > > > > > 1631087ba872 "Revert "nfsd4: support change_attr_type
> > > > > > attribute"".
> > > > > > There's some mailing list discussion to that I'm not turning
> > > > > > up
> > > > > > right
> > > > > > now.
> > > >=20
> > > > https://lore.kernel.org/linux-nfs/a6294c25cb5eb98193f609a52aa8f4b5d=
4e81279.camel@hammerspace.com/
> > > > is what I was thinking of but it isn't actually that interesting.
> > > >=20
> > > > > My main concern was that some filesystems (e.g. ext3) were
> > > > > failing
> > > > > to
> > > > > provide sufficient timestamp resolution to actually label the
> > > > > resulting
> > > > > 'change attribute' as being updated monotonically. If the time
> > > > > stamp
> > > > > doesn't change when the file data or metadata are changed, then
> > > > > the
> > > > > client has to perform extra checks to try to figure out whether
> > > > > or
> > > > > not
> > > > > its caches are up to date.
> > > >=20
> > > > That's a different issue from the one you were raising in that
> > > > discussion.
> > > >=20
> > > > > > Did NFSv4 add change_attr_type because some implementations
> > > > > > needed
> > > > > > the
> > > > > > unordered case, or because they realized ordering was useful
> > > > > > but
> > > > > > wanted
> > > > > > to keep backwards compatibility?=A0 I don't know which it was.
> > > > >=20
> > > > > We implemented it because, as implied above, knowledge of
> > > > > whether
> > > > > or
> > > > > not the change attribute behaves monotonically, or strictly
> > > > > monotonically, enables a number of optimisations.
> > > >=20
> > > > Of course, but my question was about the value of the old
> > > > behavior,
> > > > not
> > > > about the value of the monotonic behavior.
> > > >=20
> > > > Put differently, if we could redesign the protocol from scratch
> > > > would
> > > > we
> > > > actually have included the option of non-monotonic behavior?
> > > >=20
> > >=20
> > > If we could design the filesystems from scratch, we probably would
> > > not.
> > > The protocol ended up being as it is because people were trying to
> > > make
> > > it as easy to implement as possible.
> > >=20
> > > So if we could design the filesystem from scratch, we would have
> > > probably designed it along the lines of what AFS does.
> > > i.e. each explicit change is accompanied by a single bump of the
> > > change
> > > attribute, so that the clients can not only decide the order of the
> > > resulting changes, but also if they have missed a change (that
> > > might
> > > have been made by a different client).
> > >=20
> > > However that would be a requirement that is likely to be very
> > > specific
> > > to distributed caches (and hence distributed filesystems). I doubt
> > > there are many user space applications that would need that high
> > > precision. Maybe MPI, but that's the only candidate I can think of
> > > for
> > > now?
> > >=20
> >=20
> > The fact that NFS kept this more loosely-defined is what allowed us
> > to
> > elide some of the i_version bumps and regain a fair bit of
> > performance
> > for local filesystems [1]. If the change attribute had been more
> > strictly defined like you mention, then that particular optimization
> > would not have been possible.
> >=20
> > This sort of thing is why I'm a fan of not defining this any more
> > strictly than we require. Later on, maybe we'll come up with a way
> > for
> > filesystems to advertise that they can offer stronger guarantees.
>=20
> What 'eliding of the bumps' are we talking about here? If it results in
> unreliable behaviour, then I propose we just drop the whole concept and
> go back to using the ctime. The change attribute is only useful if it
> results in a reliable mechanism for detecting changes. Once you "elide
> away" the word "reliable", then it has no value beyond what ctime
> already does.
>=20

I'm talking about the scheme to optimize away i_version updates when the
current one has never been queried:

    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Df02a9ad1f15d

There's nothing unreliable about it.
--=20
Jeff Layton <jlayton@kernel.org>
