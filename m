Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9B1485CF5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 01:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343547AbiAFAMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 19:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343511AbiAFAMQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:12:16 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF981C061212
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jan 2022 16:12:15 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id jw3so682645pjb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jan 2022 16:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O5SiWExPLldaEfWo8lBT3rXCxgET/LcnPrCSIpHHBGY=;
        b=Bq3tbFj0hQ4W0bZUht09ZhxVqUleX9C8+RT6vooive/TZHMenBfn2h9ba5rAepK8JR
         u45P/p02Sl1548csvwm9DUxhoFiN9Z/NvtPVPQ2ndKB8LRHEKBy+d3+LSBdXNuUXGEJm
         SawqfZprxK+VpI5grQlefZ/TXCgpEusljjCTfd01AZLksR4hzneHwkFC+xdaU4gXkiak
         5kkrFu3di7XcwM+7rImHqHHggj5M2LaDQZJUq733NKbfxWv54vq6AGgrVKxKbiF1T5sD
         VodQG0B5NQwF1cbjRV/Vnk9nRRM349Q3VP0BMj2jzhrRf+3sfngswHWxe/v0q4Exl3yo
         lo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O5SiWExPLldaEfWo8lBT3rXCxgET/LcnPrCSIpHHBGY=;
        b=fi1kdthV0fCs6WTEMtSVNevsvqaHpAThBkHJFgatnsXJLD7u6O/YZuOuQp3ChIAokw
         R8soy/TELqpO6uolgr0xmolmKWijgZN6NWaWzbF1aMQ8auRAskQcSBSqqCxD/YjRlXLo
         8jMZvePuA6Z/5ZkKVAAlqJyV3UFGhsLxrY/+EeAiDjlNfR1S4o+8IlfflJRDQk0ZRyaB
         JzlNtJZgICF9Y4CkJs/yQrfTXZlnxivt2JWVRTPde12CB73+XhzwvOi35F6AfrpAy+uN
         /J+RLpwj/zyYg723E8wxU+XKSYkInc4t0AWd1cjaakrfuMYt5S1XLJevlPtOgWfD2aFn
         e92w==
X-Gm-Message-State: AOAM5325T0jJYXri2tvUQuQ0oH+hqS8DjODQh1L5U/E9JGPxGzhEUHeL
        vT35ulnIV/yNxLFhjsZeEGJMTfefKzXN66baxOmvug==
X-Google-Smtp-Source: ABdhPJzy4aXmWdEyOp/zErYWN3Ia55r7xQeUNljZBrq2+3BZwPZ5oD55Al+wNqk/tcS+EUPIR/EaCp9SNGZdIGsCntE=
X-Received: by 2002:a17:902:8488:b0:149:8545:5172 with SMTP id
 c8-20020a170902848800b0014985455172mr42149927plo.132.1641427935261; Wed, 05
 Jan 2022 16:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
 <20211226143439.3985960-3-ruansy.fnst@fujitsu.com> <20220105181230.GC398655@magnolia>
 <CAPcyv4iTaneUgdBPnqcvLr4Y_nAxQp31ZdUNkSRPsQ=9CpMWHg@mail.gmail.com>
 <20220105185626.GE398655@magnolia> <CAPcyv4h3M9f1-C5e9kHTfPaRYR_zN4gzQWgR+ZyhNmG_SL-u+A@mail.gmail.com>
 <20220105224727.GG398655@magnolia> <CAPcyv4iZ88FPeZC1rt_bNdWHDZ5oh7ua31NuET2-oZ1UcMrH2Q@mail.gmail.com>
 <20220105235407.GN656707@magnolia>
In-Reply-To: <20220105235407.GN656707@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 5 Jan 2022 16:12:04 -0800
Message-ID: <CAPcyv4gUmpDnGkhd+WdhcJVMP07u+CT8NXRjzcOTp5KF-5Yo5g@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] dax: Introduce holder for dax_device
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        david <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 5, 2022 at 3:54 PM Darrick J. Wong <djwong@kernel.org> wrote:
[..]
> > Yes, I think we should just fail the holder registration and
> > DAX+reflink unless the FS being mounted on a whole device. I know Ted
> > and others had reservations about moving filesystems to be mounted on
> > dax-devices directly, but hopefully the whole-block_device requirement
> > is a workable middle ground?
>
> I think you have to be /very/ careful about that kind of statement --
>
> Take ext4 for example.  It has a lot of statically allocated ondisk
> metadata.  Someone could decide that it's a good idea to wire up a media
> failure notification so that we shut down the fs if (say) a giant hole
> opens up in the middle of the inode table.  However, registering any
> kind of media failure handler brings along this requirement for not
> having partitions.
>
> This means that if ext4 finds a filesystem on a partition on a pmem
> device and someone else has already registered a media failure handler,
> it will have to choose between foregoing media failure notifications or
> failing the mount outright.

...good example.

> Or you could support notification call chains...

We ended up with explicit callbacks after hch balked at a notifier
call-chain, but I think we're back to that now. The partition mistake
might be unfixable, but at least bdev_dax_pgoff() is dead. Notifier
call chains have their own locking so, Ruan, this still does not need
to touch dax_read_lock().
