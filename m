Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A8159C406
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 18:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbiHVQXE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 12:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236958AbiHVQXC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:23:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64623F330;
        Mon, 22 Aug 2022 09:23:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6047CB815FC;
        Mon, 22 Aug 2022 16:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2476CC4347C;
        Mon, 22 Aug 2022 16:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661185378;
        bh=biuYM5Wo1aN4Uc70XLQMc1KWtn0aEFg1laOYV4x1E/4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=N20YTc8cZ7KVHZzmtmfw0ttl9cGHZK/DLftpuAMa0hgEZizusL7ETyemPBOIfP2kI
         aa6g/eaYWnClwhbxvUBr3CS12MAayFh7dAHubSG9ieSnfr5JB35ZYc3dR2A0LeLU6k
         EuUJQCFAlhlMPtkOCtHjaUm1lNXtze3F+pi2U5tFbOHlVVHgFoUlXhpvUQV2WzmjWw
         DUMxVxTGoKDAyOPru5+AI8toTlywJ3HHNzfNYyQbZyZZFeizioPn0BIVmCogRJdCF5
         eAL0DtiUBdApu5TXD6fM/qG5wQRrBlDmnScz2lEOEqv4KbZyol4+33VivcmswQ2ZYA
         3JXh8qjiNU4bw==
Message-ID: <f17b9d627703bee2a7b531a051461671648a9dbd.camel@kernel.org>
Subject: Re: [PATCH] iversion: update comments with info about atime updates
From:   Jeff Layton <jlayton@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Dave Chinner <david@fromorbit.com>
Date:   Mon, 22 Aug 2022 12:22:55 -0400
In-Reply-To: <ceb8f09a4cb2de67f40604d03ee0c475feb3130a.camel@linux.ibm.com>
References: <20220822133309.86005-1-jlayton@kernel.org>
         <ceb8f09a4cb2de67f40604d03ee0c475feb3130a.camel@linux.ibm.com>
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

On Mon, 2022-08-22 at 11:40 -0400, Mimi Zohar wrote:
> On Mon, 2022-08-22 at 09:33 -0400, Jeff Layton wrote:
> > Add an explicit paragraph codifying that atime updates due to reads
> > should not be counted against the i_version counter. None of the
> > existing subsystems that use the i_version want those counted, and
> > there is an easy workaround for those that do.
> >=20
> > Cc: NeilBrown <neilb@suse.de>
> > Cc: Trond Myklebust <trondmy@hammerspace.com>
> > Cc: Dave Chinner <david@fromorbit.com>
> > Link: https://lore.kernel.org/linux-xfs/166086932784.5425.1713471269496=
1326033@noble.neil.brown.name/#t
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  include/linux/iversion.h | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> > index 3bfebde5a1a6..da6cc1cc520a 100644
> > --- a/include/linux/iversion.h
> > +++ b/include/linux/iversion.h
> > @@ -9,8 +9,8 @@
> >   * ---------------------------
> >   * The change attribute (i_version) is mandated by NFSv4 and is mostly=
 for
> >   * knfsd, but is also used for other purposes (e.g. IMA). The i_versio=
n must
> > - * appear different to observers if there was a change to the inode's =
data or
> > - * metadata since it was last queried.
> > + * appear different to observers if there was an explicit change to th=
e inode's
> > + * data or metadata since it was last queried.
> >   *
> >   * Observers see the i_version as a 64-bit number that never decreases=
. If it
> >   * remains the same since it was last checked, then nothing has change=
d in the
> > @@ -18,6 +18,12 @@
> >   * anything about the nature or magnitude of the changes from the valu=
e, only
> >   * that the inode has changed in some fashion.
> >   *
> > + * Note that atime updates due to reads or similar activity do _not_ r=
epresent
> > + * an explicit change to the inode. If the only change is to the atime=
 and it
>=20
> Thanks, Jeff.  The ext4 patch increments i_version on file metadata
> changes.  Could the wording here be more explicit to reflect changes
> based on either inode data or metadata changes?
>=20
>=20

Thanks Mimi,

Care to suggest some wording?

The main issue we have is that ext4 and xfs both increment i_version on
atime updates due to reads. I have patches in flight to fix those, but
going forward, we want to ensure that i_version gets incremented on all
changes _except_ for atime updates.

The best wording we have at the moment is what Trond suggested, which is
to classify the changes to the inode as "explicit" (someone or something
made a deliberate change to the inode) and "implicit" (the change to the
inode was due to activity such as reads that don't actually change
anything).

Is there a better way to describe this?

> > + * wasn't set via utimes() or a similar mechanism, then i_version shou=
ld not be
> > + * incremented. If an observer cares about atime updates, it should pl=
an to
> > + * fetch and store them in conjunction with the i_version.
> > + *
> >   * Not all filesystems properly implement the i_version counter. Subsy=
stems that
> >   * want to use i_version field on an inode should first check whether =
the
> >   * filesystem sets the SB_I_VERSION flag (usually via the IS_I_VERSION=
 macro).
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
