Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2062676749
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 16:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjAUPym (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 10:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUPyl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 10:54:41 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9412A2330B;
        Sat, 21 Jan 2023 07:54:39 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id i188so8723759vsi.8;
        Sat, 21 Jan 2023 07:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/opBoVPE/FrdFzUS7Ek6cOSvDXb6UR2MBcohJHSQh8=;
        b=jRZowBBf+X+khuhSfxbH4XZorP7zPyA/Qlo1xLYNSS9vG2ppSeZUc1LVIKdGJFr7Fz
         DNsE3eJwJwfb4F3WDUnyb+T4jlmEZdlWqtdI54EtTFooBrlf163+i777BUlntkBzsx0v
         SJRmTUGm82JHvCskA8DPdFlpZclWRe4/53T7Pf+PFo2VJfmECmJns8KHKiNo69zuyaLp
         /0O9hX6t8k7w3XPqAm/FjRIU9yE2fgRQOFYEkNyIq08Wm/lBxvPQMKN7qRFa4k9XBNQx
         NtGoTrpBc09484/N678ywy6piaxRvnRjRk3CQXVTcP05Ea9jtY9al+DE+y+NBR6qBU/A
         w5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/opBoVPE/FrdFzUS7Ek6cOSvDXb6UR2MBcohJHSQh8=;
        b=1JdQTG6UTu2F7wRETCSe/HSGmy4gTWWvQa/RbRmAZvE0dAItHTdw/Wv+J2sEWWI9wF
         6mV7YSdwaWM1x8uJ3LaXFAVya0h7TyWgVwFZqjsDiK4Kd1NX0wPzBGaBqROv/c0cm0os
         oUHk5R7yr3Bn8on1GelIHKBxsxJV6/y2Ete4EVBlwYFCKYyERHnDTBqDI/AZbThaVW6K
         ljUwxpVDNFJKTj2duxN2NzxyoJgbw7PuQXeqr60UMRZ7Pie2nOseh7u848DlBdnmKjd/
         Y65HT3a2UikG/b4yzYpj02ovv7vrW2+rM+SGxY3ILPj3iJra3KDIEA3uZyqOejyT+KWs
         aDjg==
X-Gm-Message-State: AFqh2kqkTNGan6LanFcczMspzI/b3GtpX3zCijYwCjJtiFgUAzlzoG2M
        7OmYyRsz6J1p5adDf0S0lYt1n6Bcu38uTwFizKg=
X-Google-Smtp-Source: AMrXdXs1JggGci4H0ejQ8LglGcHI0qDGfPm6c9+SRIgqBJ00X5rZSCY7whTNssHBGbArx7aM6RWpiMaA9dAMU/Axjvk=
X-Received: by 2002:a05:6102:3648:b0:3d3:ca31:f1b9 with SMTP id
 s8-20020a056102364800b003d3ca31f1b9mr2636562vsu.3.1674316478455; Sat, 21 Jan
 2023 07:54:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674227308.git.alexl@redhat.com> <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <87ilh0g88n.fsf@redhat.com> <CAOQ4uxi7wT09MPf+edS6AkJzBCxjzOnCTfcdwn===q-+G2C4Gw@mail.gmail.com>
 <87cz78exub.fsf@redhat.com>
In-Reply-To: <87cz78exub.fsf@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 21 Jan 2023 17:54:26 +0200
Message-ID: <CAOQ4uxi2W=HwoXbrLo3yePTGzMxb++EDLj-fAcQZgGWU5Pz3vQ@mail.gmail.com>
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

On Sat, Jan 21, 2023 at 5:01 PM Giuseppe Scrivano <gscrivan@redhat.com> wro=
te:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Sat, Jan 21, 2023 at 12:18 AM Giuseppe Scrivano <gscrivan@redhat.com=
> wrote:
> >>
> >> Hi Amir,
> >>
> >> Amir Goldstein <amir73il@gmail.com> writes:
> >>
> >> > On Fri, Jan 20, 2023 at 5:30 PM Alexander Larsson <alexl@redhat.com>=
 wrote:
> >> >>
> >> >> Giuseppe Scrivano and I have recently been working on a new project=
 we
> >> >> call composefs. This is the first time we propose this publically a=
nd
> >> >> we would like some feedback on it.
> >> >>
> >> >> At its core, composefs is a way to construct and use read only imag=
es
> >> >> that are used similar to how you would use e.g. loop-back mounted
> >> >> squashfs images. On top of this composefs has two fundamental
> >> >> features. First it allows sharing of file data (both on disk and in
> >> >> page cache) between images, and secondly it has dm-verity like
> >> >> validation on read.
> >> >>
> >> >> Let me first start with a minimal example of how this can be used,
> >> >> before going into the details:
> >> >>
> >> >> Suppose we have this source for an image:
> >> >>
> >> >> rootfs/
> >> >> =E2=94=9C=E2=94=80=E2=94=80 dir
> >> >> =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 another_a
> >> >> =E2=94=9C=E2=94=80=E2=94=80 file_a
> >> >> =E2=94=94=E2=94=80=E2=94=80 file_b
> >> >>
> >> >> We can then use this to generate an image file and a set of
> >> >> content-addressed backing files:
> >> >>
> >> >> # mkcomposefs --digest-store=3Dobjects rootfs/ rootfs.img
> >> >> # ls -l rootfs.img objects/*/*
> >> >> -rw-------. 1 root root   10 Nov 18 13:20 objects/02/927862b4ab9fb6=
9919187bb78d394e235ce444eeb0a890d37e955827fe4bf4
> >> >> -rw-------. 1 root root   10 Nov 18 13:20 objects/cc/3da5b14909626f=
c99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
> >> >> -rw-r--r--. 1 root root 4228 Nov 18 13:20 rootfs.img
> >> >>
> >> >> The rootfs.img file contains all information about directory and fi=
le
> >> >> metadata plus references to the backing files by name. We can now
> >> >> mount this and look at the result:
> >> >>
> >> >> # mount -t composefs rootfs.img -o basedir=3Dobjects /mnt
> >> >> # ls  /mnt/
> >> >> dir  file_a  file_b
> >> >> # cat /mnt/file_a
> >> >> content_a
> >> >>
> >> >> When reading this file the kernel is actually reading the backing
> >> >> file, in a fashion similar to overlayfs. Since the backing file is
> >> >> content-addressed, the objects directory can be shared for multiple
> >> >> images, and any files that happen to have the same content are
> >> >> shared. I refer to this as opportunistic sharing, as it is differen=
t
> >> >> than the more course-grained explicit sharing used by e.g. containe=
r
> >> >> base images.
> >> >>
> >> >> The next step is the validation. Note how the object files have
> >> >> fs-verity enabled. In fact, they are named by their fs-verity diges=
t:
> >> >>
> >> >> # fsverity digest objects/*/*
> >> >> sha256:02927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe=
4bf4 objects/02/927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4=
bf4
> >> >> sha256:cc3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e=
173f objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e1=
73f
> >> >>
> >> >> The generated filesystm image may contain the expected digest for t=
he
> >> >> backing files. When the backing file digest is incorrect, the open
> >> >> will fail, and if the open succeeds, any other on-disk file-changes
> >> >> will be detected by fs-verity:
> >> >>
> >> >> # cat objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc8=
9b23d43e173f
> >> >> content_a
> >> >> # rm -f objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883d=
c89b23d43e173f
> >> >> # echo modified > objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e=
0a1d18883dc89b23d43e173f
> >> >> # cat /mnt/file_a
> >> >> WARNING: composefs backing file '3da5b14909626fc99443f580e4d8c9b990=
e85e0a1d18883dc89b23d43e173f' unexpectedly had no fs-verity digest
> >> >> cat: /mnt/file_a: Input/output error
> >> >>
> >> >> This re-uses the existing fs-verity functionallity to protect again=
st
> >> >> changes in file contents, while adding on top of it protection agai=
nst
> >> >> changes in filesystem metadata and structure. I.e. protecting again=
st
> >> >> replacing a fs-verity enabled file or modifying file permissions or
> >> >> xattrs.
> >> >>
> >> >> To be fully verified we need another step: we use fs-verity on the
> >> >> image itself. Then we pass the expected digest on the mount command
> >> >> line (which will be verified at mount time):
> >> >>
> >> >> # fsverity enable rootfs.img
> >> >> # fsverity digest rootfs.img
> >> >> sha256:da42003782992856240a3e25264b19601016114775debd80c01620260af8=
6a76 rootfs.img
> >> >> # mount -t composefs rootfs.img -o basedir=3Dobjects,digest=3Dda420=
03782992856240a3e25264b19601016114775debd80c01620260af86a76 /mnt
> >> >>
> >> >> So, given a trusted set of mount options (say unlocked from TPM), w=
e
> >> >> have a fully verified filesystem tree mounted, with opportunistic
> >> >> finegrained sharing of identical files.
> >> >>
> >> >> So, why do we want this? There are two initial users. First of all =
we
> >> >> want to use the opportunistic sharing for the podman container imag=
e
> >> >> baselayer. The idea is to use a composefs mount as the lower direct=
ory
> >> >> in an overlay mount, with the upper directory being the container w=
ork
> >> >> dir. This will allow automatical file-level disk and page-cache
> >> >> sharning between any two images, independent of details like the
> >> >> permissions and timestamps of the files.
> >> >>
> >> >> Secondly we are interested in using the verification aspects of
> >> >> composefs in the ostree project. Ostree already supports a
> >> >> content-addressed object store, but it is currently referenced by
> >> >> hardlink farms. The object store and the trees that reference it ar=
e
> >> >> signed and verified at download time, but there is no runtime
> >> >> verification. If we replace the hardlink farm with a composefs imag=
e
> >> >> that points into the existing object store we can use the verificat=
ion
> >> >> to implement runtime verification.
> >> >>
> >> >> In fact, the tooling to create composefs images is 100% reproducibl=
e,
> >> >> so all we need is to add the composefs image fs-verity digest into =
the
> >> >> ostree commit. Then the image can be reconstructed from the ostree
> >> >> commit info, generating a file with the same fs-verity digest.
> >> >>
> >> >> These are the usecases we're currently interested in, but there see=
ms
> >> >> to be a breadth of other possible uses. For example, many systems u=
se
> >> >> loopback mounts for images (like lxc or snap), and these could take
> >> >> advantage of the opportunistic sharing. We've also talked about usi=
ng
> >> >> fuse to implement a local cache for the backing files. I.e. you wou=
ld
> >> >> have the second basedir be a fuse filesystem. On lookup failure in =
the
> >> >> first basedir it downloads the file and saves it in the first based=
ir
> >> >> for later lookups. There are many interesting possibilities here.
> >> >>
> >> >> The patch series contains some documentation on the file format and
> >> >> how to use the filesystem.
> >> >>
> >> >> The userspace tools (and a standalone kernel module) is available
> >> >> here:
> >> >>   https://github.com/containers/composefs
> >> >>
> >> >> Initial work on ostree integration is here:
> >> >>   https://github.com/ostreedev/ostree/pull/2640
> >> >>
> >> >> Changes since v2:
> >> >> - Simplified filesystem format to use fixed size inodes. This resul=
ted
> >> >>   in simpler (now < 2k lines) code as well as higher performance at
> >> >>   the cost of slightly (~40%) larger images.
> >> >> - We now use multi-page mappings from the page cache, which removes
> >> >>   limits on sizes of xattrs and makes the dirent handling code simp=
ler.
> >> >> - Added more documentation about the on-disk file format.
> >> >> - General cleanups based on review comments.
> >> >>
> >> >
> >> > Hi Alexander,
> >> >
> >> > I must say that I am a little bit puzzled by this v3.
> >> > Gao, Christian and myself asked you questions on v2
> >> > that are not mentioned in v3 at all.
> >> >
> >> > To sum it up, please do not propose composefs without explaining
> >> > what are the barriers for achieving the exact same outcome with
> >> > the use of a read-only overlayfs with two lower layer -
> >> > uppermost with erofs containing the metadata files, which include
> >> > trusted.overlay.metacopy and trusted.overlay.redirect xattrs that re=
fer
> >> > to the lowermost layer containing the content files.
> >>
> >> I think Dave explained quite well why using overlay is not comparable =
to
> >> what composefs does.
> >>
> >
> > Where? Can I get a link please?
>
> I am referring to this message: https://lore.kernel.org/lkml/202301180022=
42.GB937597@dread.disaster.area/
>

That is a good explanation why the current container runtime
overlay storage driver is inadequate, because the orchestration
requires untar of OCI tarball image before mounting overlayfs.

It is not a kernel issue, it is a userspace issue, because userspace
does not utilize overlayfs driver features that are now 6 years
old (redirect_dir) and 4 years old (metacopy).

I completely agree that reflink and hardlinks are not a viable solution
to ephemeral containers.

> > If there are good reasons why composefs is superior to erofs+overlayfs
> > Please include them in the submission, since several developers keep
> > raising the same questions - that is all I ask.
> >
> >> One big difference is that overlay still requires at least a syscall f=
or
> >> each file in the image, and then we need the equivalent of "rm -rf" to
> >> clean it up.  It is somehow acceptable for long-running services, but =
it
> >> is not for "serverless" containers where images/containers are created
> >> and destroyed frequently.  So even in the case we already have all the
> >> image files available locally, we still need to create a checkout with
> >> the final structure we need for the image.
> >>
> >
> > I think you did not understand my suggestion:
> >
> > overlay read-only mount:
> >     layer 1: erofs mount of a precomposed image (same as mkcomposefs)
> >     layer 2: any pre-existing fs path with /blocks repository
> >     layer 3: any per-existing fs path with /blocks repository
> >     ...
> >
> > The mkcomposefs flow is exactly the same in this suggestion
> > the upper layer image is created without any syscalls and
> > removed without any syscalls.
>
> mkcomposefs is supposed to be used server side, when the image is built.
> The clients that will mount the image don't have to create it (at least
> for images that will provide the manifest).
>
> So this is quite different as in the overlay model we must create the
> layout, that is the equivalent of the composefs manifest, on any node
> the image is pulled to.
>

