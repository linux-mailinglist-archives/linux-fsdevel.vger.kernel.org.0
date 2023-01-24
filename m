Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EC367A262
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 20:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjAXTG7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 14:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbjAXTGm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:06:42 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0624E508;
        Tue, 24 Jan 2023 11:06:26 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id i188so17493317vsi.8;
        Tue, 24 Jan 2023 11:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leJAk1/PxgT2SR9z+DmM35hUPH1YZ76whta6pT/as+k=;
        b=ZWA2qw3ZXfk43/a2SdPGadORFul9ckHbfDrgZ0YqzbRlgoeKa6Aa8wdB53g2Fxf5Ke
         RqHLtBySvtWAHgTWMN9tLDAIaBr/Rr6nnAh2Mk4ZNItz+F7jDsIrCTPcIZg8cSz1RmQZ
         S+OmYCbbExAihf1XK/fp1DctTRaiVdJmJH2fSUVEv27I3VRi7X+9nKRdRRbVDtaSAzLu
         npYoY0cZUQUp/bw3lwqRmi6fgkkDmhE8m3avbQryZK4YblC1hkZG7jvjEcdrDhtANjQJ
         jtdR7b7/kYZ07ZJ2zjbwAxhnu8V3CJpY/EjE4ioaBwQd//Gzd2OrPla2YV0+ej2U4Z1r
         nIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leJAk1/PxgT2SR9z+DmM35hUPH1YZ76whta6pT/as+k=;
        b=D8VDljG0n0Ohk0QokvjPqXqelC3fZXxfigjB4vm64SQht7C2IsVOIeVG/9x1rwURgC
         BQqhPZO7ft0N/KI8apMeyQ2mCRPP8AI0z7q5FN8KzttRgOqApHLvmnn6m51A9fGsHAVM
         S52TNJ4NzQj+NvQea004KpkcoD0g6I1lNszfr0cP9NQ9jYrxSqt+KRJxI5z3vDZ4LEcv
         mvhT3YCbYzdvmwBYyBJGAmM6HfNzyJisybcbYtdKNqGdpK8NrPo04jzr0Kt8UvV3VrfM
         u8YHf2i9ugk6FU04jhKH2+0QFiPUUq5mlejfnxHFvik+Pm54q1n5kbqVfh/QIeBkLvDG
         LDeQ==
X-Gm-Message-State: AFqh2koEfg+Ddi0QBqcP6QWDiNZgg1FIYTFnMvtsKqfOAM2TWqrJVHhQ
        aex3GL3P9UuJWsAPLNlRXLs1oafPZX1e2/hcXNM6nKWlMzI=
X-Google-Smtp-Source: AMrXdXtZFsJ/fgMWL6eijMHP69M7tPMKncJn2ILj3eWMbFnTXek98haRv8sbL8KbWyqyOyLFxkozHoPU3H/0jK6rSK8=
X-Received: by 2002:a05:6102:5587:b0:3d1:2167:11ad with SMTP id
 dc7-20020a056102558700b003d1216711admr3685220vsb.2.1674587185801; Tue, 24 Jan
 2023 11:06:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674227308.git.alexl@redhat.com> <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
 <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com> <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
In-Reply-To: <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 Jan 2023 21:06:13 +0200
Message-ID: <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Alexander Larsson <alexl@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com, david@fromorbit.com, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
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

