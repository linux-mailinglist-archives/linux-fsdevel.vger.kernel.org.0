Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8503678EFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 04:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjAXDZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 22:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjAXDZL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 22:25:11 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F388513DE0;
        Mon, 23 Jan 2023 19:25:09 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id p1so15186767vsr.5;
        Mon, 23 Jan 2023 19:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4h/UAw2J1h8f1uzSkhlXPn8iY3q+5enkJ9enFFMsqfA=;
        b=pK4alJtdPKQrcNpA3w0SqSvR5sdWg/sk1h3I3TpAz6PfrBtL0zclLHYyi1TY1JbD36
         4NnhcZGq1H/cHbUNVt8cZItp11YqOF9OgkX5Ai6rsJioaZ5xFiCT4hVGg1v05tHY/17i
         eWquRi9WBy9XZyXQnKNxRgxbLQXbySXsPbqFFr4C6/AIv0a5K4I5ckc3XqqKYW5VJMkg
         9tYVKWhJCJKkZJ7UWMsIrbbZy64nHxp7GRZuHGPky4/PwMLeJvY4u5w9sG33ZYbNEwuE
         el9EIjd9vZYBXbn+HxBxJ9uaUBNs1h3A5U59+yuM7S7NAhSw5jm2BymlmRSvsDV6V7Ye
         uMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4h/UAw2J1h8f1uzSkhlXPn8iY3q+5enkJ9enFFMsqfA=;
        b=N8zuLMwjAO/ZSsokuSIBOMgXEqUAtcW4b6R71YDAQjIwALwEkHM/BoHJou7NWE/dOb
         4M1VRej8DaN3NyjTBvL8033NDXeEMuum0e73JfePY/CXOEvLIi0SuMIsO3v2hBjpPdk1
         4CmIyMdT6fhwnR0+jq4sqSC+14tj6DfOJ86K4bc2vGhEKEDA9ULy+9RAeZGC5i4IU3or
         IUwkm5higbSvXa6d3huc0TA8Wy6p6KPPx5D4b9HbOZ86D+CTEzkHhxZwMpUwWr9BW1QZ
         zFV5EvUWm3q0YOri5cBVf1G/sHnMVlbs4CNJ8fJS7hQbxdjwLY5E4owqzLYBBhM67fcN
         4w/g==
X-Gm-Message-State: AFqh2krzE4v0xlPFlZjA9/yokyDHhQsjn94qHxtHMK3vAlrFsMYMnLQV
        YS8YZML/91VsJifA768PjFKwL1pzxwjWgYpUiPw6S2QAxyM=
X-Google-Smtp-Source: AMrXdXsdnRUt9wBoMy70E8ENliZ8cHIyybBhclz0z2rc3J3QZb3AhxeTK3ybnWhjGgtbIFP+V1+LkKqEpfLiY9DgsGY=
X-Received: by 2002:a05:6102:330c:b0:3d3:e956:1303 with SMTP id
 v12-20020a056102330c00b003d3e9561303mr3672796vsc.71.1674530708901; Mon, 23
 Jan 2023 19:25:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674227308.git.alexl@redhat.com> <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
In-Reply-To: <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 Jan 2023 05:24:56 +0200
Message-ID: <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
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

On Mon, Jan 23, 2023 at 7:56 PM Alexander Larsson <alexl@redhat.com> wrote:
>
> On Fri, 2023-01-20 at 21:44 +0200, Amir Goldstein wrote:
> > On Fri, Jan 20, 2023 at 5:30 PM Alexander Larsson <alexl@redhat.com>
> > wrote:
> > >
> > > Giuseppe Scrivano and I have recently been working on a new project
> > > we
> > > call composefs. This is the first time we propose this publically
> > > and
> > > we would like some feedback on it.
> > >
> >
> > Hi Alexander,
> >
> > I must say that I am a little bit puzzled by this v3.
> > Gao, Christian and myself asked you questions on v2
> > that are not mentioned in v3 at all.
>
> I got lots of good feedback from Dave Chinner on V2 that caused rather
> large changes to simplify the format. So I wanted the new version with
> those changes out to continue that review. I think also having that
> simplified version will be helpful for the general discussion.
>

