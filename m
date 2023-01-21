Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BE46769CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 23:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjAUWfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 17:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjAUWe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 17:34:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE102278E
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Jan 2023 14:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674340454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ke6NuL0gSUrj92HmkcyEgzh49C3kcNH1KSnk8P16GYc=;
        b=ia3Kh5wPTgA7YNBSDQXLU0V16J1LNkaLrFdyP/HH/Zfr9y7QKXQ1iEdU1KdQQ6gj8oV+1G
        q2ZzpgZyK0NszMC5YlN/on6EwYno80O4Q4Gf+cdP2xBZ7wcd0iICDJumOIiLo+xRJhubZy
        eT/w/kyfyFsVry8LxVtfTeedizjCSz0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-d5iV_a9eM0qHTY0CoghEYg-1; Sat, 21 Jan 2023 17:34:09 -0500
X-MC-Unique: d5iV_a9eM0qHTY0CoghEYg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB3733C025AC;
        Sat, 21 Jan 2023 22:34:08 +0000 (UTC)
Received: from localhost (unknown [10.39.192.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 39A1B2166B2A;
        Sat, 21 Jan 2023 22:34:08 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
References: <cover.1674227308.git.alexl@redhat.com>
        <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
        <87ilh0g88n.fsf@redhat.com>
        <321dfdb1-3771-b16d-604f-224ce8aa22cf@linux.alibaba.com>
        <878rhvg8ru.fsf@redhat.com>
        <3ae1205a-b666-3211-e649-ad402c69e724@linux.alibaba.com>
Date:   Sat, 21 Jan 2023 23:34:06 +0100
In-Reply-To: <3ae1205a-b666-3211-e649-ad402c69e724@linux.alibaba.com> (Gao
        Xiang's message of "Sun, 22 Jan 2023 01:15:40 +0800")
Message-ID: <87sfg3ecv5.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Gao Xiang <hsiangkao@linux.alibaba.com> writes:

> On 2023/1/22 00:19, Giuseppe Scrivano wrote:
>> Gao Xiang <hsiangkao@linux.alibaba.com> writes:
>>=20
>>> On 2023/1/21 06:18, Giuseppe Scrivano wrote:
>>>> Hi Amir,
>>>> Amir Goldstein <amir73il@gmail.com> writes:
>>>>
>>>>> On Fri, Jan 20, 2023 at 5:30 PM Alexander Larsson <alexl@redhat.com> =
wrote:
>>>
>>> ...
>>>
>>>>>>
>>>>>
>>>>> Hi Alexander,
>>>>>
>>>>> I must say that I am a little bit puzzled by this v3.
>>>>> Gao, Christian and myself asked you questions on v2
>>>>> that are not mentioned in v3 at all.
>>>>>
>>>>> To sum it up, please do not propose composefs without explaining
>>>>> what are the barriers for achieving the exact same outcome with
>>>>> the use of a read-only overlayfs with two lower layer -
>>>>> uppermost with erofs containing the metadata files, which include
>>>>> trusted.overlay.metacopy and trusted.overlay.redirect xattrs that ref=
er
>>>>> to the lowermost layer containing the content files.
>>>> I think Dave explained quite well why using overlay is not
>>>> comparable to
>>>> what composefs does.
>>>> One big difference is that overlay still requires at least a syscall
>>>> for
>>>> each file in the image, and then we need the equivalent of "rm -rf" to
>>>> clean it up.  It is somehow acceptable for long-running services, but =
it
>>>> is not for "serverless" containers where images/containers are created
>>>> and destroyed frequently.  So even in the case we already have all the
>>>> image files available locally, we still need to create a checkout with
>>>> the final structure we need for the image.
>>>> I also don't see how overlay would solve the verified image problem.
>>>> We
>>>> would have the same problem we have today with fs-verity as it can only
>>>> validate a single file but not the entire directory structure.  Changes
>>>> that affect the layer containing the trusted.overlay.{metacopy,redirec=
t}
>>>> xattrs won't be noticed.
>>>> There are at the moment two ways to handle container images, both
>>>> somehow
>>>> guided by the available file systems in the kernel.
>>>> - A single image mounted as a block device.
>>>> - A list of tarballs (OCI image) that are unpacked and mounted as
>>>>     overlay layers.
>>>> One big advantage of the block devices model is that you can use
>>>> dm-verity, this is something we miss today with OCI container images
>>>> that use overlay.
>>>> What we are proposing with composefs is a way to have "dm-verity"
>>>> style
>>>> validation based on fs-verity and the possibility to share individual
>>>> files instead of layers.  These files can also be on different file
>>>> systems, which is something not possible with the block device model.
>>>
>>> That is not a new idea honestly, including chain of trust.  Even laterly
>>> out-of-tree incremental fs using fs-verity for this as well, except that
>>> it's in a real self-contained way.
>>>
>>>> The composefs manifest blob could be generated remotely and signed.
>>>> A
>>>> client would need just to validate the signature for the manifest blob
>>>> and from there retrieve the files that are not in the local CAS (even
>>>> from an insecure source) and mount directly the manifest file.
>>>
>>>
>>> Back to the topic, after thinking something I have to make a
>>> compliment for reference.
>>>
>>> First, EROFS had the same internal dissussion and decision at
>>> that time almost _two years ago_ (June 2021), it means:
>>>
>>>    a) Some internal people really suggested EROFS could develop
>>>       an entire new file-based in-kernel local cache subsystem
>>>       (as you called local CAS, whatever) with stackable file
>>>       interface so that the exist Nydus image service [1] (as
>>>       ostree, and maybe ostree can use it as well) don't need to
>>>       modify anything to use exist blobs;
>>>
>>>    b) Reuse exist fscache/cachefiles;
>>>
>>> The reason why we (especially me) finally selected b) because:
>>>
>>>    - see the people discussion of Google's original Incremental
>>>      FS topic [2] [3] in 2019, as Amir already mentioned.  At
>>>      that time all fs folks really like to reuse exist subsystem
>>>      for in-kernel caching rather than reinvent another new
>>>      in-kernel wheel for local cache.
>>>
>>>      [ Reinventing a new wheel is not hard (fs or caching), just
>>>        makes Linux more fragmented.  Especially a new filesystem
>>>        is just proposed to generate images full of massive massive
>>>        new magical symlinks with *overriden* uid/gid/permissions
>>>        to replace regular files. ]
>>>
>>>    - in-kernel cache implementation usually met several common
>>>      potential security issues; reusing exist subsystem can
>>>      make all fses addressed them and benefited from it.
>>>
>>>    - Usually an exist widely-used userspace implementation is
>>>      never an excuse for a new in-kernel feature.
>>>
>>> Although David Howells is always quite busy these months to
>>> develop new netfs interface, otherwise (we think) we should
>>> already support failover, multiple daemon/dirs, daemonless and
>>> more.
>> we have not added any new cache system.  overlay does "layer
>> deduplication" and in similar way composefs does "file deduplication".
>> That is not a built-in feature, it is just a side effect of how things
>> are packed together.
>> Using fscache seems like a good idea and it has many advantages but
>> it
>> is a centralized cache mechanism and it looks like a potential problem
>> when you think about allowing mounts from a user namespace.
>
> I think Christian [1] had the same feeling of my own at that time:
>
> "I'm pretty skeptical of this plan whether we should add more filesystems
>  that are mountable by unprivileged users. FUSE and Overlayfs are
>  adventurous enough and they don't have their own on-disk format. The
>  track record of bugs exploitable due to userns isn't making this
>  very attractive."
>
> Yes, you could add fs-verity, but EROFS could add fs-verity (or just use
> dm-verity) as well, but it doesn't change _anything_ about concerns of
> "allowing mounts from a user namespace".

