Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34735882EF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 22:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiHBUHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 16:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiHBUH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:07:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEB154640;
        Tue,  2 Aug 2022 13:07:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80787B820BC;
        Tue,  2 Aug 2022 20:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD79C433C1;
        Tue,  2 Aug 2022 20:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659470842;
        bh=aRjcPgT3PZNuFEyvFjyZ4vab6bdQ6W52MV2WjeBkq4M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MgHL2/D6pXPgUKWakoT3B0+cYFJkPAwPicUFUgcQqHzymvq7CFPuSO0zZtcdbYtkc
         QIuk1oUebpF/bM4EemMZHeT4b0KxG458k5Fr/LWkNwjzyr+ADwvkz71WIVE26PfWm7
         HOGTPve84hsG1gmhsikjwRNF9s2EjIzHhji7QDZYu4nu/YUvEVWfhrY+e52tJdr1FQ
         c1bHzA5lRBo3xSnM7lkD5PGmu8SiMaTUds8qMiKnqtAgZQLlvywoDFHLqodsQROi/R
         QgTOmg//rhGPJOYPND5sC/zxm6KqOdaFWMjYs9hTm5slVUz44F87Y3jf4EQMr+ivYu
         NxJyICHaayGAw==
Message-ID: <6f3479265b446d180d71832fd0c12650b908ebe2.camel@kernel.org>
Subject: Re: [RFC PATCH 0/3] Rename "cifs" module to "smbfs"
From:   Jeff Layton <jlayton@kernel.org>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     linux-cifs@vger.kernel.org, smfrench@gmail.com, pc@cjr.nz,
        ronniesahlberg@gmail.com, nspmangalore@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tom@talpey.com, samba-technical@lists.samba.org,
        pshilovsky@samba.org
Date:   Tue, 02 Aug 2022 16:07:19 -0400
In-Reply-To: <20220802193620.dyvt5qiszm2pobsr@cyberdelia>
References: <20220801190933.27197-1-ematsumiya@suse.de>
         <c05f4fc668fa97e737758ab03030d7170c0edbd9.camel@kernel.org>
         <20220802193620.dyvt5qiszm2pobsr@cyberdelia>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-08-02 at 16:36 -0300, Enzo Matsumiya wrote:
> On 08/02, Jeff Layton wrote:
> > On Mon, 2022-08-01 at 16:09 -0300, Enzo Matsumiya wrote:
> > > Hi,
> > >=20
> > > As part of the ongoing effort to remove the "cifs" nomenclature from =
the
> > > Linux SMB client, I'm proposing the rename of the module to "smbfs".
> > >=20
> > > As it's widely known, CIFS is associated to SMB1.0, which, in turn, i=
s
> > > associated with the security issues it presented in the past. Using
> > > "SMBFS" makes clear what's the protocol in use for outsiders, but als=
o
> > > unties it from any particular protocol version. It also fits in the
> > > already existing "fs/smbfs_common" and "fs/ksmbd" naming scheme.
> > >=20
> > > This short patch series only changes directory names and includes/ifd=
efs in
> > > headers and source code, and updates docs to reflect the rename. Othe=
r
> > > than that, no source code/functionality is modified (WIP though).
> > >=20
> > > Patch 1/3: effectively changes the module name to "smbfs" and create =
a
> > > 	   "cifs" module alias to maintain compatibility (a warning
> > > 	   should be added to indicate the complete removal/isolation of
> > > 	   CIFS/SMB1.0 code).
> > > Patch 2/3: rename the source-code directory to align with the new mod=
ule
> > > 	   name
> > > Patch 3/3: update documentation references to "fs/cifs" or "cifs.ko" =
or
> > > 	   "cifs module" to use the new name
> > >=20
> > > Enzo Matsumiya (3):
> > >   cifs: change module name to "smbfs.ko"
> > >   smbfs: rename directory "fs/cifs" -> "fs/smbfs"
> > >   smbfs: update doc references
> > > ...
> >=20
> > Why do this? My inclination is to say NAK here.
> >=20
> > This seems like a lot of change for not a lot of benefit. Renaming the
> > directory like this pretty much guarantees that backporting patches
> > after this change to kernels that existed before it will be very
> > difficult.
>=20
> Hi Jeff, yes that's a big concern that I've discussed internally with my
> team as well, since we'll also suffer from those future backports.
>=20
> But, as stated in the commit message, and from what I gathered from
> Steve, it has been an ongoing wish to have the "cifs" name no longer
> associated with a module handling SMB2.0 and SMB3.0, as the name brings
> back old bad memories for several users.
>=20
> There really is no functional benefit for this change, and I have no
> argument against that.
>=20

If the concern is "branding" then I don't see how this really helps.
Very few users interact with the kernel modules directly.

FWIW, I just called "modprobe smb3" on my workstation and got this:

[ 1223.581583] Key type cifs.spnego registered
[ 1223.582523] Key type cifs.idmap registered
[ 1230.411422] Key type cifs.idmap unregistered
[ 1230.412542] Key type cifs.spnego unregistered

Are you going to rename the keyrings too? That will have implications
for userland helper programs like cifs.upcall. There's also
/proc/fs/cifs/*.

These are a "stable interfaces" that you can't just rename at will.=A0If
you want to change these interfaces then you need to do a formal
deprecation announcement, and probably a period with /proc/fs/smbfs and
/proc/fs/cifs coexisting.

There are also a ton of printk's and such that have "CIFS" in them that
will need to be changed.

These costs do not seem worth the perceived benefit to me. You could
probably hide a lot of what users see by just renaming (or symlinking)
mount.cifs to mount.smb3.

I think if you guys are serious about this, you should probably start
somewhere else besides renaming the directory and module. This is going
to impact developers (and people who make their living doing backports)
far more than it will users.

> > Also, bear in mind that there used to be an smbfs in the kernel that
> > predated cifs.ko. That was removed ~2010 though, which is long enough
> > ago that it shouldn't produce conflicts in currently shipping releases.=
=A0
>=20
> Yes, I was aware of this before sending v1, and it got raised again in
> https://lore.kernel.org/all/20220802135201.4vm36drd5mp57nvv@cyberdelia/
>=20
> I have no experience on what kind of issues/problems could arise of
> that, aside from the git commit history being weird. If you ever seen
> any problems with that happening, please do share.
>=20

I doubt it'd be a problem in practice. If we hadn't ripped out smbfs so
long ago I'd be more concerned, but that's pretty much ancient history
now.

>=20
> I sent a v2 with a new "fs/smb" directory name, but kept "smbfs" as the
> module name.
>=20

That's a little nicer, but really the problem is the "big rename"
itself.

> Sorry I didn't reply to you before that, I got confused as the thread
> replies all went to different folders in my mailbox.
>=20

No worries.
--=20
Jeff Layton <jlayton@kernel.org>
