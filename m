Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B9C2022B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 11:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgFTJAH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 05:00:07 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:42693 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgFTJAH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 05:00:07 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mx0VH-1iy2Kk0UtH-00yMgg for <linux-fsdevel@vger.kernel.org>; Sat, 20 Jun
 2020 11:00:05 +0200
Received: by mail-qk1-f178.google.com with SMTP id l17so11254611qki.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Jun 2020 02:00:04 -0700 (PDT)
X-Gm-Message-State: AOAM533QG9xD+VA/Y9n+vXRhcKDfW6oj1x/RVEqkZL6UMESR37rdMLoy
        /7HC1JdZH6CnO/YWXa5+xZ8yW+zj0S+PL0Xeuu0=
X-Google-Smtp-Source: ABdhPJzXRspxKSSFOBWsT2O1FYthxaEw3Phzb5AS0xza1BwZN7k6j32WMkfK4mOB2wz8FD/flTxQpckHH/6DGg6rfts=
X-Received: by 2002:a37:4ed2:: with SMTP id c201mr7254582qkb.138.1592643603924;
 Sat, 20 Jun 2020 02:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200620021611.GD8681@bombadil.infradead.org>
In-Reply-To: <20200620021611.GD8681@bombadil.infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 20 Jun 2020 10:59:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1UOJa5499mZErTH6vHgLLJzr+R0EYbcbheSbjw0VqsHQ@mail.gmail.com>
Message-ID: <CAK8P3a1UOJa5499mZErTH6vHgLLJzr+R0EYbcbheSbjw0VqsHQ@mail.gmail.com>
Subject: Re: Files dated before 1970
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:7Ab/e6WqjWch0yrKUKOyj1x4ZiCyN9uL6F9HygHVCTd8d7HIO5j
 vii504zl1ZU03ta6Zu6sIJ8XqLcsPxudapXU/ozjO1jkBN7+z7dmXJcUMCIdZe1vK40DyVd
 CAXlqhk6EFqG0TUvycA+D6ZM6XcXeFQXdddYIj//7az/ISh9xyj3aiTQNuxv8LqeWwsN9QM
 X89lIqORPaAzTZ2ANXAOg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mq7U6STTJ+c=:Z2lwuq8IP/UsMeZo8ZaJbW
 w+3s1PkKxx5X9ZdIGAwfeKlNOTLYYR1dkyzEpGDz/h5QZ7LUOrbJ0fhQvzBwOGZdDvgMG0zYH
 EBqiFpi/cPOt7EHIscHTB2+irVWs0JvcU2AdZe85tzHN+dTxZkzA6eUIZcbO/29RhIOcuvP2a
 OeQ+v8iwWEMZV7xGMEVwOD0MFq4PAKikvZ/mLK1XzlsHsI4DzX2qH5AhrQWz2zU1OGOacT69M
 kjQ+GzqnuPWt6o/dOY4jyNctZQNNbiy2hmEmOClhTtAhKpZLv7mhbAFp0nvB/bkjWf/04UeXP
 mvubwn9qOta6oK99KKDqO1Zj3lltUFeIf/xVrxdnHpt9MqltHfdSYnHNeMmKkQN6gNFtVDy9H
 eJQ+f4ynDx5zEmMCVjC+2uPDcpM+r8/lq0ihwl7/GYUT1oKrvkS75J921EHfTldaOsGxYZbjg
 79H+zH83SaZ5FGbK7bvg5OHsfMNWLbm3GYzjLhHcm1kdPQAY0RJLTgaoQFh7yqNLMZKC4T7yX
 iX82Hn2CypgIxiURYrJAOU6lLE2S9LVLGq2f96DyfYWbSi9t237Vp7te0DAGmT/j29L5ASVoH
 afMxM+Q7uwZW5JW4mEk+UBS5HEd42i2UU4kdIhYqbbbeu0H/3u6Pn+KmS8aA7Ur0lO+HhwOyp
 DYO8Chx/jyHITemGvIIo2CPIoULOsAYt4v2rlOT2RL26kSBB/EDypx6LpElxAXJPFvsQcFHh/
 lEYYOV+Un5Vce2gZkmMNSswhiJYmvw8UfC2nC53YE9z79qpMfy78JqxtXeN2/py0k3nUhlVgk
 qJoHKLPqEpIKnL4gPSHra/p012DyPUzxJhfOsn//WaJfXQecm4=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 20, 2020 at 4:16 AM Matthew Wilcox <willy@infradead.org> wrote:
>
>
> Hi Deepa,
>
> Your commit 95582b008388 ("vfs: change inode times to use struct
> timespec64") changed the behaviour of some filesystems with regards to
> files from before 1970.  Specifically, this line from JFS, unchanged
> since before 2.6.12:
>
> fs/jfs/jfs_imap.c:3065: ip->i_atime.tv_sec = le32_to_cpu(dip->di_atime.tv_sec);
>
> le32_to_cpu() returns a u32.  Before your patch, the u32 was assigned
> to an s32, so a file with a date stamp of 1968 would show up that way.
> After your patch, the u32 is zero-extended to an s64, so a file from
> 1968 now appears to be from 2104.
>
> Obviously there aren't a lot of files around from before 1970, so it's
> not surprising that nobody's noticed yet.  But I don't think this was
> an intended change.

In the case of JFS, I think the change of behavior on 32-bit kernels was
intended because it makes them do the same thing as 64-bit kernels.
I'm sure Deepa or I documented this somewhere but unfortunately it's
not clear from the commit description that actually made the transition :(.

> The fix is simple; cast the result to (int) like XFS and ext2 do.
> But someone needs to go through all the filesystems with care.  And it'd
> be great if someone wrote an xfstest for handling files from 1968.

I'm sure the xfstests check was added back when XFS and ext3 decided to
stick with the behavior of 32-bit kernels in order to avoid an
inadvertent change when 64-bit kernels originally became popular.

For JFS and the others that already used an unsigned interpretation
on 64 bit kernels, the current code seems to be the least broken
of the three alternatives we had:

a) as implemented in v4.18, change 32-bit kernels to behave the
   way that 64-bit kernels always have behaved, given that 99% of
   our users are on 64-bit kernels by now.

b) keep 32-bit and 64-bit kernels use a different interpretation,
   staying compatible with older kernels but incompatible between
   machines or between running the same user space on the
   same machine in either native 32-bit mode or compat mode
    a 64-bit kernel

c) change the 99% of users that have a 64-bit kernel to overflowing
    the timestamps in y2038 because that was what the kernel
    file system driver originally implemented on 32-bit machines
    that no concept of post-y2038 time.

    Arnd
