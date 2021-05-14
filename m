Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCB23809B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 14:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbhENMjN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 08:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbhENMjJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 08:39:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7524AC061574;
        Fri, 14 May 2021 05:37:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id f1so12305899edt.4;
        Fri, 14 May 2021 05:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=uBdbEWH3X+scS8Nyxw8OcymFh2SsY7MeUYXlJf//Dp0=;
        b=Od2tQPgs4qSBP/eWAWJlI7Ai5VjBJDpA41aVaSjLUswo0cIf+L2Dd5kudvhOiExbL0
         +CXyHAxgNWB2yocfxk0f/b5ak7G0KUFPELYg4NvgNb6gFU7f8gow9FThcCPkvrR6QC8K
         Tj6UMLOkMOyJCmNrnvJ8d0nXtRKrvD11EjtKMrHUGkRVONTBqyrXu4PvEEElvnblMJPl
         dHIPyfYOtkq6YcgFpvFXxlDO2CpdGAU6VLql4OusNlP0OqOb/IOEjt6/TZ4NJI5Unhvd
         cg44h1MTRvs2vDjh8ZszvhI6jXJon+WbabtAYOKBslDXn0I788ebcZG8SY/xWOLz5377
         sdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=uBdbEWH3X+scS8Nyxw8OcymFh2SsY7MeUYXlJf//Dp0=;
        b=QM0b/FgDj1qniycmSbRLkS7ilKdAQezyvnVWbt8zz5Ebq8O5Vtc01Yar/XqAF7fuy2
         oufcO3Ymub/Ai+NMeikRamtMOPb/I6RCPlQJqITw/5yHcO8/Fsc3YlW7Hw/UzFtMljfr
         dSHlmq8wcVgrqXljatSX+5PMjY0fP3fAqge4ZqWcqFR+t73haEAp5aG7f2yZ9pXVx2ww
         b8HnnJACzrysAKE2s7PYryP862s0T7lS5s+RLZb+Q9gBFy+Q6Ogl2HnZFvPDUSR5Z+e8
         RzQ8DWGPXujwfUl+meJ+YQ18s17MJJXJ15eC9HKac62QXfn2upE2vApI4cJqFKmiFhn5
         CUQw==
X-Gm-Message-State: AOAM531tzBk3XOz+Y380bRQFB6o4e4aBEORU5R4o9YXLKB1FKO1GTlYP
        iASVGB28Qd2Th8o/jW195nhPXgJDzJnfvlJb1GNrHBoh
X-Google-Smtp-Source: ABdhPJzpxuD4tLe10fcTMybwJ6rrpYYvUqLzYThc0ntPNhS/xZMY57k86pYbhN+KkZ+hieVE0i36BSLjJERvyNkjNGU=
X-Received: by 2002:aa7:dbcd:: with SMTP id v13mr55366019edt.59.1620995876217;
 Fri, 14 May 2021 05:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjgpkBh9dnfNTdDcfk5HiL=HjjiB9o_=fjrm+0vP7Re2Q@mail.gmail.com>
 <CAOuPNLh_0Q9w96GKT-ogC0BBcEHgo=Hv3+c=JBcas2VgqDiyaw@mail.gmail.com>
In-Reply-To: <CAOuPNLh_0Q9w96GKT-ogC0BBcEHgo=Hv3+c=JBcas2VgqDiyaw@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 14 May 2021 18:07:34 +0530
Message-ID: <CAOuPNLjmJ0YufFktJzjkyvdxwFTOpxVj5AW5gANAGSG=_yT=mQ@mail.gmail.com>
Subject: [RESEND]: Kernel 4.14: SQUASHFS error: unable to read xattr id index table
To:     phillip@squashfs.org.uk, open list <linux-kernel@vger.kernel.org>,
        sean@geanix.com, linux-mtd@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is regarding the squashfs mount failure that I am getting on my
device during boot time.
I just wanted to know if someone else has come across this issue, or
this issue is already fixed, or this is altogether a different issue?

Here are more details:
Kernel: 4.14.170 ; Qualcomm chipset (arm32 bit)
Platform: busybox
Storage: NAND 512MB
Filesystem: ubifs + squashfs
ubi0 : with 5 volumes (rootfs, usrfs, others)
Kernel command line: ro rootwait console=3DttyMSM0,115200,n8
rootfstype=3Dsquashfs root=3D/dev/mtdblock34 ubi.mtd=3D30,0,30 ....

Background:
We are using ubifs filesystem with squashfs for rootfs (as ready only).
First we tried to flash "usrfs" (data) volume (ubi0_1) and it worked
fine (with device booting successfully).

Next we are trying to flash "rootfs" volume (ubi0_0) now. The volume
flashing is successful but after that when we reboot the system we are
getting below errors.

Logs:
[....]
[    4.589340] vreg_conn_pa: dis=E2=96=92[    4.602779] squashfs: SQUASHFS
error: unable to read xattr id index table
[...]
[    4.964083] No filesystem could mount root, tried:
[    4.964087]  squashfs
[    4.966255]
[    4.973443] Kernel panic - not syncing: VFS: Unable to mount root
fs on unknown-block(31,34)

-----------
[    4.246861] ubi0: attaching mtd30
[    4.453241] ubi0: scanning is finished
[    4.460655] ubi0: attached mtd30 (name "system", size 216 MiB)
[    4.460704] ubi0: PEB size: 262144 bytes (256 KiB), LEB size: 253952 byt=
es
[    4.465562] ubi0: min./max. I/O unit sizes: 4096/4096, sub-page size 409=
6
[    4.472483] ubi0: VID header offset: 4096 (aligned 4096), data offset: 8=
192
[    4.479295] ubi0: good PEBs: 864, bad PEBs: 0, corrupted PEBs: 0
[    4.486067] ubi0: user volume: 5, internal volumes: 1, max. volumes
count: 128
[    4.492311] ubi0: max/mean erase counter: 4/0, WL threshold: 4096,
image sequence number: 1
[    4.499333] ubi0: available PEBs: 0, total reserved PEBs: 864, PEBs
reserved for bad PEB handling: 60

So, we just wanted to know if this issue is related to squashfs or if
there is some issue with our volume flashing.
Note: We are using fastboot mechanism to support UBI volume flashing.

Observation:
Recently I have seen some squashfs changes related to similar issues
(xattr) so I wanted to understand if these changes are relevant to our
issue or not ?

Age           Commit message(Expand)                                 Author
2021-03-30    squashfs: fix xattr id and id lookup sanity checks
Phillip Lougher
2021-03-30    squashfs: fix inode lookup sanity checks
Sean Nyekjaer
2021-02-23    squashfs: add more sanity checks in xattr id lookup
Phillip Lougher
2021-02-23    squashfs: add more sanity checks in inode lookup
Phillip Lougher
2021-02-23    squashfs: add more sanity checks in id lookup
Phillip Lougher

Please let us know your opinion about this issue...
It will help us to decide whether the issue is related to squashfs  or not.


Thanks,
Pintu
