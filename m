Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CAD5B5AA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 14:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiILMzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 08:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiILMz3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:55:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62386101F9;
        Mon, 12 Sep 2022 05:55:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B02C7611E4;
        Mon, 12 Sep 2022 12:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91E9C433C1;
        Mon, 12 Sep 2022 12:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662987308;
        bh=kXVl3lKGhuGMB8e8q0RvmHygAe7Nq48CUY69vkKdMNw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LSPyR/AGEvllwX8KzbZK8QLpzGQtSj8nQM5ONoAzIq54XZLFnZ7SrmnP+cfaRQ+nS
         phTff8vWAEihEOnYF9G89DfKxUUfX3K4BBiBqGpc5gfn3X5mhy8/jDg92GRproCe6L
         Jm7sz55mjQ07qJlwM2lc1Pd1OjOPykqy6rWb14Pl4iGhwsLId0QYizMl4dP2HGTBb9
         kwayjFy56Ogq7SybiITPST8FdEyP9vstDvIWuFlwHPFO6f/QOC8SpScApFo6yPnWLd
         FuDBKBF5U2U6jv3QBn/w0V7PjG0kxDYoZM1WlAncS3bUEjIknhtrlECkhUkWU7Q0L/
         USm1GJ8xJ1pkw==
Message-ID: <7c71050e139a479e08ab7cf95e9e47da19a30687.camel@kernel.org>
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
Date:   Mon, 12 Sep 2022 08:55:04 -0400
In-Reply-To: <87a67423la.fsf@oldenburg.str.redhat.com>
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

On Mon, 2022-09-12 at 14:13 +0200, Florian Weimer wrote:
> * Jeff Layton:
>=20
> > To do this we'd need 2 64-bit fields in the on-disk and in-memory=20
> > superblocks for ext4, xfs and btrfs. On the first mount after a crash,
> > the filesystem would need to bump s_version_max by the significant
> > increment (2^40 bits or whatever). On a "clean" mount, it wouldn't need
> > to do that.
> >=20
> > Would there be a way to ensure that the new s_version_max value has mad=
e
> > it to disk? Bumping it by a large value and hoping for the best might b=
e
> > ok for most cases, but there are always outliers, so it might be
> > worthwhile to make an i_version increment wait on that if necessary.=
=20
>=20
> How common are unclean shutdowns in practice?  Do ex64/XFS/btrfs keep
> counters in the superblocks for journal replays that can be read easily?
>=20
> Several useful i_version applications could be negatively impacted by
> frequent i_version invalidation.
>=20

One would hope "not very often", but Oopses _are_ something that happens
occasionally, even in very stable environments, and it would be best if
what we're building can cope with them. Consider:

reader				writer
----------------------------------------------------------
start with i_version 1
				inode updated in memory, i_version++
query, get i_version 2

 <<< CRASH : update never makes it to disk, back at 1 after reboot >>>

query, get i_version 1
				application restarts and redoes write, i_version at 2^40+1
query, get i_version 2^40+1=20

The main thing we have to avoid here is giving out an i_version that
represents two different states of the same inode. This should achieve
that.

Something else we should consider though is that with enough crashes on
a long-lived filesystem, the value could eventually wrap. I think we
should acknowledge that fact in advance, and plan to deal with it
(particularly if we're going to expose this to userland eventually).

Because of the "seen" flag, we have a 63 bit counter to play with. Could
we use a similar scheme to the one we use to handle when "jiffies"
wraps?=A0Assume that we'd never compare two values that were more than
2^62 apart? We could add i_version_before/i_version_after macros to make
it simple to handle this.
--=20
Jeff Layton <jlayton@kernel.org>
