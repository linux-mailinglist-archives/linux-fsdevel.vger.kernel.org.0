Return-Path: <linux-fsdevel+bounces-1242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139837D82C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 14:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A131C20EC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2926718C39;
	Thu, 26 Oct 2023 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISbqW9Ve"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839918480
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 12:37:04 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86968193;
	Thu, 26 Oct 2023 05:37:02 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-778999c5ecfso66907185a.2;
        Thu, 26 Oct 2023 05:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698323821; x=1698928621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TU8lx6TOyLPafNYRhGdIjsv507MO+BD38ImNLDidbKo=;
        b=ISbqW9Ve/UeNUxGr5pk3uz64hHt1Lg13aNeTH5yhlikLP42DR+E+htLJ2LjeOSMEdQ
         kuWQsFFYMPwjJfTioXcvfYGzMOBQ4QXV/WnsZGGEFiicIJHeUL3jqtjJPLdqiQTWmLrU
         ubY2d1t26LV2xtBfGtk6es+Nag2v3IgFHFZjKO8BXHFH39OBNeeYq+nYMP+sTjI14BHz
         jbvisVi+SLJmfBwnaYIuSVQK5GWh2eSNRyoqkzuBqcZWlknKqc1Yj+PcROKBJenkGsOI
         gIclR1yWOAfSHI3RmmmhQW0I2u0HcMoFXp/IN66R4BcJF1I+cl1o/gXHRT45tLS6knUK
         X/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698323821; x=1698928621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TU8lx6TOyLPafNYRhGdIjsv507MO+BD38ImNLDidbKo=;
        b=rbLdXHZsiYaWF6acmGSplmBj2Kr7Ik+iHK5wzHY87twC41mDRh9pmtgFG07NuYgIu3
         7K3HevjVDWlPFhPzMnJTs+v5aVwL3Mw51fUg+cAVmv+aOMuS6RQ6Q9jQqsafqyOsZgbO
         3ZkdtHZbVD5wL1Yer7x7i7oz7QBwvJZbrqr7+DY5tX9Rc0xzIAQyhrNb4+4GwMReCwD5
         EUWaXBZMBVw/Gf09dezaSTz/Fka6fh26Lyu8STdzEjxzP2bzmDPf1bPd2ZIwAV/x2zgw
         8qZy7XrfypESHuP7NTAeKy3uTyq/GkwVd1OuMDcFmJF9gHi64av9euqDzD/VwY9lDgvv
         RnVw==
X-Gm-Message-State: AOJu0YxswEO5CM6XTPEFOhn1ExTeRRYfx4Lq+MWLWuWf+1+n2F/hl838
	TuQz0zo4EVuKEHRYqGz2SWLjPDrg+TCRGZILaZw=
X-Google-Smtp-Source: AGHT+IHHwwUhJNwCnMgCP53IGq1GF+QxpIpR1ZBCGjwB3j32BSiwleFO8tVHFx+VhE1PmsKVjpR2Ca3Ja4YwlNoDR8k=
X-Received: by 2002:a05:6214:130b:b0:66d:ba80:2324 with SMTP id
 pn11-20020a056214130b00b0066dba802324mr17325681qvb.41.1698323821449; Thu, 26
 Oct 2023 05:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025135048.36153-1-amir73il@gmail.com> <CAOQ4uxg2uFz8bR37bwR_OwnDkq5C7NG+hoqu=7gwSC5Zjd4Ccg@mail.gmail.com>
 <CAOQ4uxjJFyXUOP_46O9erdCEmwctBc8BVJU_jTzyX4d+m0gFyg@mail.gmail.com> <20231026121734.o4k7djftwdnectq4@quack3>
