Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8E559EFC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 01:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiHWXmb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 19:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHWXma (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 19:42:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8368512D09;
        Tue, 23 Aug 2022 16:42:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4E1C522DEE;
        Tue, 23 Aug 2022 23:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661298147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mf7FYVg+p3n1ZzY3dE3fTI4r38K9m9zJQ3Gw2K+VYH4=;
        b=wBkZNzNScsOzP10MLgrykcXVKvQlPGQm0X1gzLLlQJH5oBuIA/9UEqOtnpPdvCIvaCsNin
        Yr4JqjyFuqjlNh3c1DKDfNWfOoZcU7d7ALuG/+41ULFflSlUEuH3BUIBp3idw2GqQ0whih
        iteMF7eWMMj/wCLwIpdTaeTiHb7DYWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661298147;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mf7FYVg+p3n1ZzY3dE3fTI4r38K9m9zJQ3Gw2K+VYH4=;
        b=5Ou6IYEXHZV+8gZL4+aWoPqmV6ShSBFcp5ZtcC1seUWaW4pxLyruGtX89xHRAyyb4P/9nO
        7ugKlTr/CzaAs5BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A060813AB7;
        Tue, 23 Aug 2022 23:42:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZNKLF99lBWN9PQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 23 Aug 2022 23:42:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Dave Chinner" <david@fromorbit.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Mimi Zohar" <zohar@linux.ibm.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        "Trond Myklebust" <trondmy@hammerspace.com>
Subject: Re: [PATCH] iversion: update comments with info about atime updates
In-reply-to: <20220823232832.GQ3600936@dread.disaster.area>
References: <20220822133309.86005-1-jlayton@kernel.org>,
 <ceb8f09a4cb2de67f40604d03ee0c475feb3130a.camel@linux.ibm.com>,
 <f17b9d627703bee2a7b531a051461671648a9dbd.camel@kernel.org>,
 <18827b350fbf6719733fda814255ec20d6dcf00f.camel@linux.ibm.com>,
 <4cc84440d954c022d0235bf407a60da66a6ccc39.camel@kernel.org>,
 <20220822233231.GJ3600936@dread.disaster.area>,
 <6cbcb33d33613f50dd5e485ecbf6ce7e305f3d6f.camel@kernel.org>,
 <166125468756.23264.2859374883806269821@noble.neil.brown.name>,
 <df469d936b2e1c1a8c9c947896fa8a160f33b0e8.camel@kernel.org>,
 <166129348704.23264.10381335282721356873@noble.neil.brown.name>,
 <20220823232832.GQ3600936@dread.disaster.area>
Date:   Wed, 24 Aug 2022 09:42:18 +1000
Message-id: <166129813890.23264.7939069509747685028@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 24 Aug 2022, Dave Chinner wrote:
> On Wed, Aug 24, 2022 at 08:24:47AM +1000, NeilBrown wrote:
> > On Tue, 23 Aug 2022, Jeff Layton wrote:
> > > On Tue, 2022-08-23 at 21:38 +1000, NeilBrown wrote:
> > > > On Tue, 23 Aug 2022, Jeff Layton wrote:
> > > > > So, we can refer to that and simply say:
> > > > >=20
> > > > > "If the function updates the mtime or ctime on the inode, then the
> > > > > i_version should be incremented. If only the atime is being updated,
> > > > > then the i_version should not be incremented. The exception to this=
 rule
> > > > > is explicit atime updates via utimes() or similar mechanism, which
> > > > > should result in the i_version being incremented."
> > > >=20
> > > > Is that exception needed?  utimes() updates ctime.
> > > >=20
> > > > https://man7.org/linux/man-pages/man2/utimes.2.html
> > > >=20
> > > > doesn't say that, but
> > > >=20
> > > > https://pubs.opengroup.org/onlinepubs/007904875/functions/utimes.html
> > > >=20
> > > > does, as does the code.
> > > >=20
> > >=20
> > > Oh, good point! I think we can leave that out. Even better!
> >=20
> > Further, implicit mtime updates (file_update_time()) also update ctime.
> > So all you need is
> >    If the function updates the ctime, then i_version should be
> >    incremented.
> >=20
> > and I have to ask - why not just use the ctime?  Why have another number
> > that is parallel?
> >=20
> > Timestamps are updated at HZ (ktime_get_course) which is at most every
> > millisecond.
>=20
> Kernel time, and therefore timestamps, can go backwards.

Yes, and when that happens you get to keep both halves...

For NFSv4 I really don't think that matters.  If it happened every day,
that might be a problem.  Even if it happens as a consequence of normal
operations it might be a problem.  But it can only happen if something
goes wrong.

Mostly, NFSv4 only needs to changeid to change.  If the kernel time goes
backwards it is possible that a changeid will repeat, though unlikely.
It is even possible that a client will see the first and second
instances of that repeat, and assume there is no change in between - but
that is astronomically unlikely.  "touch"ing the file or remounting will
fix that.

When a write delegation is in force (which Linux doesn't currently offer
and no-one seems to care about, but maybe one day), the client is
allowed to update the changeid, and when the delegation is returned, the
server is supposed to ensure the new changeid is at least the last one
assigned by the client.  This is the only reason that it is defined as
being monotonic (rather than just "non-repeating") - so the client and
server can change it in the same way.

So while kernel time going backwards is theoretically less than ideal,
it is not practically a problem.

NeilBrown
