Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A7A59FA8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 14:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbiHXMyA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 08:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbiHXMx6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:53:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B7995E4F;
        Wed, 24 Aug 2022 05:53:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 828B16138B;
        Wed, 24 Aug 2022 12:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8C2C433D6;
        Wed, 24 Aug 2022 12:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661345635;
        bh=9qKTFfSvvv3odyymWozZ3aH/e3Es4L33cC41zZfYrDE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Hk1K3btiYElGBvohLpvnxQA2OisfrjMc8S/kg7OoZJF85mm9jLVcvTTAZ2Lw3evSf
         +sk8cPvrEnDfRUlkNaDMbeNAim0UmwOmrY2pIWcRft2vYW4uPpmhpNvFOWSEFl9mf3
         QLay6v3wIZsAU5jfFCs7L1BJGnXS/W03OFJ0YDMp4gY37+neRradBW1qYmAIK/3vXZ
         rH0cBEQjhvbko4l7YDHO4ZvHkKsW6ii/iQNe7zRcOO0XiedDIeQ1GB55rvhtyCgtDT
         MTwkOUMyoB8htAc5+QUeCwDFg2s1hrRx+bU8zr99viJWCFLcJrbgo2GNfUpBcdOvDe
         UEdrfsdXKJDGw==
Message-ID: <5f248d934ec5d2345986fd75d7d12bcd9e2f32b9.camel@kernel.org>
Subject: Re: [PATCH] iversion: update comments with info about atime updates
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Wed, 24 Aug 2022 08:53:53 -0400
In-Reply-To: <166129348704.23264.10381335282721356873@noble.neil.brown.name>
References: <20220822133309.86005-1-jlayton@kernel.org>
        , <ceb8f09a4cb2de67f40604d03ee0c475feb3130a.camel@linux.ibm.com>
        , <f17b9d627703bee2a7b531a051461671648a9dbd.camel@kernel.org>
        , <18827b350fbf6719733fda814255ec20d6dcf00f.camel@linux.ibm.com>
        , <4cc84440d954c022d0235bf407a60da66a6ccc39.camel@kernel.org>
        , <20220822233231.GJ3600936@dread.disaster.area>
        , <6cbcb33d33613f50dd5e485ecbf6ce7e305f3d6f.camel@kernel.org>
        , <166125468756.23264.2859374883806269821@noble.neil.brown.name>
        , <df469d936b2e1c1a8c9c947896fa8a160f33b0e8.camel@kernel.org>
         <166129348704.23264.10381335282721356873@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-08-24 at 08:24 +1000, NeilBrown wrote:
> On Tue, 23 Aug 2022, Jeff Layton wrote:
> > On Tue, 2022-08-23 at 21:38 +1000, NeilBrown wrote:
> > > On Tue, 23 Aug 2022, Jeff Layton wrote:
> > > > So, we can refer to that and simply say:
> > > >=20
> > > > "If the function updates the mtime or ctime on the inode, then the
> > > > i_version should be incremented. If only the atime is being updated=
,
> > > > then the i_version should not be incremented. The exception to this=
 rule
> > > > is explicit atime updates via utimes() or similar mechanism, which
> > > > should result in the i_version being incremented."
> > >=20
> > > Is that exception needed? utimes() updates ctime.
> > >=20
> > > https://man7.org/linux/man-pages/man2/utimes.2.html
> > >=20
> > > doesn't say that, but
> > >=20
> > > https://pubs.opengroup.org/onlinepubs/007904875/functions/utimes.html
> > >=20
> > > does, as does the code.
> > >=20
> >=20
> > Oh, good point! I think we can leave that out. Even better!
>=20
> Further, implicit mtime updates (file_update_time()) also update ctime.
> So all you need is
>  If the function updates the ctime, then i_version should be
>  incremented.
>=20
> and I have to ask - why not just use the ctime? Why have another number
> that is parallel?
>=20
> Timestamps are updated at HZ (ktime_get_course) which is at most every
> millisecond.
> xfs stores nanosecond resolution, so about 20 bits are currently wasted.
> We could put a counter like i_version in there that only increments
> after it is viewed, then we can get all the precision we need but with
> exactly ctime semantics.
>=20
> The 64 change-id could comprise
>  35 bits of seconds (nearly a millenium)
>  16 bits of sub-seconds (just in case a higher precision time was wanted
>  one day)
>  13 bits of counter. - 8192 changes per tick

We'd need a "seen" flag too, so maybe only 4096 changes per tick...

>=20
> The value exposed in i_ctime would hide the counter and just show the
> timestamp portion of what the filesystem stores. This would ensure we
> never get changes on different files that happen in one order leaving
> timestamps with the reversed order (the timestamps could be the same,
> but that is expected).
>=20
> This scheme could be made to handle a sustained update rate of 1
> increment every 8 nanoseconds (if the counter were allowed to overflow
> into unused bits of the sub-second field). This is one ever 24 CPU
> cycles. Incrementing a counter and making it visible to all CPUs can
> probably be done in 24 cycles. Accessing it and setting the "seen" flag
> as well might just fit with faster memory. Getting any other useful
> work done while maintaining that rate on a single file seems unlikely.

This is an interesting idea.

So, for NFSv4 you'd just mask off the counter bits (and "seen" flag) to
get the ctime, and for the change attribute we'd just mask off the
"seen" flag and put it all in there.

 * Implementing that for all filesystems would be a huge project though.
   If we were implementing the i_version counter from scratch, I'd
   probably do something along these lines. Given that we already have
   an existing i_version counter, would there be any real benefit to
   pursuing this avenue instead?
--=20
Jeff Layton <jlayton@kernel.org>