In-Reply-To: <20231026121734.o4k7djftwdnectq4@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Oct 2023 15:36:50 +0300
Message-ID: <CAOQ4uxg9wjESoCFNDADbneF0-nW4xVHHV3Rhhp=gJwAs=S83dQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 3:17=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 25-10-23 21:02:45, Amir Goldstein wrote:
> > On Wed, Oct 25, 2023 at 8:17=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > On Wed, Oct 25, 2023 at 4:50=E2=80=AFPM Amir Goldstein <amir73il@gmai=
l.com> wrote:
> > > >
> > > > Jan,
> > > >
> > > > This patch set implements your suggestion [1] for handling fanotify
> > > > events for filesystems with non-uniform f_fsid.
> > > >
> > > > With these changes, events report the fsid as it would be reported
> > > > by statfs(2) on the same objet, i.e. the sub-volume's fsid for an i=
node
> > > > in sub-volume.
> > > >
> > > > This creates a small challenge to watching program, which needs to =
map
> > > > from fsid in event to a stored mount_fd to use with open_by_handle_=
at(2).
> > > > Luckily, for btrfs, fsid[0] is uniform and fsid[1] is per sub-volum=
e.
> > > >
> > > > I have adapted fsnotifywatch tool [2] to be able to watch btrfs sb.
> > > > The adapted tool detects the special case of btrfs (a bit hacky) an=
d
> > > > indexes the mount_fd to be used for open_by_handle_at(2) by fsid[0]=
.
> > > >
> > > > Note that this hackacry is not needed when the tool is watching a
> > > > single filesystem (no need for mount_fd lookup table), because btrf=
s
> > > > correctly decodes file handles from any sub-volume with mount_fd fr=
om
> > > > any other sub-volume.
> > >
> > > Jan,
> > >
> > > Now that I've implemented the userspace part of btrfs sb watch,
> > > I realize that if userspace has to be aware of the fsid oddity of btr=
fs
> > > anyway, maybe reporting the accurate fsid of the object in event is
> > > not that important at all.
> > >
> > > Facts:
> > > 1. file_handle is unique across all sub-volumes and can be resolved
> > >     from any fd on any sub-volume
> > > 2. fsid[0] can be compared to match an event to a btrfs sb, where any
> > >     fd can be used to resolve file_handle
> > > 3. userspace needs to be aware of this fsid[0] fact if it watches mor=
e
> > >     than a single sb and userspace needs not care about the value of
> > >     fsid in event at all when watching a single sb
> > > 4. even though fanotify never allowed setting sb mark on a path insid=
e
> > >     btrfs sub-volume, it always reported events on inodes in sub-volu=
mes
> > >     to btrfs sb watch - those events always carried the "wrong" fsid =
(i.e.
> > >     the btrfs root volume fsid)
> > > 5. we already agreed that setting up inode marks on inodes inside
> > >     sub-volume should be a no brainer
> > >
> > > If we allow reporting either sub-vol fsid or root-vol fsid (exactly a=
s
> > > we do for inodes in sub-vol in current upstream),
> >
> > Another way to put it is that fsid in event describes the object
> > that was used to setup the mark not the target object.
> >
> > If an event is received via an inode/sb/mount mark, the fsid
> > would always describe the fsid of the inode that was used to setup
> > the mark and that is always the fsid that userspace would query
> > statfs(2) at the time of calling the fanotify_mark(2) call.
> >
> > Maybe it is non trivial to document, but for a library that returns
> > an opaque "watch descriptor", the "watch descriptor" can always
> > be deduced from the event.
> >
> > Does this make sense?
>
> Yes, it makes sense if we always reported event with fsid of the object
> used for placing the mark. For filesystems with homogeneous fsid there's =
no
> difference, for btrfs it looks like the least surprising choice and works
> well for inode marks as well. The only catch is in the internal fsnotify
> implementation AFAICT - if we have multiple marks for the same btrfs
> superblock, each mark on different subvolume, then we should be reporting
> one event with different fsids for different marks. So we need to cache t=
he
> fsid in the mark and not in the connector. But that should be easy to do.

True. I thought about this as well.

I have prepared the would be man page (fanotify.7) update:

fsid   This is a unique identifier of the filesystem containing the object
         associated with the event.  It is a structure of type
__kernel_fsid_t and
         contains the same value reported in  f_fsid  when calling
statfs(2) with
         the same pathname argument that was used for fanotify_mark(2).
         Note that some filesystems (e.g., btrfs(5)) report
non-uniform values of
         f_fsid on different objects of the same filesystem.  In these case=
s, if
         fanotify_mark(2) is called several times with different
pathname values,
         the fsid value reported in events will match f_fsid associated  wi=
th at
         least one of those pathname values.

FWIW, I removed the -EXDEV subvolume change and ran the upstream
fsnotifywatch tool (without btrfs magic) on btrfs sub-volume and it correct=
ly
resolves paths for all events in the filesystem:

root@kvm-xfstests:~# fsnotifywatch --filesystem /vdf/sub/vol/ &
[1] 1703
root@kvm-xfstests:~# Establishing watches...
Setting up filesystem watch on /vdf/sub/vol/
Finished establishing watches, now collecting statistics.

root@kvm-xfstests:~# touch /vdf/x /vdf/sub/vol/y
root@kvm-xfstests:~# fg
fsnotifywatch --filesystem /vdf/sub/vol/
^Ctotal  attrib  close_write  open  create  filename
3      1       1            1     1       /vdf/x
3      1       1            1     1       /vdf/sub/vol/y

I will prepare the patch.

Thanks,
Amir.