That's ok.
I was not puzzled about why you posted v3.
I was puzzled by why you did not mention anything about the
alternatives to adding a new filesystem that were discussed on
v2 and argue in favor of the new filesystem option.
If you post another version, please make sure to include a good
explanation for that.

> > To sum it up, please do not propose composefs without explaining
> > what are the barriers for achieving the exact same outcome with
> > the use of a read-only overlayfs with two lower layer -
> > uppermost with erofs containing the metadata files, which include
> > trusted.overlay.metacopy and trusted.overlay.redirect xattrs that
> > refer to the lowermost layer containing the content files.
>
> So, to be more precise, and so that everyone is on the same page, lemme
> state the two options in full.
>
> For both options, we have a directory "objects" with content-addressed
> backing files (i.e. files named by sha256). In this directory all
> files have fs-verity enabled. Additionally there is an image file
> which you downloaded to the system that somehow references the objects
> directory by relative filenames.
>
> Composefs option:
>
>  The image file has fs-verity enabled. To use the image, you mount it
>  with options "basedir=3Dobjects,digest=3D$imagedigest".
>
> Overlayfs option:
>
>  The image file is a loopback image of a gpt disk with two partitions,
>  one partition contains the dm-verity hashes, and the other contains
>  some read-only filesystem.
>
>  The read-only filesystem has regular versions of directories and
>  symlinks, but for regular files it has sparse files with the xattrs
>  "trusted.overlay.metacopy" and "trusted.overlay.redirect" set, the
>  later containing a string like like "/de/adbeef..." referencing a
>  backing file in the "objects" directory. In addition, the image also
>  contains overlayfs whiteouts to cover any toplevel filenames from the
>  objects directory that would otherwise appear if objects is used as
>  a lower dir.
>
>  To use this you loopback mount the file, and use dm-verity to set up
>  the combined partitions, which you then mount somewhere. Then you
>  mount an overlayfs with options:
>   "metacopy=3Don,redirect_dir=3Dfollow,lowerdir=3Dveritydev:objects"
>
> I would say both versions of this can work. There are some minor
> technical issues with the overlay option:
>
> * To get actual verification of the backing files you would need to
> add support to overlayfs for an "trusted.overlay.digest" xattrs, with
> behaviour similar to composefs.
>
> * mkfs.erofs doesn't support sparse files (not sure if the kernel code
> does), which means it is not a good option for the backing all these
> sparse files. Squashfs seems to support this though, so that is an
> option.
>

Fair enough.
Wasn't expecting for things to work without any changes.
Let's first agree that these alone are not a good enough reason to
introduce a new filesystem.
Let's move on..

> However, the main issue I have with the overlayfs approach is that it
> is sort of clumsy and over-complex. Basically, the composefs approach
> is laser focused on read-only images, whereas the overlayfs approach
> just chains together technologies that happen to work, but also do a
> lot of other stuff. The result is that it is more work to use it, it
> uses more kernel objects (mounts, dm devices, loopbacks) and it has

Up to this point, it's just hand waving, and a bit annoying if I am
being honest.
overlayfs+metacopy feature were created for the containers use case
for very similar set of requirements - they do not just "happen to work"
for the same use case.
Please stick to technical arguments when arguing in favor of the new
"laser focused" filesystem option.

> worse performance.
>
> To measure performance I created a largish image (2.6 GB centos9
> rootfs) and mounted it via composefs, as well as overlay-over-squashfs,
> both backed by the same objects directory (on xfs).
>
> If I clear all caches between each run, a `ls -lR` run on composefs
> runs in around 700 msec:
>
> # hyperfine -i -p "echo 3 > /proc/sys/vm/drop_caches" "ls -lR cfs-mount"
> Benchmark 1: ls -lR cfs-mount
>   Time (mean =C2=B1 =CF=83):     701.0 ms =C2=B1  21.9 ms    [User: 153.6=
 ms, System: 373.3 ms]
>   Range (min =E2=80=A6 max):   662.3 ms =E2=80=A6 725.3 ms    10 runs
>
> Whereas same with overlayfs takes almost four times as long:

