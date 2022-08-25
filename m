Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053205A050A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 02:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiHYARV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 20:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiHYART (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 20:17:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1DC6D559;
        Wed, 24 Aug 2022 17:17:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9F0D55C167;
        Thu, 25 Aug 2022 00:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661386636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=se5jWXIzFtpgRYm/ZgsUL2TuX6cQdVJ2jx4NrHnS5Qo=;
        b=QJuIpxPKfyh2tlQhlVwToDBZZTeevLVIMa4GUkq0MvKSOAYs3AkmuxXPszKu9s/p1RPRDb
        TfAJ1+TL3nFnoDE+teRnQtl4ti3H+UECG7S+PyOx6OKmCZDEr1NzLaciqxaw/g6ypyez5g
        xxgVSbdo4p1PZzICsnsrARPfGAkP+HM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661386636;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=se5jWXIzFtpgRYm/ZgsUL2TuX6cQdVJ2jx4NrHnS5Qo=;
        b=J+HbTfCHYrnr78czRZrbfy8ON9Uv8NH80LcoLBmC/GUseZqk1slWtu2vfxWC9lti3CYJgW
        c/vID/+Kx2QfKPBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71D9D13A47;
        Thu, 25 Aug 2022 00:17:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I9TiCom/BmM/TgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 25 Aug 2022 00:17:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Dave Chinner" <david@fromorbit.com>,
        "Mimi Zohar" <zohar@linux.ibm.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        "Trond Myklebust" <trondmy@hammerspace.com>
Subject: Re: [PATCH] iversion: update comments with info about atime updates
In-reply-to: <5f248d934ec5d2345986fd75d7d12bcd9e2f32b9.camel@kernel.org>
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
 <5f248d934ec5d2345986fd75d7d12bcd9e2f32b9.camel@kernel.org>
Date:   Thu, 25 Aug 2022 10:17:09 +1000
Message-id: <166138662999.27490.2273361647379875097@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 24 Aug 2022, Jeff Layton wrote:
> On Wed, 2022-08-24 at 08:24 +1000, NeilBrown wrote:
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
> > > > Is that exception needed? utimes() updates ctime.
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
> >  If the function updates the ctime, then i_version should be
> >  incremented.
> >=20
> > and I have to ask - why not just use the ctime? Why have another number
> > that is parallel?
> >=20
> > Timestamps are updated at HZ (ktime_get_course) which is at most every
> > millisecond.
> > xfs stores nanosecond resolution, so about 20 bits are currently wasted.
> > We could put a counter like i_version in there that only increments
> > after it is viewed, then we can get all the precision we need but with
> > exactly ctime semantics.
> >=20
> > The 64 change-id could comprise
> >  35 bits of seconds (nearly a millenium)
> >  16 bits of sub-seconds (just in case a higher precision time was wanted
> >  one day)
> >  13 bits of counter. - 8192 changes per tick
>=20
> We'd need a "seen" flag too, so maybe only 4096 changes per tick...

The "seen" flag does not need to be visible to NFSv4.
Nor does it need to be appear on storage.

Though it may still be easier to include it with the counter bits.

>=20
> >=20
> > The value exposed in i_ctime would hide the counter and just show the
> > timestamp portion of what the filesystem stores. This would ensure we
> > never get changes on different files that happen in one order leaving
> > timestamps with the reversed order (the timestamps could be the same,
> > but that is expected).
> >=20
> > This scheme could be made to handle a sustained update rate of 1
> > increment every 8 nanoseconds (if the counter were allowed to overflow
> > into unused bits of the sub-second field). This is one ever 24 CPU
> > cycles. Incrementing a counter and making it visible to all CPUs can
> > probably be done in 24 cycles. Accessing it and setting the "seen" flag
> > as well might just fit with faster memory. Getting any other useful
> > work done while maintaining that rate on a single file seems unlikely.
>=20
> This is an interesting idea.
>=20
> So, for NFSv4 you'd just mask off the counter bits (and "seen" flag) to
> get the ctime, and for the change attribute we'd just mask off the
> "seen" flag and put it all in there.

Obviously it isn't just NFSv4 that needs the ctime, it is also the
vfs...

I imagine that the counter would be separate in the in-memory inode.  It
would be split out when read from storage, and merge in when written to
storage.

>=20
>  * Implementing that for all filesystems would be a huge project though.
>    If we were implementing the i_version counter from scratch, I'd
>    probably do something along these lines. Given that we already have
>    an existing i_version counter, would there be any real benefit to
>    pursuing this avenue instead?

i_version is currently only supported by btrfs, ext4, and xfs.  Plus
cephfs which has its own internal ideas.
So "all filesystems" isn't needed.  Let's just start with xfs.

All we need is for xfs store in ->i_version a value that meets the
semantics that we specify for ->i_version.
So we need to change xfs to use somewhere else to store its internal
counter that is used for forensics, and then arrange that ->i_version
stores the ctime combined with a counter that resets whenever the ctime
changes.
I think most of this would be done in xfs_vn_update_time(), but probably
some changes would be needed in iversion.h to provide useful support.

If ext4's current use of i_version provides the semantics that we need,
there would be no need to change it.  Ditto for btrfs.

NeilBrown
