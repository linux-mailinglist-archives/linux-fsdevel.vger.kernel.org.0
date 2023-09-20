Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029F57A80F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 14:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbjITMld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 08:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbjITMlb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:41:31 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B3A93;
        Wed, 20 Sep 2023 05:41:19 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-48faba23f51so2928686e0c.1;
        Wed, 20 Sep 2023 05:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695213678; x=1695818478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2xiNXfJVDy0tcPh5SWeJ/z/xr1C6nk1yaZAQeAQEJQ=;
        b=TzuiY+wmXsPGHrOT43oFqAC7Y0TvRz6M9xoo52sVpgWochuJVyD02cUSBIZizR/kRl
         X769LBNzrPT1891fskNHNCqmubC49tAWAYSf9Xyo2JSg5ljS6ewunBDAu0OAyhEmZoWK
         LrZRRv5T+ikSi1lfq2QEV5HAzccRacqJRnvCrmaY6mmfGqcldlKYqCedTtSf403SmZRc
         DCYkFXljPkypouh7mxf+dTUJHDnYFKEJB7fv6YFKB3PID1+po3NqqRtl66Uu+x9J+QRj
         c5Y/7C1TENOMfv8dDPDvquTzEhn9CSpoda3dDThmwNG/5lJwfulf5Y89u/aw7qHpskwp
         myEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213678; x=1695818478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2xiNXfJVDy0tcPh5SWeJ/z/xr1C6nk1yaZAQeAQEJQ=;
        b=m8Nvxbl+ioDkzuAmYDWUlMwOLh/9BzGPVZKsDvjxFnjuGmhXkEIerSxDoU1uoQD6kW
         hwHTbxCW0La40zemyVzgoP/y4eWH6sgrFWFo57k9N589dFXXUw6iIYKZaUOfpKj3rYGt
         2tNpG2nbQr2ihJ6H5n5AjjINGNmeabQPJVEpAwHDhA7I71P0zHokubM2CzJKMvUTzTE+
         3PCiKVBlGQCYnxYpvacGS03aIVFMBcJuFXCnOq04UcsNRxHOMAiIHV53q/VIVNMZo1em
         xB9LhaTa3BZuqGDLJJexSxFOltoyMvTbDf/I+clfJ+GF4lL4StLsLTSxnsVBI89IDGh+
         cOPg==
X-Gm-Message-State: AOJu0YzF5l6JyC3d/oH/eKtGDfb1Ea1dDGGXbrTNzeCCLuBme95T1I5J
        lwbDRka8sIwf0s5EsHW9/Lpxx7gHItg//fo2yxM=
X-Google-Smtp-Source: AGHT+IHLzfKzO/ufM0KZ8wQ5xYs9pEj272Xc/ywT+TaSKtuuhbFGq/CZGdtgsOsFNBNzq0K2BqmI3fnp6jVZpDcAfOg=
X-Received: by 2002:a1f:c942:0:b0:48f:e2eb:6dd2 with SMTP id
 z63-20020a1fc942000000b0048fe2eb6dd2mr2290402vkf.9.1695213677858; Wed, 20 Sep
 2023 05:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230411124037.1629654-1-amir73il@gmail.com> <20230412184359.grx7qyujnb63h4oy@quack3>
 <CAOQ4uxj_OQt+yLVnBH-Cg4mKe4_19L42bcsQx2BSOxR7E46SDQ@mail.gmail.com>
 <20230417162721.ouzs33oh6mb7vtft@quack3> <CAOQ4uxjfP+TrDded+Zps6k6GQM+UsEuW0R2PT_fMEH8ouY_aUg@mail.gmail.com>
 <20230920110429.f4wkfuls73pd55pv@quack3>
