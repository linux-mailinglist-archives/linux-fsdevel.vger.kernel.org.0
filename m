Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23627A87F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 17:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbjITPMV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 11:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjITPMU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:12:20 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B7FA3;
        Wed, 20 Sep 2023 08:12:12 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-4525dd7f9d0so1482718137.3;
        Wed, 20 Sep 2023 08:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695222731; x=1695827531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MJsi/TfPGsKboiCTOzz3krQMAHJ0ZhaSu8jme9s5Aw=;
        b=fRpaLxBvWoOS9/zMXyr1iNEJYjmJ16WY77lPvi+pIy2fnoL4Mah19CEwbxaHpxS5s3
         nVG4ddZxd6YNR4+opwCvX0hHF6O5ZqYw/mxCC7DYkORSpka2lm9Rq/Otm8QyjkBHmayw
         UO2VJoIzbRfrVxoD2fvcxpdSloHyJ0zFuB/5Hf5hht/bCR/6GqD4BK/sm0nXLauaUkAx
         LbxqBzsgxnnYp7nsuShJnkxWGVAk4hd8KpTFQZtrIwwkaSGlMJ/3u/js8aL9X6eGm3iF
         y+KujKXl+qAVhMm91+JwTyOVqyhESQf3JoMJcdYrra14A3gjwvtvU+6MVfacXsAn47FS
         VWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695222731; x=1695827531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MJsi/TfPGsKboiCTOzz3krQMAHJ0ZhaSu8jme9s5Aw=;
        b=CclrIlx6aGPxMsVIkMd4ltf1DM5xzhn6V3TYu3cGJBca3p9ELRzytexKFpkeDVchbJ
         2AyyQj3e8bBdImhSzKtgxR1QxrZ7lQ1G/BIDgQnmyW6iWu2gsUk8vYX5Z8IQLV0ooeRv
         ESGkjBIRRBVLLla/yxhMgd5zkiXXIUh9xvEdR0wI6WQe4kc7xD+34LlLsdxq7PocqaQF
         xpeLnA0hVREDcCAPImtmX27wRSCR5vbUG2jGi0uq8zOZnYbgN5u05vgujEqLmbm09L7N
         K5MhT2EKpA3cz9oK/ktlKMio9X0/wppd5/MbOGJdGJtZp1EAKVuGWSyQMu1wSyAyHqDS
         srBA==
X-Gm-Message-State: AOJu0Ywl2FOJY5hJRXqIoAlp4gJ0tgzTCIdK0+HoG98Zyjag62iDNqNX
        JwJPrCTaqPc63Q/w1D5I1u/qSZX5Q2rGe0tWHBTwWT/YAk4=
X-Google-Smtp-Source: AGHT+IHUqGZuuho1CL+oLgpcNRTBCWMu9gyo70jmeSOOlY0vFvwraCTFRbizN13wNg5EWhX3dUoif2Mx3DH6zWchZ0c=
X-Received: by 2002:a67:e44e:0:b0:452:6ac7:cdf with SMTP id
 n14-20020a67e44e000000b004526ac70cdfmr2786734vsm.24.1695222731446; Wed, 20
 Sep 2023 08:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230411124037.1629654-1-amir73il@gmail.com> <20230412184359.grx7qyujnb63h4oy@quack3>
 <CAOQ4uxj_OQt+yLVnBH-Cg4mKe4_19L42bcsQx2BSOxR7E46SDQ@mail.gmail.com>
 <20230417162721.ouzs33oh6mb7vtft@quack3> <CAOQ4uxjfP+TrDded+Zps6k6GQM+UsEuW0R2PT_fMEH8ouY_aUg@mail.gmail.com>
 <20230920110429.f4wkfuls73pd55pv@quack3> <CAOQ4uxisRMZh_g-M06ROno9g-E+u2ME0109FAVJLiV4V=mwKDw@mail.gmail.com>
 <20230920134829.n74smxum27herhl6@quack3>
In-Reply-To: <20230920134829.n74smxum27herhl6@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 20 Sep 2023 18:12:00 +0300
Message-ID: <CAOQ4uxj-5n3ja+22Qv4H27wEGn=eAdE1JNRBSxS3TgdEr7b75A@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: Enable FAN_REPORT_FID on more filesystem types
To:     Jan Kara <jack@suse.cz>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
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