You don't need to re-create the erofs manifest on the client.
Unless I am completely missing something, the flow that I am
suggesting is drop-in replacement to what you have done.

IIUC, you invented an on-disk format for composefs manifest.
Is there anything preventing you from using the existing
erofs on-disk format to pack the manifest file?
The files in the manifest would be inodes with no blocks, only
with size and attributes and overlay xattrs with references to
the real object blocks, same as you would do with mkcomposefs.
Is it not?

Maybe what I am missing is how are the blob objects distributed?
Are they also shipped as composefs image bundles?
That can still be the case with erofs images that may contain both
blobs with data and metadata files referencing blobs in older images.

> > Overlayfs already has the feature of redirecting from upper layer
> > to relative paths in lower layers.
>
> Could you please provide more information on how you would compose the
> overlay image first?
>
> From what I can see, it still requires at least one syscall for each
> file in the image to be created and these images are not portable to a
> different machine.

Terminology nuance - you do not create an overlayfs image on the server
you create an erofs image on the server, exactly as you would create
a composefs image on the server.

The shipped overlay "image" would then be the erofs image with
references to prereqisite images that contain the blobs and the digest
of the erofs image.

# mount -t composefs rootfs.img -o basedir=3Dobjects /mnt

client will do:

# mount -t erofs rootfs.img -o digest=3Dda.... /metadata
# mount -t overlay -o ro,metacopy=3Don,lowerdir=3D/metadata:/objects /mnt

