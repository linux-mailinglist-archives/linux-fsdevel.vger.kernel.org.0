Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E762C59C5FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 20:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbiHVSW3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 14:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236665AbiHVSW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:22:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E8C474F6;
        Mon, 22 Aug 2022 11:22:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD804B81722;
        Mon, 22 Aug 2022 18:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841D2C433C1;
        Mon, 22 Aug 2022 18:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661192542;
        bh=/tpyJXjO6Yic3E7IJcvmUnNa+4Nr/vUf3u9YFHixZ2Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dnzwHnapIewwCmDXke2kVm+53LUPX25tcSri8h9z1XwTOrzjVRRBlVNWKf5mPkijV
         FkQRmiQhlSxjra5I9JIN6Z5GmlEZeR7b6hcqegQmCFGxBTSG6oO/CdXCSRz6z26bxT
         FEWwhyagbBr6MT7BnM0Uc8LxiQr1EMQBqQ1Cin84/2FMe7qrYb9dMwrKFRmsABGL9B
         heeA1DvdFBzp3cfobc4L/MKNuxfR00iZPF4t+Krs/picmPCS7BCaHJCzPLiDYfUQQa
         7etSOl/AFLEeTAr5vj80NIZ4D4gaqciXIC3bETNlQnVbeTPdCQRHc1bGWKb+38hw+c
         Rh1R91RQ2ANcg==
Message-ID: <4cc84440d954c022d0235bf407a60da66a6ccc39.camel@kernel.org>
Subject: Re: [PATCH] iversion: update comments with info about atime updates
From:   Jeff Layton <jlayton@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Dave Chinner <david@fromorbit.com>
Date:   Mon, 22 Aug 2022 14:22:20 -0400
In-Reply-To: <18827b350fbf6719733fda814255ec20d6dcf00f.camel@linux.ibm.com>
References: <20220822133309.86005-1-jlayton@kernel.org>
         <ceb8f09a4cb2de67f40604d03ee0c475feb3130a.camel@linux.ibm.com>
         <f17b9d627703bee2a7b531a051461671648a9dbd.camel@kernel.org>
         <18827b350fbf6719733fda814255ec20d6dcf00f.camel@linux.ibm.com>
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

