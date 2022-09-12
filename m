Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18D05B5B96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 15:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiILNtt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 09:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiILNtr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:49:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A81647B;
        Mon, 12 Sep 2022 06:49:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DD6661127;
        Mon, 12 Sep 2022 13:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6D4C433C1;
        Mon, 12 Sep 2022 13:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662990581;
        bh=cE0fgTzS2xHuhEez4lyRXI9w5uwXw4cYpWRlU0GijPI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oA1g1mw0vEX9gcB3Pfa63ixHHTfSnpPK0kg5uxN3YeeGXuLuQuB/5sSFYY9FbUvHH
         /vWR87xqr72Wggpo544fiS63/BMSGpryhGTY/XEDRpDLw112+e6lBAOKWc0ZzP3Ii+
         iye4kKiENNqZwVUHxPy31lgXw9CYc405bTnobe905KGU9Mor+qmdmv5e4wh2SmJ56n
         xOvweRvVp1T2ky9cTcG7OW1Fgdr9HseEO1gzbSdzRO56wIhpHtTlr0vJCCnY6uI83t
         Hk0qB2r60r4DCWnwxdsbqg5SM+0TcOp/z1SOCrSNQXXP9j4Y13y0jL75n/L6jRGZJ+
         N9dPHQ9y4214w==
Message-ID: <8c096b3ec41b1ea3de69da038064087fd0fa481f.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.de>, adilger.kernel@dilger.ca,
        djwong@kernel.org, david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, brauner@kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Date:   Mon, 12 Sep 2022 09:49:38 -0400
In-Reply-To: <875yhs20gh.fsf@oldenburg.str.redhat.com>
References: <166259786233.30452.5417306132987966849@noble.neil.brown.name>
         <20220908083326.3xsanzk7hy3ff4qs@quack3> <YxoIjV50xXKiLdL9@mit.edu>
         <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
         <20220908155605.GD8951@fieldses.org>
         <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
         <20220908182252.GA18939@fieldses.org>
         <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
         <20220909154506.GB5674@fieldses.org>
         <125df688dbebaf06478b0911e76e228e910b04b3.camel@kernel.org>
         <20220910145600.GA347@fieldses.org>
         <9eaed9a47d1aef11fee95f0079e302bc776bc7ff.camel@kernel.org>
         <87a67423la.fsf@oldenburg.str.redhat.com>
         <7c71050e139a479e08ab7cf95e9e47da19a30687.camel@kernel.org>
         <875yhs20gh.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 2022-09-12 at 15:20 +0200, Florian Weimer wrote:
> * Jeff Layton:
>=20
> > On Mon, 2022-09-12 at 14:13 +0200, Florian Weimer wrote:
> > > * Jeff Layton:
> > >=20
> > > > To do this we'd need 2 64-bit fields in the on-disk and in-memory=
=20
> > > > superblocks for ext4, xfs and btrfs. On the first mount after a cra=
sh,
> > > > the filesystem would need to bump s_version_max by the significant
> > > > increment (2^40 bits or whatever). On a "clean" mount, it wouldn't =
need
> > > > to do that.
> > > >=20
> > > > Would there be a way to ensure that the new s_version_max value has=
 made
> > > > it to disk? Bumping it by a large value and hoping for the best mig=
ht be
> > > > ok for most cases, but there are always outliers, so it might be
> > > > worthwhile to make an i_version increment wait on that if necessary=
.=20
> > >=20
> > > How common are unclean shutdowns in practice?  Do ex64/XFS/btrfs keep
> > > counters in the superblocks for journal replays that can be read easi=
ly?
> > >=20
> > > Several useful i_version applications could be negatively impacted by
> > > frequent i_version invalidation.
> > >=20
> >=20
> > One would hope "not very often", but Oopses _are_ something that happen=
s
> > occasionally, even in very stable environments, and it would be best if
> > what we're building can cope with them.
>=20
> I was wondering if such unclean shutdown events are associated with SSD
> =E2=80=9Cunsafe shutdowns=E2=80=9D, as identified by the SMART counter.  =
I think those
> aren't necessarily restricted to oopses or various forms of powerless
> (maybe depending on file system/devicemapper configuration)?
>=20
> I admit it's possible that the file system is shut down cleanly before
> the kernel requests the power-off state from the firmware, but the
> underlying SSD is not.
>=20

Yeah filesystem integrity is mostly what we're concerned with here.

I think most local filesystems effectively set a flag in the superblock
that is cleared when the it's cleanly unmounted. If that flag is set
when you go to mount then you know there was a crash. We'd probably key
off of that in some way internally.
--=20
Jeff Layton <jlayton@kernel.org>