On Tue, Jan 24, 2023 at 3:13 PM Alexander Larsson <alexl@redhat.com> wrote:
>
> On Tue, 2023-01-24 at 05:24 +0200, Amir Goldstein wrote:
> > On Mon, Jan 23, 2023 at 7:56 PM Alexander Larsson <alexl@redhat.com>
> > wrote:
> > >
> > > On Fri, 2023-01-20 at 21:44 +0200, Amir Goldstein wrote:
> > > > On Fri, Jan 20, 2023 at 5:30 PM Alexander Larsson
> > > > <alexl@redhat.com>
> > > > wrote:
> > > > >
> > > > > Giuseppe Scrivano and I have recently been working on a new
> > > > > project
> > > > > we
> > > > > call composefs. This is the first time we propose this
> > > > > publically
> > > > > and
> > > > > we would like some feedback on it.
> > > > >
> > > >
> > > > Hi Alexander,
> > > >
> > > > I must say that I am a little bit puzzled by this v3.
> > > > Gao, Christian and myself asked you questions on v2
> > > > that are not mentioned in v3 at all.
> > >
> > > I got lots of good feedback from Dave Chinner on V2 that caused
> > > rather
> > > large changes to simplify the format. So I wanted the new version
> > > with
> > > those changes out to continue that review. I think also having that
> > > simplified version will be helpful for the general discussion.
> > >
> >
> > That's ok.
> > I was not puzzled about why you posted v3.
> > I was puzzled by why you did not mention anything about the
> > alternatives to adding a new filesystem that were discussed on
> > v2 and argue in favor of the new filesystem option.
> > If you post another version, please make sure to include a good
> > explanation for that.
>
> Sure, I will add something to the next version. But like, there was
> already a discussion about this, duplicating that discussion in the v3
> announcement when the v2->v3 changes are unrelated to it doesn't seem
> like it makes a ton of difference.
>
> > > > To sum it up, please do not propose composefs without explaining
> > > > what are the barriers for achieving the exact same outcome with
> > > > the use of a read-only overlayfs with two lower layer -
> > > > uppermost with erofs containing the metadata files, which include
> > > > trusted.overlay.metacopy and trusted.overlay.redirect xattrs that
> > > > refer to the lowermost layer containing the content files.
> > >
> > > So, to be more precise, and so that everyone is on the same page,
> > > lemme
> > > state the two options in full.
> > >
> > > For both options, we have a directory "objects" with content-
> > > addressed
> > > backing files (i.e. files named by sha256). In this directory all
> > > files have fs-verity enabled. Additionally there is an image file
> > > which you downloaded to the system that somehow references the
> > > objects
> > > directory by relative filenames.
> > >
> > > Composefs option:
> > >
> > >  The image file has fs-verity enabled. To use the image, you mount
> > > it
> > >  with options "basedir=3Dobjects,digest=3D$imagedigest".
> > >
> > > Overlayfs option:
> > >
> > >  The image file is a loopback image of a gpt disk with two
> > > partitions,
> > >  one partition contains the dm-verity hashes, and the other
> > > contains
> > >  some read-only filesystem.
> > >
> > >  The read-only filesystem has regular versions of directories and
> > >  symlinks, but for regular files it has sparse files with the
> > > xattrs
> > >  "trusted.overlay.metacopy" and "trusted.overlay.redirect" set, the
> > >  later containing a string like like "/de/adbeef..." referencing a
> > >  backing file in the "objects" directory. In addition, the image
> > > also
> > >  contains overlayfs whiteouts to cover any toplevel filenames from
> > > the
> > >  objects directory that would otherwise appear if objects is used
> > > as
> > >  a lower dir.
> > >
> > >  To use this you loopback mount the file, and use dm-verity to set
> > > up
> > >  the combined partitions, which you then mount somewhere. Then you
> > >  mount an overlayfs with options:
> > >   "metacopy=3Don,redirect_dir=3Dfollow,lowerdir=3Dveritydev:objects"
> > >
> > > I would say both versions of this can work. There are some minor
> > > technical issues with the overlay option:
> > >
> > > * To get actual verification of the backing files you would need to
> > > add support to overlayfs for an "trusted.overlay.digest" xattrs,
> > > with
> > > behaviour similar to composefs.
> > >
> > > * mkfs.erofs doesn't support sparse files (not sure if the kernel
> > > code
> > > does), which means it is not a good option for the backing all
> > > these
> > > sparse files. Squashfs seems to support this though, so that is an
> > > option.
> > >
> >
> > Fair enough.
> > Wasn't expecting for things to work without any changes.
> > Let's first agree that these alone are not a good enough reason to
> > introduce a new filesystem.
> > Let's move on..
>
> Yeah.
>
> > > However, the main issue I have with the overlayfs approach is that
> > > it
> > > is sort of clumsy and over-complex. Basically, the composefs
> > > approach
> > > is laser focused on read-only images, whereas the overlayfs
> > > approach
> > > just chains together technologies that happen to work, but also do
> > > a
> > > lot of other stuff. The result is that it is more work to use it,
> > > it
> > > uses more kernel objects (mounts, dm devices, loopbacks) and it has
> >
> > Up to this point, it's just hand waving, and a bit annoying if I am
> > being honest.
> > overlayfs+metacopy feature were created for the containers use case
> > for very similar set of requirements - they do not just "happen to
> > work"
> > for the same use case.
> > Please stick to technical arguments when arguing in favor of the new
> > "laser focused" filesystem option.
> >
> > > worse performance.
> > >
> > > To measure performance I created a largish image (2.6 GB centos9
> > > rootfs) and mounted it via composefs, as well as overlay-over-
> > > squashfs,
> > > both backed by the same objects directory (on xfs).
> > >
> > > If I clear all caches between each run, a `ls -lR` run on composefs
> > > runs in around 700 msec:
> > >
> > > # hyperfine -i -p "echo 3 > /proc/sys/vm/drop_caches" "ls -lR cfs-
> > > mount"
> > > Benchmark 1: ls -lR cfs-mount
> > >   Time (mean =C2=B1 =CF=83):     701.0 ms =C2=B1  21.9 ms    [User: 1=
53.6 ms,
> > > System: 373.3 ms]
> > >   Range (min =E2=80=A6 max):   662.3 ms =E2=80=A6 725.3 ms    10 runs
> > >
> > > Whereas same with overlayfs takes almost four times as long:
> >
> > No it is not overlayfs, it is overlayfs+squashfs, please stick to
> > facts.
> > As Gao wrote, squashfs does not optimize directory lookup.
> > You can run a test with ext4 for POC as Gao suggested.
> > I am sure that mkfs.erofs sparse file support can be added if needed.
>
> New measurements follow, they now include also erofs over loopback,
> although that isn't strictly fair, because that image is much larger
> due to the fact that it didn't store the files sparsely. It also
> includes a version where the topmost lower is directly on the backing
> xfs (i.e. not via loopback). I attached the scripts used to create the
> images and do the profiling in case anyone wants to reproduce.
>
> Here are the results (on x86-64, xfs base fs):
>
> overlayfs + loopback squashfs - uncached
> Benchmark 1: ls -lR mnt-ovl
>   Time (mean =C2=B1 =CF=83):      2.483 s =C2=B1  0.029 s    [User: 0.167=
 s, System: 1.656 s]