In-Reply-To: <20230920110429.f4wkfuls73pd55pv@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 20 Sep 2023 15:41:06 +0300
Message-ID: <CAOQ4uxisRMZh_g-M06ROno9g-E+u2ME0109FAVJLiV4V=mwKDw@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: Enable FAN_REPORT_FID on more filesystem types
To:     Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 2:04=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 20-09-23 11:26:38, Amir Goldstein wrote:
> > On Mon, Apr 17, 2023 at 7:27=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > > > > My motivation is to close functional gaps between fanotify and =
inotify.
> > > > > >
> > > > > > One of the largest gaps right now is that FAN_REPORT_FID is lim=
ited
> > > > > > to a subset of local filesystems.
> > > > > >
> > > > > > The idea is to report fid's that are "good enough" and that the=
re
> > > > > > is no need to require that fid's can be used by open_by_handle_=
at()
> > > > > > because that is a non-requirement for most use cases, unpriv li=
stener
> > > > > > in particular.
> > > > >
> > > > > OK. I'd note that if you report only inode number, you are prone =
to the
> > > > > problem that some inode gets freed (file deleted) and then reallo=
cated (new
> > > > > file created) and the resulting identifier is the same. It can be
> > > > > problematic for a listener to detect these cases and deal with th=
em.
> > > > > Inotify does not have this problem at least for some cases becaus=
e 'wd'
> > > > > uniquely identifies the marked inode. For other cases (like watch=
ing dirs)
> > > > > inotify has similar sort of problems. I'm muttering over this bec=
ause in
> > > > > theory filesystems not having i_generation counter on disk could =
approach
> > > > > the problem in a similar way as FAT and then we could just use
> > > > > FILEID_INO64_GEN for the file handle.
> > > >
> > > > Yes, of course we could.
> > > > The problem with that is that user space needs to be able to query =
the fid
> > > > regardless of fanotify.
> > > >
> > > > The fanotify equivalent of wd is the answer to that query.
> > > >
> > > > If any fs would export i_generation via statx, then FILEID_INO64_GE=
N
> > > > would have been my choice.
> > >
> > > One problem with making up i_generation (like FAT does it) is that wh=
en
> > > inode gets reclaimed and then refetched from the disk FILEID_INO64_GE=
N will
> > > change because it's going to have different i_generation. For NFS thi=
s is
> > > annoying but I suppose it mostly does not happen since client's acces=
ses
> > > tend to keep the inode in memory. For fanotify it could be more likel=
y to
> > > happen if watching say the whole filesystem and I suppose the watchin=
g
> > > application will get confused by this. So I'm not convinced faking
> > > i_generation is a good thing to do. But still I want to brainstorm a =
bit
> > > about it :)
> > >
> > > > But if we are going to change some other API for that, I would not =
change
> > > > statx(), I would change name_to_handle_at(...., AT_HANDLE_FID)
> > > >
> > > > This AT_ flag would relax this check in name_to_handle_at():
> > > >
> > > >         /*
> > > >          * We need to make sure whether the file system
> > > >          * support decoding of the file handle
> > > >          */
> > > >         if (!path->dentry->d_sb->s_export_op ||
> > > >             !path->dentry->d_sb->s_export_op->fh_to_dentry)
> > > >                 return -EOPNOTSUPP;
> > > >
> > > > And allow the call to proceed to the default export_encode_fh() imp=
lementation.
> > > > Alas, the default implementation encodes FILEID_INO32_GEN.
> > > >
> > > > I think we can get away with a default implementation for FILEID_IN=
O64_GEN
> > > > as long as the former (INO32) is used for fs with export ops withou=
t ->encode_fh
> > > > (e.g. ext*) and the latter (INO64) is used for fs with no export op=
s.
> > >
> > > These default calls seem a bit too subtle to me. I'd rather add expli=
cit
> > > handlers to filesystems that really want FILEID_INO32_GEN encoding an=
d then
> > > have a fallback function for filesystems not having s_export_op at al=
l.
> > >
> > > But otherwise the proposal to make name_to_handle_at() work even for
> > > filesystems not exportable through NFS makes sense to me. But I guess=
 we
