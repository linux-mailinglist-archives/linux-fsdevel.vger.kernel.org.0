Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8822371FFCD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 12:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbjFBKyO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 06:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjFBKyL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:54:11 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8118A194;
        Fri,  2 Jun 2023 03:54:07 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-75b17298108so178733485a.0;
        Fri, 02 Jun 2023 03:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685703246; x=1688295246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cQHr2UxcneX5TfpH9CtPoVeT5+NBUBjbfAeN3ef6Ys=;
        b=YuriXQztLXBVe7ezyi4GRHRULkEfct8sSFdVIh+PzJUJiIBA08INXPICAc6nTFfOW+
         t4YNUOCbjvSCuXIVbWjXcU+uLWbDgcMFA4Bwa9U9XPpdT77+0CJUTA4rqVR4VRaoUkNr
         KOcYv7DorpErPtuspGPy6gK1C6vnTj5f6J6Ux+6LBpMvDpdb6d7/xQaQDA+cK/tbwIZ9
         VTCxGqTzOhV0yvHq5iXcs/uU5ZT8ZykXIdPyD1o9irgXw4/JQaHeNSrCdqrqT8vxfJtl
         4H6gtLrPiLEp9/cvA/xX9oXCfAZaOwLrb93i9mN7JBHUMZhx997VdpiL3YDZXICoTgdV
         +FnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685703246; x=1688295246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cQHr2UxcneX5TfpH9CtPoVeT5+NBUBjbfAeN3ef6Ys=;
        b=AdtPh0G9vgk8Zk30jPKTQbpk0M5J6v1Kz2nPtQJuhhzyivokI05FKgtmsVYh83hK9b
         qoz9zlmvmCPsJHCuO/SsJapTYupa0gMYipgEHKj2+eLaPXLrwO0jgNVHYn8JIHkkAY8O
         +h+OmzNCtSOAEPQOCO+YFpoHVe6j99X+2F9YAbxL2N5dEW1Qi5Z3b/Cxy5r2fmMNA77+
         W7b1Nmpky5sIm/lG3l+YzqZ+c+688Gu8IV3iVkGSv1UhvmRupZMdlfBg2SNHyawlOrfV
         9lRRntP1k8bbHL3Y3PKy0Og7IJySCRh7QLGM0fLLyINMr+BlUDp15+ztdsTOaHA2qxl1
         JVEQ==
X-Gm-Message-State: AC+VfDzfp4S/p6W2Nc+Bwu8FJyWG9oqAw+Ni22wiEMYRFfl5FwU19OLc
        LXr8MA/5KzaOkYH0+Mvyr0a4h8DpWHdLgSMwydc=
X-Google-Smtp-Source: ACHHUZ5oRn8r9eekCZTt9vx2AoqlDMy7tebjruG+B7sHLhOC6dUeT8pqe7DDyk1cJREGXHYf/RpFELFetIhEL1HPtPM=
X-Received: by 2002:a05:620a:28d2:b0:75b:23a1:3f7 with SMTP id
 l18-20020a05620a28d200b0075b23a103f7mr14163961qkp.13.1685703246470; Fri, 02
 Jun 2023 03:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <078d8c1fd6b6de59cde8aa85f8e59a056cb78614.camel@linux.ibm.com>
 <20230520-angenehm-orangen-80fdce6f9012@brauner> <ZGqgDjJqFSlpIkz/@dread.disaster.area>
 <20230522-unsensibel-backblech-7be4e920ba87@brauner> <20230602012335.GB16848@frogsfrogsfrogs>
 <20230602042714.GE1128744@mit.edu> <ZHmNksPcA9tudSVQ@dread.disaster.area>
