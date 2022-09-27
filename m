Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E5A5EC459
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 15:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiI0NX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 09:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiI0NWu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:22:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767151B2D13;
        Tue, 27 Sep 2022 06:18:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62FDEB81BE5;
        Tue, 27 Sep 2022 13:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FECC43141;
        Tue, 27 Sep 2022 13:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664284726;
        bh=75r45GYNmdQ6TGZtVM1PaqeQt62nqyjqpVvH5ey6w3w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fl/6F/CbEzRJTGc0S8S+u4io0/U1Y20LUrcV8EI3ai8sfiZq7a4r0+QeC02bKrgC4
         7HLpeekjBIf7338lAJOzta/LOslAVVelG3jIV1Lvn6wCxaW7H+tOwrFkKYSVJIeAz8
         /Dns3spD7Duj6yT0m9RoAt8Ok1gNZQmxjyeybUAIEzuijiFrg6vhwlJ5lZy6iCXJr7
         XaUkai7saTAfwQ7h38pJ0iO5LTsAKKJO2EcfaHan35eEHdu3BlHxlrm+iLEsC8YZtA
         wYCyXxLU7CInTWkFKw/JgXdTP65K/aQBbe0kZCxmfO6ZROiBEORjT7PgdJKddfO079
         J+SzYeeiBsV9Q==
Message-ID: <6012013b1fd92e5dad7927d8133d5d5b3cd76e3f.camel@kernel.org>
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
Date:   Tue, 27 Sep 2022 09:18:42 -0400
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
> While we agree that the current implementation of i_version is
> imperfect, it isn't causing major data corruption all around the world.
> I don't think there are even any known bug reports are there?
> So while we do want to fix it as best we can, we don't need to make that
> the first priority.
>=20
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
> Then we can explore some options for handling unclean restart - in a
> context where we can write tests and maybe even demonstrate a concrete
> problem before we start trying to fix it.
>=20

We can also argue that crash resilience isn't a hard requirement for all
possible applications. We'll definitely need some sort of mitigation for
nfsd so we can claim that it's MONOTONIC [1], but local applications may
not care whether the value rolls backward after a crash, since they
would have presumably crashed as well and may not be persisting values.

IOW, I think I agree with Dave C. that crash resilience for regular
files is best handled at the application level (with the first
application being knfsd). RFC 7862 requires that the change_attr_type be
homogeneous across the entire filesystem, so we don't have the option of
deciding that on a per-inode basis. If we want to advertise it, we have
ensure that all inode types conform.

I think for nfsd, a crash counter tracked in userland by nfsdcld
multiplied by some large number of reasonable version bumps in a jiffy
would work well and allow us to go back to advertising the value as
MONOTONIC.=A0That's a bit of a project though and may take a while.

For presentation via statx, maybe we can create a
STATX_ATTR_VERSION_MONOTONIC bit for stx_attributes for when the
filesystem can provide that sort of guarantee. I may just add that
internally for now anyway, since that would make for nicer layering.

[1]: https://datatracker.ietf.org/doc/html/rfc7862#section-12.2.3
--=20
Jeff Layton <jlayton@kernel.org>