On Mon, 2022-08-22 at 13:39 -0400, Mimi Zohar wrote:
> On Mon, 2022-08-22 at 12:22 -0400, Jeff Layton wrote:
> > On Mon, 2022-08-22 at 11:40 -0400, Mimi Zohar wrote:
> > > On Mon, 2022-08-22 at 09:33 -0400, Jeff Layton wrote:
> > > > Add an explicit paragraph codifying that atime updates due to reads
> > > > should not be counted against the i_version counter. None of the
> > > > existing subsystems that use the i_version want those counted, and
> > > > there is an easy workaround for those that do.
> > > >=20
> > > > Cc: NeilBrown <neilb@suse.de>
> > > > Cc: Trond Myklebust <trondmy@hammerspace.com>
> > > > Cc: Dave Chinner <david@fromorbit.com>
> > > > Link: https://lore.kernel.org/linux-xfs/166086932784.5425.171347126=
94961326033@noble.neil.brown.name/#t
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  include/linux/iversion.h | 10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> > > > index 3bfebde5a1a6..da6cc1cc520a 100644
> > > > --- a/include/linux/iversion.h
> > > > +++ b/include/linux/iversion.h
> > > > @@ -9,8 +9,8 @@
> > > >   * ---------------------------
> > > >   * The change attribute (i_version) is mandated by NFSv4 and is mo=
stly for
> > > >   * knfsd, but is also used for other purposes (e.g. IMA). The i_ve=
rsion must
> > > > - * appear different to observers if there was a change to the inod=
e's data or
> > > > - * metadata since it was last queried.
> > > > + * appear different to observers if there was an explicit change t=
o the inode's
> > > > + * data or metadata since it was last queried.
> > > >   *
> > > >   * Observers see the i_version as a 64-bit number that never decre=
ases. If it
> > > >   * remains the same since it was last checked, then nothing has ch=
anged in the
> > > > @@ -18,6 +18,12 @@
> > > >   * anything about the nature or magnitude of the changes from the =
value, only
> > > >   * that the inode has changed in some fashion.
> > > >   *
> > > > + * Note that atime updates due to reads or similar activity do _no=
t_ represent
> > > > + * an explicit change to the inode. If the only change is to the a=
time and it
> > >=20
> > > Thanks, Jeff.  The ext4 patch increments i_version on file metadata
> > > changes.  Could the wording here be more explicit to reflect changes
> > > based on either inode data or metadata changes?b
> > >=20
> > >=20
> >=20
> > Thanks Mimi,
> >=20
> > Care to suggest some wording?
> >=20
> > The main issue we have is that ext4 and xfs both increment i_version on
> > atime updates due to reads. I have patches in flight to fix those, but
> > going forward, we want to ensure that i_version gets incremented on all
> > changes _except_ for atime updates.
> >=20
> > The best wording we have at the moment is what Trond suggested, which i=
s
> > to classify the changes to the inode as "explicit" (someone or somethin=
g
> > made a deliberate change to the inode) and "implicit" (the change to th=
e
> > inode was due to activity such as reads that don't actually change
> > anything).
> >=20
> > Is there a better way to describe this?
>=20
> "explicit change to the inode" probably implies both the inode file
> data and metadata, but let's call it out by saying "an explicit change
> to either the inode data or metadata".
>=20
> >=20
> > > > + * wasn't set via utimes() or a similar mechanism, then i_version =
should not be
> > > > + * incremented. If an observer cares about atime updates, it shoul=
d plan to
> > > > + * fetch and store them in conjunction with the i_version.
> > > > + *
> > > >   * Not all filesystems properly implement the i_version counter. S=
ubsystems that
> > > >   * want to use i_version field on an inode should first check whet=
her the
> > > >   * filesystem sets the SB_I_VERSION flag (usually via the IS_I_VER=
SION macro).
> > >=20
> > >=20
> >=20
>=20
>=20

Thanks Mimi,

Here's what I have now. I'll plan to send a v2 patch once others have
had a chance to comment as well.

-- Jeff

diff --git a/include/linux/iversion.h b/include/linux/iversion.h
index 3bfebde5a1a6..524abd372100 100644
--- a/include/linux/iversion.h
+++ b/include/linux/iversion.h
@@ -9,8 +9,8 @@
  * ---------------------------
  * The change attribute (i_version) is mandated by NFSv4 and is mostly for
  * knfsd, but is also used for other purposes (e.g. IMA). The i_version mu=
st
- * appear different to observers if there was a change to the inode's data=
 or
- * metadata since it was last queried.
+ * appear different to observers if there was an explicit change to the in=
ode's
+ * data or metadata since it was last queried.
  *
  * Observers see the i_version as a 64-bit number that never decreases. If=
 it
  * remains the same since it was last checked, then nothing has changed in=
 the
@@ -18,6 +18,13 @@
  * anything about the nature or magnitude of the changes from the value, o=
nly
  * that the inode has changed in some fashion.
  *
+ * Note that atime updates due to reads or similar activity do not represe=
nt
+ * an explicit change to the inode data or metadata. If the only change is=
 to
+ * the atime and it wasn't set via utimes() or a similar mechanism, then
+ * i_version should not be incremented. If an observer cares about atime
+ * updates, it should plan to fetch and store them in conjunction with the
+ * i_version.
+ *
  * Not all filesystems properly implement the i_version counter. Subsystem=
s that
  * want to use i_version field on an inode should first check whether the
  * filesystem sets the SB_I_VERSION flag (usually via the IS_I_VERSION mac=
ro).


--=20
Jeff Layton <jlayton@kernel.org>