> > > need some buy-in from VFS maintainers for this.
> > >
> >
> > Hi Jan,
> >
> > I seem to have dropped the ball on this after implementing AT_HANDLE_FI=
D.
> > It was step one in a larger plan.
>
> No problem, I forgot about this as well :)
>
> > Christian, Jeff,
> >
> > Do you have an objection to this plan:
> > 1. Convert all "legacy" FILEID_INO32_GEN fs with non-empty
> >     s_export_op and no explicit ->encode_fh() to use an explicit
> >     generic_encode_ino32_gen_fh()
> > 2. Relax requirement of non-empty s_export_op for AT_HANDLE_FID
> >     to support encoding a (non-NFS) file id on all fs
> > 3. For fs with empty s_export_op, allow fallback of AT_HANDLE_FID
> >     in exportfs_encode_inode_fh() to encode FILEID_INO64_GEN
> >
> >
> > > > > Also I have noticed your workaround with using st_dev for fsid. A=
s I've
> > > > > checked, there are actually very few filesystems that don't set f=
sid these
> > > > > days. So maybe we could just get away with still refusing to repo=
rt on
> > > > > filesystems without fsid and possibly fixup filesystems which don=
't set
> > > > > fsid yet and are used enough so that users complain?
> > > >
> > > > I started going down this path to close the gap with inotify.
> > > > inotify is capable of watching all fs including pseudo fs, so I wou=
ld
> > > > like to have this feature parity.
> > >
> > > Well, but with pseudo filesystems (similarly as with FUSE) the notifi=
cation
> > > was always unreliable. As in: some cases worked but others did not. I=
'm not
> > > sure that is something we should try to replicate :)
> > >
> > > So still I'd be interested to know which filesystems we are exactly
> > > interested to support and whether we are not better off to explicitly=
 add
> > > fsid support to them like we did for tmpfs.
> > >
> >
> > Since this email, kernfs derivative fs gained fsid as well.
> > Quoting your audit of remaining fs from another thread:
> >
> > > ...As far as I remember
> > > fanotify should be now able to handle anything that provides f_fsid i=
n its
> > > statfs(2) call. And as I'm checking filesystems not setting fsid curr=
ently are:
> > >
> > > afs, coda, nfs - networking filesystems where inotify and fanotify ha=
ve
> > >   dubious value anyway
> >
> > Be that as it may, there may be users that use inotify on network fs
> > and it even makes a lot of sense in controlled environments with
> > single NFS client per NFS export (e.g. home dirs), so I think we will
> > need to support those fs as well.
>
> Fair enough.
>
> > Maybe the wise thing to do is to opt-in to monitor those fs after all?
> > Maybe with explicit opt-in to watch a single fs, fanotify group will
> > limit itself to marks on a specific sb and then a null fsid won't matte=
r?
>
> We have virtual filesystems with all sorts of missing or weird notificati=
on
> functionality and we don't flag that in any way. So making a special flag
> for network filesystems seems a bit arbitrary. I'd just make them provide
> fsid and be done with it.
>

OK. I will try.

However, in reply to Jeff's comment:

> Caution here. Most of these filesystems don't have protocol support for
> anything like inotify (the known exception being SMB). You can monitor
> such a network filesystem, but you won't get events for things that
> happen on remote hosts.

Regardless of the fsid question, when we discussed remote notifications
support for FUSE/SMB, we raised the point that which notifications the
user gets (local or remote) are ambiguous and one suggestion was to
be explicit about requesting LOCAL or REMOTE notifications (or both).

Among the filesystems that currently support fanotify, except for the
most recent kernfs family, I think all of them are "purely local".
For the purpose of this discussion I consider debugfs and such to have
REMOTE notifications, which are not triggered from user vfs syscalls.

The one exception is smb, but only with config CIFS_NFSD_EXPORT
and that one depends on BROKEN.

