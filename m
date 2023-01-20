Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98923675E42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 20:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjATTo6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 14:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjATTo6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:44:58 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46642B2B8;
        Fri, 20 Jan 2023 11:44:56 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id i185so6816919vsc.6;
        Fri, 20 Jan 2023 11:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3Kkcboz436xPXdic1Aj4mFEK8VKCO6HmZ5YwofYW3g=;
        b=nRevD/aowNLcxaccb7GYBFgLkm9vc7k6MWOce9fvz7tcxVTo98Yyg5Y/YZikwz/mrK
         Zge9Azd6IxI0IFngHhFcq1yRhP+gASOowYn8ZAb0Zn/LYtrqNcEIntehHYfpwBvwrp7r
         flyN3eI6Eqthx1ajUjHjt4sZ4w3ZPLjx5C0xnFdsd8f6kRbnYQzQUE/HaW8qeno/M40f
         +Qb5ZnApO+OUHcREQPpInWedKy93qNoyvGGmMJwEPXDLx2CJi7IHB489zqb9fcOvG58I
         UVpxBNJqfSXqJwVHoHnmn7ahUMxdUcJBDPDYKlMIaebgkS4p62kR92BmsnKuL+XFXtmZ
         yozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3Kkcboz436xPXdic1Aj4mFEK8VKCO6HmZ5YwofYW3g=;
        b=YAjD1K1KvgzfWXivFehy/hevXp/CTD4o9Dvky5DWeaMNxRaWNjqWLTXZNPDG149hRt
         aJvnYCLyQ60ScHUf4AoiMlvRzTchfT9xF3yC+uhYzBHkS4Yg+PEtoPUx1JEdLPZ+cJNr
         Bc5kWtTwTXpY1PRk/JS3BxhLfouT+kL4Yr4lxVeHkXaOoZ2yVY9o66OkO+ep685eN+ad
         bogDUljDol4ZhPIfP4x63iAQyIVT4zyovfp/xd/QfrlcMRB4idT7XYFYACSjSSNLDKJI
         9goh77ZLFaIFu1iXSICOALNIufUtM0s8o5beANS8/blMut470EH1DISe0PjWagkTX4zK
         D0mQ==
X-Gm-Message-State: AFqh2kq4e/ZQRQusgT37GxhiXcIk88uDg3bkhkYlAE+HdfYzCUTCD2Lu
        RikwQZ5axDBR3W3knHWmgKXHIFog2D+ssTxVCfM=
X-Google-Smtp-Source: AMrXdXtcan7zm1ZcqEO0BsPNZZp2zzYEVC9vsjFGxj57Rg/Sr1CwABN1E/mmMBA4Lvt6vTzsUjlZ1bqKcQVnP10VzeI=
X-Received: by 2002:a05:6102:3d0d:b0:3b0:7462:a91 with SMTP id
 i13-20020a0561023d0d00b003b074620a91mr2235349vsv.36.1674243895770; Fri, 20
 Jan 2023 11:44:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674227308.git.alexl@redhat.com>
In-Reply-To: <cover.1674227308.git.alexl@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 20 Jan 2023 21:44:46 +0200
Message-ID: <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
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