I've mentioned that as a potential feature we could add in future, given
the simplicity of the format and that it uses a CAS for its data instead
of fscache.  Each user can have and use their own store to mount the
images.

At this point it is just a wish from userspace, as it would improve a
few real use cases we have.

Having the possibility to run containers without root privileges is a
big deal for many users, look at Flatpak apps for example, or rootless
Podman.  Mounting and validating images would be a a big security
improvement.  It is something that is not possible at the moment as
fs-verity doesn't cover the directory structure and dm-verity seems out
of reach from a user namespace.

Composefs delegates the entire logic of dealing with files to the
underlying file system in a similar way to overlay.

Forging the inode metadata from a user namespace mount doesn't look
like an insurmountable problem as well since it is already possible
with a FUSE filesystem.

So the proposal/wish here is to have a very simple format, that at some
point could be considered safe to mount from a user namespace, in
addition to overlay and FUSE.


>> As you know as I've contacted you, I've looked at EROFS in the past
>> and tried to get our use cases to work with it before thinking about
>> submitting composefs upstream.
>>  From what I could see EROFS and composefs use two different
>> approaches
>> to solve a similar problem, but it is not possible to do exactly with
>> EROFS what we are trying to do.  To oversimplify it: I see EROFS as a
>> block device that uses fscache, and composefs as an overlay for files
>> instead of directories.
>
> I don't think so honestly.  EROFS "Multiple device" feature is
> actually "multiple blobs" feature if you really think "device"
> is block device.
>
> Primary device -- primary blob -- "composefs manifest blob"
> Blob device -- data blobs -- "composefs backing files"
>
> any difference?