In-Reply-To: <ZHmNksPcA9tudSVQ@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 2 Jun 2023 13:53:55 +0300
Message-ID: <CAOQ4uxjN=ew1mzk+g31S99uLq10ab1i1wTz2Lt9H5rtzuBH6mg@mail.gmail.com>
Subject: Re: uuid ioctl - was: Re: [PATCH] overlayfs: Trigger file
 re-evaluation by IMA / EVM after writes
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 2, 2023 at 9:35=E2=80=AFAM Dave Chinner <david@fromorbit.com> w=
rote:
>
> On Fri, Jun 02, 2023 at 12:27:14AM -0400, Theodore Ts'o wrote:
> > On Thu, Jun 01, 2023 at 06:23:35PM -0700, Darrick J. Wong wrote:
> > > Someone ought to cc Ted since I asked him about this topic this morni=
ng
> > > and he said he hadn't noticed it going by...
> > >
> > > > > > In addition the uuid should be set when the filesystem is mount=
ed.
> > > > > > Unless the filesystem implements a dedicated ioctl() - like ext=
4 - to
> > > > > > change the uuid.
> > > > >
> > > > > IMO, that ext4 functionality is a landmine waiting to be stepped =
on.
> > > > >
> > > > > We should not be changing the sb->s_uuid of filesysetms dynamical=
ly.
> > > >
> > > > Yeah, I kinda agree. If it works for ext4 and it's an ext4 specific
> > > > ioctl then this is fine though.
> > >
> > > Now that Dave's brought up all kinds of questions about other parts o=
f
> > > the kernel using s_uuid for things, I'm starting to think that even e=
xt4
> > > shouldn't be changing its own uuid on the fly.
> >
> > So let's set some context here.  The tune2fs program in e2fsprogs has
> > supported changing the UUID for a *very* long time.  Specifically,
> > since September 7, 1996 (e2fsprogs version 1.05, when we first added
> > the UUID field in the ext2 superblock).
>
> Yup, and XFS has supported offline changing of the UUID a couple of
> years before that.
>
> > This feature was added from
> > the very beginning since in Large Installation System Administration
> > (LISA) systems, a very common thing to do is to image boot disks from
> > a "golden master", and then afterwards, you want to make sure the file
> > systems on each boot disk have a unique UUID; and this is done via
> > "tune2fs -U random /dev/sdXX".  Since I was working at MIT Project
> > Athena at the time, we regularly did this when installing Athena
> > client workstations, and when I added UUID support to ext2, I made
> > sure this feature was well-supported.
>
> See xfs_copy(8). This was a tool originally written, IIRC, in early
> 1995 for physically cloning sparse golden images in the SGI factory
> production line. It was multi-threaded and could write up to 16 scsi
> disks at once with a single ascending LBA order pass. The last thing
> it does is change the UUID of each clone to make them unique.
>
> There's nothing new here - this is all 30 years ago, and we've had
> tools changing filesystems UUIDs for all this time.
>
> > The tune2fs program allows the UUID to be changed via the file system
> > is mounted (with some caveats), which it did by directly modifying the
> > on-disk superblock.  Obviously, when it did that, it wouldn't change
> > sb->s_uuid "dynamically", although the next time the file system was
> > mounted, sb->s_uuid would get the new UUID.
>
> Yes, which means for userspace and most of the kernel it's no
> different to "unmount, change UUID, mount". It's effectively an
> offline change, even if the on-disk superblock is changed while the
> filesystem is mounted.
>
> > If overlayfs and IMA are
> > expecting that a file system's UUID would stay consant and persistent
> > --- well, that's not true, and it has always been that way, since
> > there are tools that make it trivially easy for a system administrator
> > to adjust the UUID.
>
> Yes, but that's not the point I've been making. My point is that the
> *online change of sb->s_uuid* that was being proposed for the
> XFS/generic variant of the ext4 online UUID change ioctl is
> completely new, and that's where all the problems start....
>
> > In addition to the LISA context, this feature is also commonly used in
> > various cloud deployments, since when you create a new VM, it
> > typically gets a new root file system, which is copied from a fixed,
> > read-only image.  So on a particular hyperscale cloud system, if we
> > didn't do anything special, there could be hundreds of thousands VM's
> > whose root file system would all have the same UUID, which would mean
> > that the UUID... isn't terribly unique.
>
> Again, nothing new here - we've been using snapshots/clones/reflinks
> for efficient VM storage provisioning for well over 15 years now.
>
> .....
>
> > This is the reason why we added the ext4 ioctl; it was intended for
> > the express use of "tune2fs -U", and like tune2fs -U, it doesn't
> > actually change sb->s_uuid; it only changes the on-disk superblock's
> > UUID.  This was mostly because we forgot about sb->s_uuid, to be
> > honest, but it means that regardless of whether "tune2fs -U" directly
> > modifies the block device, or uses the ext4 ioctl, the behaviour with
> > respect to sb->s_uuid is the same; it's not modified when the on-disk
> > uuid is changed.
>
> IOWs, not only was the ext4 functionality was poorly thought out, it
> was *poorly implemented*.
>
> So, let's take a step back here - we've done the use case thing to
> death now - and consider what is it we actually need here?
>
> All we need for the hyperscale/VM provisioning use case is for the
> the UUID to be changed at first boot/mount time before anything else
> happens.
>
> So why do we need userspace to be involved in that? Indeed,
> all the problems stem from needing to have userspace change the
> UUID.
>
> There's an obvious solution: a newly provisioned filesystem needs to
> change the uuid at first mount. The only issue is the
> kernel/filesystem doesn't know when the first mount is.
>
> Darrick suggested "mount -o setuuid=3Dxxxx" on #xfs earlier, but that
> requires changing userspace init stuff and, well, I hate single use
> case mount options like this.
>
> However, we have a golden image that every client image is cloned
> from. Say we set a special feature bit in that golden image that
> means "need UUID regeneration". Then on the first mount of the
> cloned image after provisioning, the filesystem sees the bit and
> automatically regenerates the UUID with needing any help from
> userspace at all.
>
> Problem solved, yes? We don't need userspace to change the uuid on
> first boot of the newly provisioned VM - the filesystem just makes
> it happen.
>