On Wed, Sep 20, 2023 at 4:48=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 20-09-23 15:41:06, Amir Goldstein wrote:
> > On Wed, Sep 20, 2023 at 2:04=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > On Wed 20-09-23 11:26:38, Amir Goldstein wrote:
> > > > Be that as it may, there may be users that use inotify on network f=
s
> > > > and it even makes a lot of sense in controlled environments with
> > > > single NFS client per NFS export (e.g. home dirs), so I think we wi=
ll
> > > > need to support those fs as well.
> > >
> > > Fair enough.
> > >
> > > > Maybe the wise thing to do is to opt-in to monitor those fs after a=
ll?
> > > > Maybe with explicit opt-in to watch a single fs, fanotify group wil=
l
> > > > limit itself to marks on a specific sb and then a null fsid won't m=
atter?
> > >
> > > We have virtual filesystems with all sorts of missing or weird notifi=
cation
> > > functionality and we don't flag that in any way. So making a special =
flag
> > > for network filesystems seems a bit arbitrary. I'd just make them pro=
vide
> > > fsid and be done with it.
> > >
> >
> > OK. I will try.
> >
> > However, in reply to Jeff's comment:
> >
> > > Caution here. Most of these filesystems don't have protocol support f=
or
> > > anything like inotify (the known exception being SMB). You can monito=
r
> > > such a network filesystem, but you won't get events for things that
> > > happen on remote hosts.
> >
> > Regardless of the fsid question, when we discussed remote notifications
> > support for FUSE/SMB, we raised the point that which notifications the
> > user gets (local or remote) are ambiguous and one suggestion was to
> > be explicit about requesting LOCAL or REMOTE notifications (or both).
> >
> > Among the filesystems that currently support fanotify, except for the
> > most recent kernfs family, I think all of them are "purely local".
> > For the purpose of this discussion I consider debugfs and such to have
> > REMOTE notifications, which are not triggered from user vfs syscalls.
>
> Well, now you are speaking of FAN_REPORT_FID mode. There I agree we
> currently support only filesystems with a sane behavior. But there are
> definitely existing users of fanotify in "standard" file-descriptor mode
> for filesystems such as sysfs, proc, etc. So the new flag would have to
> change behavior only to FAN_REPORT_FID groups and that's why I think it's=
 a
> bit odd.
>

No flag is fine by me.

> > The one exception is smb, but only with config CIFS_NFSD_EXPORT
> > and that one depends on BROKEN.
> >
> > If we did want to require an explicit FAN_LOCAL_NOTIF flag to allow
> > setting marks on fs which may have changes not via local syscalls,
> > it may be a good idea to flag those fs and disallow them without explic=
it
> > opt-in, before we add fanotify support to fs with missing notifications=
?
> > Perhaps before the official release of 6.6?
>
> Yeah, overall I agree it would be nice to differentiate filesystems where
> we aren't going to generate all the events. But as I write above, there a=
re
> already existing users for non-FID mode so we cannot have that flag in th=
e
> general setting.
>
> > > > > configfs, debugfs, devpts, efivarfs, hugetlbfs, openpromfs, proc,=
 pstore,
> > > > > ramfs, sysfs, tracefs - virtual filesystems where fsnotify functi=
onality is
> > > > >   quite limited. But some special cases could be useful. Adding f=
sid support
> > > > >   is the same amount of trouble as for kernfs - a few LOC. In fac=
t, we
> > > > >   could perhaps add a fstype flag to indicate that this is a file=
system
> > > > >   without persistent identification and so uuid should be autogen=
erated on
> > > > >   mount (likely in alloc_super()) and f_fsid generated from sb->s=
_uuid.
> > > > >   This way we could handle all these filesystems with trivial amo=
unt of
> > > > >   effort.
> > > > >
> > > >
> > > > Christian,
> > > >
> > > > I recall that you may have had reservations on initializing s_uuid
> > > > and f_fsid in vfs code?
> > > > Does an opt-in fstype flag address your concerns?
> > > > Will you be ok with doing the tmpfs/kernfs trick for every fs
> > > > that opted-in with fstype flag in generic vfs code?
> > > >
> > > > > freevxfs - the only real filesystem without f_fsid. Trivial to ha=
ndle one
> > > > >   way or the other.
> > > > >
> > > >
> > > > Last but not least, btrfs subvolumes.
> > > > They do have an fsid, but it is different from the sb fsid,
> > > > so we disallow (even inode) fanotify marks.
> > > >
> > > > I am not sure how to solve this one,
> > > > but if we choose to implement the opt-in fanotify flag for
> > > > "watch single fs", we can make this problem go away, along
> > > > with the problem of network fs fsid and other odd fs that we
> > > > do not want to have to deal with.
> > > >
> > > > On top of everything, it is a fast solution and it doesn't
> > > > involve vfs and changing any fs at all.
> > >
> > > Yeah, right, forgot about this one. Thanks for reminding me. But this=
 is