No it is not overlayfs, it is overlayfs+squashfs, please stick to facts.
As Gao wrote, squashfs does not optimize directory lookup.
You can run a test with ext4 for POC as Gao suggested.
I am sure that mkfs.erofs sparse file support can be added if needed.

>
> # hyperfine -i -p "echo 3 > /proc/sys/vm/drop_caches" "ls -lR ovl-mount"
> Benchmark 1: ls -lR ovl-mount
>   Time (mean =C2=B1 =CF=83):      2.738 s =C2=B1  0.029 s    [User: 0.176=
 s, System: 1.688 s]
>   Range (min =E2=80=A6 max):    2.699 s =E2=80=A6  2.787 s    10 runs
>
> With page cache between runs the difference is smaller, but still
> there:

It is the dentry cache that mostly matters for this test and please
use hyerfine -w 1 to warmup dentry cache for correct measurement
of warm cache lookup.
I guess these test runs started with warm cache? but it wasn't
mentioned explicitly.

>
> # hyperfine "ls -lR cfs-mnt"
> Benchmark 1: ls -lR cfs-mnt
>   Time (mean =C2=B1 =CF=83):     390.1 ms =C2=B1   3.7 ms    [User: 140.9=
 ms, System: 247.1 ms]
>   Range (min =E2=80=A6 max):   381.5 ms =E2=80=A6 393.9 ms    10 runs
>
> vs
>
> # hyperfine -i "ls -lR ovl-mount"
> Benchmark 1: ls -lR ovl-mount
>   Time (mean =C2=B1 =CF=83):     431.5 ms =C2=B1   1.2 ms    [User: 124.3=
 ms, System: 296.9 ms]
>   Range (min =E2=80=A6 max):   429.4 ms =E2=80=A6 433.3 ms    10 runs
>
> This isn't all that strange, as overlayfs does a lot more work for
> each lookup, including multiple name lookups as well as several xattr
> lookups, whereas composefs just does a single lookup in a pre-computed

Seriously, "multiple name lookups"?
Overlayfs does exactly one lookup for anything but first level subdirs
and for sparse files it does the exact same lookup in /objects as
composefs.
Enough with the hand waving please. Stick to hard facts.

> table. But, given that we don't need any of the other features of
> overlayfs here, this performance loss seems rather unnecessary.
>
> I understand that there is a cost to adding more code, but efficiently
> supporting containers and other forms of read-only images is a pretty
> important usecase for Linux these days, and having something tailored
> for that seems pretty useful to me, even considering the code
> duplication.
>
>
>
> I also understand Cristians worry about stacking filesystem, having
> looked a bit more at the overlayfs code. But, since composefs doesn't
> really expose the metadata or vfs structure of the lower directories it
> is much simpler in a fundamental way.
>

I agree that composefs is simpler than overlayfs and that its security
model is simpler, but this is not the relevant question.
The question is what are the benefits to the prospect users of composefs
that justify this new filesystem driver if overlayfs already implements
the needed functionality.

The only valid technical argument I could gather from your email is -
10% performance improvement in warm cache ls -lR on a 2.6 GB
centos9 rootfs image compared to overlayfs+squashfs.

I am not counting the cold cache results until we see results of
a modern ro-image fs.

Considering that most real life workloads include reading the data
and that most of the time inodes and dentries are cached, IMO,
the 10% ls -lR improvement is not a good enough reason
for a new "laser focused" filesystem driver.

Correct me if I am wrong, but isn't the use case of ephemeral
containers require that composefs is layered under a writable tmpfs
using overlayfs?

If that is the case then the warm cache comparison is incorrect
as well. To argue for the new filesystem you will need to compare
ls -lR of overlay{tmpfs,composefs,xfs} vs. overlay{tmpfs,erofs,xfs}

Alexander,

On a more personal note, I know this discussion has been a bit
stormy, but am not trying to fight you.
I think that {mk,}composefs is a wonderful thing that will improve
the life of many users.
But mount -t composefs vs. mount -t overlayfs is insignificant
to those users, so we just need to figure out based on facts
and numbers, which is the best technical alternative.

Thanks,
Amir.
