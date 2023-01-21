Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED7A676756
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 17:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjAUQUa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 11:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjAUQU3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 11:20:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12B521962
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Jan 2023 08:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674317980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rKkPMT3Ajc5zrq8qeQZeYgfPlgFajh5mqwRTMJ2ZEfg=;
        b=KdB9aH2UrWdsMdRlnq4EP3d9G8LeQuxwx9flwiAlpLA7gu0yRHDJTdV1XgI4Ya7ZQ5WmRh
        4tT0Cq+SBVAR2KfjqexrDxhh2oqmx480t3JbWfbNFsrBxhM3bK5HBQ33Akjwsx/DVI4Zp3
        hNtWuqHv/Tid1seaasjKJSG6ZcRul2s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-rdzxQk2PNQS5aPTJgOLLIw-1; Sat, 21 Jan 2023 11:19:37 -0500
X-MC-Unique: rdzxQk2PNQS5aPTJgOLLIw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F8B7185A78B;
        Sat, 21 Jan 2023 16:19:36 +0000 (UTC)
Received: from localhost (unknown [10.39.192.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 111301731B;
        Sat, 21 Jan 2023 16:19:35 +0000 (UTC)
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
Date:   Sat, 21 Jan 2023 17:19:33 +0100
In-Reply-To: <321dfdb1-3771-b16d-604f-224ce8aa22cf@linux.alibaba.com> (Gao
        Xiang's message of "Sat, 21 Jan 2023 11:08:14 +0800")
Message-ID: <878rhvg8ru.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Gao Xiang <hsiangkao@linux.alibaba.com> writes:

> On 2023/1/21 06:18, Giuseppe Scrivano wrote:
>> Hi Amir,
>> Amir Goldstein <amir73il@gmail.com> writes:
>> 
>>> On Fri, Jan 20, 2023 at 5:30 PM Alexander Larsson <alexl@redhat.com> wrote:
>
> ...
>
>>>>
>>>
>>> Hi Alexander,
>>>
>>> I must say that I am a little bit puzzled by this v3.
>>> Gao, Christian and myself asked you questions on v2
>>> that are not mentioned in v3 at all.
>>>
>>> To sum it up, please do not propose composefs without explaining
>>> what are the barriers for achieving the exact same outcome with
>>> the use of a read-only overlayfs with two lower layer -
>>> uppermost with erofs containing the metadata files, which include
>>> trusted.overlay.metacopy and trusted.overlay.redirect xattrs that refer
>>> to the lowermost layer containing the content files.
>> I think Dave explained quite well why using overlay is not
>> comparable to
>> what composefs does.
>> One big difference is that overlay still requires at least a syscall
>> for
>> each file in the image, and then we need the equivalent of "rm -rf" to
>> clean it up.  It is somehow acceptable for long-running services, but it
>> is not for "serverless" containers where images/containers are created
>> and destroyed frequently.  So even in the case we already have all the
>> image files available locally, we still need to create a checkout with
>> the final structure we need for the image.
>> I also don't see how overlay would solve the verified image problem.
>> We
>> would have the same problem we have today with fs-verity as it can only
>> validate a single file but not the entire directory structure.  Changes
>> that affect the layer containing the trusted.overlay.{metacopy,redirect}
>> xattrs won't be noticed.
>> There are at the moment two ways to handle container images, both
>> somehow
>> guided by the available file systems in the kernel.
>> - A single image mounted as a block device.
>> - A list of tarballs (OCI image) that are unpacked and mounted as
>>    overlay layers.
>> One big advantage of the block devices model is that you can use
>> dm-verity, this is something we miss today with OCI container images
>> that use overlay.
>> What we are proposing with composefs is a way to have "dm-verity"
>> style
>> validation based on fs-verity and the possibility to share individual
>> files instead of layers.  These files can also be on different file
>> systems, which is something not possible with the block device model.
>
> That is not a new idea honestly, including chain of trust.  Even laterly
> out-of-tree incremental fs using fs-verity for this as well, except that
> it's in a real self-contained way.
>
>> The composefs manifest blob could be generated remotely and signed.
>> A
>> client would need just to validate the signature for the manifest blob
>> and from there retrieve the files that are not in the local CAS (even
>> from an insecure source) and mount directly the manifest file.
>
>
> Back to the topic, after thinking something I have to make a
> compliment for reference.
>
> First, EROFS had the same internal dissussion and decision at
> that time almost _two years ago_ (June 2021), it means:
>
>   a) Some internal people really suggested EROFS could develop
>      an entire new file-based in-kernel local cache subsystem
>      (as you called local CAS, whatever) with stackable file
>      interface so that the exist Nydus image service [1] (as
>      ostree, and maybe ostree can use it as well) don't need to
>      modify anything to use exist blobs;
>
>   b) Reuse exist fscache/cachefiles;
>
> The reason why we (especially me) finally selected b) because:
>
>   - see the people discussion of Google's original Incremental
>     FS topic [2] [3] in 2019, as Amir already mentioned.  At
>     that time all fs folks really like to reuse exist subsystem
>     for in-kernel caching rather than reinvent another new
>     in-kernel wheel for local cache.
>
>     [ Reinventing a new wheel is not hard (fs or caching), just
>       makes Linux more fragmented.  Especially a new filesystem
>       is just proposed to generate images full of massive massive
>       new magical symlinks with *overriden* uid/gid/permissions
>       to replace regular files. ]
>
>   - in-kernel cache implementation usually met several common
>     potential security issues; reusing exist subsystem can
>     make all fses addressed them and benefited from it.
>
>   - Usually an exist widely-used userspace implementation is
>     never an excuse for a new in-kernel feature.
>
> Although David Howells is always quite busy these months to
> develop new netfs interface, otherwise (we think) we should
> already support failover, multiple daemon/dirs, daemonless and
> more.