>   Range (min =E2=80=A6 max):    2.427 s =E2=80=A6  2.530 s    10 runs
>
> overlayfs + loopback squashfs - cached
> Benchmark 1: ls -lR mnt-ovl
>   Time (mean =C2=B1 =CF=83):     429.2 ms =C2=B1   4.6 ms    [User: 123.6=
 ms, System: 295.0 ms]
>   Range (min =E2=80=A6 max):   421.2 ms =E2=80=A6 435.3 ms    10 runs
>
> overlayfs + loopback ext4 - uncached
> Benchmark 1: ls -lR mnt-ovl
>   Time (mean =C2=B1 =CF=83):      4.332 s =C2=B1  0.060 s    [User: 0.204=
 s, System: 3.150 s]
>   Range (min =E2=80=A6 max):    4.261 s =E2=80=A6  4.442 s    10 runs
>
> overlayfs + loopback ext4 - cached
> Benchmark 1: ls -lR mnt-ovl
>   Time (mean =C2=B1 =CF=83):     528.3 ms =C2=B1   4.0 ms    [User: 143.4=
 ms, System: 381.2 ms]
>   Range (min =E2=80=A6 max):   521.1 ms =E2=80=A6 536.4 ms    10 runs
>
> overlayfs + loopback erofs - uncached
> Benchmark 1: ls -lR mnt-ovl
>   Time (mean =C2=B1 =CF=83):      3.045 s =C2=B1  0.127 s    [User: 0.198=
 s, System: 1.129 s]
>   Range (min =E2=80=A6 max):    2.926 s =E2=80=A6  3.338 s    10 runs
>
> overlayfs + loopback erofs - cached
> Benchmark 1: ls -lR mnt-ovl
>   Time (mean =C2=B1 =CF=83):     516.9 ms =C2=B1   5.7 ms    [User: 139.4=
 ms, System: 374.0 ms]
>   Range (min =E2=80=A6 max):   503.6 ms =E2=80=A6 521.9 ms    10 runs
>
> overlayfs + direct - uncached
> Benchmark 1: ls -lR mnt-ovl
>   Time (mean =C2=B1 =CF=83):      2.562 s =C2=B1  0.028 s    [User: 0.199=
 s, System: 1.129 s]
>   Range (min =E2=80=A6 max):    2.497 s =E2=80=A6  2.585 s    10 runs
>
> overlayfs + direct - cached
> Benchmark 1: ls -lR mnt-ovl
>   Time (mean =C2=B1 =CF=83):     524.5 ms =C2=B1   1.6 ms    [User: 148.7=
 ms, System: 372.2 ms]
