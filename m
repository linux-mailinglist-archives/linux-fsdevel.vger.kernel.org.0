Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE185B1BA2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 13:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiIHLhN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 07:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIHLhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:37:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505807D7A9;
        Thu,  8 Sep 2022 04:37:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07D9BB820BD;
        Thu,  8 Sep 2022 11:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74312C433D6;
        Thu,  8 Sep 2022 11:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662637028;
        bh=nFaIloh72XswjqLypFm7qEwZe0n6G6z7SXTNzBgCMjg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=T8fy2B8GzUAkzTIPSAwnHwIr6BrIEln2MeWmJAxpt9MOd925gW1B2lQhZYSO4COYu
         B2O8n2i73wr8nQ+Xl9fXqr5P9fydyAptj/hEQAIeJ51Xa/wC8HJ39zNDiXvXlWzeAH
         Yda5slhtPSR7aZt2pwMzXhhFhRe5nrfP+UOan5Gou2I7n4cg45cMkkZXhJqXnq7/W9
         aIDWYDkMNc0c9V1oMyr0Ojcp8Tb3pXVFnJPg/eIRJfpXyzU5wP48Yb60jYJPaVcfwS
         jtr/wUtGXPernRKRBPdv9HqXzzQo9VLCkAV2iNdNCznGAQGrXT/r2lX5iXbMgopjjo
         jBbL/T/kwrleQ==
Message-ID: <c15f58c78e560bb9a597db6d22c317f98f020435.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "neilb@suse.de" <neilb@suse.de>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
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
Date:   Thu, 08 Sep 2022 07:37:05 -0400
In-Reply-To: <9f8b9ee28dcc479ab6fb1105fc12ff190a9b5c48.camel@hammerspace.com>
References: <20220907111606.18831-1-jlayton@kernel.org>
                , <166255065346.30452.6121947305075322036@noble.neil.brown.name>
                , <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
                , <20220907125211.GB17729@fieldses.org>
                , <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
                , <8a71986b4fb61cd9b4adc8b4250118cbb19eec58.camel@hammerspace.com>
         <166259706887.30452.6749778447732126953@noble.neil.brown.name>
         <9f8b9ee28dcc479ab6fb1105fc12ff190a9b5c48.camel@hammerspace.com>
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

On Thu, 2022-09-08 at 00:41 +0000, Trond Myklebust wrote:
> On Thu, 2022-09-08 at 10:31 +1000, NeilBrown wrote:
> > On Wed, 07 Sep 2022, Trond Myklebust wrote:
> > > On Wed, 2022-09-07 at 09:12 -0400, Jeff Layton wrote:
> > > > On Wed, 2022-09-07 at 08:52 -0400, J. Bruce Fields wrote:
> > > > > On Wed, Sep 07, 2022 at 08:47:20AM -0400, Jeff Layton wrote:
> > > > > > On Wed, 2022-09-07 at 21:37 +1000, NeilBrown wrote:
> > > > > > > On Wed, 07 Sep 2022, Jeff Layton wrote:
> > > > > > > > +The change to \fIstatx.stx_ino_version\fP is not atomic
> > > > > > > > with
> > > > > > > > respect to the
> > > > > > > > +other changes in the inode. On a write, for instance,
> > > > > > > > the
> > > > > > > > i_version it usually
> > > > > > > > +incremented before the data is copied into the
> > > > > > > > pagecache.
> > > > > > > > Therefore it is
> > > > > > > > +possible to see a new i_version value while a read still
> > > > > > > > shows the old data.
> > > > > > >=20
> > > > > > > Doesn't that make the value useless?
> > > > > > >=20
> > > > > >=20
> > > > > > No, I don't think so. It's only really useful for comparing
> > > > > > to an
> > > > > > older
> > > > > > sample anyway. If you do "statx; read; statx" and the value
> > > > > > hasn't
> > > > > > changed, then you know that things are stable.=20
> > > > >=20
> > > > > I don't see how that helps.=A0 It's still possible to get:
> > > > >=20
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0reader=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0writer
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0------=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0------
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0i_version++
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0statx
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0read
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0statx
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0update page cache
> > > > >=20
> > > > > right?
> > > > >=20
> > > >=20
> > > > Yeah, I suppose so -- the statx wouldn't necessitate any locking.
> > > > In
> > > > that case, maybe this is useless then other than for testing
> > > > purposes
> > > > and userland NFS servers.
> > > >=20
> > > > Would it be better to not consume a statx field with this if so?
> > > > What
> > > > could we use as an alternate interface? ioctl? Some sort of
> > > > global
> > > > virtual xattr? It does need to be something per-inode.
> > >=20
> > > I don't see how a non-atomic change attribute is remotely useful
> > > even
> > > for NFS.
> > >=20
> > > The main problem is not so much the above (although NFS clients are
> > > vulnerable to that too) but the behaviour w.r.t. directory changes.
> > >=20
> > > If the server can't guarantee that file/directory/... creation and
> > > unlink are atomically recorded with change attribute updates, then
> > > the
> > > client has to always assume that the server is lying, and that it
> > > has
> > > to revalidate all its caches anyway. Cue endless
> > > readdir/lookup/getattr
> > > requests after each and every directory modification in order to
> > > check
> > > that some other client didn't also sneak in a change of their own.
> >=20
> > NFS re-export doesn't support atomic change attributes on
> > directories.
> > Do we see the endless revalidate requests after directory
> > modification
> > in that situation?=A0 Just curious.
>=20
> Why wouldn't NFS re-export be capable of supporting atomic change
> attributes in those cases, provided that the server does? It seems to
> me that is just a question of providing the correct information w.r.t.
> atomicity to knfsd.
>=20
> ...but yes, a quick glance at nfs4_update_changeattr_locked(), and what
> happens when !cinfo->atomic should tell you all you need to know.

The main reason we disabled atomic change attribute updates was that
getattr calls on NFS can be pretty expensive. By setting the NOWCC flag,
we can avoid those for WCC info, but at the expense of the client having
to do more revalidation on its own.
--=20
Jeff Layton <jlayton@kernel.org>
