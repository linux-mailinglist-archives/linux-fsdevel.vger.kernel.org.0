Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30AE6765CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 11:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjAUK5n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 05:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjAUK5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 05:57:39 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D072702;
        Sat, 21 Jan 2023 02:57:37 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id t10so8285595vsr.3;
        Sat, 21 Jan 2023 02:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3biplUWGJfsf66JQLG/s47IVawBkuREWHbwWCNlIjo=;
        b=FoWMM9U7BzA9sow+UnZnyui3ntlJYJwQzGyaAWTR2CFvitYYxNDCb78y2C7+cqyaO0
         uYVLybTHnKfG0OEWHJeIF3S12WnJVs/XIHh3nE066GCTr1Dk8Rz0aSZWRcYG4u+RI0om
         CYOoYtpCGCEzz+RVzP5ppW/ebk9LT/+BHDt8cNVyVxm2ll5DalQdzLsBNcy7REraPEB/
         0j+oVDuKJJchU9T3usVwu8ATUPL7l5uuAN3Bh9A9XQNa6jJSJLR/rC+8PCaEYS46JpW2
         P1hdc82ieqnmoRM7gggicYU4QZxtb3KIB5ajiPuIf0E1Pe0PXlqa4Ct6ATFoShpQhbCY
         5sWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3biplUWGJfsf66JQLG/s47IVawBkuREWHbwWCNlIjo=;
        b=m3vDoiqTxs589+vbzRRfKQk6e6bkw/L1NA1+e+kgou0TzazLyL7NOmnnPSUt+EOpce
         hf3fbEnjwrcrlsg1EIgZK4Kz+4U+86ivTbJneMMl5wZZSGM44b7p2f6FocfngDSoK4TI
         1dTG9M16ifSmH3I7O/Ro4+2OIegnfbbyGtckM6eUFDcY9UYkdfXzIYCgzd8w85m4IRA9
         Osat3un0fvEP+yMp17qbc96DBHi6M5beKY9hZc8E2COMoU3KyYiY3rivxK5TLalJ6LHu
         JNwJ4MbhfO/J34FiYSrLnrSoNpVneBxavPrNF52QXCLiwtk1FqxX4feMP2PlvQcI1Jk9
         M3zw==
X-Gm-Message-State: AFqh2kp6Xnk93uGRRsc9VnCkZ/F3XFrgVRu4xfpaIkvHh9mwYSw8OBLD
        4BwriM250WwRt1PxcQWbr2fuBSdXmm/kfb5uYCc=
X-Google-Smtp-Source: AMrXdXsHZRUKEzVz2KZmjOQBkW8l/4uzi1VYPQeLO0CMMa0gVe4ivFO0g4G6CSVgXcrWVz4VS4FzsM+Au2sUtFSXiwI=
X-Received: by 2002:a05:6102:f98:b0:3d3:c7d9:7b62 with SMTP id
 e24-20020a0561020f9800b003d3c7d97b62mr2251158vsv.72.1674298656241; Sat, 21
 Jan 2023 02:57:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674227308.git.alexl@redhat.com> <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <87ilh0g88n.fsf@redhat.com>
In-Reply-To: <87ilh0g88n.fsf@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 21 Jan 2023 12:57:24 +0200
Message-ID: <CAOQ4uxi7wT09MPf+edS6AkJzBCxjzOnCTfcdwn===q-+G2C4Gw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
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