I wouldn't expect any substancial difference between two RO file
systems.

Please correct me if I am wrong: EROFS uses 16 bits for the blob device
ID, so if we map each file to a single blob device we are kind of
limited on how many files we can have.
Sure this is just an artificial limit and can be bumped in a future
version but the major difference remains: EROFS uses the blob device
through fscache while the composefs files are looked up in the specified
repositories.

>> Sure composefs is quite simple and you could embed the composefs
>> features in EROFS and let EROFS behave as composefs when provided a
>> similar manifest file.  But how is that any better than having a
>
> EROFS always has such feature since v5.16, we called primary device,
> or Nydus concept --- "bootstrap file".
>
>> separate implementation that does just one thing well instead of merging
>> different paradigms together?
>
> It's exist fs on-disk compatible (people can deploy the same image
> to wider scenarios), or you could modify/enhacnce any in-kernel local
> fs to do so like I already suggested, such as enhancing "fs/romfs" and
> make it maintained again due to this magic symlink feature
>
> (because composefs don't have other on-disk requirements other than
>  a symlink path and a SHA256 verity digest from its original
>  requirement.  Any local fs can be enhanced like this.)
>
>>=20
>>> I know that you guys repeatedly say it's a self-contained
>>> stackable fs and has few code (the same words as Incfs
>>> folks [3] said four years ago already), four reasons make it
>>> weak IMHO:
>>>
>>>    - I think core EROFS is about 2~3 kLOC as well if
>>>      compression, sysfs and fscache are all code-truncated.
>>>
>>>      Also, it's always welcome that all people could submit
>>>      patches for cleaning up.  I always do such cleanups
>>>      from time to time and makes it better.
>>>
>>>    - "Few code lines" is somewhat weak because people do
>>>      develop new features, layout after upstream.
>>>
>>>      Such claim is usually _NOT_ true in the future if you
>>>      guys do more to optimize performance, new layout or even
>>>      do your own lazy pulling with your local CAS codebase in
>>>      the future unless
>>>      you *promise* you once dump the code, and do bugfix
>>>      only like Christian said [4].
>>>
>>>      From LWN.net comments, I do see the opposite
>>>      possibility that you'd like to develop new features
>>>      later.
>>>
>>>    - In the past, all in-tree kernel filesystems were
>>>      designed and implemented without some user-space
>>>      specific indication, including Nydus and ostree (I did
>>>      see a lot of discussion between folks before in ociv2
>>>      brainstorm [5]).
>> Since you are mentioning OCI:
>> Potentially composefs can be the file system that enables something
>> very
>> close to "ociv2", but it won't need to be called v2 since it is
>> completely compatible with the current OCI image format.
>> It won't require a different image format, just a seekable tarball
>> that
>> is compatible with old "v1" clients and we need to provide the composefs
>> manifest file.
>
> May I ask did you really look into what Nydus + EROFS already did (as you
> mentioned we discussed before)?
>
> Your "composefs manifest file" is exactly "Nydus bootstrap file", see:
> https://github.com/dragonflyoss/image-service/blob/master/docs/nydus-desi=
gn.md
>
> "Rafs is a filesystem image containing a separated metadata blob and
>  several data-deduplicated content-addressable data blobs. In a typical
>  rafs filesystem, the metadata is stored in bootstrap while the data
>  is stored in blobfile.
>  ...
>
>  bootstrap:  The metadata is a merkle tree (I think that is typo, should =
be
>  filesystem tree) whose nodes represents a regular filesystem's
>  directory/file a leaf node refers to a file and contains hash value of
>  its file data.
>    Root node and internal nodes refer to directories and contain the
>   hash value
>  of their children nodes."
>
> Nydus is already supported "It won't require a different image format, ju=
st
> a seekable tarball that is compatible with old "v1" clients and we need to
> provide the composefs manifest file." feature in v2.2 and will be released
> later.

