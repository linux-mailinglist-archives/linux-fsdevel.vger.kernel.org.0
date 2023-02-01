Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E4C6860E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 08:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjBAHqQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 02:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjBAHpx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:45:53 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3945EF80;
        Tue, 31 Jan 2023 23:44:31 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id 3so18708359vsq.7;
        Tue, 31 Jan 2023 23:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J0fsN0zafmOy6v04Ga2Ws7LTKT/5u/B8+RmnKRZAN2A=;
        b=WBRMHnh8kAyR5qWZAj93pb70pPO0xBG6RcmlwZPIV7AlwIHSmp3ei/Js2epe6f4DBr
         ZuB0fVz0iHsPVa2mJPwp+2LtYUY1kQwiZMXRCe71sluBCY6/We2QHzmYH5MstBXDyArk
         vKd4JOeOc9xWXTCGH2HtGBM/1JAlwHYwZcYpJfGe56u4znGatNeir/hVXrKH/tIWx0Le
         y78hUkrGVhJTQYSvNtuFpBx9bLUNcP6WG2hOWBm/8SWNlUjvbS4dNVJeGLNOGvEMUUMj
         L/z8CThZsLZ3y48gCkhFnNd36F1NKzHDzzvmURbaCKi8uulKkkVS9mWTgrJJtHxEjxp7
         TJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0fsN0zafmOy6v04Ga2Ws7LTKT/5u/B8+RmnKRZAN2A=;
        b=petc6IOAp0HJYvoA1dCmzwsRWJxrrozh0+ZzIFrlIXFZeQ9xdODa3zfKMjy1/BRrX5
         /F6RDNYyhls4zgTxAytC/HoJ/TeH8QyyfMpA5PdWn4xQQS/EwBbUM0G4paPK+B9ean/r
         org+YrTDFmHcsi9dlhgiRu5/w9bCev7u421C1pQvy2YsSvnm9LMUud6lD5Qgt1CO4kgl
         EJcuAiGYscBEOPN7XhlibNcK/10bWWMAgvzktjLA+GjgTxgf0gzQXduVphZGjqMBf7i6
         DAlU+tjmtDXYnToGCGbwtWVb/FhDbG+p4s6xj+nhL1g8zzN0f4AaFfpS/W28vvcHr8zM
         6oyA==
X-Gm-Message-State: AO0yUKUPu7iRJjBGamC70sggONbEjHW5hFiFIJLGRlosTUYExcFmrCiv
        NIJGdVZ1AfvPAUzG0rRaCFGwT+ZI2x0pKRbg9Uw=
X-Google-Smtp-Source: AK7set9OzjXJJIKgepqMgJ+FNx09mEhSlGTv4LLZi4lGKwRjvU90bR2OYHVAZNYIwXyyIuAa3YFUp/WyLEUaoP9eabA=
X-Received: by 2002:a05:6102:34c8:b0:3d3:e956:1303 with SMTP id
 a8-20020a05610234c800b003d3e9561303mr299653vst.71.1675237470169; Tue, 31 Jan
 2023 23:44:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674227308.git.alexl@redhat.com> <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
 <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
 <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
 <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
 <b8601c976d6e5d3eccf6ef489da9768ad72f9571.camel@redhat.com>
 <e840d413-c1a7-d047-1a63-468b42571846@linux.alibaba.com> <2ef122849d6f35712b56ffbcc95805672980e185.camel@redhat.com>
 <8ffa28f5-77f6-6bde-5645-5fb799019bca@linux.alibaba.com> <51d9d1b3-2b2a-9b58-2f7f-f3a56c9e04ac@linux.alibaba.com>
In-Reply-To: <51d9d1b3-2b2a-9b58-2f7f-f3a56c9e04ac@linux.alibaba.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 1 Feb 2023 09:44:18 +0200
Message-ID: <CAOQ4uxhzGru2Z8tjcAWvKVi0reNeX9SHMi6cwdyA9Vws8c1ppw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Alexander Larsson <alexl@redhat.com>, gscrivan@redhat.com,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 1, 2023 at 6:28 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>
> Hi all,
>
> There are some updated performance statistics with different
> combinations on my test environment if you are interested.
>

Cool report!

>
> On 1/27/23 6:24 PM, Gao Xiang wrote:
> > ...
> >
> > I've made a version and did some test, it can be fetched from:
> > git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b
> > experimental
> >
>
> Setup
> ======
> CPU: x86_64 Intel(R) Xeon(R) Platinum 8269CY CPU @ 2.50GHz
> Disk: 6800 IOPS upper limit
> OS: Linux v6.2 (with composefs v3 patchset)
>
> I build erofs/squashfs images following the scripts attached on [1],
> with each file in the rootfs tagged with "metacopy" and "redirect" xattr.
>
> The source rootfs is from the docker image of tensorflow [2].
>
> The erofs images are built with mkfs.erofs with support for sparse file
> added [3].
>
> [1]
> https://lore.kernel.org/linux-fsdevel/5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com/
> [2]
> https://hub.docker.com/layers/tensorflow/tensorflow/2.10.0/images/sha256-7f9f23ce2473eb52d17fe1b465c79c3a3604047343e23acc036296f512071bc9?context=explore
> [3]
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=experimental&id=7c49e8b195ad90f6ca9dfccce9f6e3e39a8676f6
>
>
>
> Image size
> ===========
> 6.4M large.composefs
> 5.7M large.composefs.w/o.digest (w/o --compute-digest)
> 6.2M large.erofs
> 5.2M large.erofs.T0 (with -T0, i.e. w/o nanosecond timestamp)
> 1.7M large.squashfs
> 5.8M large.squashfs.uncompressed (with -noI -noD -noF -noX)
>
> (large.erofs.T0 is built without nanosecond timestamp, so that we get
> smaller disk inode size (same with squashfs).)
>
>
> Runtime Perf
> =============
>
> The "uncached" column is tested with:
> hyperfine -p "echo 3 > /proc/sys/vm/drop_caches" "ls -lR $MNTPOINT"
>
>
> While the "cached" column is tested with:
> hyperfine -w 1 "ls -lR $MNTPOINT"
>
>
> erofs and squashfs are mounted with loopback device.
>
>
>                                   | uncached(ms)| cached(ms)
> ----------------------------------|-------------|-----------
> composefs (with digest)           | 326         | 135
> erofs (w/o -T0)                   | 264         | 172
> erofs (w/o -T0) + overlayfs       | 651         | 238

This is a nice proof of the overlayfs "early lookup" overhead.
As I wrote, this overhead could be optimized by doing "lazy lookup"
on open like composefs does.

Here is a suggestion for a simple test variant that could be used to
approximate the expected improvement -
if you set all the metacopy files in erofs to redirect to the same
lower block, most of the lower lookup time will be amortized
because all but the first lower lookup are cached.
If you get a performance number with erofs + overlayfs that are
close to composefs performance numbers, it will prove the point
that same functionality and performance could be achieved by
modifying ovelrayfs/mkfs.erofs.

Thanks,
Amir.
