Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B80D5A5754
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 00:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiH2W63 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 18:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiH2W62 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:58:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0C68672D;
        Mon, 29 Aug 2022 15:58:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6EDE61F91B;
        Mon, 29 Aug 2022 22:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661813905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Nh7JLxfon4+atbvUG155Svob5ValkyyKRW6pBz4oyQ=;
        b=Sz2ZMz3YoSrAWwB4ylH2l7mfPjgXeUsF7Vfliei6AjTVQ1/uOvix13iR97dgDQuDUlyuD5
        LZHWC3oQccvpl+MxqKAeJs1n1359Xbg8xv8mxY5rF2jydT5mLstdUdpg5QkmmTyfKlApCf
        +esqUEBjGPYWxHPLzIQI//WfDwZh2sg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661813905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Nh7JLxfon4+atbvUG155Svob5ValkyyKRW6pBz4oyQ=;
        b=LOWfVmxR4+I1gwlrnu5py92Oqj9rRpwaWA8jtFry1OH67I5Baqy5ZvQxTZgpZnUDf9nvHV
        Q8GV5aXa2PZgOvCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7ABE61352A;
        Mon, 29 Aug 2022 22:58:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Sv+lDotEDWNcIQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 29 Aug 2022 22:58:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Dave Chinner" <david@fromorbit.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, djwong@kernel.org,
        trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, brauner@kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ceph@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Colin Walters" <walters@verbum.org>
Subject: Re: [PATCH v3 1/7] iversion: update comments with info about atime updates
In-reply-to: <549776abfaddcc936c6de7800b6d8249d97d9f28.camel@kernel.org>
References: <20220826214703.134870-1-jlayton@kernel.org>,
 <20220826214703.134870-2-jlayton@kernel.org>,
 <20220829075651.GS3600936@dread.disaster.area>,
 <549776abfaddcc936c6de7800b6d8249d97d9f28.camel@kernel.org>
Date:   Tue, 30 Aug 2022 08:58:15 +1000
Message-id: <166181389550.27490.8200873228292034867@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 29 Aug 2022, Jeff Layton wrote:
> On Mon, 2022-08-29 at 17:56 +1000, Dave Chinner wrote:
> > On Fri, Aug 26, 2022 at 05:46:57PM -0400, Jeff Layton wrote:
> > > The i_version field in the kernel has had different semantics over
> > > the decades, but we're now proposing to expose it to userland via
> > > statx. This means that we need a clear, consistent definition of
> > > what it means and when it should change.
> > >=20
> > > Update the comments in iversion.h to describe how a conformant
> > > i_version implementation is expected to behave. This definition
> > > suits the current users of i_version (NFSv4 and IMA), but is
> > > loose enough to allow for a wide range of possible implementations.
> > >=20
> > > Cc: Colin Walters <walters@verbum.org>
> > > Cc: NeilBrown <neilb@suse.de>
> > > Cc: Trond Myklebust <trondmy@hammerspace.com>
> > > Cc: Dave Chinner <david@fromorbit.com>
> > > Link: https://lore.kernel.org/linux-xfs/166086932784.5425.1713471269496=
1326033@noble.neil.brown.name/#t
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  include/linux/iversion.h | 23 +++++++++++++++++++++--
> > >  1 file changed, 21 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> > > index 3bfebde5a1a6..45e93e1b4edc 100644
> > > --- a/include/linux/iversion.h
> > > +++ b/include/linux/iversion.h
> > > @@ -9,8 +9,19 @@
> > >   * ---------------------------
> > >   * The change attribute (i_version) is mandated by NFSv4 and is mostly=
 for
> > >   * knfsd, but is also used for other purposes (e.g. IMA). The i_versio=
n must
> > > - * appear different to observers if there was a change to the inode's =
data or
> > > - * metadata since it was last queried.
> > > + * appear different to observers if there was an explicit change to th=
e inode's
> > > + * data or metadata since it was last queried.
> > > + *
> > > + * An explicit change is one that would ordinarily result in a change =
to the
> > > + * inode status change time (aka ctime). The version must appear to ch=
ange, even
> > > + * if the ctime does not (since the whole point is to avoid missing up=
dates due
> > > + * to timestamp granularity). If POSIX mandates that the ctime must ch=
ange due
> > > + * to an operation, then the i_version counter must be incremented as =
well.
> > > + *
> > > + * A conformant implementation is allowed to increment the counter in =
other
> > > + * cases, but this is not optimal. NFSv4 and IMA both use this value t=
o determine
> > > + * whether caches are up to date. Spurious increments can cause false =
cache
> > > + * invalidations.
> >=20
> > "not optimal", but never-the-less allowed - that's "unspecified
> > behaviour" if I've ever seen it. How is userspace supposed to
> > know/deal with this?
> >=20
> > Indeed, this loophole clause doesn't exist in the man pages that
> > define what statx.stx_ino_version means. The man pages explicitly
> > define that stx_ino_version only ever changes when stx_ctime
> > changes.
> >=20
>=20
> We can fix the manpage to make this more clear.
>=20
> > IOWs, the behaviour userspace developers are going to expect *does
> > not include* stx_ino_version changing it more often than ctime is
> > changed. Hence a kernel iversion implementation that bumps the
> > counter more often than ctime changes *is not conformant with the
> > statx version counter specification*. IOWs, we can't export such
> > behaviour to userspace *ever* - it is a non-conformant
> > implementation.
> >=20
>=20
> Nonsense. The statx version counter specification is *whatever we decide
> to make it*. If we define it to allow for spurious version bumps, then
> these implementations would be conformant.
>=20
> Given that you can't tell what or how much changed in the inode whenever
> the value changes, allowing it to be bumped on non-observable changes is
> ok and the counter is still useful. When you see it change you need to
> go stat/read/getxattr etc, to see what actually happened anyway.
>=20
> Most applications won't be interested in every possible explicit change
> that can happen to an inode. It's likely these applications would check
> the parts of the inode they're interested in, and then go back to
> waiting for the next bump if the change wasn't significant to them.
>=20
>=20
> > Hence I think anything that bumps iversion outside the bounds of the
> > statx definition should be declared as such:
> >=20
> > "Non-conformant iversion implementations:
> > 	- MUST NOT be exported by statx() to userspace
> > 	- MUST be -tolerated- by kernel internal applications that
> > 	  use iversion for their own purposes."
> >=20
>=20
> I think this is more strict than is needed. An implementation that bumps
> this value more often than is necessary is still useful. It's not
> _ideal_, but it still meets the needs of NFSv4, IMA and other potential
> users of it. After all, this is basically the definition of i_version
> today and it's still useful, even if atime update i_version bumps are
> currently harmful for performance.

Why do you want to let it be OK?  Who is hurt by it being "more strict
than needed"?  There is an obvious cost in not being strict as an
implementation can be compliant but completely useless (increment every
nanosecond).  So there needs to be a clear benefit to balance this.  Who
benefits by not being strict?

Also: Your spec doesn't say it must increase, only it must be different.
So would as hash of all data and metadata be allowed (sysfs might be
able to provide that, but probably wouldn't bother).

Also: if stray updates are still conformant, can occasional repeated
values be still conformant?  I would like for a high-precision ctime
timestamp to be acceptable, but as time can go backwards it is currently
not conformant (even though the xfs iversion which is less useful is
actually conformant).

NeilBrown