Nydus is not using a tarball compatible with OCI v1.

It defines a media type "application/vnd.oci.image.layer.nydus.blob.v1", th=
at
means it is not compatible with existing clients that don't know about
it and you need special handling for that.

Anyway, let's not bother LKML folks with these userspace details.  It
has no relevance to the kernel and what file systems do.


>> The seekable tarball allows individual files to be retrieved.  OCI
>> clients will not need to pull the entire tarball, but only the individual
>> files that are not already present in the local CAS. They won't also need
>> to create the overlay layout at all, as we do today, since it is already
>> described with the composefs manifest file.
>> The manifest is portable on different machines with different
>> configurations, as you can use multiple CAS when mounting composefs.
>> Some users might have a local CAS, some others could have a
>> secondary
>> CAS on a network file system and composefs support all these
>> configurations with the same signed manifest file.
>>=20
>>>      That is why EROFS selected exist in-kernel fscache and
>>>      made userspace Nydus adapt it:
>>>
>>>        even (here called) manifest on-disk format ---
>>>             EROFS call primary device ---
>>>             they call Nydus bootstrap;
>>>
>>>      I'm not sure why it becomes impossible for ... ($$$$).
>> I am not sure what you mean, care to elaborate?
>
> I just meant these concepts are actually the same concept with
> different names and:
>   Nydus is a 2020 stuff;

CRFS[1] is 2019 stuff.

>   EROFS + primary device is a 2021-mid stuff.
>
>>> In addition, if fscache is used, it can also use
>>> fsverity_get_digest() to enable fsverity for non-on-demand
>>> files.
>>>
>>> But again I think even Google's folks think that is
>>> (somewhat) broken so that they added fs-verity to its incFS
>>> in a self-contained way in Feb 2021 [6].
>>>
>>> Finally, again, I do hope a LSF/MM discussion for this new
>>> overlay model (full of massive magical symlinks to override
>>> permission.)
>> you keep pointing it out but nobody is overriding any permission.
>> The
>> "symlinks" as you call them are just a way to refer to the payload files
>> so they can be shared among different mounts.  It is the same idea used
>> by "overlay metacopy" and nobody is complaining about it being a
>> security issue (because it is not).
>
> See overlay documentation clearly wrote such metacopy behavior:
> https://docs.kernel.org/filesystems/overlayfs.html
>
> "
> Do not use metacopy=3Don with untrusted upper/lower directories.
> Otherwise it is possible that an attacker can create a handcrafted file
> with appropriate REDIRECT and METACOPY xattrs, and gain access to file
> on lower pointed by REDIRECT. This should not be possible on local
> system as setting =E2=80=9Ctrusted.=E2=80=9D xattrs will require CAP_SYS_=
ADMIN. But
> it should be possible for untrusted layers like from a pen drive.
> "
>
> Do we really need such behavior working on another fs especially with
> on-disk format?  At least Christian said,
> "FUSE and Overlayfs are adventurous enough and they don't have their
> own on-disk format."

If users want to do something really weird then they can always find a
way but the composefs lookup is limited under the directories specified
at mount time, so it is not possible to access any file outside the
repository.


>> The files in the CAS are owned by the user that creates the mount,
>> so
>> there is no need to circumvent any permission check to access them.
>> We use fs-verity for these files to make sure they are not modified by a
>> malicious user that could get access to them (e.g. a container breakout).
>
> fs-verity is not always enforcing and it's broken here if fsverity is not
> supported in underlay fses, that is another my arguable point.

It is a trade-off.  It is up to the user to pick a configuration that
allows using fs-verity if they care about this feature.

Regards,
Giuseppe

[1] https://github.com/google/crfs


> Thanks,
> Gao Xiang
>
> [1] https://lore.kernel.org/linux-fsdevel/20230117152756.jbwmeq724potyzju=
@wittgenstein/
>
>> Regards,
>> Giuseppe

