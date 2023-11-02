Return-Path: <linux-fsdevel+bounces-1795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7F07DEE6B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 09:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45DC281A0E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 08:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B7A79D6;
	Thu,  2 Nov 2023 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+hy2ybY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7998B79C2
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 08:54:13 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC4E191;
	Thu,  2 Nov 2023 01:54:02 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-66d24ccc6f2so15255736d6.0;
        Thu, 02 Nov 2023 01:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698915242; x=1699520042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/kZLfpDPN/1t+qmfSry72Fhhn1LC5NXJUO2FF/ULTs=;
        b=m+hy2ybYDG/bIqimtdG6X+dVlpyx73YdC12KKUk0Mrzov2J2VZk8JXh/i6sIc4P7+a
         oujbo3lXlxHpoK54NNNWeCenP8Ox3K4tX7Hwr6SINZ4v/OaHexAj+BztFmqgpFzOJcAA
         ORjgyADB2zNc8Ki75Ji56FVdSghsL7ojE1O43znjXMHRfxdetNVMD3A/L4wn4e7HUkEn
         AU/dPQbxSU8AO8A0RUc//xcYpNIOgdLnmNwEp8u+kHsujUD0nKvMO+YWj3PqT2cQy0Nq
         FS+Pt9h5tZYAYiI+8CpJ46Wdw6o9apU4VbhaSuOEwCL7FTssggWTRnrsDLExZRK4IxmS
         /lXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698915242; x=1699520042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/kZLfpDPN/1t+qmfSry72Fhhn1LC5NXJUO2FF/ULTs=;
        b=GQQfkvDVf4sRPNyxh2m9D0mJ0ZpEx+K+h2Ri3n2pmv2Gvd+I+KD/DFRCJ8pOqAo0si
         tM8+k6QHxPRzu1uydv3K6NTaVxkaiTx5xaGcKYvvK7UBKHXuNkwKdpbhRPi21DubmmE+
         O93EcXDv11WMIwyyMVDmsOqftGpdeZjpf8kK1tYnER9zVzZPgA7E1o6q1BgB3LUoL+8m
         IOn6Zu7mMfsYd7LWOiDHa7KsIDF+kC9V+RsA19Fsi/mHo1w0g+0vvFEleyT5sr539uPj
         TKz5zLiSROt60DGC+D291cb44O5folNdRExu8232aHR+wbSXprXI7Q/c6JsXEFGgdtfg
         nuVA==
X-Gm-Message-State: AOJu0YwULiREWDDHJ38O/+y+5ouKE39DuuDHzNI6qmQwxGCf1ofCtKvi
	tkigKqevVtikFYs0D1svClkjmyBEecbmpbNTNgw=
X-Google-Smtp-Source: AGHT+IEzkB09uKn7erKXfRFE8esxLTA61UblTRaM+fV5HqU7BE3uPKIeE8DyU20j5xYwX6FahngMsM8FKJcgR04aNy8=
X-Received: by 2002:a05:6214:1307:b0:66d:327:bf8f with SMTP id
 pn7-20020a056214130700b0066d0327bf8fmr7686346qvb.30.1698915241636; Thu, 02
 Nov 2023 01:54:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZTtOmWEx5neNKkez@infradead.org> <20231027131726.GA2915471@perftesting>
 <ZT+uxSEh+nTZ2DEY@infradead.org> <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
 <ZUDxli5HTwDP6fqu@infradead.org> <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org> <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com> <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
In-Reply-To: <20231102051349.GA3292886@perftesting>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 2 Nov 2023 10:53:49 +0200
Message-ID: <CAOQ4uxietLxuv+gEb=k+Q1s+MYSS=af7kzOu6J_YXwxhWmhjsQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
To: Josef Bacik <josef@toxicpanda.com>, Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>, 
	Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 7:13=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> On Wed, Nov 01, 2023 at 10:52:18AM +0100, Christian Brauner wrote:
> > On Wed, Nov 01, 2023 at 07:11:53PM +1030, Qu Wenruo wrote:
> > >
> > >
> > > On 2023/11/1 18:46, Christian Brauner wrote:
> > > > On Tue, Oct 31, 2023 at 10:06:17AM -0700, Christoph Hellwig wrote:
> > > > > On Tue, Oct 31, 2023 at 01:50:46PM +0100, Christian Brauner wrote=
:
> > > > > > So this is effectively a request for:
> > > > > >
> > > > > > btrfs subvolume create /mnt/subvol1
> > > > > >
> > > > > > to create vfsmounts? IOW,
> > > > > >
> > > > > > mkfs.btrfs /dev/sda
> > > > > > mount /dev/sda /mnt
> > > > > > btrfs subvolume create /mnt/subvol1
> > > > > > btrfs subvolume create /mnt/subvol2
> > > > > >
> > > > > > would create two new vfsmounts that are exposed in /proc/<pid>/=
mountinfo
> > > > > > afterwards?
> > > > >
> > > > > Yes.
> > > > >
> > > > > > That might be odd. Because these vfsmounts aren't really mounte=
d, no?
> > > > >
> > > > > Why aren't they?
> > > > >
> > > > > > And so you'd be showing potentially hundreds of mounts in
> > > > > > /proc/<pid>/mountinfo that you can't unmount?
> > > > >
> > > > > Why would you not allow them to be unmounted?
> > > > >
> > > > > > And even if you treat them as mounted what would unmounting mea=
n?
> > > > >
> > > > > The code in btrfs_lookup_dentry that does a hand crafted version
> > > > > of the file system / subvolume crossing (the location.type !=3D
> > > > > BTRFS_INODE_ITEM_KEY one) would not be executed.
> > > >
> > > > So today, when we do:
> > > >
> > > > mkfs.btrfs -f /dev/sda
> > > > mount -t btrfs /dev/sda /mnt
> > > > btrfs subvolume create /mnt/subvol1
> > > > btrfs subvolume create /mnt/subvol2
> > > >
> > > > Then all subvolumes are always visible under /mnt.
> > > > IOW, you can't hide them other than by overmounting or destroying t=
hem.
> > > >
> > > > If we make subvolumes vfsmounts then we very likely alter this beha=
vior
> > > > and I see two obvious options:
> > > >
> > > > (1) They are fake vfsmounts that can't be unmounted:
> > > >
> > > >      umount /mnt/subvol1 # returns -EINVAL
> > > >
> > > >      This retains the invariant that every subvolume is always visi=
ble
> > > >      from the filesystems root, i.e., /mnt will include /mnt/subvol=
{1,}
> > >
> > > I'd like to go this option. But I still have a question.
> > >
> > > How do we properly unmount a btrfs?
> > > Do we have some other way to record which subvolume is really mounted
> > > and which is just those place holder?
> >
> > So the downside of this really is that this would be custom btrfs
> > semantics. Having mounts in /proc/<pid>/mountinfo that you can't unmoun=
t
> > only happens in weird corner cases today:
> >
> > * mounts inherited during unprivileged mount namespace creation
> > * locked mounts
> >
> > Both of which are pretty inelegant and effectively only exist because o=
f
> > user namespaces. So if we can avoid proliferating such semantics it
> > would be preferable.
> >
> > I think it would also be rather confusing for userspace to be presented
> > with a bunch of mounts in /proc/<pid>/mountinfo that it can't do
> > anything with.
> >
> > > > (2) They are proper vfsmounts:
> > > >
> > > >      umount /mnt/subvol1 # succeeds
> > > >
> > > >      This retains standard semantics for userspace about anything t=
hat
> > > >      shows up in /proc/<pid>/mountinfo but means that after
> > > >      umount /mnt/subvol1 succeeds, /mnt/subvol1 won't be accessible=
 from
> > > >      the filesystem root /mnt anymore.
> > > >
> > > > Both options can be made to work from a purely technical perspectiv=
e,
> > > > I'm asking which one it has to be because it isn't clear just from =
the
> > > > snippets in this thread.
> > > >
> > > > One should also point out that if each subvolume is a vfsmount, the=
n say
> > > > a btrfs filesystems with 1000 subvolumes which is mounted from the =
root:
> > > >
> > > > mount -t btrfs /dev/sda /mnt
> > > >
> > > > could be exploded into 1000 individual mounts. Which many users mig=
ht not want.
> > >
> > > Can we make it dynamic? AKA, the btrfs_insert_fs_root() is the perfec=
t
> > > timing here.
> >
> > Probably, it would be an automount. Though I would have to recheck that
> > code to see how exactly that would work but roughly, when you add the
> > inode for the subvolume you raise S_AUTOMOUNT on it and then you add
> > .d_automount for btrfs.
>
> Btw I'm working on this, mostly to show Christoph it doesn't do what he t=
hinks
> it does.
>
> However I ran into some weirdness where I need to support the new mount A=
PI, so
> that's what I've been doing since I wandered away from this thread.  I sh=
ould
> have that done tomorrow, and then I was going to do the S_AUTOMOUNT thing=
 ontop
> of that.
>
> But I have the same questions as you Christian, I'm not entirely sure how=
 this
> is supposed to be better.  Even if they show up in /proc/mounts, it's not=
 going
> to do anything useful for the applications that don't check /proc/mounts =
to see
> if they've wandered into a new mount.  I also don't quite understand how =
NFS
> suddenly knows it's wandered into a new mount with a vfsmount.
>

IIUC, the NFS server communicated the same/different filesystem to the clie=
nt
by means of an FSID. This is not the same f_fsid from statfs(), it's the FS=
ID
communicated to nfsd server from /etc/exports or guessed by nfsd server
for blockdev fs. IIRC, the NFS FSID is 128bit (?).

If we implemented the s_op->get_fsid() method that Jan has suggested [1],
we could make it mean -
"nfsd, please use this as the NFS FSID instead of assuming the all inodes o=
n
 this sb should be presented to the client as a uniform FSID".

[1] https://lore.kernel.org/linux-fsdevel/20231025135048.36153-2-amir73il@g=
mail.com/

> At this point I'm tired of it being brought up in every conversation wher=
e we
> try to expose more information to the users.  So I'll write the patches a=
nd as
> long as they don't break anything we can merge it, but I don't think it'l=
l make
> a single bit of difference.
>
> We'll be converted to the new mount API tho, so I suppose that's somethin=
g.

Horray!

I had just noticed that since Monday, we have a new fs on the block with
multiple subvol on the same sb - bcachefs.

I took a look at bch2_statfs(), bch2_encode_fh() and bch2_getattr() and
I can't help wondering, what's different from btrfs?

Kent,

Is inode->v.i_ino unique for all inodes in bcachefs sb
and inode->ei_inode.bi_inum unique within a subvol?
If so, how is a cloned inode number allocated?

BTW1: bch2_statfs() open codes uuid_to_fsid().
BTW2: Any reason why bcache fs uses  bch_sb.uuid and not sb.s_uuid?

If you publish bch_sb.uuid to vfs via sb.s_uuid, you can use
bcachefs as a layer in overlayfs for advance features like
NFS export of overlayfs - with s_uuid, those features will not
be available for overlayfs over bcachefs.

Thanks,
Amir.