On Sat, Jan 21, 2023 at 12:18 AM Giuseppe Scrivano <gscrivan@redhat.com> wr=
ote:
>
> Hi Amir,
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Fri, Jan 20, 2023 at 5:30 PM Alexander Larsson <alexl@redhat.com> wr=
ote:
> >>
> >> Giuseppe Scrivano and I have recently been working on a new project we
> >> call composefs. This is the first time we propose this publically and
> >> we would like some feedback on it.
> >>
> >> At its core, composefs is a way to construct and use read only images
> >> that are used similar to how you would use e.g. loop-back mounted
> >> squashfs images. On top of this composefs has two fundamental
> >> features. First it allows sharing of file data (both on disk and in
> >> page cache) between images, and secondly it has dm-verity like
> >> validation on read.
> >>
> >> Let me first start with a minimal example of how this can be used,
> >> before going into the details:
> >>
> >> Suppose we have this source for an image:
> >>
> >> rootfs/
> >> =E2=94=9C=E2=94=80=E2=94=80 dir
> >> =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 another_a
> >> =E2=94=9C=E2=94=80=E2=94=80 file_a
> >> =E2=94=94=E2=94=80=E2=94=80 file_b
> >>
> >> We can then use this to generate an image file and a set of
> >> content-addressed backing files:
> >>
> >> # mkcomposefs --digest-store=3Dobjects rootfs/ rootfs.img
> >> # ls -l rootfs.img objects/*/*
> >> -rw-------. 1 root root   10 Nov 18 13:20 objects/02/927862b4ab9fb6991=
9187bb78d394e235ce444eeb0a890d37e955827fe4bf4
> >> -rw-------. 1 root root   10 Nov 18 13:20 objects/cc/3da5b14909626fc99=
443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
> >> -rw-r--r--. 1 root root 4228 Nov 18 13:20 rootfs.img
> >>
> >> The rootfs.img file contains all information about directory and file
> >> metadata plus references to the backing files by name. We can now
> >> mount this and look at the result:
> >>
> >> # mount -t composefs rootfs.img -o basedir=3Dobjects /mnt
> >> # ls  /mnt/
> >> dir  file_a  file_b
> >> # cat /mnt/file_a
> >> content_a
> >>
> >> When reading this file the kernel is actually reading the backing
> >> file, in a fashion similar to overlayfs. Since the backing file is
> >> content-addressed, the objects directory can be shared for multiple
> >> images, and any files that happen to have the same content are
> >> shared. I refer to this as opportunistic sharing, as it is different
> >> than the more course-grained explicit sharing used by e.g. container
> >> base images.
> >>
> >> The next step is the validation. Note how the object files have
> >> fs-verity enabled. In fact, they are named by their fs-verity digest:
> >>
> >> # fsverity digest objects/*/*
> >> sha256:02927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf=
4 objects/02/927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf4
> >> sha256:cc3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173=
f objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
> >>
> >> The generated filesystm image may contain the expected digest for the
> >> backing files. When the backing file digest is incorrect, the open
> >> will fail, and if the open succeeds, any other on-disk file-changes
> >> will be detected by fs-verity:
> >>
> >> # cat objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b2=
3d43e173f
> >> content_a
> >> # rm -f objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89=
b23d43e173f
> >> # echo modified > objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1=
d18883dc89b23d43e173f
> >> # cat /mnt/file_a
> >> WARNING: composefs backing file '3da5b14909626fc99443f580e4d8c9b990e85=
e0a1d18883dc89b23d43e173f' unexpectedly had no fs-verity digest
> >> cat: /mnt/file_a: Input/output error
> >>
> >> This re-uses the existing fs-verity functionallity to protect against
> >> changes in file contents, while adding on top of it protection against
> >> changes in filesystem metadata and structure. I.e. protecting against
> >> replacing a fs-verity enabled file or modifying file permissions or
> >> xattrs.
> >>
> >> To be fully verified we need another step: we use fs-verity on the
> >> image itself. Then we pass the expected digest on the mount command
> >> line (which will be verified at mount time):
> >>
> >> # fsverity enable rootfs.img
> >> # fsverity digest rootfs.img
> >> sha256:da42003782992856240a3e25264b19601016114775debd80c01620260af86a7=
6 rootfs.img
> >> # mount -t composefs rootfs.img -o basedir=3Dobjects,digest=3Dda420037=
82992856240a3e25264b19601016114775debd80c01620260af86a76 /mnt
> >>
> >> So, given a trusted set of mount options (say unlocked from TPM), we
> >> have a fully verified filesystem tree mounted, with opportunistic
> >> finegrained sharing of identical files.
> >>
> >> So, why do we want this? There are two initial users. First of all we
> >> want to use the opportunistic sharing for the podman container image
> >> baselayer. The idea is to use a composefs mount as the lower directory
> >> in an overlay mount, with the upper directory being the container work
> >> dir. This will allow automatical file-level disk and page-cache
> >> sharning between any two images, independent of details like the
> >> permissions and timestamps of the files.
> >>
> >> Secondly we are interested in using the verification aspects of
> >> composefs in the ostree project. Ostree already supports a
> >> content-addressed object store, but it is currently referenced by
> >> hardlink farms. The object store and the trees that reference it are
> >> signed and verified at download time, but there is no runtime
> >> verification. If we replace the hardlink farm with a composefs image
> >> that points into the existing object store we can use the verification
> >> to implement runtime verification.
> >>
> >> In fact, the tooling to create composefs images is 100% reproducible,
> >> so all we need is to add the composefs image fs-verity digest into the
> >> ostree commit. Then the image can be reconstructed from the ostree
> >> commit info, generating a file with the same fs-verity digest.
> >>
> >> These are the usecases we're currently interested in, but there seems
> >> to be a breadth of other possible uses. For example, many systems use
> >> loopback mounts for images (like lxc or snap), and these could take
> >> advantage of the opportunistic sharing. We've also talked about using
> >> fuse to implement a local cache for the backing files. I.e. you would
> >> have the second basedir be a fuse filesystem. On lookup failure in the
> >> first basedir it downloads the file and saves it in the first basedir
> >> for later lookups. There are many interesting possibilities here.
> >>
> >> The patch series contains some documentation on the file format and
> >> how to use the filesystem.
> >>
> >> The userspace tools (and a standalone kernel module) is available
> >> here:
> >>   https://github.com/containers/composefs
> >>
> >> Initial work on ostree integration is here:
> >>   https://github.com/ostreedev/ostree/pull/2640
> >>
> >> Changes since v2:
> >> - Simplified filesystem format to use fixed size inodes. This resulted
> >>   in simpler (now < 2k lines) code as well as higher performance at
> >>   the cost of slightly (~40%) larger images.
> >> - We now use multi-page mappings from the page cache, which removes
> >>   limits on sizes of xattrs and makes the dirent handling code simpler=
.
> >> - Added more documentation about the on-disk file format.
> >> - General cleanups based on review comments.
> >>
> >
> > Hi Alexander,
> >
> > I must say that I am a little bit puzzled by this v3.
> > Gao, Christian and myself asked you questions on v2
> > that are not mentioned in v3 at all.
> >
> > To sum it up, please do not propose composefs without explaining
> > what are the barriers for achieving the exact same outcome with
> > the use of a read-only overlayfs with two lower layer -
> > uppermost with erofs containing the metadata files, which include
> > trusted.overlay.metacopy and trusted.overlay.redirect xattrs that refer
> > to the lowermost layer containing the content files.
>
> I think Dave explained quite well why using overlay is not comparable to
> what composefs does.
>