>
> Should we always make "/blocks" a whiteout to prevent it is leaked in
> the container?

That would be the simplest option, yes.
If needed we can also make it a hidden layer whose objects
never appear in the namespace and can only be referenced
from an upper layer redirection.

>
> And what prevents files under "/blocks" to be replaced with a different
> version?  I think fs-verity on the EROFS image itself won't cover it.
>

I think that part should be added to the overlayfs kernel driver.
We could enhance overlayfs to include optional "overlay.verity" digest
on the metacopy upper files to be fed into fsverity when opening lower
blob files that reside on an fsverity supported filesystem.

I am not an expert in trust chains, but I think this is equivalent to
how composefs driver was going to solve the same problem?

> >> I also don't see how overlay would solve the verified image problem.  =
We
> >> would have the same problem we have today with fs-verity as it can onl=
y
> >> validate a single file but not the entire directory structure.  Change=
s
> >> that affect the layer containing the trusted.overlay.{metacopy,redirec=
t}
> >> xattrs won't be noticed.
> >>
> >
> > The entire erofs image would be fsverified including the overlayfs xatt=
rs.
> > That is exactly the same model as composefs.
> > I am not even saying that your model is wrong, only that you are within
> > reach of implementing it with existing subsystems.
>
> now we can do:
>
> mount -t composefs rootfs.img -o basedir=3Dobjects,digest=3Dda42003782992=
856240a3e25264b19601016114775debd80c01620260af86a76 /mnt
>
> that is quite useful for mounting the OS image, as is the OSTree case.
>
> How would that be possible with the setup you are proposing?  Would
> overlay gain a new "digest=3D" kind of option to validate its first layer=
?
>

Overlayfs job is to merge the layers.
The first layer would first need to be mounted as erofs,
so I think that the option digest=3D would need to be added to erofs.

Then, any content in the erofs mount (which is the first overlay layer)
would be verified by fsverity and overlayfs job would be to feed the digest
found in "overlay.verity" xattrs inside the erofs layer when accessing file=
s in
the blob lower (or hidden) layer.

Does this make sense to you?
Or is there still something that I am missing or
misunderstanding about the use case?

Thanks,
Amir.
