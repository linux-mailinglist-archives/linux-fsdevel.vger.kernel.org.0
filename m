Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EC66C54DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 20:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjCVTXk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 15:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCVTXj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:23:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548FA974D
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 12:23:36 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q102so4937198pjq.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 12:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679513016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgL5DcFp9hxZVsze0lj/Mr8Oi3/8QULjQCWzF+Knqzg=;
        b=bmrdJHDSuWfbKv+zgoi0s5sq70aaDL2ijBKPX0hWdXBo/ssOtr1uhTMhJM/uGO7IW2
         +vKKMcLrXXpZXK9/bndiIVMVwpBLvuPIeGtoRvs3AeJ+YsqkFjwTU9mkLYdgXgOctkgO
         8KrW6yTuMlPFazAD/3jkFzXmoZlsrSoQhW8AnQRoN/D72dKfjeHLfPFYGBMRNF8/gfKM
         im8kIMaKMc3PoHSB13lf61okGID73bExILn4pqSCCAT4aYyMKUw5A+X6JcesW/sF4xs5
         h0A8F2E0X/RBHxyU+W4iOI/j1EL4k8BzNmnJ8wOKxLTzkOkGTJH5bQbYN8RjkQihuPGU
         UoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679513016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgL5DcFp9hxZVsze0lj/Mr8Oi3/8QULjQCWzF+Knqzg=;
        b=UMOfha/+InSyhvLsyAEAsytAqId2mW5QFR4/OLNaWPW3RLpIQbOAgy5ef4EMdtY+mG
         AmGRavnkE+vF4aovToQGkrOCL1+9tpOViHbpHDCnia5eO8Er5FKZPHKzXsC0/0esHEo1
         iofDpQJwPFeg+RWcwa3ZxdsZjuWc4KU6zgHXzhq9F/69EkhKUT7mlkIlO+E5Nztmv3SG
         GXZo9ht4kFF3BqxIK2NpOTA8F5wfQ+y/S2R3pUHHzCQpLwskYEV0iXL3qn5lKGA2MxiA
         sTU4hSuK2y0c5qpUPCSl4XmZi86pN5TwYF/3PTA4oMESdR7mSTaqxo6zYapVxE+75qag
         ArDw==
X-Gm-Message-State: AO0yUKW9Mzgkw6kqPucGHWZ6esAhHAHfBVAnrPVMrNXwnuGVZtFeH97q
        v/xGO6owv4k1zAfEn2voSBGvSl56DkYsJK1IFCU=
X-Google-Smtp-Source: AK7set8xJcNvljrMmwdNaUms/8Ep1ZU+H3InhGsqybamnfB2MFssMsDE1VSCDoiOrQQxth9socYhPrFqvEU4PYW4izo=
X-Received: by 2002:a17:902:c404:b0:19f:3aa9:9ea1 with SMTP id
 k4-20020a170902c40400b0019f3aa99ea1mr1431925plk.8.1679513015802; Wed, 22 Mar
 2023 12:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <CADNhMOuFyDv5addXDX3feKGS9edJ3nwBTBh7AB1UY+CYzrreFw@mail.gmail.com>
 <ZBsVnQatzjB9QgnF@casper.infradead.org>
In-Reply-To: <ZBsVnQatzjB9QgnF@casper.infradead.org>
From:   Amol Dixit <amoldd@gmail.com>
Date:   Wed, 22 Mar 2023 12:13:54 -0700
Message-ID: <CADNhMOuA+aNdqASoS6AGVx4s2kEZJubzVBi8qVhAO4VubGSBpA@mail.gmail.com>
Subject: Re: inotify on mmap writes
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for correction. It has been a while for me and I thought
writepages may be the common denominator (vague memory of reads
blocking on DIO writeback with writepages casued me to believe it may
be the path for mmap)...most certainly it is ext4_page_mkwrite that
does get_block and and ends up with ll_rw_block(), so I stand
corrected.

Back to my point of tracking mmap writes to any region of a file. The
use case is to build on top of inotify to know dirty files and take
action as the app would wish - so this is more about completion of the
API to track all writes. Just saw patches in the works for splice() go
by, also in the same vein.

Ideally I would want to take the inotify interface further, by
returning offset/length information in the MODIFY event to further
assist user applications built on this interface. For vfs originated
events this would be at byte granularity, while for mmap originated
events this may be at page granularity - in any case this would be
valuable information surfaced up from the depths of the filesystem up
to userspace.

Thanks,
Amol



On Wed, Mar 22, 2023 at 7:50=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Mar 21, 2023 at 06:50:14PM -0700, Amol Dixit wrote:
> > The lack of file modification notification events (inotify, fanotify)
> > for mmap() regions is a big hole to anybody watching file changes from
> > userspace. I can imagine atleast 2 reasons why that support may be
> > lacking, perhaps there are more:
> >
> > 1. mmap() writeback is async (unless msync/fsync triggered) driven by
> > file IO and page cache writeback mechanims, unlike write system calls
> > that get funneled via the vfs layer, whih is a convenient common place
> > to issue notifications. Now mm code would have to find a common ground
> > with filesystem/vfs, which is messy.
> >
> > 2. writepages, being an address-space op is treated by each file
> > system independently. If mm did not want to get involved, onus would
> > be on each filesystem to make their .writepages handlers notification
> > aware. This is probably also considered not worth the trouble.
> >
> > So my question is, notwithstanding minor hurdles (like lost events,
> > hardlinks etc.), would the community like to extend inotify support
> > for mmap'ed writes to files? Under configs options, would a fix on a
> > per filesystem basis be an acceptable solution (I can start with say
> > ext4 writepages linking back to inode/dentry and firing a
> > notification)?
>
> I don't understand why you think writepages is the right place for
> monitoring.  That tells you when data is leaving the page cache, not
> when the file is modified.  If you want to know when the file is
> modified, you need to hook into the page_mkwrite path.