>   Range (min =E2=80=A6 max):   522.8 ms =E2=80=A6 527.8 ms    10 runs
>
> composefs - uncached
> Benchmark 1: ls -lR mnt-fs
>   Time (mean =C2=B1 =CF=83):     681.4 ms =C2=B1  14.1 ms    [User: 154.4=
 ms, System: 369.9 ms]
>   Range (min =E2=80=A6 max):   652.5 ms =E2=80=A6 703.2 ms    10 runs
>
> composefs - cached
> Benchmark 1: ls -lR mnt-fs
>   Time (mean =C2=B1 =CF=83):     390.8 ms =C2=B1   4.7 ms    [User: 144.7=
 ms, System: 243.7 ms]
>   Range (min =E2=80=A6 max):   382.8 ms =E2=80=A6 399.1 ms    10 runs
>
> For the uncached case, composefs is still almost four times faster than
> the fastest overlay combo (squashfs), and the non-squashfs versions are
> strictly slower. For the cached case the difference is less (10%) but
> with similar order of performance.
>
> For size comparison, here are the resulting images:
>
> 8.6M large.composefs
> 2.5G large.erofs
> 200M large.ext4
> 2.6M large.squashfs
>

Nice.
Clearly, mkfs.ext4 and mkfs.erofs are not optimized for space.
Note that Android has make_ext4fs which can create a compact
ro ext4 image without a journal.
Found this project that builds it outside of Android, but did not test:
https://github.com/iglunix/make_ext4fs

> > > # hyperfine -i -p "echo 3 > /proc/sys/vm/drop_caches" "ls -lR ovl-
> > > mount"
> > > Benchmark 1: ls -lR ovl-mount
> > >   Time (mean =C2=B1 =CF=83):      2.738 s =C2=B1  0.029 s    [User: 0=
.176 s,
> > > System: 1.688 s]
> > >   Range (min =E2=80=A6 max):    2.699 s =E2=80=A6  2.787 s    10 runs
> > >
> > > With page cache between runs the difference is smaller, but still
> > > there:
> >
> > It is the dentry cache that mostly matters for this test and please
> > use hyerfine -w 1 to warmup dentry cache for correct measurement
> > of warm cache lookup.
>
> I'm not sure why the dentry cache case would be more important?
> Starting a new container will very often not have cached the image.
>
> To me the interesting case is for a new image, but with some existing
> page cache for the backing files directory. That seems to model staring
> a new image in an active container host, but its somewhat hard to test
> that case.
>

ok, you can argue that faster cold cache ls -lR is important
for starting new images.
I think you will be asked to show a real life container use case where
that benchmark really matters.

> > I guess these test runs started with warm cache? but it wasn't
> > mentioned explicitly.
>
> Yes, they were warm (because I ran the previous test before it). But,
> the new profile script explicitly adds -w 1.
>
> > > # hyperfine "ls -lR cfs-mnt"
> > > Benchmark 1: ls -lR cfs-mnt
> > >   Time (mean =C2=B1 =CF=83):     390.1 ms =C2=B1   3.7 ms    [User: 1=
40.9 ms,
> > > System: 247.1 ms]
> > >   Range (min =E2=80=A6 max):   381.5 ms =E2=80=A6 393.9 ms    10 runs
> > >
> > > vs
> > >
> > > # hyperfine -i "ls -lR ovl-mount"
> > > Benchmark 1: ls -lR ovl-mount
> > >   Time (mean =C2=B1 =CF=83):     431.5 ms =C2=B1   1.2 ms    [User: 1=
24.3 ms,
> > > System: 296.9 ms]
> > >   Range (min =E2=80=A6 max):   429.4 ms =E2=80=A6 433.3 ms    10 runs
> > >
> > > This isn't all that strange, as overlayfs does a lot more work for
> > > each lookup, including multiple name lookups as well as several
> > > xattr
> > > lookups, whereas composefs just does a single lookup in a pre-
> > > computed
> >
> > Seriously, "multiple name lookups"?
> > Overlayfs does exactly one lookup for anything but first level
> > subdirs
> > and for sparse files it does the exact same lookup in /objects as
> > composefs.
> > Enough with the hand waving please. Stick to hard facts.
>
> With the discussed layout, in a stat() call on a regular file,
> ovl_lookup() will do lookups on both the sparse file and the backing
> file, whereas cfs_dir_lookup() will just map some page cache pages and
> do a binary search.
>
> Of course if you actually open the file, then cfs_open_file() would do
> the equivalent lookups in /objects. But that is often not what happens,
> for example in "ls -l".
>
> Additionally, these extra lookups will cause extra memory use, as you
> need dentries and inodes for the erofs/squashfs inodes in addition to
> the overlay inodes.
>