If we did want to require an explicit FAN_LOCAL_NOTIF flag to allow
setting marks on fs which may have changes not via local syscalls,
it may be a good idea to flag those fs and disallow them without explicit
opt-in, before we add fanotify support to fs with missing notifications?
Perhaps before the official release of 6.6?

> > > configfs, debugfs, devpts, efivarfs, hugetlbfs, openpromfs, proc, pst=
ore,
> > > ramfs, sysfs, tracefs - virtual filesystems where fsnotify functional=
ity is
> > >   quite limited. But some special cases could be useful. Adding fsid =
support
> > >   is the same amount of trouble as for kernfs - a few LOC. In fact, w=
e
> > >   could perhaps add a fstype flag to indicate that this is a filesyst=
em
> > >   without persistent identification and so uuid should be autogenerat=
ed on
> > >   mount (likely in alloc_super()) and f_fsid generated from sb->s_uui=
d.
> > >   This way we could handle all these filesystems with trivial amount =
of
> > >   effort.
> > >
> >
> > Christian,
> >
> > I recall that you may have had reservations on initializing s_uuid
> > and f_fsid in vfs code?
> > Does an opt-in fstype flag address your concerns?
> > Will you be ok with doing the tmpfs/kernfs trick for every fs
> > that opted-in with fstype flag in generic vfs code?
> >
> > > freevxfs - the only real filesystem without f_fsid. Trivial to handle=
 one
> > >   way or the other.
> > >
> >
> > Last but not least, btrfs subvolumes.
> > They do have an fsid, but it is different from the sb fsid,
> > so we disallow (even inode) fanotify marks.
> >
> > I am not sure how to solve this one,
> > but if we choose to implement the opt-in fanotify flag for
> > "watch single fs", we can make this problem go away, along
> > with the problem of network fs fsid and other odd fs that we
> > do not want to have to deal with.
> >
> > On top of everything, it is a fast solution and it doesn't
> > involve vfs and changing any fs at all.
>
> Yeah, right, forgot about this one. Thanks for reminding me. But this is
> mostly a kernel internal implementation issue and doesn't seem to be a
> principial problem so I'd prefer not to complicate the uAPI for this. We
> could for example mandate a special super_operation for fetching fsid for=
 a
> dentry for filesystems which don't have uniform fsids over the whole
> filesystem (i.e., btrfs) and call this when generating event for such
> filesystems. Or am I missing some other complication?
>

The problem is the other way around :)
btrfs_statfs() takes a dentry and returns the fsid of the subvolume.
That is the fsid that users will get when querying the path to be marked.

If users had a flag to statfs() to request the "btrfs root volume fsid",
then fanotify could also report the root fsid and everyone will be happy
because the btrfs file handle already contains the subvolume root
object id (FILEID_BTRFS_WITH_PARENT_ROOT), but that is not
what users get for statfs() and that is not what fanotify documentation
says about how to query fsid.

We could report the subvolume fsid for marked inode/mount
that is not a problem - we just cache the subvol fsid in inode/mount
connector, but that fsid will be inconsistent with the fsid in the sb
connector, so the same object (in subvolume) can get events
with different fsid (e.g. if one event is in mask of sb and another
event is in mask of inode).

As Jeff said, nfsd also have issues with exporting btrfs subvolumes,
because of these oddities and I have no desire to solve those issues.

I think we could relax the EXDEV case for unpriv fanotify, because
inode marks should not have this problem?

That would be an easy way to get feature parity with inotify wrt btrfs.

