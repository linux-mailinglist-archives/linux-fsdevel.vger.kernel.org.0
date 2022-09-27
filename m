Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC435EC0C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 13:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiI0LPE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 07:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiI0LOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:14:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB9215FEA;
        Tue, 27 Sep 2022 04:14:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D152EB81B10;
        Tue, 27 Sep 2022 11:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C55C433D6;
        Tue, 27 Sep 2022 11:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664277272;
        bh=5RonbP18IW8Z1fzGmvbzApRwvceRQaHvox4MafxU4WM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jPMifld9Bgt7hQQIZP4NRfbCWgUUNzwL6HS1//AyhPQuhCxgajDcxDDX/IjN3dzp0
         aRijbdoPQLxecjpIv+XrikW9FVpKmVIt9XrPx83dZDoJRtO4rA2tfDGL5+jPOOGXHE
         dBCMMpfl3TQY1hcxDVcLgkN3iZVUrmcvpwoT7lvIkWVp28WHlg0DtaD3Cell82dfvc
         RZJonJLYZbRRBIuz7w8Gy5LPXTUemXiCsxLPbXXIyyVClhIpq7JzhX7+Nu48q9Mgcl
         Z2oQfGygH6flhHdLwADKaxx8/xQHSoeHKDHRSkCJXRDLwP6zG8b+dzYIaWTQet5NZc
         7bvm2jVgTJhgQ==
Message-ID: <32723e738a37806a76b9c346295b9464f45f410b.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
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
Date:   Tue, 27 Sep 2022 07:14:28 -0400
In-Reply-To: <166423223623.17572.7229091435446226718@noble.neil.brown.name>
References: <24005713ad25370d64ab5bd0db0b2e4fcb902c1c.camel@kernel.org>
        , <20220918235344.GH3600936@dread.disaster.area>
        , <87fb43b117472c0a4c688c37a925ac51738c8826.camel@kernel.org>
        , <20220920001645.GN3600936@dread.disaster.area>
        , <5832424c328ea427b5c6ecdaa6dd53f3b99c20a0.camel@kernel.org>
        , <20220921000032.GR3600936@dread.disaster.area>
        , <93b6d9f7cf997245bb68409eeb195f9400e55cd0.camel@kernel.org>
        , <20220921214124.GS3600936@dread.disaster.area>
        , <e04e349170bc227b330556556d0592a53692b5b5.camel@kernel.org>
        , <1ef261e3ff1fa7fcd0d75ed755931aacb8062de2.camel@kernel.org>
        , <20220923095653.5c63i2jgv52j3zqp@quack3>
        , <2d41c08e1fd96d55c794c3b4cd43a51a0494bfcf.camel@hammerspace.com>
        , <baf852dfb57aaf5a670bc88236f8d62c99668fcc.camel@kernel.org>
         <166423223623.17572.7229091435446226718@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-09-27 at 08:43 +1000, NeilBrown wrote:
> On Fri, 23 Sep 2022, Jeff Layton wrote:
> >=20
> > Absolutely. That is the downside of this approach, but the priority her=
e
> > has always been to improve nfsd. If we don't get the ability to present
> > this info via statx, then so be it. Later on, I suppose we can move tha=
t
> > handling into the kernel in some fashion if we decide it's worthwhile.
> >=20
> > That said, not having this in statx makes it more difficult to test
> > i_version behavior. Maybe we can add a generic ioctl for that in the
> > interim?
>=20
> I wonder if we are over-thinking this, trying too hard, making "perfect"
> the enemy of "good".

I tend to think we are.

> While we agree that the current implementation of i_version is
> imperfect, it isn't causing major data corruption all around the world.
> I don't think there are even any known bug reports are there?
> So while we do want to fix it as best we can, we don't need to make that
> the first priority.
>=20

I'm not aware of any bug reports aside from the issue of atime updates
affecting the change attribute, but the effects of misbehavior here can
be very subtle.


> I think the first priority should be to document how we want it to work,
> which is what this thread is really all about.  The documentation can
> note that some (all) filesystems do not provide perfect semantics across
> unclean restarts, and can list any other anomalies that we are aware of.
> And on that basis we can export the current i_version to user-space via
> statx and start trying to write some test code.
>=20
> We can then look at moving the i_version/ctime update from *before* the
> write to *after* the write, and any other improvements that can be
> achieved easily in common code.  We can then update the man page to say
> "since Linux 6.42, this list of anomalies is no longer present".
>=20

I have a patch for this for ext4, and started looking at the same for
btrfs and xfs.

> Then we can explore some options for handling unclean restart - in a
> context where we can write tests and maybe even demonstrate a concrete
> problem before we start trying to fix it.
>=20

I think too that we need to recognize that there are multiple distinct
issues around i_version handling:

1/ atime updates affecting i_version in ext4 and xfs, which harms
performance

2/ ext4 should enable the change attribute by default

3/ we currently mix the ctime into the change attr for directories,
which is unnecessary.

4/ we'd like to be able to report NFS4_CHANGE_TYPE_IS_MONOTONIC_INCR
from nfsd, but the change attr on regular files can appear to go
backward after a crash+clock jump.

5/ testing i_version behavior is very difficult since there is no way to
query it from userland.

We can work on the first three without having to solve the last two
right away.
--=20
Jeff Layton <jlayton@kernel.org>