Where? Can I get a link please?
If there are good reasons why composefs is superior to erofs+overlayfs
Please include them in the submission, since several developers keep
raising the same questions - that is all I ask.

> One big difference is that overlay still requires at least a syscall for
> each file in the image, and then we need the equivalent of "rm -rf" to
> clean it up.  It is somehow acceptable for long-running services, but it
> is not for "serverless" containers where images/containers are created
> and destroyed frequently.  So even in the case we already have all the
> image files available locally, we still need to create a checkout with
> the final structure we need for the image.
>

I think you did not understand my suggestion:

overlay read-only mount:
    layer 1: erofs mount of a precomposed image (same as mkcomposefs)
    layer 2: any pre-existing fs path with /blocks repository
    layer 3: any per-existing fs path with /blocks repository
    ...

The mkcomposefs flow is exactly the same in this suggestion
the upper layer image is created without any syscalls and
removed without any syscalls.

Overlayfs already has the feature of redirecting from upper layer
to relative paths in lower layers.

> I also don't see how overlay would solve the verified image problem.  We
> would have the same problem we have today with fs-verity as it can only
> validate a single file but not the entire directory structure.  Changes
> that affect the layer containing the trusted.overlay.{metacopy,redirect}
> xattrs won't be noticed.
>

The entire erofs image would be fsverified including the overlayfs xattrs.
That is exactly the same model as composefs.
I am not even saying that your model is wrong, only that you are within
reach of implementing it with existing subsystems.

> There are at the moment two ways to handle container images, both somehow
> guided by the available file systems in the kernel.
>
> - A single image mounted as a block device.
> - A list of tarballs (OCI image) that are unpacked and mounted as
>   overlay layers.
>
> One big advantage of the block devices model is that you can use
> dm-verity, this is something we miss today with OCI container images
> that use overlay.
>
> What we are proposing with composefs is a way to have "dm-verity" style
> validation based on fs-verity and the possibility to share individual
> files instead of layers.  These files can also be on different file
> systems, which is something not possible with the block device model.
>
> The composefs manifest blob could be generated remotely and signed.  A
> client would need just to validate the signature for the manifest blob
> and from there retrieve the files that are not in the local CAS (even
> from an insecure source) and mount directly the manifest file.
>

Excellent description of the problem.
I agree that we need a hybrid solution between the block
and tarball image model.

All I am saying is that this solution can use existing kernel
components and existing established on-disk formats
(erofs+overlayfs).

What was missing all along was the userspace component
(i.e. composefs) and I am very happy that you guys are
working on this project.

These userspace tools could be useful for other use cases.
For example, overlayfs is able to describe a large directory
rename with redirect xattr since v4.9, but image composing
tools do not make use of that, so an OCI image describing a
large dir rename will currently contain all the files within.

Once again, you may or may not be able to use erofs and
overlayfs out of the box for your needs, but so far I did not
see any functionality gap that is not possible to close.

Please let me know if you know of such gaps or if my
proposal does not meet the goals of composefs.

Thanks,
Amir.