we have not added any new cache system.  overlay does "layer
deduplication" and in similar way composefs does "file deduplication".
That is not a built-in feature, it is just a side effect of how things
are packed together.

Using fscache seems like a good idea and it has many advantages but it
is a centralized cache mechanism and it looks like a potential problem
when you think about allowing mounts from a user namespace.

As you know as I've contacted you, I've looked at EROFS in the past
and tried to get our use cases to work with it before thinking about
submitting composefs upstream.

From what I could see EROFS and composefs use two different approaches
to solve a similar problem, but it is not possible to do exactly with
EROFS what we are trying to do.  To oversimplify it: I see EROFS as a
block device that uses fscache, and composefs as an overlay for files
instead of directories.

Sure composefs is quite simple and you could embed the composefs
features in EROFS and let EROFS behave as composefs when provided a
similar manifest file.  But how is that any better than having a
separate implementation that does just one thing well instead of merging
different paradigms together?

> I know that you guys repeatedly say it's a self-contained
> stackable fs and has few code (the same words as Incfs
> folks [3] said four years ago already), four reasons make it
> weak IMHO:
>
>   - I think core EROFS is about 2~3 kLOC as well if
>     compression, sysfs and fscache are all code-truncated.
>
>     Also, it's always welcome that all people could submit
>     patches for cleaning up.  I always do such cleanups
>     from time to time and makes it better.
>
>   - "Few code lines" is somewhat weak because people do
>     develop new features, layout after upstream.
>
>     Such claim is usually _NOT_ true in the future if you
>     guys do more to optimize performance, new layout or even
>     do your own lazy pulling with your local CAS codebase in
>     the future unless
>     you *promise* you once dump the code, and do bugfix
>     only like Christian said [4].
>
>     From LWN.net comments, I do see the opposite
>     possibility that you'd like to develop new features
>     later.
>
>   - In the past, all in-tree kernel filesystems were
>     designed and implemented without some user-space
>     specific indication, including Nydus and ostree (I did
>     see a lot of discussion between folks before in ociv2
>     brainstorm [5]).

Since you are mentioning OCI:

Potentially composefs can be the file system that enables something very
close to "ociv2", but it won't need to be called v2 since it is
completely compatible with the current OCI image format.

It won't require a different image format, just a seekable tarball that
is compatible with old "v1" clients and we need to provide the composefs
manifest file.

The seekable tarball allows individual files to be retrieved.  OCI
clients will not need to pull the entire tarball, but only the individual
files that are not already present in the local CAS. They won't also need
to create the overlay layout at all, as we do today, since it is already
described with the composefs manifest file.

The manifest is portable on different machines with different
configurations, as you can use multiple CAS when mounting composefs.

Some users might have a local CAS, some others could have a secondary
CAS on a network file system and composefs support all these
configurations with the same signed manifest file.

>     That is why EROFS selected exist in-kernel fscache and
>     made userspace Nydus adapt it:
>
>       even (here called) manifest on-disk format ---
>            EROFS call primary device ---
>            they call Nydus bootstrap;
>
>     I'm not sure why it becomes impossible for ... ($$$$).

I am not sure what you mean, care to elaborate?

> In addition, if fscache is used, it can also use
> fsverity_get_digest() to enable fsverity for non-on-demand
> files.
>
> But again I think even Google's folks think that is
> (somewhat) broken so that they added fs-verity to its incFS
> in a self-contained way in Feb 2021 [6].
>
> Finally, again, I do hope a LSF/MM discussion for this new
> overlay model (full of massive magical symlinks to override
> permission.)

you keep pointing it out but nobody is overriding any permission.  The
"symlinks" as you call them are just a way to refer to the payload files
so they can be shared among different mounts.  It is the same idea used
by "overlay metacopy" and nobody is complaining about it being a
security issue (because it is not).

The files in the CAS are owned by the user that creates the mount, so
there is no need to circumvent any permission check to access them.
We use fs-verity for these files to make sure they are not modified by a
malicious user that could get access to them (e.g. a container breakout).

Regards,
Giuseppe

>
> [1] https://github.com/dragonflyoss/image-service
> [2] https://lore.kernel.org/r/CAK8JDrFZW1jwOmhq+YVDPJi9jWWrCRkwpqQ085EouVSyzw-1cg@mail.gmail.com/
> [3] https://lore.kernel.org/r/CAK8JDrGRzA+yphpuX+GQ0syRwF_p2Fora+roGCnYqB5E1eOmXA@mail.gmail.com/
> [4] https://lore.kernel.org/r/20230117101202.4v4zxuj2tbljogbx@wittgenstein/
> [5] https://hackmd.io/@cyphar/ociv2-brainstorm
> [6] https://android-review.googlesource.com/c/kernel/common/+/1444521
>
> Thanks,
> Gao Xiang
>
>> Regards,
>> Giuseppe
>> 
>>> Any current functionality gap in erofs and/or in overlayfs
>>> cannot be considered as a reason to maintain a new filesystem
>>> driver unless you come up with an explanation why closing that
>>> functionality gap is not possible or why the erofs+overlayfs alternative
>>> would be inferior to maintaining a new filesystem driver.
>>>
>>>  From the conversations so far, it does not seem like Gao thinks
>>> that the functionality gap in erofs cannot be closed and I don't
>>> see why the functionality gap in overlayfs cannot be closed.
>>>
>>> Are we missing something?
>>>
>>> Thanks,
>>> Amir.
>> 