> > > mostly a kernel internal implementation issue and doesn't seem to be =
a
> > > principial problem so I'd prefer not to complicate the uAPI for this.=
 We
> > > could for example mandate a special super_operation for fetching fsid=
 for a
> > > dentry for filesystems which don't have uniform fsids over the whole
> > > filesystem (i.e., btrfs) and call this when generating event for such
> > > filesystems. Or am I missing some other complication?
> > >
> >
> > The problem is the other way around :)
> > btrfs_statfs() takes a dentry and returns the fsid of the subvolume.
> > That is the fsid that users will get when querying the path to be marke=
d.
>
> Yup.
>
> > If users had a flag to statfs() to request the "btrfs root volume fsid"=
,
> > then fanotify could also report the root fsid and everyone will be happ=
y
> > because the btrfs file handle already contains the subvolume root
> > object id (FILEID_BTRFS_WITH_PARENT_ROOT), but that is not
> > what users get for statfs() and that is not what fanotify documentation
> > says about how to query fsid.
> >
> > We could report the subvolume fsid for marked inode/mount
> > that is not a problem - we just cache the subvol fsid in inode/mount
> > connector, but that fsid will be inconsistent with the fsid in the sb
> > connector, so the same object (in subvolume) can get events
> > with different fsid (e.g. if one event is in mask of sb and another
> > event is in mask of inode).
>
> Yes. I'm sorry I didn't describe all the details. My idea was to report
> even on a dentry with the fsid statfs(2) would return on it. We don't wan=
t
> to call dentry_statfs() on each event (it's costly and we don't always ha=
ve
> the dentry available) but we can have a special callback into the
> filesystem to get us just the fsid (which is very cheap) and call *that* =
on
> the inode on which the event happens to get fsid for the event. So yes, t=
he
> sb mark would be returning events with different fsids for btrfs. Or we
> could compare the obtained fsid with the one in the root volume and ignor=
e
> the event if they mismatch (that would be more like the different subvolu=
me
> =3D> different filesystem point of view and would require some more work =
on
> fanotify side to remember fsid in the sb mark and not in the sb connector=
).
>

It sounds like a big project.
I am not sure it is really needed.

On second thought, maybe getting different events on the
same subvol with different fsid is not that bad, because for
btrfs, it is possible to resolve the path of an fid in subvol
from either the root mount or the subvol mount.
IOW, subvol_fsid+fid and root_fsid+fid are two ways to
describe the same unique object.

Remember that we have two use cases for fsid+fid:
1. (unpriv/priv) User queries fsid+fid, sets an inode mark on path,
    stores fsid+fid<->path in a map to match events to path later
2. (priv-only) User queries fsid, sets a sb/mount mark on path,
    stores fsid<->path to match event to mntfd and
    resolves path by handle from mntfd+fid

Suppose we only allow to set sb marks on btrfs root volume,
but we relax the rule to allow btrfs inode/mount mark on subvol.

Use case #1 is not a problem.
If we prefer inode conn->fsid, to sb/mount conn->fsid, whichever
conn->fsid that is chosen, reports an fsid+fid that user has
recorded the path for, even if sb/mount marks also exist.

In use case #2,
- If the mark was on root sb, then the user has
  the root volume mntfd mapped to root fsid
- If the mark was on subvol mount, then the user has
  the subvol mntfd mapped to subvol fsid
- If the user has both marks it also has both mntfds,
  so it does not matter if events carry the root fsid
  (event is in the root sb mark mask) or if they carry the
  subvol fsid (event is in the subvol mount mark mask)

This needs a POC, but I think it should work.
In any case I can fix the btrfs inode marks.

Thanks,
Amir.