I see. composefs is really very optimized for ls -lR.
Now only need to figure out if real users start a container and do ls -lR
without reading many files is a real life use case.

> > > table. But, given that we don't need any of the other features of
> > > overlayfs here, this performance loss seems rather unnecessary.
> > >
> > > I understand that there is a cost to adding more code, but
> > > efficiently
> > > supporting containers and other forms of read-only images is a
> > > pretty
> > > important usecase for Linux these days, and having something
> > > tailored
> > > for that seems pretty useful to me, even considering the code
> > > duplication.
> > >
> > >
> > >
> > > I also understand Cristians worry about stacking filesystem, having
> > > looked a bit more at the overlayfs code. But, since composefs
> > > doesn't
> > > really expose the metadata or vfs structure of the lower
> > > directories it
> > > is much simpler in a fundamental way.
> > >
> >
> > I agree that composefs is simpler than overlayfs and that its
> > security
> > model is simpler, but this is not the relevant question.
> > The question is what are the benefits to the prospect users of
> > composefs
> > that justify this new filesystem driver if overlayfs already
> > implements
> > the needed functionality.
> >
> > The only valid technical argument I could gather from your email is -
> > 10% performance improvement in warm cache ls -lR on a 2.6 GB
> > centos9 rootfs image compared to overlayfs+squashfs.
> >
> > I am not counting the cold cache results until we see results of
> > a modern ro-image fs.
>
> They are all strictly worse than squashfs in the above testing.
>

It's interesting to know why and if an optimized mkfs.erofs
mkfs.ext4 would have done any improvement.

> > Considering that most real life workloads include reading the data
> > and that most of the time inodes and dentries are cached, IMO,
> > the 10% ls -lR improvement is not a good enough reason
> > for a new "laser focused" filesystem driver.
> >
> > Correct me if I am wrong, but isn't the use case of ephemeral
> > containers require that composefs is layered under a writable tmpfs
> > using overlayfs?
> >
> > If that is the case then the warm cache comparison is incorrect
> > as well. To argue for the new filesystem you will need to compare
> > ls -lR of overlay{tmpfs,composefs,xfs} vs. overlay{tmpfs,erofs,xfs}
>
> That very much depends. For the ostree rootfs uscase there would be no
> writable layer, and for containers I'm personally primarily interested
> in "--readonly" containers (i.e. without an writable layer) in my
> current automobile/embedded work. For many container cases however,
> that is true, and no doubt that would make the overhead of overlayfs
> less of a issue.
>
> > Alexander,
> >
> > On a more personal note, I know this discussion has been a bit
> > stormy, but am not trying to fight you.
>
> I'm overall not getting a warm fuzzy feeling from this discussion.
> Getting weird complaints that I'm somehow "stealing" functions or weird
> "who did $foo first" arguments for instance. You haven't personally
> attacked me like that, but some of your comments can feel rather
> pointy, especially in the context of a stormy thread like this. I'm
> just not used to kernel development workflows, so have patience with me
> if I do things wrong.
>

Fair enough.
As long as the things that we discussed are duly
mentioned in future posts, I'll do my best to be less pointy.

> > I think that {mk,}composefs is a wonderful thing that will improve
> > the life of many users.
> > But mount -t composefs vs. mount -t overlayfs is insignificant
> > to those users, so we just need to figure out based on facts
> > and numbers, which is the best technical alternative.
>
> In reality things are never as easy as one thing strictly being
> technically best. There is always a multitude of considerations. Is
> composefs technically better if it uses less memory and performs better
> for a particular usecase? Or is overlayfs technically better because it
> is useful for more usecases and already exists? A judgement needs to be
> made depending on things like complexity/maintainability of the new fs,
> ease of use, measured performance differences, relative importance of
> particular performance measurements, and importance of the specific
> usecase.
>
> It is my belief that the advantages of composefs outweight the cost of
> the code duplication, but I understand the point of view of a
> maintainer of an existing codebase and that saying "no" is often the
> right thing. I will continue to try to argue for my point of view, but
> will try to make it as factual as possible.
>

Improving overlayfs and erofs has additional advantages -
improving performance and size of erofs image may benefit
many other users regardless of the ephemeral containers
use case, so indeed, there are many aspects to consider.

Thanks,
Amir.
