Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB6B777E75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 18:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjHJQju (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 12:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjHJQj3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:39:29 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C409C;
        Thu, 10 Aug 2023 09:39:28 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-44757af136cso479929137.3;
        Thu, 10 Aug 2023 09:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691685568; x=1692290368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiiUXlYJ8bvDKMXQX0ZpS7OfVahtG1U2z1S893Hu6ZU=;
        b=MRHaf2nEjiv5t5Q5zoZ0UefIWXOkWjR11SdaXVYzelWOneebbVCB3cHeCHu/l1S4aj
         tZHdJB4H0OWjl7w7FiTUQGuIsJFhmgFe9Nf/3Rj2u4tIfahYGZv2GbnKN/mltO2q60wZ
         sTV15EDdCdTHliC4RYvxDLyHniXcvUYzLvIubBiAWaA4poKsO7WCLJyOZrRshvRGVmq+
         ldlHhJOLuZBMe0jCvT5Q3ASTyW930C9fQWLpIasD6NAs0tKU8RMNdxrQLFjOPFFsUGgG
         T5y8zxlLG/LOjUIhGzDECYXnHbt7WtuLnsX6kIAwDmkpVskifAA9mmVp4qxX+knQr+P6
         sAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685568; x=1692290368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiiUXlYJ8bvDKMXQX0ZpS7OfVahtG1U2z1S893Hu6ZU=;
        b=BfbBxlq5LfP77OstwPPrVcjub6PNNBgcCwd7tJDixYQx/Q0mdjzaJbRTZhAjj5yxrV
         EwOmpOppw+/r6DKNHyGtBpj7iuIiRlljHhzzBwv2H1d6+E1sN26Uw6J1TroYzklSDwNF
         OkN3IfHvStmYayOeS6v2Q5tgE5nncJ7qrtouSGDlu4RzXdcDiEU/B6CH/UhP9+M0qpNt
         gqkmP1IoaBYeZ7Hdb4THxxYBT+H7lIPoHvbIIMa0XXejFOMk4/pgNba65LHY+gFDBFl/
         hMZXWNLFYT7358Slfa5Rbj9B8GEosSCo0LNfolQdAGr7GtMdDmQIkqonvjDWsqx4ZDf0
         dbvQ==
X-Gm-Message-State: AOJu0Yy6wp5iYW8e6QWaxE6/6l0CRoqj7P+YOge85+i7xB0qyJ0uFJ2j
        pnwnXV3R9wMrN+HbQt4AvlfOD5WZkXu4lUka06/JdSG54YcdAQ==
X-Google-Smtp-Source: AGHT+IGrX1ae/kXMdBqblfeIEI/NiLvob99ua2FBeyd4WVGKXISuhSkW8yHD7vYRNdG1Oh0tfwTkI8jasKFCVAxJC6A=
X-Received: by 2002:a05:6102:498:b0:43d:6660:581b with SMTP id
 n24-20020a056102049800b0043d6660581bmr2236672vsa.5.1691685567696; Thu, 10 Aug
 2023 09:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230802154131.2221419-1-hch@lst.de> <20230802154131.2221419-3-hch@lst.de>
 <20230803114651.ihtqqgthbdjjgxev@quack3> <CAKFNMomzHg33SHnp6xGMEZY=+k6Y4t7dvBvgBDbO9H3ujzNDCw@mail.gmail.com>
 <20230810110547.ks62g2flysgwpgru@quack3>
In-Reply-To: <20230810110547.ks62g2flysgwpgru@quack3>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 11 Aug 2023 01:39:10 +0900
Message-ID: <CAKFNMon_3A7dC+k1q_RjEnoXXNtxBJAUQud_FD4s4VrHZdCVzg@mail.gmail.com>
Subject: Re: [PATCH 02/12] nilfs2: use setup_bdev_super to de-duplicate the
 mount code
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 8:05=E2=80=AFPM Jan Kara wrote:
>
> On Fri 04-08-23 11:01:39, Ryusuke Konishi wrote:
> > On Thu, Aug 3, 2023 at 8:46=E2=80=AFPM Jan Kara wrote:
> > >
> > > On Wed 02-08-23 17:41:21, Christoph Hellwig wrote:
> > > > Use the generic setup_bdev_super helper to open the main block devi=
ce
> > > > and do various bits of superblock setup instead of duplicating the
> > > > logic.  This includes moving to the new scheme implemented in commo=
n
> > > > code that only opens the block device after the superblock has allo=
cated.
> > > >
> > > > It does not yet convert nilfs2 to the new mount API, but doing so w=
ill
> > > > become a bit simpler after this first step.
> > > >
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > >
> > > AFAICS nilfs2 could *almost* use mount_bdev() directly and then just =
do its
> >
> > > snapshot thing after mount_bdev() returns. But it has this weird logi=
c
> > > that: "if the superblock is already mounted but we can shrink the who=
le
> > > dcache, then do remount instead of ignoring mount options". Firstly, =
this
> > > looks racy - what prevents someone from say opening a file on the sb =
just
> > > after nilfs_tree_is_busy() shrinks dcache? Secondly, it is inconsiste=
nt
> > > with any other filesystem so it's going to surprise sysadmins not
> > > intimately knowing nilfs2. Thirdly, from userspace you cannot tell wh=
at
> > > your mount call is going to do. Last but not least, what is it really=
 good
> > > for? Ryusuke, can you explain please?
> > >
> > >                                                                 Honza
> >
> > I think you are referring to the following part:
> >
> > >        if (!s->s_root) {
> > ...
> > >        } else if (!sd.cno) {
> > >                if (nilfs_tree_is_busy(s->s_root)) {
> > >                        if ((flags ^ s->s_flags) & SB_RDONLY) {
> > >                                nilfs_err(s,
> > >                                          "the device already has a %s=
 mount.",
> > >                                          sb_rdonly(s) ? "read-only" :=
 "read/write");
> > >                                err =3D -EBUSY;
> > >                                goto failed_super;
> > >                        }
> > >                } else {
> > >                        /*
> > >                         * Try remount to setup mount states if the cu=
rrent
> > >                         * tree is not mounted and only snapshots use =
this sb.
> > >                         */
> > >                        err =3D nilfs_remount(s, &flags, data);
> > >                        if (err)
> > >                                goto failed_super;
> > >                }
> > >        }
> >
> > What this logic is trying to do is, if there is already a nilfs2 mount
> > instance for the device, and are trying to mounting the current tree
> > (sd.cno is 0, so this is not a snapshot mount), then will switch
> > depending on whether the current tree has a mount:
> >
> > - If the current tree is mounted, it's just like a normal filesystem.
> > (A read-only mount and a read/write mount can't coexist, so check
> > that, and reuse the instance if possible)
> > - Otherwise, i.e. for snapshot mounts only, do whatever is necessary
> > to add a new current mount, such as starting a log writer.
> >    Since it does the same thing that nilfs_remount does, so
> > nilfs_remount() is used there.
> >
> > Whether or not there is a current tree mount can be determined by
> > d_count(s->s_root) > 1 as nilfs_tree_is_busy() does.
> > Where s->s_root is always the root dentry of the current tree, not
> > that of the mounted snapshot.
>
> I see now, thanks for explanation! But one thing still is not clear to me=
.
> If you say have a snapshot mounted read-write and then you mount the
> current snapshot (cno =3D=3D 0) read-only, you'll switch the whole superb=
lock
> to read-only state. So also the mounted snapshot is suddently read-only
> which is unexpected and actually supposedly breaks things because you can
> still have file handles open for writing on the snapshot etc.. So how do
> you solve that?
>
>                                                                 Honza

One thing I have to tell you as a premise is that nilfs2's snapshot
mounts (cno !=3D 0) are read-only.

The read-only option is mandatory for nilfs2 snapshot mounts, so
remounting to read/write mode will result in an error.
This constraint is checked in nilfs_parse_snapshot_option() which is
called from nilfs_identify().

In fact, any write mode file/inode operations on a snapshot mount will
result in an EROFS error, regardless of whether the coexisting current
tree mount is read-only or read/write (i.e. regardless of the
read-only flag of the superblock instance).

This is mostly (and possibly entirely) accomplished at the vfs layer
by checking the MNT_READONLY flag in mnt_flags of the vfsmount
structure, and even on the nilfs2 side,  iops->permission
(=3Dnilfs_permission) rejects write operations on snapshot mounts.

Therefore, the problem you pointed out shouldn't occur in the first
place since the situation where a snapshot with a handle in write mode
suddenly becomes read-only doesn't happen.   Unless I'm missing
something..

Regards,
Ryusuke Konishi
