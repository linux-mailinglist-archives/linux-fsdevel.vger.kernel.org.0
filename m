Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BD35B9FD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 18:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiIOQpr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 12:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiIOQpj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:45:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2414F3B4;
        Thu, 15 Sep 2022 09:45:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27F8662564;
        Thu, 15 Sep 2022 16:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5302EC433D6;
        Thu, 15 Sep 2022 16:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663260336;
        bh=7QoGPp9vcUcB7hhq18SRD+bpB1C1+NfYZZj7FAZ+E6M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=W9rgNJ3SH7gXXgofN1CZth0elGN3abwdqgo2Y0QWRD8eUiSpo+Y206ovGRYQfqui0
         q5xxRGnTsy6dzWM+neWHODXDMDnV8+DvNG5Mvkmpg9ygkX/57vfwUXyzNrcUzk5lvf
         BSbX2qCxR6tAQ182JQVnx28qST05Z8cBNxn1PEcu9k1YTEHlicuihj88WrVaZ3/7nR
         cTm/ZCZSAQ3vOH7tYLWPyWVX0lwQIhX9fQyD0YL03uge+2XKGqUJXUR7pvaR/++ezg
         225t/vogg+gUbu/v+PCFQqXhd2O8Bv3YbvtAgiXaSe9+HT2bjV16fhDd2uzPS4H7M7
         lOcBnwZO87Lvg==
Message-ID: <1a968b8e87f054e360877c9ab8cdfc4cfdfc8740.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "neilb@suse.de" <neilb@suse.de>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Date:   Thu, 15 Sep 2022 12:45:32 -0400
In-Reply-To: <577b6d8a7243aeee37eaa4bbb00c90799586bc48.camel@hammerspace.com>
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

On Thu, 2022-09-15 at 15:08 +0000, Trond Myklebust wrote:
> On Thu, 2022-09-15 at 10:06 -0400, J. Bruce Fields wrote:
> > On Tue, Sep 13, 2022 at 09:14:32AM +1000, NeilBrown wrote:
> > > On Mon, 12 Sep 2022, J. Bruce Fields wrote:
> > > > On Sun, Sep 11, 2022 at 08:13:11AM +1000, NeilBrown wrote:
> > > > > On Fri, 09 Sep 2022, Jeff Layton wrote:
> > > > > >=20
> > > > > > The machine crashes and comes back up, and we get a query for
> > > > > > i_version
> > > > > > and it comes back as X. Fine, it's an old version. Now there
> > > > > > is a write.
> > > > > > What do we do to ensure that the new value doesn't collide
> > > > > > with X+1?=20
> > > > >=20
> > > > > (I missed this bit in my earlier reply..)
> > > > >=20
> > > > > How is it "Fine" to see an old version?
> > > > > The file could have changed without the version changing.
> > > > > And I thought one of the goals of the crash-count was to be
> > > > > able to
> > > > > provide a monotonic change id.
> > > >=20
> > > > I was still mainly thinking about how to provide reliable close-
> > > > to-open
> > > > semantics between NFS clients.=A0 In the case the writer was an NFS
> > > > client, it wasn't done writing (or it would have COMMITted), so
> > > > those
> > > > writes will come in and bump the change attribute soon, and as
> > > > long as
> > > > we avoid the small chance of reusing an old change attribute,
> > > > we're OK,
> > > > and I think it'd even still be OK to advertise
> > > > CHANGE_TYPE_IS_MONOTONIC_INCR.
> > >=20
> > > You seem to be assuming that the client doesn't crash at the same
> > > time
> > > as the server (maybe they are both VMs on a host that lost
> > > power...)
> > >=20
> > > If client A reads and caches, client B writes, the server crashes
> > > after
> > > writing some data (to already allocated space so no inode update
> > > needed)
> > > but before writing the new i_version, then client B crashes.
> > > When server comes back the i_version will be unchanged but the data
> > > has
> > > changed.=A0 Client A will cache old data indefinitely...
> >=20
> > I guess I assume that if all we're promising is close-to-open, then a
> > client isn't allowed to trust its cache in that situation.=A0 Maybe
> > that's
> > an overly draconian interpretation of close-to-open.
> >=20
> > Also, I'm trying to think about how to improve things incrementally.
> > Incorporating something like a crash count into the on-disk i_version
> > fixes some cases without introducing any new ones or regressing
> > performance after a crash.
> >=20
> > If we subsequently wanted to close those remaining holes, I think
> > we'd
> > need the change attribute increment to be seen as atomic with respect
> > to
> > its associated change, both to clients and (separately) on disk.=A0
> > (That
> > would still allow the change attribute to go backwards after a crash,
> > to
> > the value it held as of the on-disk state of the file.=A0 I think
> > clients
> > should be able to deal with that case.)
> >=20
> > But, I don't know, maybe a bigger hammer would be OK:
> >=20
>=20
> If you're not going to meet the minimum bar of data integrity, then
> this whole exercise is just a massive waste of everyone's time. The
> answer then going forward is just to recommend never using Linux as an
> NFS server. Makes my life much easier, because I no longer have to
> debug any of the issues.
>=20
>=20

To be clear, you believe any scheme that would allow the client to see
an old change attr after a crash is insufficient?

The only way I can see to fix that (at least with only a crash counter)
would be to factor it in at presentation time like Neil suggested.
Basically we'd just mask off the top 16 bits and plop the crash counter
in there before presenting it.

In principle, I suppose we could do that at the nfsd level as well (and
that might be the simplest way to fix this). We probably wouldn't be
able to advertise a change attr type of MONOTONIC with this scheme
though.
--=20
Jeff Layton <jlayton@kernel.org>