On Fri, Jan 20, 2023 at 5:30 PM Alexander Larsson <alexl@redhat.com> wrote:
>
> Giuseppe Scrivano and I have recently been working on a new project we
> call composefs. This is the first time we propose this publically and
> we would like some feedback on it.
>
> At its core, composefs is a way to construct and use read only images
> that are used similar to how you would use e.g. loop-back mounted
> squashfs images. On top of this composefs has two fundamental
> features. First it allows sharing of file data (both on disk and in
> page cache) between images, and secondly it has dm-verity like
> validation on read.
>
> Let me first start with a minimal example of how this can be used,
> before going into the details:
>
> Suppose we have this source for an image:
>
> rootfs/
> =E2=94=9C=E2=94=80=E2=94=80 dir
> =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 another_a
> =E2=94=9C=E2=94=80=E2=94=80 file_a
> =E2=94=94=E2=94=80=E2=94=80 file_b
>
> We can then use this to generate an image file and a set of
> content-addressed backing files:
>
> # mkcomposefs --digest-store=3Dobjects rootfs/ rootfs.img
> # ls -l rootfs.img objects/*/*
> -rw-------. 1 root root   10 Nov 18 13:20 objects/02/927862b4ab9fb6991918=
7bb78d394e235ce444eeb0a890d37e955827fe4bf4
> -rw-------. 1 root root   10 Nov 18 13:20 objects/cc/3da5b14909626fc99443=
f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
> -rw-r--r--. 1 root root 4228 Nov 18 13:20 rootfs.img
>
> The rootfs.img file contains all information about directory and file
> metadata plus references to the backing files by name. We can now
> mount this and look at the result:
>
> # mount -t composefs rootfs.img -o basedir=3Dobjects /mnt
> # ls  /mnt/
> dir  file_a  file_b
> # cat /mnt/file_a
> content_a
>
> When reading this file the kernel is actually reading the backing
> file, in a fashion similar to overlayfs. Since the backing file is
> content-addressed, the objects directory can be shared for multiple
> images, and any files that happen to have the same content are
> shared. I refer to this as opportunistic sharing, as it is different
> than the more course-grained explicit sharing used by e.g. container
> base images.
>
> The next step is the validation. Note how the object files have
> fs-verity enabled. In fact, they are named by their fs-verity digest:
>
> # fsverity digest objects/*/*
> sha256:02927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf4 o=
bjects/02/927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf4
> sha256:cc3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f o=
bjects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
>
> The generated filesystm image may contain the expected digest for the
> backing files. When the backing file digest is incorrect, the open
> will fail, and if the open succeeds, any other on-disk file-changes
> will be detected by fs-verity:
>
> # cat objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d4=
3e173f
> content_a
> # rm -f objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23=
d43e173f
> # echo modified > objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18=
883dc89b23d43e173f
> # cat /mnt/file_a
> WARNING: composefs backing file '3da5b14909626fc99443f580e4d8c9b990e85e0a=
1d18883dc89b23d43e173f' unexpectedly had no fs-verity digest
> cat: /mnt/file_a: Input/output error
>
> This re-uses the existing fs-verity functionallity to protect against
> changes in file contents, while adding on top of it protection against
> changes in filesystem metadata and structure. I.e. protecting against
> replacing a fs-verity enabled file or modifying file permissions or
> xattrs.
>
> To be fully verified we need another step: we use fs-verity on the
> image itself. Then we pass the expected digest on the mount command
> line (which will be verified at mount time):
>
> # fsverity enable rootfs.img
> # fsverity digest rootfs.img
> sha256:da42003782992856240a3e25264b19601016114775debd80c01620260af86a76 r=
ootfs.img
> # mount -t composefs rootfs.img -o basedir=3Dobjects,digest=3Dda420037829=
92856240a3e25264b19601016114775debd80c01620260af86a76 /mnt
>
> So, given a trusted set of mount options (say unlocked from TPM), we
> have a fully verified filesystem tree mounted, with opportunistic
> finegrained sharing of identical files.
>
> So, why do we want this? There are two initial users. First of all we
> want to use the opportunistic sharing for the podman container image
> baselayer. The idea is to use a composefs mount as the lower directory
> in an overlay mount, with the upper directory being the container work
> dir. This will allow automatical file-level disk and page-cache
> sharning between any two images, independent of details like the
> permissions and timestamps of the files.
>
> Secondly we are interested in using the verification aspects of
> composefs in the ostree project. Ostree already supports a
> content-addressed object store, but it is currently referenced by
> hardlink farms. The object store and the trees that reference it are
> signed and verified at download time, but there is no runtime
> verification. If we replace the hardlink farm with a composefs image
> that points into the existing object store we can use the verification
> to implement runtime verification.
>
> In fact, the tooling to create composefs images is 100% reproducible,
> so all we need is to add the composefs image fs-verity digest into the
> ostree commit. Then the image can be reconstructed from the ostree
> commit info, generating a file with the same fs-verity digest.
>
> These are the usecases we're currently interested in, but there seems
> to be a breadth of other possible uses. For example, many systems use
> loopback mounts for images (like lxc or snap), and these could take
> advantage of the opportunistic sharing. We've also talked about using
> fuse to implement a local cache for the backing files. I.e. you would
> have the second basedir be a fuse filesystem. On lookup failure in the
> first basedir it downloads the file and saves it in the first basedir
> for later lookups. There are many interesting possibilities here.
>
> The patch series contains some documentation on the file format and
> how to use the filesystem.
>
> The userspace tools (and a standalone kernel module) is available
> here:
>   https://github.com/containers/composefs
>
> Initial work on ostree integration is here:
>   https://github.com/ostreedev/ostree/pull/2640
>
> Changes since v2:
> - Simplified filesystem format to use fixed size inodes. This resulted
>   in simpler (now < 2k lines) code as well as higher performance at
>   the cost of slightly (~40%) larger images.
> - We now use multi-page mappings from the page cache, which removes
>   limits on sizes of xattrs and makes the dirent handling code simpler.
> - Added more documentation about the on-disk file format.
> - General cleanups based on review comments.
>

Hi Alexander,

I must say that I am a little bit puzzled by this v3.
Gao, Christian and myself asked you questions on v2
that are not mentioned in v3 at all.

To sum it up, please do not propose composefs without explaining
what are the barriers for achieving the exact same outcome with
the use of a read-only overlayfs with two lower layer -
uppermost with erofs containing the metadata files, which include
trusted.overlay.metacopy and trusted.overlay.redirect xattrs that refer
to the lowermost layer containing the content files.

Any current functionality gap in erofs and/or in overlayfs
cannot be considered as a reason to maintain a new filesystem
driver unless you come up with an explanation why closing that
functionality gap is not possible or why the erofs+overlayfs alternative
would be inferior to maintaining a new filesystem driver.

From the conversations so far, it does not seem like Gao thinks
that the functionality gap in erofs cannot be closed and I don't
see why the functionality gap in overlayfs cannot be closed.

Are we missing something?

Thanks,
Amir.
