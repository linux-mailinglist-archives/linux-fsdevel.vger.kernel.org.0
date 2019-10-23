Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEB8E1F48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 17:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392454AbfJWP1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 11:27:01 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:49965 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732725AbfJWP1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:27:01 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MTRAS-1iZJ5a35tU-00Tlmm; Wed, 23 Oct 2019 17:26:58 +0200
Received: by mail-qt1-f182.google.com with SMTP id t20so32846600qtr.10;
        Wed, 23 Oct 2019 08:26:58 -0700 (PDT)
X-Gm-Message-State: APjAAAXqWsXeKYx3tVUPgi4zvMXArJGL9FoUQBOxxW6sVjFum4KgkVff
        SsCbSXoi5BzZfWcGaKwaX0BbG8xvD8aaY2Aveno=
X-Google-Smtp-Source: APXvYqwZJYNUcjDljv5SUIIJYNavbp3Ujmk3aAqd++SffV/emyrXQ3UBboCiPVxPkT3VPGqZOs5oW07jKNUPG9sQS8s=
X-Received: by 2002:a0c:fde8:: with SMTP id m8mr8218926qvu.4.1571844417540;
 Wed, 23 Oct 2019 08:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191009190853.245077-1-arnd@arndb.de> <20191009191044.308087-11-arnd@arndb.de>
 <20191022043451.GB20354@ZenIV.linux.org.uk> <CAK8P3a1C=skow522Ge7w=ya2hK8TPS8ncusdyX-Ne4GBWB1H4A@mail.gmail.com>
 <20191023031711.GA26530@ZenIV.linux.org.uk>
In-Reply-To: <20191023031711.GA26530@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Oct 2019 17:26:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1=5gtn5xcg8Sjc-emcb4fy=VuNPNo6-MhP3ZDP9BXxPw@mail.gmail.com>
Message-ID: <CAK8P3a1=5gtn5xcg8Sjc-emcb4fy=VuNPNo6-MhP3ZDP9BXxPw@mail.gmail.com>
Subject: Re: [PATCH v6 11/43] compat_ioctl: move drivers to compat_ptr_ioctl
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Z5Y717p5ugEHBIsqAFglSr6xPjtai5XYu7pkkFiVWRWQ+2VZW0i
 EyM3AUu2N+5ZHLIKRo63Xcwzwr8PpvCiEC7s2a+WCZeoWBfyBIV62JntY2GczKRHGbiIHoE
 6Lcu5Bloflt0T8JbKStO1zjnzvpTirNfNvZCi9kuIulouG86+zDwR4LvCcvTVgiCyjUZ8oA
 AIHsN2o/u6a9t9kHakuJw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XIa79+yPgP4=:g0KBe50nVSYObmj9uZqsgY
 xZb7GQQFhLM2BmD/TMx1Xqe1eADBh3Apr7V9f+jVCol2LTujnun4Dku293bLhs3irnLQTPOLJ
 NLfbebRdtsB1sxjpF84DoLttFhGtRJYTYogSNh4sVGeYkTZPAPQwEF9pYSyV6H3ow5OVVz/rd
 TOWpcXLHzbpteNhyzrORmiIF1gx3DQRRKJMsL1L46ShikHNb+l0IcC4j7SNEc5YST0plB/hWy
 F46Wy5xgejqEgGJfclfBLYlhJBEeSzUyy71zwYuQzX6SwFJ3ig5VyzXCnOBhQFMc06vFr1ztS
 hPMDlxqf8bhPtCrgTsL/wmEH/knuYouwKaZzOkBRUsiBq9SJqQpLfhS0SgAuGF0N3T4oAPg25
 9SOE36kQLavNUuA9zBMLfybAFZQPcObWzdBm5cKSKNxldOLKkAXIiMcU8qwLHEdm7SQvr227S
 xH8Pky7maFe9Y5D3EQ1J1KNaLMMGpHhroF1V4VL4M9ZUd0ySqXAUFsjmva3HUTVo3ub+qFzv/
 C3EvxkXLOjTppQTm9gVtG69Nxvu77onUddBy+NyTySrjQbEYVwl800sMaqzoPE7IPFvWpdXjN
 jEili9kHlpzd5BYshSnUbEdM6hjOF3XReb6N4+F2iJFWq9u/vzouHwJacj5oEX4p4ET/qfE0W
 XAI26xss5amRLddIgFKMxkTLZXeED7rjOIYwtYjc9JzvED+Qo8D7qhPguKW7okBym23y4fIlF
 rqdOQFzLA0jbfUd1U/u5Hd1R9meV75EZWpRLY1x681yizjYTUbe/y5Y+WIo8yRAwfRhWXX3a7
 w1DcOf8AQULXBVBYsVZ8gUhVwiCbqD+PVv7haTTo/4IjzcygN6jpbDkWiYRnvrJXpmt9D1Usg
 VZEhNeekpUoXDsciHdiw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 5:17 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Oct 22, 2019 at 12:26:09PM +0200, Arnd Bergmann wrote:
> > On Tue, Oct 22, 2019 at 6:34 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Wed, Oct 09, 2019 at 09:10:11PM +0200, Arnd Bergmann wrote:
> > > > Each of these drivers has a copy of the same trivial helper function to
> > > > convert the pointer argument and then call the native ioctl handler.
> > > >
> > > > We now have a generic implementation of that, so use it.
> > >
> > > I'd rather flipped your #7 (ceph_compat_ioctl() introduction) past
> > > that one...
> >
> > The idea was to be able to backport the ceph patch as a bugfix
> > to stable kernels without having to change it or backport
> > compat_ptr_ioctl() as well.
> >
> > If you still prefer it that way, I'd move to a simpler version of this
> > patch and drop the Cc:stable.
>
> What I'm going to do is to put the introduction of compat_ptr_ioctl()
> into a never-rebased branch; having e.g. ceph patch done on top of
> it should suffice - it can go into -stable just fine. Trivially
> backported all the way back, has no prereqs and is guaranteed to
> cause no conflicts, so if any -stable fodder ends up depending upon
> it, there will be no problem whatsoever.  IMO that commit should
> precede everything else in the queue...

Ok, fair enough. I've moved that one patch to the start of my git
branch now. See below for the updated patch. I also uploaded
the modified y2038 branch for linux-next.

> Another thing is that I'd fold #8 into #6 - it clearly belongs
> in there.

Done.

      Arnd

8<------
commit 18bd6caaef4021803dd0d031dc37c2d001d18a5b (HEAD)
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Tue Sep 11 20:47:23 2018 +0200

    ceph: fix compat_ioctl for ceph_dir_operations

    The ceph_ioctl function is used both for files and directories, but only
    the files support doing that in 32-bit compat mode.

    On the s390 architecture, there is also a problem with invalid 31-bit
    pointers that need to be passed through compat_ptr().

    Use the new compat_ptr_ioctl() to address both issues.

    Note: When backporting this patch to stable kernels, "compat_ioctl:
    add compat_ptr_ioctl()" is needed as well.

    Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
    Cc: stable@vger.kernel.org
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 4ca0b8ff9a72..811f45badc10 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1808,6 +1808,7 @@ const struct file_operations ceph_dir_fops = {
        .open = ceph_open,
        .release = ceph_release,
        .unlocked_ioctl = ceph_ioctl,
+       .compat_ioctl = compat_ptr_ioctl,
        .fsync = ceph_fsync,
        .lock = ceph_lock,
        .flock = ceph_flock,
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d277f71abe0b..6092ccea50d2 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2162,7 +2162,7 @@ const struct file_operations ceph_file_fops = {
        .splice_read = generic_file_splice_read,
        .splice_write = iter_file_splice_write,
        .unlocked_ioctl = ceph_ioctl,
-       .compat_ioctl   = ceph_ioctl,
+       .compat_ioctl = compat_ptr_ioctl,
        .fallocate      = ceph_fallocate,
        .copy_file_range = ceph_copy_file_range,
 };