> > > > If we can get away with fallback to s_dev as fsid in vfs_statfs()
> > > > I have no problem with that, but just to point out - functionally
> > > > it is equivalent to do this fallback in userspace library as the
> > > > fanotify_get_fid() LTP helper does.
> > >
> > > Yes, userspace can workaround this but I was more thinking about avoi=
ding
> > > adding these workarounds into fanotify in kernel *and* to userspace.
> > >
> > > > > > I chose a rather generic name for the flag to opt-in for "good =
enough"
> > > > > > fid's.  At first, I was going to make those fid's self describi=
ng the
> > > > > > fact that they are not NFS file handles, but in the name of sim=
plicity
> > > > > > to the API, I decided that this is not needed.
> > > > >
> > > > > I'd like to discuss a bit about the meaning of the flag. On the f=
irst look
> > > > > it is a bit strange to have a flag that says "give me a fh, if yo=
u don't
> > > > > have it, give me ino". It would seem cleaner to have "give me fh"=
 kind of
> > > > > interface (FAN_REPORT_FID) and "give me ino" kind of interface (n=
ew
> > > > > FAN_REPORT_* flag). I suspect you've chosen the more complex mean=
ing
> > > > > because you want to allow a usecase where watches of filesystems =
which
> > > > > don't support filehandles are mixed with watches of filesystems w=
hich do
> > > > > support filehandles in one notification group and getting filehan=
dles is
> > > > > actually prefered over getting just inode numbers? Do you see rea=
l benefit
> > > > > in getting file handles when userspace has to implement fallback =
for
> > > > > getting just inode numbers anyway?
> > > > >
> > > >
> > > > Yes, there is a benefit, because a real fhandle has no-reuse guaran=
tee.
> > > >
> > > > Even if we implement the kernel fallback to FILEID_INO64_GEN, it do=
es
> > > > not serve as a statement from the filesystem that i_generation is u=
seful
> > > > and in fact, i_generation will often be zero in simple fs and ino w=
ill be
> > > > reusable.
> > > >
> > > > Also, I wanted to have a design where a given fs/object always retu=
rns
> > > > the same FID regardless of the init flags.
> > > >
> > > > Your question implies that if
> > > > "userspace has to implement fallback for getting just inode numbers=
",
> > > > then it doesn't matter if we report fhandle or inode, but it is not=
 accurate.
> > > >
> > > > The fanotify_get_fid() LTP helper always gets a consistent FID for =
a
> > > > given fs/object. You do not need to feed it the fanotify init flags=
 to
> > > > provide a consistent answer.
> > > >
> > > > For all the reasons above, I think that a "give me ino'' flag is no=
t useful.
> > > > IMO, the flag just needs better marketing.
> > > > This is a "I do not need/intend to open_by_handle flag".
> > > > Suggestions for a better name are welcome.
> > >
> > > I see, yes, these reasons make sense.
> > >
> > > > For all I care, we do not need to add an opt-in flag at all.
> > > > We could simply start to support fs that were not supported before.
> > > > This sort of API change is very common and acceptable.
> > > >
> > > > There is no risk if the user tries to call open_by_handle_at() with=
 the
> > > > fanotify encoded FID, because in this case the fs is guaranteed to
> > > > return ESTALE, because fs does not support file handles.
> > > >
> > > > This is especially true, if we can get away with seamless change
> > > > of behavior for vfs_statfs(), because that seamless change would
> > > > cause FAN_REPORT_FID to start working on fs like fuse that
> > > > support file handles and have zero fsid.
> > >
> > > Yeah. Actually I like the idea of a seamless change to start reportin=
g fsid
> > > and also to start reporting "fake" handles. In the past we've already
> > > enabled tmpfs like this...
> > >
> >
> > I am now leaning towards a combination of:
> > 1. Seamless change of behavior for vfs_statfs() and
> >     name_to_handle_at(..., AT_HANDLE_FID) for the simple cases
> >     using an opt-in fstype flag
>
> Ack.
>
> > AND
> > 2. Simple interim fallback for other fs with an opt-in fanotify flag (*=
)
>
> I'm not sold on the special flag yet (see above) ;).

OK, will try to make progress without an opt-in flag.

Thanks,
Amir.