I like this idea.

> If the "first run" init scripts are set up to run blkid to grab the
> new uuid after mount and update whatever needs to be updated with
> the new root filesystem UUID, then we've moved the entire problem
> out of the VM boot path and back into the provisioning system where
> it should be.
>

Seems to me like libblkid does not check for unknown feature bits:
https://github.com/util-linux/util-linux/blob/01a0a556018694bfaf6b01a5a40f8=
d0d10641a1f/libblkid/src/superblocks/xfs.c#L173
I wonder how systems will behave when libblkid examines this image
and finds a null UUID, without regarding the feature flag.
This is something that can be fixed in userspace, but may cause complicatio=
ns.

> And then we don't need an ioctl to change UUIDs online, nor do we
> require the VFS, kernel subsystems, userspace infrastructure and
> applications to be capable of handling the UUID of a mounted
> filesystem changing without warning....
>
> > > > > The VFS does not guarantee in any way that it is safe to change t=
he
> > > > > sb->s_uuid (i.e. no locking, no change notifications, no udev
> > > > > events, etc). Various subsystems - both in the kernel and in
> > > > > userspace - use the sb->s_uuid as a canonical and/or persistent
> > > > > filesystem/device identifier and are unprepared to have it change
> > > > > while the filesystem is mounted and active.
> >
> > Note that the last sentence is a bit ambiguous.
>
> Well, yes, because while the UUID is normally persistent, if the
> administrator chooses to modify the UUID while the filesystem is
> unmounted, it will change between mounts.  In that case.....
>
> > There is the question
> > of whether sb->s_uuid won't change while the file system is mounted,
> > and then there is the question of whether s_uuid is **persistent**
> > ---- which is to say, that it won't change across mounts or reboots.
> >
> > If there are subsystems like IMA, overlayfs, pnfs, et.al, which expect
> > that, I'm sorry, but sysadmin tools to make it trivially easy to
> > change the file system UUID long-predate these other subsystems, and
> > there *are* system adminsitrators --- particularly in the LISA or
> > Cloud context --- which have used "tune2fs -U" for good and proper
> > reasons.
>
> .... it's on the sysadmins to understand they need to regenerate
> anything that is reliant on the old filesystem UUIDs before mounting
> the filesystem again to avoid these issues...
>

For the records, overlayfs looks at s_uuid to try and determine if the
underlying fs was swapped underneath it while overlayfs was offline.
It is sometimes allowed to swap the underlying fs, but overlayfs needs
to know about it.
s_uuid is used as part of a "persistent file handle" in a very similar way
that NFS clients use "fsid" for a unique file handle.

For the very basic overlayfs configuration, changing the lower fs uuid
will result in some overlayfs objects changing their inode numbers.
For overlayfs with opt-in index/nfs_export features, after changing the
underlying fs uuid, overlayfs could no longer be mounted with the same
layer configuration and those opt-in features enabled.

Thanks,
Amir.
