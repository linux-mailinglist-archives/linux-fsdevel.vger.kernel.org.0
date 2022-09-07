Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D565B0609
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 16:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiIGOFO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 10:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIGOFN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:05:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E982EF07;
        Wed,  7 Sep 2022 07:05:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CEC0B81CBB;
        Wed,  7 Sep 2022 14:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B7BC433D7;
        Wed,  7 Sep 2022 14:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662559508;
        bh=5lNGsOF2ajdE3eZM/ZhuIKJFPKWxkqc/O43CxlRdETw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iHINgelRFdW9XpgWxJT4+BZAOcCagp76Jlx168FXARg9CGlzv1O9X1nbzOBkyWnfH
         DvcNjBBa2NBfDaLCDdulT4eoGcqyRAfrU7Pkwia/jC++XRnrwvEDdA0yuBiidY8n9z
         xkYy9xO+PosTOFM/Z5gioUWOqnPpGn/5RwsW5IwsGpJjb3aTgJMDcNaTBbwPxGb/9N
         75WPXU/Rxqm3c7uF3u+uomA6YVE4jfr4fX45ocNA2xpSTYq8csdcEYk8JWzhh8IS7f
         P17k7h+Nxi28WUxLZC8RBrkt6nvaFageSdyvAPIJW2/KPzvp7KNqmcmCCL7jNYUMVD
         KO6UPHjE9x1IQ==
Message-ID: <c22baa64133a23be3aba81df23b4af866df51343.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
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
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Date:   Wed, 07 Sep 2022 10:05:05 -0400
In-Reply-To: <8a71986b4fb61cd9b4adc8b4250118cbb19eec58.camel@hammerspace.com>
References: <20220907111606.18831-1-jlayton@kernel.org>
         <166255065346.30452.6121947305075322036@noble.neil.brown.name>
         <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
         <20220907125211.GB17729@fieldses.org>
         <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
         <8a71986b4fb61cd9b4adc8b4250118cbb19eec58.camel@hammerspace.com>
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

On Wed, 2022-09-07 at 13:55 +0000, Trond Myklebust wrote:
> On Wed, 2022-09-07 at 09:12 -0400, Jeff Layton wrote:
> > On Wed, 2022-09-07 at 08:52 -0400, J. Bruce Fields wrote:
> > > On Wed, Sep 07, 2022 at 08:47:20AM -0400, Jeff Layton wrote:
> > > > On Wed, 2022-09-07 at 21:37 +1000, NeilBrown wrote:
> > > > > On Wed, 07 Sep 2022, Jeff Layton wrote:
> > > > > > +The change to \fIstatx.stx_ino_version\fP is not atomic with
> > > > > > respect to the
> > > > > > +other changes in the inode. On a write, for instance, the
> > > > > > i_version it usually
> > > > > > +incremented before the data is copied into the pagecache.
> > > > > > Therefore it is
> > > > > > +possible to see a new i_version value while a read still
> > > > > > shows the old data.
> > > > >=20
> > > > > Doesn't that make the value useless?
> > > > >=20
> > > >=20
> > > > No, I don't think so. It's only really useful for comparing to an
> > > > older
> > > > sample anyway. If you do "statx; read; statx" and the value
> > > > hasn't
> > > > changed, then you know that things are stable.=20
> > >=20
> > > I don't see how that helps.=A0 It's still possible to get:
> > >=20
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0reader=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0writer
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0------=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0------
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0i_version++
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0statx
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0read
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0statx
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0update page cache
> > >=20
> > > right?
> > >=20
> >=20
> > Yeah, I suppose so -- the statx wouldn't necessitate any locking. In
> > that case, maybe this is useless then other than for testing purposes
> > and userland NFS servers.
> >=20
> > Would it be better to not consume a statx field with this if so? What
> > could we use as an alternate interface? ioctl? Some sort of global
> > virtual xattr? It does need to be something per-inode.
>=20
> I don't see how a non-atomic change attribute is remotely useful even
> for NFS.
>=20
> The main problem is not so much the above (although NFS clients are
> vulnerable to that too) but the behaviour w.r.t. directory changes.
>=20
> If the server can't guarantee that file/directory/... creation and
> unlink are atomically recorded with change attribute updates, then the
> client has to always assume that the server is lying, and that it has
> to revalidate all its caches anyway. Cue endless readdir/lookup/getattr
> requests after each and every directory modification in order to check
> that some other client didn't also sneak in a change of their own.
>=20

We generally hold the parent dir's inode->i_rwsem exclusively over most
important directory changes, and the times/i_version are also updated
while holding it. What we don't do is serialize reads of this value vs.
the i_rwsem, so you could see new directory contents alongside an old
i_version. Maybe we should be taking it for read when we query it on a
directory?

Achieving atomicity with file writes though is another matter entirely.
I'm not sure that's even doable or how to approach it if so.
Suggestions?
--=20
Jeff Layton <jlayton@kernel.org>
